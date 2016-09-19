// $( document ).ready(function() {
//   var easystar = new EasyStar.js();

//   var grid = [[0,0,0,0,0],
//               [0,0,0,0,0],
//               [0,0,1,0,0],
//               [0,0,1,0,0],
//               [0,0,0,0,0]];

//   easystar.setGrid(grid);

//   easystar.setAcceptableTiles([0]);

//   var checkPathLength = function( path ) {
//     path.forEach(function(step){
//       console.log(step);
//     });
//   };

//   easystar.findPath(0, 0, 4, 0, function ( path ) {
//     checkPathLength(path);
//   });


//   // easystar.findPath(0, 0, 4, 0, function( path ) {

//   //   first_x = path[0].x;
//   //     if (path === null) {
//   //         console.log("Path was not found.");
//   //     } else {
//   //         console.log("Path was found. " + path[0].x + " " + path[0].y);
//   //     }
//   // });
//   easystar.calculate();
// });

// $( document ).ready(function() {
//   var matrix = [
//   //   0  1  2  3  4
//       [0, 0, 0, 1, 0], //0
//       [1, 0, 0, 0, 1], //1
//       [0, 0, 1, 0, 0], //2
//   ];

//   var grid = new PF.Grid(matrix);

//   var finder = new PF.AStarFinder();

//   var path = finder.findPath(1, 2, 4, 2, grid);
//   console.log(path[0]);
// });
