function [W_new,initial_Rs,final_Rs,flag_value] = signallingrobustness_seesaw(W,d)
% W in Ai Ao Bi Bo
% d = [dAi dAo dBi dBo]

dAi = d(1);
dAo = d(2);
dBi = d(3);
dBo = d(4);

[S,initial_Rs,~] = signallingrobustness_dual(W,d);

gap = 1;
precision = 10^(-6);
count = 0;
old_Rs = initial_Rs;
flag_value = 0;

%tic;
while gap>precision
    
    [W,~,flag] = maximize_witnessscore(S,d);
    
    if flag.problem~=0
        maxwit_problem = flag.problem %#ok<*NOPRT,*NASGU> 
        info           = flag.info 
        flag_value     = 1;
        %pause
    end
    
    [S,Rs,flag] = signallingrobustness_dual(W,d); 
    
    if flag.problem~=0
        dual_problem = flag.problem 
        info         = flag.info 
        flag_value   = 1;
        %pause
    end
        
    gap     = abs(old_Rs - Rs);
    old_Rs  = Rs;
    count   = count + 1;
end
%toc;

final_Rs = Rs;
W_new = W;
