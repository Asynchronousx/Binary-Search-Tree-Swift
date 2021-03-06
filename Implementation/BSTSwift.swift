/*********************************************
*                                            *
*                Asynchronousx               *
*                - BST Swift -               *
*                                            *
**********************************************/

//: Playground - noun: a place where people can play
import UIKit

//defining the node class
class TreeNode {
    private var nodeValue: Int
    private var isRoot: Bool
    private var nodeCount: Int
    private var leftChild: TreeNode?
    private var rightChild: TreeNode?
    private var parentNode: TreeNode?
    
    //init
    //calling init to initialize our node
    init (nodeValue: Int, isRoot: Bool = false, nodeCount: Int = 1, leftChild: TreeNode? = nil, rightChild: TreeNode? = nil,
        parentNode: TreeNode? = nil) {
        self.nodeValue = nodeValue
        self.isRoot = isRoot
        self.nodeCount = nodeCount
        self.leftChild = leftChild ?? leftChild
        self.rightChild = rightChild ?? rightChild
        self.parentNode = parentNode ?? parentNode
    }
    
    //getter/setter:
    //value
    var _nodeValue: Int {
        get {
            return nodeValue
        }
        set (newValue) {
            nodeValue = newValue
        }
    }
    
    //nodecount 
    var _nodeCount: Int {
        get {
            return nodeCount
        }
        set (incrementCount) { 
            nodeCount = incrementCount
        }
    }
    
    //leftChild
    var _leftChild: TreeNode? {
        get {
            return leftChild
        }
        set (newLeftChild) {
            leftChild = newLeftChild
        }
    }
    
    //leftChild
    var _rightChild: TreeNode? {
        get {
            return rightChild
        }
        set (newRightChild) {
            rightChild = newRightChild
        }
    }
    
    //parent node
    var _parentNode: TreeNode? {
        get {
            return parentNode
        }
        set (newParentNode) {
            parentNode = newParentNode
        }
    }

}//END TreeNode

//defining the tree class
class Tree {
    private var rootNode: TreeNode?
    
    //init
    init (rootNode: TreeNode? = nil) {
        self.rootNode = rootNode
    }
    
    //deinit
    deinit {
        print("Tree deleted.")
    }
    
    //set and get
    var _Tree: TreeNode? {
        get {
            return rootNode
        }
        set (newTree) {
            self.rootNode = newTree
        }
    }
    
    // *** FUNCTIONS *** 
    
    //------* INSERT *------
    //wrapper function Insert
    func Insert (value: Int) {
        if _Tree == nil { //if the tree doesn't have a root
            let newRoot: TreeNode? = TreeNode(nodeValue: value, isRoot: true) //create a new root
            _Tree = newRoot //assign the new root as root
        }
        else {
            insertNode(value, treeNode: _Tree) //otherwise call the insertNode func
            }
    }
    
    //function to insert a newnode
    private func insertNode (_ valueToInsert: Int, treeNode: TreeNode?) -> Void {
        //three cases: root > value, root < value, root = value
        
        //FIRST CASE
        if valueToInsert > (treeNode?._nodeValue)! { //current node value < value
            if treeNode?._rightChild == nil { //else value != and next is null
                treeNode?._rightChild = TreeNode(nodeValue: valueToInsert) //create the node
                treeNode?._rightChild?._parentNode = treeNode //set the parent
            } else { //else go deeper
                insertNode(valueToInsert, treeNode: treeNode?._rightChild) //call the recursive insert
            }
        } 
        //SECOND CASE
        else if valueToInsert < (treeNode?._nodeValue)! { //current node value > value
            if treeNode?._leftChild == nil { //if next is null
                treeNode?._leftChild = TreeNode(nodeValue: valueToInsert) //create the node
                treeNode?._leftChild?._parentNode = treeNode //set the parent
            } else { // else go deeper
                insertNode(valueToInsert, treeNode: treeNode?._leftChild) //call the recursive insert
            }
        } 
        //THIRD CASE
        else if valueToInsert == (treeNode?._nodeValue)! { //else value = treeNode value
            treeNode?._nodeCount = (treeNode?._nodeCount)! + 1 //increment the counter by one
        }
    }
    
    //*------ TREE SEARCH *------
    //wrapper function search
    func Search (value: Int) -> Bool {
        if _Tree == nil { //base case: tree is null
            print("Tree is not initialized.")
            return false
        }
        else if (_Tree?._nodeValue)! == value { //base case: value is the root
            return true
        }
        else { //complex case: go search it
             return searchNode(value, treeNode: _Tree)
        }
    }
    
