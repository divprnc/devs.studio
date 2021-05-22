import 'package:devloperstudio/size_configuration.dart';
import 'package:flutter/material.dart';

class CpExpandedSubTopics extends StatefulWidget {
  @override
  _CpExpandedSubTopicsState createState() => _CpExpandedSubTopicsState();
}

class _CpExpandedSubTopicsState extends State<CpExpandedSubTopics> {
  Map<dynamic, dynamic> cpData = {
    "Algebra": {
      "Fundamental": [
        "Binary Exponentiation",
        "Euclidean algorithm for computing the greatest common divisor"
            "Extended Euclidean Algorithm",
        "Linear Diophantine Equations",
        "Fibonacci Numbers",
      ],
      "Prime Numbers": [
        "Sieve of Eratosthenes",
        "Sieve of Eratosthenes With Linear Time Complexity",
        "Primality tests",
        "Integer factorization",
      ],
      "Number-theoretic functions": [
        "Euler's totient function",
        "Number of divisors / sum of divisors"
      ],
      "Modular arithmetic": [
        "Modular Inverse"
            "Linear Congruence Equation"
            "Chinese Remainder Theorem"
            "Factorial modulo p"
            "Discrete Log"
            "Primitive Root"
            "Discrete Root"
            "Montgomery Multiplication"
      ],
      "Number systems": ["Balanced Ternary", "Gray code"],
      "Miscellaneous": [
        "Enumerating submasks of a bitmask",
        "Arbitrary-Precision Arithmetic",
        "Fast Fourier transform",
        "Operations on polynomials and series",
      ],
    },
    "Data Structures": {
      "Fundamentals": ["Minimum Stack / Minimum Queue", "Sparse Table"],
      "Trees": [
        "Disjoint Set Union",
        "Fenwick Tree",
        "Sqrt Decomposition",
        "Segment Tree",
        "Treap",
        "Sqrt Tree",
        "Randomized Heap",
      ],
      "Advanced": ["Deleting from a data structure in O(T(n)log n)"]
    },
    "Dynamic Programming": {
      "DP optimizations": ["Divide and Conquer DP"],
      "Tasks": [
        "Dynamic Programming on Broken Profile. Problem Parquet",
        "Finding the largest zero submatrix"
      ],
    },
    "String Processing": {
      "Fundamentals": [
        "String Hashing",
        "Rabin-Karp for String Matching",
        "Prefix function - Knuth-Morris-Pratt",
        "Z-function",
        "Suffix Array",
        "Aho-Corasick algorithm"
      ],
      "Advanced": ["Suffix Tree", "Suffix Automaton", "Lyndon factorization"],
      "Tasks": [
        "Expression parsing",
        "Manacher's Algorithm - Finding all sub-palindromes in O(N)",
        "Finding repetitions",
      ]
    },
    "Linear Algebra": {
      "Matrices": [
        "Gauss & System of Linear Equations",
        "Gauss & Determinant",
        "Kraut & Determinant",
        "Rank of a matrix",
      ]
    },
    "Combinatorics": {
      "Fundamentals": [
        "Finding Power of Factorial Divisor",
        "Binomial Coefficients",
        "Catalan Numbers",
      ],
      "Techniques": [
        "The Inclusion-Exclusion Principle",
        "Burnside's lemma / Pólya enumeration theorem",
        "Stars and bars",
        "Generating all K-combinations",
      ],
      "Tasks": [
        "Placing Bishops on a Chessboard",
        "Balanced bracket sequences",
        "Counting labeled graphs",
      ],
    },
    "Numerical Methods": {
      "Search": ["Ternary Search", "Newton's method for finding roots"],
      "Integration": ["Integration by Simpson's formula"]
    },
    "Geometry": {
      "Elementary Operations": [
        "Basic Geometry",
        "Finding the equation of a line for a segment",
        "Intersection Point of Lines",
        "Check if two segments intersect",
        "Intersection of Segments",
        "Circle-Line Intersection",
        "Circle-Circle Intersection",
        "Common tangents to two circles",
        "Length of the union of segments",
      ],
      "Polygons": [
        "Oriented area of a triangle",
        "Area of simple polygon",
        "Check if points belong to the convex polygon in O(log N)",
        "Minkowski sum of convex polygons",
        "Pick's Theorem - area of lattice polygons",
        "Lattice points of non-lattice polygon",
      ],
      "Convex hull": [
        "Convex hull construction using Graham's Scan",
        "Convex hull trick and Li Chao tree",
      ],
      "Sweep-line": [
        "Search for a pair of intersecting segments",
        "Point location in O(log N)",
      ],
      "Miscellaneous": [
        "Finding the nearest pair of points",
        "Delaunay triangulation and Voronoi diagram",
        "Vertical decomposition",
      ]
    },
    "Graphs": {
      "Graph traversal": [
        "Breadth First Search",
        "Depth First Search",
      ],
      "Connected components, bridges, articulations points": [
        "Finding Connected Components",
        "Finding Bridges in O(N+M)",
        "Finding Bridges Online",
        "Finding Articulation Points in O(N+M)",
        "Strongly Connected Components and Condensation Graph",
        "Strong Orientation",
      ],
      "Single-source shortest paths": [
        "Dijkstra - finding shortest paths from given vertex",
        "Dijkstra on sparse graphs",
        "Bellman-Ford - finding shortest paths with negative weights",
        "0-1 BFS",
        "D´Esopo-Pape algorithm",
      ],
      "All-pairs shortest paths": [
        "Floyd-Warshall - finding all shortest paths",
        "Number of paths of fixed length / Shortest paths of fixed length",
      ],
      "Spanning trees": [
        "Minimum Spanning Tree - Prim's Algorithm",
        "Minimum Spanning Tree - Kruskal",
        "Minimum Spanning Tree - Kruskal with Disjoint Set Union",
        "Second best Minimum Spanning Tree - Using Kruskal and Lowest Common Ancestor",
        "Kirchhoff Theorem",
        "Prüfer code",
      ],
      "Cycles": [
        "Checking a graph for acyclicity and finding a cycle in O(M)",
        "Finding a Negative Cycle in the Graph",
        "Eulerian Path"
      ],
      "Lowest common ancestor": [
        "Lowest Common Ancestor",
        "Lowest Common Ancestor - Binary Lifting",
        "Lowest Common Ancestor - Farach-Colton and Bender algorithm",
        "Solve RMQ by finding LCA",
        "Lowest Common Ancestor - Tarjan's off-line algorithm",
      ],
      "Flows and related problems": [
        "Maximum flow - Ford-Fulkerson and Edmonds-Karp",
        "Maximum flow - Push-relabel algorithm",
        "Maximum flow - Push-relabel algorithm improved",
        "Maximum flow - Dinic's algorithm",
        "Maximum flow - MPM algorithm",
        "Flows with demands",
        "Minimum-cost flow",
        "Assignment problem. Solution using min-cost-flow in O (N^5)",
      ],
      "Matchings and related problems": [
        "Bipartite Graph Check",
        "Kuhn' Algorithm - Maximum Bipartite Matching",
      ],
      "Miscellaneous": [
        "Topological Sorting",
        "Edge connectivity / Vertex connectivity",
        "Tree painting",
        "2-SAT",
        "Heavy-light decomposition",
      ]
    },
    "Miscellaneous": {
      "Sequences": [
        "RMQ task (Range Minimum Query - the smallest element in an interval)",
        "Longest increasing subsequence",
        "Search the subsegment with the maximum/minimum sum",
        "K-th order statistic in O(N)",
      ],
      "Game Theory": [
        "Games on arbitrary graphs",
        "Sprague-Grundy theorem. Nim",
      ],
      "Schedules": [
        "Scheduling jobs on one machine",
        "Scheduling jobs on two machines",
        "Optimal schedule of jobs given their deadlines and durations",
      ],
      "Miscellaneous": [
        "Josephus problem",
        "15 Puzzle Game: Existence Of The Solution",
        "The Stern-Brocot Tree and Farey Sequences",
      ]
    }
  };
  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    String topicName = routeArguments['topicName'];
    Map<dynamic, dynamic> finalData = {};
    finalData[topicName] = cpData[topicName];
    List<String> finalKeys = [];
    List<List> finalValues = [];
    var dataValues = finalData[topicName];
    dataValues.forEach((key, values) {
      finalKeys.add(key);
      finalValues.add(values);
    });
    print(finalKeys);
    print(finalValues);
    SizeConfig().init(context);
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 10,
        title: appLogo,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Comptetive Programming",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 8),
              child: Text(
                "$topicName",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                ),
              ),
            ),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
            
              scrollDirection: Axis.vertical,
              itemCount: finalKeys.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.lightBlue[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          finalKeys[index],
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: "OpenSans",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          bottom: 10,
                        ),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: finalValues[index].length,
                          itemBuilder: (BuildContext context, int id) =>
                              Text(finalValues[index][id].toString(), style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "OpenSans",
                              ),)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
