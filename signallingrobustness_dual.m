function [S,Rs,flag] = signallingrobustness_dual(W,d)

dAi = d(1);
dAo = d(2);
dBi = d(3);
dBo = d(4);

yalmip('clear');

S = sdpvar(dAi*dAo*dBi*dBo,dAi*dAo*dBi*dBo,'hermitian','complex');

F = [S>=0,eye(dAi*dBi)-PartialTrace(S,[2 4],d)>=0];

Rs = trace(W*S) - 1;

flag = solvesdp(F,-Rs,sdpsettings('solver','mosek','verbose',0,'cachesolvers',1));

Rs = double(Rs);
S = double(S);

