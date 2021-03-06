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
            pausePlayButton.tintColor = .white
            controlsContainterView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            backButton.isHidden = false
            settingsButton.isHidden = false
            circleLabel.isHidden = false
            textLabel.isHidden = false
            aspectRatioButton.isHidden = false
            landscapeButton.isHidden = false
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            controlsContainterView.backgroundColor = .clear
            pausePlayButton.tintColor = .clear
            backButton.isHidden = true
            settingsButton.isHidden = true
            circleLabel.isHidden = true
            textLabel.isHidden = true
            aspectRatioButton.isHidden = true
            landscapeButton.isHidden = true
        }
        
        isPlaying = !isPlaying
    }
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "???????????? ????????"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var circleLabel: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "circle.fill")
        imageView.image = image
        imageView.tintColor = UIColor.rgb(red: 133, green: 237, blue: 129)
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.left")
        button.setImage(image, for: UIControl.State())
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(goToBack(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func goToBack(sender: UIButton) {
//        var segue = UINavigationController()
//        let homeViewController = HomeViewController()
//        segue.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "gearshape")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var landscapeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "viewfinder")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var aspectRatioButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "aspectRatio")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var controlsContainterView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupPlayerView()
        embedSubviews()
        setupConstraints()
    }
    
    fileprivate func embedSubviews() {
        addSubview(controlsContainterView)
        controlsContainterView.frame = frame
        
        controlsContainterView.addSubview(activityIndicatorView)
        controlsContainterView.addSubview(pausePlayButton)
        controlsContainterView.addSubview(backButton)
        controlsContainterView.addSubview(settingsButton)
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
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 8),
            backButton.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            settingsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18)
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
//            controlsContainterView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            pausePlayButton.isHidden = false
            pausePlayButton.tintColor = .clear
            isPlaying = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}
