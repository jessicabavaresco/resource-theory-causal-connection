function x = ProjL(W,spaces,dims)

%function that traces out the spaces of W given by the array spaces and replaces
%them by maximally mixed states. 
%W = full(W);
%number of subsystems
sys_num = length(dims);

%overall dimension of the spaces that get traced out. Necessary for
%correct normalization
d = prod(dims(spaces));

%create correct permutation of spaces
n = length(spaces);
rem_spaces = 1:sys_num;
rem_spaces([spaces]) = [];
perm1 = [spaces rem_spaces];
perm = 1:sys_num;
perm(perm1) = perm;

x = 1/d*syspermute(TnProduct(eye(d), TrX(W,spaces,dims)),perm,dims(perm1));

end