    //function to search a value
    private func searchNode (_ valueToSearch: Int, treeNode: TreeNode?) -> Bool {
        //three cases: node is nil,  treeNode value > value, treeNode value < value
        //base case: the node value == value
        
        //FIRST CASE
        if valueToSearch > (treeNode?._nodeValue)! { // value > node value?
            if treeNode?._rightChild != nil { //if possible
                return searchNode(valueToSearch, treeNode: treeNode?._rightChild) //search the right subtree
            }
        }
        //SECOND CASE
        else if valueToSearch < (treeNode?._nodeValue)! { //value < node value?
            if treeNode?._leftChild != nil { //if possible
                return searchNode(valueToSearch, treeNode: treeNode?._leftChild) // search the left subtree
            }
        }
        //THIRD CASE
        else { //node value == value
            return true //return found
        }
        
        
        return false //value not found
        
    }
    
    //------* TREE DELETE *------
    //Tree delete helper
    func Delete (value: Int) {
        if _Tree == nil { //tree empty
           print("Can't delete an empty tree.")
           return
        }
        else if (_Tree?._nodeValue)! == value { //value is the tree root
            _Tree = nil //set the root nil
        }
        else { //else go search it
            deleteNode(value, treeNode: _Tree)
        }
    }

    //function to find a deleted-wannabe value
    private func deleteNode (_ valueToDelete: Int, treeNode: TreeNode?) {
        
        if valueToDelete > (treeNode?._nodeValue)! { //value > current
            if treeNode?._rightChild != nil { //right son exists?
                deleteNode(valueToDelete, treeNode: treeNode?._rightChild) //go search
            } else {
                print("Value not found.") //not found
            }
        }
        else if valueToDelete < (treeNode?._nodeValue)! { //value < current
            if treeNode?._leftChild != nil { //left son exists?
                deleteNode(valueToDelete, treeNode: treeNode?._leftChild) //go search
            } else {
                print("Value not found.") //not found
            }
        }
        else { //value found, remove the node
            removeNode(valueToDelete, treeNode)
        }
    }
    
    //function to remove the node
    private func removeNode (_ valueToDelete: Int, _ treeNode: TreeNode?) {
        
        //In Swift, we can't mutate a let costant passed to the function.
        //so we need to make all the assumption of the cases, find which
        //subtree a node belong to and make all the connections/disconnection
        //of the nodes.
        //We got 4 Cases:
        //1. Node is leaf.
        //2. Node got both children.
        //3. Node got only Left children.
        //4. Node got only Right children.
        
        //FIRST CASE
        if treeNode?._leftChild == nil, treeNode?._rightChild == nil { //node is leaf
            if valueToDelete < (treeNode?._parentNode?._nodeValue)! { //is left leaf
                treeNode?._parentNode?._leftChild = nil //destroy node
            } else { //is right leaf
                treeNode?._parentNode?._rightChild = nil //destroy node
            }
        }
        //SECOND CASE
        else if treeNode?._leftChild != nil, treeNode?._rightChild != nil { //node got both son
            let treeNodeSuccessor = findSuccessor(treeNode) //find inorder successor
            overrideNode(nodeSrc: treeNode, nodeNew: treeNodeSuccessor) //override the node values
            removeNode((treeNodeSuccessor?._nodeValue)!, treeNodeSuccessor) //remove the successor node
        }
        //THIRD CASE
        else if treeNode?._leftChild != nil { //got only left son
            let treeNodeTMP = treeNode //tmp node for linking
            treeNode?._leftChild?._parentNode = treeNode?._parentNode //updating the father
            
            //which subtree?
            if  (treeNode?._nodeValue)! < (treeNode?._parentNode?._nodeValue)! { //left
                treeNode?._parentNode?._leftChild = nil //destroy node
                treeNodeTMP?._parentNode?._leftChild = treeNode?._leftChild //updating the son
            } else { //right
                treeNode?._parentNode?._rightChild = nil //destroy node
                treeNodeTMP?._parentNode?._rightChild = treeNode?._leftChild //updating the son
            }
        }
        //FOURTH CASE
        else if treeNode?._rightChild != nil { //got only right son
            let treeNodeTMP = treeNode //tmp node for linking
            treeNode?._rightChild?._parentNode = treeNode?._parentNode //updating the father
            
            //which subtree?
            if  (treeNode?._nodeValue)! < (treeNode?._parentNode?._nodeValue)! { //left
                treeNode?._parentNode?._leftChild = nil //destroy the node
                treeNodeTMP?._parentNode?._leftChild = treeNode?._rightChild//updating the son
            } else { //right
                treeNode?._parentNode?._rightChild = nil //destroy the node
                treeNodeTMP?._parentNode?._rightChild = treeNode?._rightChild //updating the son
            }
        }
    }
    
    
    private func overrideNode (nodeSrc: TreeNode?, nodeNew: TreeNode?) {
        nodeSrc?._nodeValue = (nodeNew?._nodeValue)!
        nodeSrc?._nodeCount = (nodeNew?._nodeCount)!
        //if other attribute present, just write them here
    }
    
