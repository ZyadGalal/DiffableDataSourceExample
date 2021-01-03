//
//  ViewController.swift
//  TableviewDiffableDataSource
//
//  Created by Zyad Galal on 03/01/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: UITableViewDiffableDataSource<Int, Student>?
    var snapShot = NSDiffableDataSourceSnapshot<Int, Student>()
    var students: [Student] = [Student(id: UUID(), name: "zyad") , Student(id: UUID(), name: "mahmoud") , Student(id: UUID(), name: "galal el-din") , Student(id: UUID(), name: "soliman")]
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = UITableViewDiffableDataSource<Int , Student>(tableView: tableView) { (table, index, student) -> UITableViewCell? in
            let cell = table.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = student.name
            cell.detailTextLabel?.text = "\(student.id)"
            return cell
        }
        tableView.dataSource = dataSource

    }
    
    override func viewDidAppear(_ animated: Bool) {

        snapShot.appendSections([0])
        
        snapShot.appendItems(students, toSection: 0)
        dataSource?.apply(snapShot)
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        students.append(Student(id: UUID(), name: "zozz"))
        snapShot.appendItems(students)
        dataSource?.apply(snapShot)
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        snapShot.deleteItems([students[indexPath.row]])
        students.remove(at: indexPath.row)
        dataSource?.apply(snapShot)
    }
}
struct Student: Hashable {
    let id: UUID
    let name: String
}
