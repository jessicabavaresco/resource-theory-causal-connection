function x = L_NST(Ups,dims)
% Projects any hermitian matrix onto the subspace of legal adapters, legal
% in the sense of mapping non-signalling to non-signalling


%Compute full projector
x = Ups - L_Ad_Primed(Ups,dims) + L_Ad_Unprimed(L_Ad_Primed(Ups,dims),dims) ;

end