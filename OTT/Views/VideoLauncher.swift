//
//  ChannelView.swift
//  OTT
//
//  Created by Alisher Djuraev on 14/04/22.
//

import UIKit
import AVFoundation

class VideoLauncher: UIView {
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "pause.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isPlaying = false
    
    @objc func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            pausePlayButton.backgroundColor = UIColor(white: 0, alpha: 0)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Прямой эфир"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var circleLabel: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "circle.fill")
        imageView.image = image
        imageView.tintColor = UIColor.rgb(red: 133, green: 237, blue: 129)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var landscapeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "viewfinder")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var aspectRatioButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "aspectRatio")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var controlsContainterView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupPlayerView()
        addGradient()
        embedSubviews()
        setupConstraints()
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    fileprivate func embedSubviews() {
        addSubview(controlsContainterView)
        controlsContainterView.frame = frame
        
        controlsContainterView.addSubview(activityIndicatorView)
        controlsContainterView.addSubview(pausePlayButton)
        controlsContainterView.addSubview(circleLabel)
        controlsContainterView.addSubview(textLabel)
        controlsContainterView.addSubview(landscapeButton)
        controlsContainterView.addSubview(aspectRatioButton)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            controlsContainterView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            controlsContainterView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            controlsContainterView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            controlsContainterView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            pausePlayButton.widthAnchor.constraint(equalToConstant: 30),
            pausePlayButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            circleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
            circleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            circleLabel.widthAnchor.constraint(equalToConstant: 10),
            circleLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            textLabel.leadingAnchor.constraint(equalTo: circleLabel.trailingAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            landscapeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            landscapeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
        
        NSLayoutConstraint.activate([
            aspectRatioButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            aspectRatioButton.trailingAnchor.constraint(equalTo: landscapeButton.leadingAnchor, constant: -22)
        ])
    }
    
    var player: AVPlayer?
    
    fileprivate func setupPlayerView() {
        let urlString = "http://185.74.5.25:1935/live/smil:1.smil/playlist.m3u8"
        if let url = NSURL(string: urlString) {
            player = AVPlayer(url: url as URL)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainterView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}
