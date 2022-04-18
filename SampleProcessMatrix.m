function W = SampleProcessMatrix(d)
% d = [dAi dAo dBi dBo]

dAi = d(1);
dAo = d(2);
dBi = d(3);
dBo = d(4);

W = -eye(dAi*dAo*dBi*dBo);

while min(eig(W))<0 %select only positive semidefinite W
       
    W = RandomDensityMatrix(dAi*dAo*dBi*dBo);
    % sample positive semidefinite matrix

    W = + PermuteSystems(kron(PartialTrace(W,2,[dAi dAo dBi dBo]),eye(dAo)/(dAo)),[1 4 2 3],[dAi dBi dBo dAo]) + kron(PartialTrace(W,4,[dAi dAo dBi dBo]),eye(dBo)/(dBo)) - PermuteSystems(kron(PartialTrace(W,[2 4],[dAi dAo dBi dBo]),eye(dAo*dBo)/(dAo*dBo)),[1 3 2 4],[dAi dBi dAo dBo]) - kron(PartialTrace(W,[3 4],[dAi dAo dBi dBo]),eye(dBi*dBo)/(dBi*dBo)) + kron(PartialTrace(W,[2 3 4],[dAi dAo dBi dBo]),eye(dAo*dBi*dBo)/(dAo*dBi*dBo)) - PermuteSystems(kron(PartialTrace(W,[1 2],[dAi dAo dBi dBo]),eye(dAi*dAo)/(dAi*dAo)),[2 1],[dBi*dBo dAi*dAo]) + PermuteSystems(kron(PartialTrace(W,[1 2 4],[dAi dAo dBi dBo]),eye(dAi*dAo*dBo)/(dAi*dAo*dBo)),[2 3 1 4],[dBi dAi dAo dBo]); 
    % project into valid subspace
    
    W = dAo*dBo*W/trace(W);
    % adjust total trace
    
end

