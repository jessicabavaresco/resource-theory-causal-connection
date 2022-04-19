function [W_par,Rs,flag] = signallingrobustness_primal(W,d)
% hilbert space order of W: Ai Ao Bi Bo
% input: W is a valid process matrix, d is a dimension vector d = [dAi dAo dBi dBo]

dAi = d(1);
dAo = d(2);
dBi = d(3);
dBo = d(4);

yalmip('clear');

rho = sdpvar(dAi*dBi,dAi*dBi,'hermitian','complex');

F = [rho>=0,PermuteSystems(kron(rho,eye(dAo*dBo)),[1 3 2 4],[dAi dBi dAo dBo])-W>=0];

Rs = trace(rho) - 1;

flag = solvesdp(F,Rs,sdpsettings('solver','mosek','verbose',0,'cachesolvers',1));

Rs = double(Rs);
rho   = double(rho)/trace(double(rho));
W_par = PermuteSystems(kron(rho,eye(dAo*dBo)),[1 3 2 4],[dAi dBi dAo dBo]);


