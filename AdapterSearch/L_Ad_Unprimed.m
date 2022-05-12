function x = L_Ad_Unprimed(Ups,dims)
% Projects any hermitian matrix onto the primed subspaces of legal process adapters
%Ordering is AIAOBIBO


%Projector on the unprimed variables
x = Ups - ProjL(Ups,[4],dims) + ProjL(Ups,[3,4],dims) - ProjL(Ups,[2],dims) + ProjL(Ups,[2,4],dims) ...
-ProjL(Ups,[2,3,4],dims) + ProjL(Ups,[1,2],dims) - ProjL(Ups,[1,2,4],dims) + ProjL(Ups,[1,2,3,4],dims); 




end