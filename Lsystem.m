function Lsystem(numberOfIterations,seed,rules,delta,len,title)
% Lsystem: a high-level compute function that calls the functions that expand and draw the L-system 
% Inputs
% numberOfIterations: number of times rules are applied
% seed == the initial point from which growth occurs
% rules == instructions for substitution
% delta == scalar incremental angle size in Degrees
% len == length of the base line segments corresponding to the symbols F and G
% colorVar == line color
% original code at http://courses.cit.cornell.edu/bionb441/LSystem/index.html
% modified by Michael Robinette 2/1/2017


x = LsysExpand(numberOfIterations,seed,rules);
LsysDraw(x,delta,len,title);

end


