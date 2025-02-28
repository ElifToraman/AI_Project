% For each cell, decide whether it is kept (i.e. not crossed out).
{ in(R,C) } :- cell(R,C,_).

% Ensure at least one cell is kept.
:- not 1 { in(R,C) : cell(R,C,_) }.

% Constraint 1: In each row, no duplicate symbol among kept cells.
:- cell(R,C,S), cell(R,C2,S), C < C2, in(R,C), in(R,C2).

% Constraint 1: In each column, no duplicate symbol among kept cells.
:- cell(R,C,S), cell(R2,C,S), R < R2, in(R,C), in(R2,C).

% Define neighbor relation (cells adjacent horizontally or vertically).
neighbor(R,C,R1,C) :- cell(R,C,_), cell(R1,C,_), R1 = R+1.
neighbor(R,C,R1,C) :- cell(R,C,_), cell(R1,C,_), R1 = R-1.
neighbor(R,C,R,C1) :- cell(R,C,_), cell(R,C1,_), C1 = C+1.
neighbor(R,C,R,C1) :- cell(R,C,_), cell(R,C1,_), C1 = C-1.

% Constraint 2: Two adjacent cells must not both be crossed out.
:- cell(R,C,_), neighbor(R,C,R1,C1), not in(R,C), not in(R1,C1).

% Connectivity:
% Select exactly one kept cell to serve as the root.
1 { root(R,C) : in(R,C) } 1.

% Propagate reachability from the root over kept cells.
reachable(R,C) :- root(R,C).
reachable(R,C) :- reachable(R1,C1), neighbor(R1,C1,R,C), in(R,C).

% Constraint 3: Every kept cell must be reachable to the root.
:- in(R,C), not reachable(R,C).

kept(R,C,S) :- in(R,C), cell(R,C,S).
% Show the kept cells (non-crossed-out positions).
#show kept/3.