var quizQuestions = [
  {},
  {
    "1": {
      "Ques":
          "Which of the followings is/are automatically added to every class, if we do not write our own.",
      "Code": null,
    },
    "2": {
      "Ques": "When a copy constructor may be called?",
      "Code": null,
    },
    "3": {
      "Ques": "Output of following program?",
      "Code": '''
              #include<iostream>
using namespace std;
              class Point {
                  Point() { cout << "Constructor called"; }
              };
              
              int main()
              {
                Point t1;
                return 0;
              }
            '''
    },
    "4": {
      "Ques": "Output of following program?",
      "Code": '''#include<iostream>
using namespace std;
class Point {
public:
    Point() { cout << "Constructor called"; }
};
 
int main()
{
   Point t1, *t2;
   return 0;
}
            '''
    },
    "5": {
      "Ques": "Output of following program?",
      "Code": '''#include<iostream>
using namespace std;
 
class X 
{
public:
    int x;
};
 
int main()
{
    X a = {10};
    X b = a;
    cout << a.x << " " << b.x;
    return 0;
}
            '''
    },
    "6": {
      "Ques": "Output of following program?",
      "Code": '''#include <iostream>
using namespace std;
 
class Point
{
    int x, y;
public:
   Point(const Point &p) { x = p.x; y = p.y; }
   int getX() { return x; }
   int getY() { return y; }
};
 
int main()
{
    Point p1;
    Point p2 = p1;
    cout << "x = " << p2.getX() << " y = " << p2.getY();
    return 0;
}
            '''
    },
    "7": {
      "Ques": "Output of following program?",
      "Code": '''#include <iostream>
using namespace std;
 
class Point
{
    int x, y;
public:
   Point(int i = 0, int j = 0) { x = i; y = j; }
   int getX() { return x; }
   int getY() { return y; }
};
 
int main()
{
    Point p1;
    Point p2 = p1;
    cout << "x = " << p2.getX() << " y = " << p2.getY();
    return 0;
}
            '''
    },
    "8": {
      "Ques": "Output of following program?",
      "Code": '''#include<iostream>
#include<stdlib.h>
using namespace std;
 
class Test
{
public:
   Test()
   { cout << "Constructor called"; }
};
 
int main()
{
    Test *t = (Test *) malloc(sizeof(Test));
    return 0;
}
            '''
    },
    "9": {
      "Ques": "Output of following program?",
      "Code": '''#include <iostream>
using namespace std;
 
class Test
{
public:
      Test() { cout << "Hello from Test() "; }
} a;
 
int main()
{
    cout << "Main Started ";
    return 0;
}
            '''
    },
    "10": {
      "Ques": "Predict the Output of following program?",
      "Code": '''#include<iostream>
using namespace std;
class Point {
    int x;
public:
    Point(int x) { this->x = x; }
    Point(const Point p) { x = p.x;}
    int getX() { return x; }
};
 
int main()
{
   Point p1(10);
   Point p2 = p1;
   cout << p2.getX();
   return 0;
}
            '''
    },
  },
  {
    "1": {
      "a": "Copy Constructor",
      "b": "Assignment Operator",
      "c": "A constructor without any parameter",
      "d": "All of the above"
    },
    "2": {
      "a": "When an object of the class is returned by value",
      "b":
          "When an object is constructed based on another object of the same class",
      "c": "When compiler generates a temporary object",
      "d": "All of the above"
    },
    "3": {
      "a": "Compile Time Error",
      "b": "Run Time Error",
      "c": "Constructor Called",
      "d": "Non of these"
    },
    "4": {
      "a": "Compile Time Error",
      "b": "Constructor Called",
      "c": "Constructor Called\nConstructor Called",
      "d": "Non of these"
    },
    "5": {
      "a": "Compile Time Error",
      "b": "10 Followed by Garbage value",
      "c": "10 10",
      "d": "10 0"
    },
    "6": {
      "a": "x = garbage value y = garbage value",
      "b": "x = 0 y = 0",
      "c": "Compile Error",
      "d": "None of these"
    },
    "7": {
      "a": "x = garbage value y = garbage value",
      "b": "x = 0 y = 0",
      "c": "Compile Error",
      "d": "None of these"
    },
    "8": {
      "a": "Compile Time Error",
      "b": "Run Time Error",
      "c": "Constructor Called",
      "d": "Empty"
    },
    "9": {
      "a": "Main Started",
      "b": "Main Started Hello from Test()",
      "c": "Hello from Test() Main Started",
      "d": "Compiler Error: Global objects are not allowed"
    },
    "10": {
      "a": "Compiler Error: p must be passed by reference",
      "b": "10",
      "c": "Garbage Value",
      "d": "None of these"
    }
  },
  {
    "1": "All of the above",
    "2": "All of the above",
    "3": "Compile Time Error",
    "4": "Constructor Called",
    "5": "Compile Time Error",
    "6": "x = 0 y = 0",
    "7": "None of these",
    "8": "Constructor Called",
    "9": "Hello from Test() Main Started",
    "10": "Compiler Error: p must be passed by reference"
  }
];
