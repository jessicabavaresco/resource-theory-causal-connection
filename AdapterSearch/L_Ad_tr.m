function x = L_Ad_tr(Ups,dims)
% Projects any adapter that is properly trace rescaling to zero.


%Projector on the primed variables
x = Ups - ProjL(L_Ad_Primed(Ups,dims),[1,2,3,4],dims) + ProjL(Ups,[1,2,3,4,5,6,7,8],dims); 


end