   //*------ SUCCESSORS / PREDECESSORS *------
    //function to find a successor
    private func findSuccessor (_ treeNode: TreeNode?) -> TreeNode? {
        var treeNodeTMP = treeNode?._rightChild
        while treeNodeTMP?._leftChild != nil  {
            treeNodeTMP = treeNodeTMP?._leftChild
        }
        
        return treeNodeTMP
    }
    
    //function to find a predecessor
    private func findPredecessor (_ treeNode: TreeNode?) -> TreeNode? {
        var treeNodeTMP = treeNode?._leftChild
        while treeNodeTMP?._rightChild != nil {
            treeNodeTMP = treeNodeTMP?._rightChild
        }
        
        return treeNodeTMP
    }
    
    //------* TREE PRINT *------
    //Tree traversal helper
    func PrintTree (type: String) {
        
        let lowerCase = type.lowercased() //lower the input
        
        switch type { //switch the choice
        case _ where lowerCase.hasPrefix("in"): //inorder case
            print("In Order:")
            InOrderPrint(treeNode: _Tree)
        
        case _ where lowerCase.hasPrefix("pre"): //preorder case
            print("Pre Order:")
            PreOrderPrint(treeNode: _Tree)
            
        case _ where lowerCase.hasPrefix("post"): //postorder case
            print("Post Order:")
            PostOrderPrint(treeNode: _Tree)
            
        default:
            print("Choice not recognized.")
            print("Try: in order, post order, pre order.")
            print("Case insensitive.")
        }
    }
    
    //In Order
    private func InOrderPrint (treeNode: TreeNode?) {
        if treeNode == nil { //current node = nil
            return //return to previous call
        }
        
        InOrderPrint(treeNode: treeNode?._leftChild) //traversal left subtree
        printDuplicate(treeNode)
        InOrderPrint(treeNode: treeNode?._rightChild) //traversal right subtree
    }
    
    //Pre Order
    private func PreOrderPrint(treeNode: TreeNode?) {
        if treeNode == nil { //current node = nil
            return //return to previous call
        }
        
        printDuplicate(treeNode)
        PreOrderPrint(treeNode: treeNode?._leftChild) //traversal left subtree
        PreOrderPrint(treeNode: treeNode?._rightChild) //traversal right subtree
    }
    
    //Post Order
    private func PostOrderPrint(treeNode: TreeNode?) {
        if treeNode == nil { //current node = nil
            return //return to previous call
        }
        
        PostOrderPrint(treeNode: treeNode?._leftChild) //traversal left subtree
        PostOrderPrint(treeNode: treeNode?._rightChild) //traversal right subtree
        printDuplicate(treeNode)
    }
    
    //print duplicate
    private func printDuplicate (_ treeNode: TreeNode?) {
        if (treeNode?._nodeCount)! > 1 { //if duplicate of that value
            print("\((treeNode?._nodeValue)!) (\((treeNode?._nodeCount)!))") //print value and its counter
        } else { //otherwise
            print((treeNode?._nodeValue)!) //print the value
        }
        //NB: while unwrapping, we can also write print(treeNode?._nodeValue ?? 0)
        //assigning a default value in case of nil, without unwrapping.
    }
    
} //end tree class

//Function to generate a random tree:
func randomTreeGenerator (nodeNumber: Int, maxNodeValue: Int) -> Tree {
    
    //Generate the tree:
    let MyTree = Tree()
    
    //generate the nodes
    for _ in 0..<nodeNumber {
        MyTree.Insert(value: (Int(arc4random_uniform(UInt32(maxNodeValue)))))
    }
    
    //return the tree
    return MyTree
}

//Execution sample:
/*
var MyTree = Tree() 
    OR 
var MyTree = randomTreeGenerator(nodeNumber: 16, maxNodeValue: 100 // with this we generate 16 node with a max value of 100.

do whatever: Insert, Search, Delete, Print.

*/
