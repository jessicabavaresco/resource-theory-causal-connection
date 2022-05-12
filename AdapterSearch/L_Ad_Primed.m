function x = L_Ad_Primed(Ups,dims)
% Projects any hermitian matrix onto the primed subspaces of legal process adapters
%Ordering is AI'AO'BI'BO'


%Projector on the primed variables
x = Ups - ProjL(Ups,[8],dims) + ProjL(Ups,[7,8],dims) - ProjL(Ups,[6],dims) + ProjL(Ups,[6,8],dims) ...
-ProjL(Ups,[6,7,8],dims) + ProjL(Ups,[5,6],dims) - ProjL(Ups,[5,6,8],dims) + ProjL(Ups,[5,6,7,8],dims); 

end