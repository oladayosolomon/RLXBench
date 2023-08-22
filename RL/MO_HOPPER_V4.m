classdef MO_HOPPER_V4 < PROBLEM
% <multi> <real> <large/none>
% Benchmark MOP with bias feature

%------------------------------- Reference --------------------------------
% H. Li, Q. Zhang, and J. Deng, Biased multiobjective optimization and
% decomposition algorithm, IEEE Transactions on Cybernetics, 2017, 47(1):
% 52-66.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2023 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        %% Default settings of the problem

        function Setting(obj)
            obj.M = 3;
            if isempty(obj.D); obj.D = 5123; end
            obj.lower    = zeros(1,obj.D) - 1;
            obj.upper    = zeros(1,obj.D) + 1;
%             obj.encoding = ones(1,obj.D);
%             obj.optimum = [1000,1000]
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,X)
            
            PopObj = pyrunfile("mat_eval_env.py","fitnesses",env='mo-hopper-v4', agent='A2C', policy='MlpPolicy', weights=X);
            PopObj = double(PopObj);
        end
        function Population = Evaluation(obj,varargin)
        %Evaluation - Evaluate multiple solutions.
        %
        %   P = obj.Evaluation(Dec) returns the SOLUTION objects based on
        %   the decision variables Dec. The objective values and constraint
        %   violations of the solutions are calculated automatically, and
        %   obj.FE is increased accordingly.
        %
        %   P = obj.Evaluation(Dec,Add) also sets the additional properties
        %   (e.g., velocity) of solutions.
        %
        %   This function is usually called after generating new solutions.
        %
        %   Example:
        %       Population = Problem.Evaluation(PopDec)
        %       Population = Problem.Evaluation(PopDec,PopVel)
            
            PopDec     = obj.CalDec(varargin{1});
            refs       = repmat([-100,-100],size(PopDec,1),1);
            PopObj     = obj.CalObj(PopDec);
            PopCon     = obj.CalCon(PopDec);
            Population = SOLUTION(PopDec,PopObj,PopCon,varargin{2:end});
            obj.FE     = obj.FE + length(Population);
        end
    end
end 

