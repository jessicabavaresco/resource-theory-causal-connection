function [W,J,flag] = maximize_witnessscore(S,d)
% W in Ai Ao Bi Bo

dAi = d(1);
dAo = d(2);
dBi = d(3);
dBo = d(4);

yalmip('clear')

W = sdpvar(dAi*dAo*dBi*dBo,dAi*dAo*dBi*dBo,'hermitian','real');

W_AiAo   = kron(eye(dAi*dAo)/(dAi*dAo),PartialTrace(W,[1 2],[dAi dAo dBi dBo]));
W_AiAoBo = Tensor(eye(dAi*dAo)/(dAi*dAo),PartialTrace(W,[1 2 4],[dAi dAo dBi dBo]),eye(dBo)/dBo);
 
W_BiBo   = kron(PartialTrace(W,[3 4],[dAi dAo dBi dBo]),eye(dBi*dBo)/(dBi*dBo));
W_AoBiBo = kron(PartialTrace(W,[2 3 4],[dAi dAo dBi dBo]),eye(dAo*dBi*dBo)/(dAo*dBi*dBo));

W_Ao     = PermuteSystems(kron(PartialTrace(W,2,[dAi dAo dBi dBo]),eye(dAo)/dAo),[1 4 2 3],[dAi dBi dBo dAo]);
W_Bo     = kron(PartialTrace(W,4,[dAi dAo dBi dBo]),eye(dBo)/dBo);
W_AoBo   = PermuteSystems(kron(PartialTrace(W,[2 4],[dAi dAo dBi dBo]),eye(dAo*dBo)/(dAo*dBo)),[1 3 2 4],[dAi dBi dAo dBo]);

F = [W>=0,trace(W)==dAo*dBo,W_AiAo==W_AiAoBo,W_BiBo==W_AoBiBo,W==W_Ao+W_Bo-W_AoBo];

J = real(trace(W*S) - 1);

flag = solvesdp(F,-J,sdpsettings('solver','mosek','verbose',0,'cachesolvers',1));

J = double(J);
W = double(W);
