//
//  ChannelViewController.swift
//  OTT
//
//  Created by Alisher Djuraev on 14/04/22.
//

import UIKit

class ChannelViewController: UIViewController {
    
    private lazy var tableTitle: String = "каналы"
    
    var tableChannels: [ChannelItems] = [] {
        didSet {
            self.channelTableView.reloadData()
        }
    }
    
    private lazy var channelTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ChannelsTableCell.self, forCellReuseIdentifier: ChannelsTableCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Data source protocol
        channelTableView.delegate = self
        channelTableView.dataSource = self
        
        setupView()
        
        self.tableChannels = ChannelService.shared.channels
    }
    
    private func setupView() {
        let channelView = VideoLauncher(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 9/16))
        channelTableView.tableHeaderView = channelView
        view.addSubview(channelTableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            channelTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            channelTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            channelTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            channelTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Extensions

extension ChannelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableChannels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelsTableCell.identifier, for: indexPath) as? ChannelsTableCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .black
        cell.channel = tableChannels[indexPath.row]
        
        let model = tableChannels[indexPath.row]
        let urlString = model.image
        let url = URL(string: urlString)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            cell.channelImageView.image = image
        } else {
            cell.channelImageView.image = UIImage(named: "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.uppercased()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableTitle
    }
}

