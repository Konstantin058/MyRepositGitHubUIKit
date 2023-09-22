//
//  ViewController.swift
//  MyRepositGitHubUIKit
//
//  Created by Константин Евсюков on 22.09.2023.
//

import UIKit

class ViewController: UIViewController {

    private var myTable = UITableView()
    
    var reposits: [Repositories] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createtable()
        fetchReposit()
    }

}

extension ViewController {
    
    func createtable() {
        myTable = UITableView(frame: view.bounds)
        myTable.register(MyTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        view.addSubview(myTable)
        myTable.translatesAutoresizingMaskIntoConstraints = false
        myTable.rowHeight = 100
        myTable.delegate = self
        myTable.dataSource = self
        
        NSLayoutConstraint.activate([
            myTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            myTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            myTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    
    func fetchReposit() {
        let urlStr = "https://api.github.com/users/Konstantin058/repos"
        
        guard let url = URL(string: urlStr) else {
            print("Не верный юрл")
            return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Ошибка при выполнении запроса \(error)")
                return
            }
            
            guard let data = data else {
                print("Получены пустые данные")
                return
            }
            
            do {
                
                let reposits = try JSONDecoder().decode([Repositories].self, from: data)
                
                DispatchQueue.main.async {
                    self.reposits = reposits
                    self.myTable.reloadData()
                }
                print(reposits)
            } catch {
                print("Error parsing JSON")
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reposits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        
        cell.configure(myReposit: reposits[indexPath.row])
        
        return cell
    }
    
    
    
}

