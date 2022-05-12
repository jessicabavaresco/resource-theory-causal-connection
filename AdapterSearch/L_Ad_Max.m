function x = L_Ad_Max(Ups,dims)
% Projects any adapter that maps free to free to zero.


%Projector on the primed variables
x = Ups - ProjL(L_Ad_Primed(Ups,dims),[2,4],dims) + ProjL(L_Ad_Primed(Ups,dims),[2,4,6,8],dims); 


end