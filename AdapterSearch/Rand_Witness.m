function x= Rand_Witness()
% Computation of a random witness for a two-player qubit process matrix, with the 
%Hilbert spaces in the order A1A2B1B2


%Random state (used for randomization of the witness)
FiducState = zeros(16,16);
FiducState(1,1) = 1;
U = randU(16);
initial = mtimes(mtimes(U,FiducState),U');

dims=[2,2,2,2];
Nout = dims(4)*dims(2);
N=16;

cvx_begin quiet
    %variables for the witness, i.e. the witness itself and the auxiliary 
    %variables Sp and Sigp (see Araujo et al. NJP)
    variable S(N,N) hermitian;
    variable Sp(N,N) hermitian;
    variable Sigp(N,N) hermitian semidefinite;
    
    %Criterion: Minimize trace with process matrix W: The more negative, the more
    %entangled
    minimize norm(S-initial);
    
    subject to
        %Normalization condition
        S == Lv(Sp,dims);
        TrX(Sp,[2],dims) == semidefinite(dims(1)*dims(3)*dims(4))
        TrX(Sp,[4],dims) == semidefinite(dims(1)*dims(2)*dims(3));
        eye(N)/Nout - S == Lv(Sigp,dims);
cvx_end
x=S;
end
