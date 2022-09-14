## Code to accompany: *[Resource theory of causal connection](https://arxiv.org/abs/2110.03233)*
#### Simon Milz, Jessica Bavaresco, and Giulio Chiribella

This is a repository for the code used in the article "*Resource theory of causal connection*, Simon Milz, Jessica Bavaresco, and Giulio Chiribella, [*Quantum* **6**, 788 (2022)](https://quantum-journal.org/papers/q-2022-08-25-788/), [arXiv:2110.03233 [quant-ph]](https://arxiv.org/abs/2110.03233)".

All code is written in MATLAB and requires:
- [Yalmip](https://yalmip.github.io) - a free MATLAB toolbox for rapid prototyping of optimization problems
- [MOSEK](https://www.mosek.com) - a software package for solving mathematical optimization problems (under the free personal academic license)
- [SCS](https://www.cvxgrp.org/scs/index.html) - a numerical optimization package for solving large-scale convex cone problems
- [QETLAB](http://www.qetlab.com/) - a free MATLAB toolbox for quantum entanglement theory

For the code in the folder [AdapterSearch/](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/AdapterSearch) see extra requirements below.

This repository consists of the following:

#### CODE

- [SampleProcessMatrix.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/SampleProcessMatrix.m):
given the subspace dimensions, this algorithm samples a valid bipartite process matrix according to the method described in Sec. 6.2 of the paper.

- [adapter_feasibility.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/adaptor_feasibility.m):
given two process matrices, Win and Wout, this feasibility SDP checks whether or not there exists a free adapter Y that can transform Win into Wout.

- [causalrobustness_primal.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/causalrobustness_primal.m):
given a bipartite process matrix W, calculates the value of its causal robustness R_c(W) by solving the primal SDP problem, as defined in Eq. (97) of the paper.

- [causalrobustness_dual.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/causalrobustness_dual.m):
given a bipartite process matrix W, calculates the value of its causal robustness R_s(W) by solving the dual SDP problem, as defined in Eq. (98) of the paper. Also returns a witness of causal nonseparability S that, when the input process is causally nonseparable, can certify this property.

- [causalrobustness_seesaw.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/causalrobustness_seesaw.m): 
seesaw algorithm that searches for the bipartite process matrix W of a certain given dimension that has maximal causal robustness. It does so by taking some input process matrix as "seed" and then iterating the dual causal robustness SDP with the witness score maximization SDP, until the difference between the values of the signalling robustness in two consecutive rounds is smaller than a predefined gap. Details can be found in Sec. 6.3. Uses [causalrobustness_dual.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/causalrobustness_dual.m) and [maximize_witnessscore.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/maximize_witnessscore.m).

- [maximize_witnessscore.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/maximize_witnessscore.m):
given a witness S (of signalling or causal nonseparability), finds the process matrix W that maximally violates this witness and returns the witness score J.

- [signallingrobustness_primal.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/signallingrobustness_primal.m):
given a bipartite process matrix W, calculates the value of its signalling robustness R_s(W) by solving the primal SDP problem, as defined in Eq. (71) of the paper.

- [signallingrobustness_dual.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/signallingrobustness_dual.m):
given a bipartite process matrix W, calculates the value of its signalling robustness R_s(W) by solving the dual SDP problem, as defined in Eq. (72) of the paper. Also returns a witness of signalling (aka witness of causal connection) S that, when the input process is signalling, can certify this property. 

- [signallingrobustness_seesaw.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/signallingrobustness_seesaw.m):
seesaw algorithm that searches for the bipartite process matrix W of a certain given dimension that has maximal signalling robustness. It does so by taking some input process matrix as "seed" and then iterating the dual signaling robustness SDP with the witness score maximization SDP, until the difference between the values of the signalling robustness in two consecutive rounds is smaller than a predefined gap. Details can be found in Sec. 6.3. Uses [signallingrobustness_dual.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/signallingrobustness_dual.m) and [maximize_witnessscore.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/maximize_witnessscore.m).

- [AdapterSearch/](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/AdapterSearch): the code in this folder additionally requires [CVX](http://cvxr.com/) - a free MATLAB toolbox for rapid prototyping of optimization problems and makes use of functions from the [Quantinf](https://www.dr-qubit.org/matlab.html) package for MATLAB/Octave.
  - [AdapterSearch/Search_Caus_non_sep.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/AdapterSearch/Search_Caus_non_sep.m): 
  seesaw algorithm that searches for a legal and free-preserving (LFP) adapter (see Sec. 3.2.3 of the paper) that can transform a fully one-way signalling process into a causally nonseparable process. It does so by taking some causal robustness witness as "seed" and then iterating an SDP that, given the causal robustness witness, finds a LFP adapter that transforms a fully one-way signalling process into the resulting process that can violate the given witness the most; and an SDP that takes the resulting process and computes a specific witness of causal robustness that can detect it. This seesaw runs for a pre-defined number of initial seeds and a pre-defined number of rounds.
  - All other functions in the folder [AdapterSearch](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/AdapterSearch) are subroutines called by [Search_Caus_non_sep.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/Search_Caus_non_sep.m).


#### DATA FILES

- [DataFiles/inconvertable_nonsep_W&Wocb.mat](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/DataFiles/inconvertable_nonsep_W&Wocb.mat):
MATLAB data file containing the following variables, which were obtained using [SampleProcessMatrix.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/SampleProcessMatrix.m) and [signallingrobustness_primal.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/signallingrobustness_primal.m):
  - W: complex matrix corresponding to the process matrix W^# in Eqs. (101) and (102) of the paper; example of a causally nonseparable process that cannot be converted into W^OCB from Eq. (89) and vice-versa.
  - Wocb: real matrix corresponding to the process matrix W^\text{OCB} in Eq. (89) of the paper.
  - Rs_W: value of the signalling robustness R_s(W^#) of the process matrix W^# written in variable W.
  - Rc_W: value of the causal robustness R_c(W^#) of the process matrix W^# written in variable W.
  - Rs_Wocb: value of the signalling robustness R_s(W^\text{OCB}) of the process matrix W^\text{OCB} written in variable Wocb.
  - Rc_Wocb: value of the causal robustness R_c(W^\text{OCB}) of the process matrix W^\text{OCB} written in variable Wocb.

- [DataFiles/max_causalrobustness_W.mat](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/DataFiles/max_causalrobustness_W.mat): MATLAB data file containing the following variables, which were obtained using [causalrobustness_seesaw.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/causalrobustness_seesaw.m) and [signallingrobustness_primal.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/signallingrobustness_primal.m):
  - W: complex matrix corresponding to the process matrix W^* in Eqs. (104) and (105) of the paper; this is the process matrix with highest causal robustness found by our see-saw search.
  - Rs_W: value of the signalling robustness R_s(W^* ) of the process matrix W^*  written in variable W.
  - Rc_W: value of the causal robustness R_c(W^* ) of the process matrix W^*  written in variable W.

- [DataFiles/LFPadapter_ordered2causalnonsep.mat](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/DataFiles/LFPadapter_ordered2causalnonsep.mat): MATLAB data file containing the following variables, which were obtained using [Search_Caus_non_sep.m](https://github.com/jessicabavaresco/resource-theory-causal-connection/blob/main/Search_Caus_non_sep.m):
  - Win: complex matrix corresponding to an ordered, fully one-way signalling process in Eq. (85) of the paper.
  - Wout: complex matrix corresponding to a causally nonseparable process.
  - Y: complex matrix corresponding to the legal and free-preserving adapter that can convert Win into Wout, therefore creating causal nonseparability.

