%Program to find -- via a see-saw -- a legal and free-preserving adapter
%that maps a fully-signalling A \prec B processe to a causally non-separable process

%clear existing yalmip problems
yalmip('clear');

%Preliminary definitions
Zero = [[1 0];[0 0]];
dims = [2,2,2,2,2,2,2,2];
dimUnprimed = prod(dims(1:4));
dimPrimed = prod(dims(5:8));
counter = 1;

%Fully-signalling process
WFully = TnProduct(Zero, MaxEnt(2),eye(2));


%Number and depth of iterations
N = 10; %Number of different initial points
depth = 10; %Number of rounds in the seesaw


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Main Program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=1:N
    i
    %Random Witness for the initialization
    Wit = Rand_Witness();
    
    for k=1:depth
        k
        %Optimize the Adapter
        %%%%%%%%%%%%%%%%%%%%%
        %Define Adapter and its projections
        Ups = sdpvar(prod(dims),prod(dims),'hermitian','complex');
        UpsLeg = L_NST(Ups,dims);
        UpsTr = L_Ad_tr(Ups,dims);
        UpsFree = L_Ad_Max(Ups,dims);

	%SDP Constraints
        F = [Ups>=0,
            trace(Ups) == dims(1)*dims(3)*dims(6)*dims(8),
            UpsLeg - Ups == zeros(prod(dims),prod(dims)),
            UpsTr - Ups ==zeros(prod(dims),prod(dims)),
            UpsFree - Ups == zeros(prod(dims),prod(dims))];

	%Causal robustness of the resulting process matrix after the action of the adapter
        J = trace( mtimes(TrX(mtimes(Ups,TnProduct(transpose(WFully),eye(dimPrimed))),[1],[dimUnprimed,dimPrimed]), Wit)) - 1

	%Find the best Adapter for the given witness of causal non-separability
        Result = solvesdp(F,-J,sdpsettings('solver','scs','verbose',1,'cachesolvers',1))

        J = double(J);
        Ups = double(Ups);
        
        %Make proper Adapter, in case the solution is not ideal
        Ups = Proj_Adapt(Ups,dims);
        Ups = dims(1)*dims(3)*dims(6)*dims(8)*Ups/trace(Ups);
        Lmin = min(real(eig(Ups)));
        if Lmin <= -1e-7
            d = dims(2)*dims(4)*dims(5)*dims(7);
            p = 1/(1-d*Lmin)
            Ups = p*Ups + (1-p)*eye(prod(dims))/d;
        end
        
        %New process matrix after the action of the adapter
        W = TrX(mtimes(Ups,TnProduct(transpose(WFully),eye(dimPrimed))),[1],[dimUnprimed,dimPrimed]);
        
        %Optimize witness
        [R, Wit] = Caus_Wit(W, dims(5:8));
        J = -real(trace(mtimes(W,Wit)))
        Wit = full(Wit);
    end
    
    %Save the resulting adapter, witness and value of the causal non-separability
    if J >=0
        nameUps = strcat('Ups_',num2str(counter), '.mat')
        save([nameUps],'Ups')
        nameWit = strcat('Witness_',num2str(counter), '.mat')
        save([nameWit],'Wit')
        nameNonCaus = strcat('NonCaus_',num2str(counter), '.mat')
        save([nameNonCaus],'J')
        nameProcMat = strcat('ProcMat_',num2str(counter), '.mat')
        save([nameNonCaus],'W')
        
        counter = counter +1;
    end
        
end
