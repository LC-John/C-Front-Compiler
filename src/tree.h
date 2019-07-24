#ifndef PARSER_NODES
#define PARSER_NODES

#include <string>
#include <vector>
using namespace std;

extern FILE* yyout;

enum NodeType
{
    Ter, Non
};

struct TreeNode
{
public:
    NodeType type;
    string str;
    TreeNode* parent;
    vector<TreeNode*> children;

    TreeNode(NodeType _type, string _str);
    ~TreeNode();
    int addChild(TreeNode* _child);
    void printTree(int depth);
private:
    void printNode(int depth);
};

#endif // !PARSER_NODES