function x = Proj_Adapt(Ups,dims)

%Function that projects onto the space of proper adapters

x = L_Ad_Max(L_Ad_tr(L_NST(Ups,dims),dims),dims);

end
