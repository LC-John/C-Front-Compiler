#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <vector>
#include "tree.h"
using namespace std;

TreeNode::TreeNode(NodeType _type, string _str)
{
    type = _type;
    str = _str;
    parent = NULL;
    children = vector<TreeNode*>();
#ifdef TREE_NODE_DEBUG
    printNode(0);
#endif // TREE_NODE_DEBUG
}

TreeNode::~TreeNode()
{
#ifdef TREE_NODE_DEBUG
    cout << "del " << str << endl;
#endif // TREE_NODE_DEBUG
    for (int i = 0; i < children.size(); i++)
        if (children[i] != NULL)
            delete children[i];
}

int TreeNode::addChild(TreeNode* _child)
{
    if (type == Ter)
        return -1;
    children.push_back(_child);
    return children.size();
}

void TreeNode::printNode(int _depth)
{
    for (int i = 0; i < _depth; i++)
        fprintf(yyout, "\t");
    switch(type)
    {
        case Ter: fprintf(yyout, "[#] "); break;
        case Non: fprintf(yyout, "[*] "); break;
        default: break;
    }
    fprintf(yyout, "%s\n", str.c_str());
}

void TreeNode::printTree(int _depth)
{
    printNode(_depth);
    for (int i = 0; i < children.size(); i++)
        children[i]->printTree(_depth+1);
}

#ifdef TREE_NODE_DEBUG
int main()
{
    TreeNode* root = new TreeNode(Non, "root");
    root->addChild(new TreeNode(Non, "1-1"));
    root->addChild(new TreeNode(Non, "1-2"));
    root->addChild(new TreeNode(Ter, "1-3"));
    root->children[0]->addChild(new TreeNode(Non, "2-1"));
    root->children[0]->addChild(new TreeNode(Ter, "2-2"));
    root->children[1]->addChild(new TreeNode(Ter, "2-3"));
    root->children[1]->addChild(new TreeNode(Non, "2-4"));
    root->children[0]->children[0]->addChild(new TreeNode(Ter, "3-1"));
    root->children[1]->children[1]->addChild(new TreeNode(Ter, "3-1"));
    printf("\n");
    root->printTree(0);
    printf("\n");
    delete root;
    return 0;
}
#endif // TREE_NODE_DEBUG