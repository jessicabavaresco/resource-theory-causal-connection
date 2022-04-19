function [W_sep,Rc,flag] = causalrobustness_primal(W,d)
% hilbert space order of W: AI AO BI BO
% input: W is a valid process matrix, d is a dimension vector d = [dAi dAo dBi dBo]

dAi = d(1);
dAo = d(2);
dBi = d(3);
dBo = d(4);

yalmip('clear');

W_AB = sdpvar(dAi*dAo*dBi*dBo,dAi*dAo*dBi*dBo,'hermitian','complex');
W_BA = sdpvar(dAi*dAo*dBi*dBo,dAi*dAo*dBi*dBo,'hermitian','complex');

F = [W_AB+W_BA-W>=0
    W_AB>=0,W_BA>=0,
    W_AB==kron(PartialTrace(W_AB,4,[dAi dAo dBi dBo]),eye(dBo)/dBo),
    PartialTrace(W_AB,[3 4],[dAi dAo dBi dBo])==kron(PartialTrace(W_AB,[2 3 4],[dAi dAo dBi dBo]),eye(dAo)/dAo),
    W_BA==PermuteSystems(kron(PartialTrace(W_BA,2,[dAi dAo dBi dBo]),eye(dAo)/dAo),[1 4 2 3],[dAi dBi dBo dAo]),
    PartialTrace(W_BA,[1 2],[dAi dAo dBi dBo])==kron(PartialTrace(W_BA,[1 2 4],[dAi dAo dBi dBo]),eye(dBo)/dBo),
    ];

Rc = (1/(dAo*dBo))*trace(W_AB+W_BA) - 1;

flag = solvesdp(F,Rc,sdpsettings('solver','mosek','verbose',0,'cachesolvers',1));


W_sep = double(W_AB+W_BA);
W_sep = (dAo*dBo)*W_sep/trace(W_sep);
Rc = double(Rc);