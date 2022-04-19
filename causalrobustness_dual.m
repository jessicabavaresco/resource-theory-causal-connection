function [S,Rc,flag] = causalrobustness_dual(W,d)

dAi = d(1);
dAo = d(2);
dBi = d(3);
dBo = d(4);

yalmip('clear')

S = sdpvar(dAi*dAo*dBi*dBo,dAi*dAo*dBi*dBo,'hermitian','complex');
U = sdpvar(dAi*dAo*dBi*dBo,dAi*dAo*dBi*dBo,'hermitian','complex');
V = sdpvar(dAi*dAo*dBi*dBo,dAi*dAo*dBi*dBo,'hermitian','complex');

U_Bo     = kron(PartialTrace(U,4,[dAi dAo dBi dBo]),eye(dBo)/dBo);
U_BiBo   = kron(PartialTrace(U,[3 4],[dAi dAo dBi dBo]),eye(dBi*dBo)/(dBi*dBo));
U_AoBiBo = kron(PartialTrace(U,[2 3 4],[dAi dAo dBi dBo]),eye(dAo*dBi*dBo)/(dAo*dBi*dBo));

V_Ao     = PermuteSystems(kron(PartialTrace(V,2,[dAi dAo dBi dBo]),eye(dAo)/dAo),[1 4 2 3],[dAi dBi dBo dAo]);
V_AiAo   = kron(eye(dAi*dAo)/(dAi*dAo),PartialTrace(V,[1 2],[dAi dAo dBi dBo]));
V_AiAoBo = Tensor(eye(dAi*dAo)/(dAi*dAo),PartialTrace(V,[1 2 4],[dAi dAo dBi dBo]),eye(dBo)/dBo);

F = [S>=0,
    (1/(dAo*dBo))*eye(dAi*dAo*dBi*dBo)+U-U_Bo+U_BiBo-U_AoBiBo-S>=0,
    (1/(dAo*dBo))*eye(dAi*dAo*dBi*dBo)+V-V_Ao+V_AiAo-V_AiAoBo-S>=0];

Rc = trace(W*S) - 1;

flag = solvesdp(F,-Rc,sdpsettings('solver','mosek','verbose',0,'cachesolvers',1));

Rc = double(Rc);
S = double(S);
    
    
    
    
    