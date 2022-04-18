function Y = adaptor_feasibility(Win,Wout,din,dout)
% Win in Ai'Ao'Bi'Bo' (Hilbert space order)
% Wout in Ai Ao Bi Bo
% Y in Ai' Ai Ao Ao' Bi' Bi Bo Bo'
% din = [dAip dAop dBip dBop]
% dout = [dAi dAo dBi dBo]

dAip = din(1);
dAop = din(2);
dBip = din(3);
dBop = din(4);

dAi = dout(1);
dAo = dout(2);
dBi = dout(3);
dBo = dout(4);

dB = dBip*dBi*dBo*dBop;
dA = dAip*dAi*dAo*dAop;

d = [dAip dAi dAo dAop dBip dBi dBo dBop];

yalmip('clear')

Y = sdpvar(dAip*dAi*dAo*dAop*dBip*dBi*dBo*dBop,dAip*dAi*dAo*dAop*dBip*dBi*dBo*dBop,'hermitian','complex');

F = [Y>=0,
    PartialTrace(Y,4,d)==PermuteSystems(kron(PartialTrace(Y,[3 4],d),eye(dAo)/dAo),[1 2 4 3],[dAip dAi dB dAo]),
    PartialTrace(Y,8,d)==kron(PartialTrace(Y,[7 8],d),eye(dBo)/dBo),
    PartialTrace(Y,[2 3 4],d)==kron(eye(dAip)/dAip,PartialTrace(Y,1,[dA dB])),
    PartialTrace(Y,[6 7 8],d)==kron(PartialTrace(Y,2,[dA dB]),eye(dBip)/dBip),
    PartialTrace(Y,[4 5],[dAip dAi dAo dAop dB])==kron(PartialTrace(Y,[3 4 5],[dAip dAi dAo dAop dB]),eye(dAo)/dAo),
    PartialTrace(Y,[2 3 4 5],[dAip dAi dAo dAop dB])==trace(Y)*eye(dAip)/dAip,
    PartialTrace(Y,[1 5],[dA dBip dBi dBo dBop])==kron(PartialTrace(Y,[1 4 5],[dA dBip dBi dBo dBop]),eye(dBo)/dBo),
    PartialTrace(Y,[1 3 4 5],[dA dBip dBi dBo dBop])==trace(Y)*eye(dBip)/dBip,
    Wout==PartialTrace(PartialTranspose(Y,[1 4 5 8],d)*PermuteSystems(kron(eye(dAi*dAo*dBi*dBo),Win),[5 1 2 6 7 3 4 8],[dAi dAo dBi dBo dAip dAop dBip dBop]),[1 4 5 8],d)];


flag = solvesdp(F,[],sdpsettings('solver','scs','verbose',1,'cachesolvers',1))

Y = double(Y);

