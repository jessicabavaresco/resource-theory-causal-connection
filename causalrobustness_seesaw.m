function [W_new,initial_Rc,final_Rc,flag_value] = causalrobustness_seesaw(W,d)
% W in Ai Ao Bi Bo
% d = [dAi dAo dBi dBo]

dAi = d(1);
dAo = d(2);
dBi = d(3);
dBo = d(4);

[S,initial_Rc,~] = causalrobustness_dual(W,d);

gap = 1;
precision = 10^(-6);
count = 0;
old_Rc = initial_Rc;
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
    
    [S,Rc,flag] = causalrobustness_dual(W,d);
    
    if flag.problem~=0
        dual_problem = flag.problem 
        info         = flag.info 
        flag_value   = 1;
        %pause
    end
        
    gap     = abs(old_Rc - Rc);
    old_Rc   = Rc;
    count   = count + 1;
end
%toc;

final_Rc = Rc;
W_new = W;
