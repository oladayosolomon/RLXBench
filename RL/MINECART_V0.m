classdef MINECART_V0 < PROBLEM
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
            if isempty(obj.D); obj.D = 5062; end
            obj.lower    = zeros(1,obj.D) - 1;
            obj.upper    = zeros(1,obj.D) + 1;
%             obj.encoding = ones(1,obj.D);
%             obj.optimum = [1000,1000]
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,X)
            
            PopObj = pyrunfile("mat_eval_env.py","fitnesses",env='minecart-v0', agent='A2C', policy='MlpPolicy', weights=X);
            PopObj = double(PopObj);
        end
        %%% Generate points on the Pareto front
%         function R = GetOptimum(obj,N)
% %             R(:,1) = linspace(0,1,N)';
% %             R(:,2) = 1 - R(:,1).^0.5;
%               R=[1000,1000]
%         end
        %% Generate the image of Pareto front
        %function R = GetPF(obj)
        %    R = obj.GetOptimum(100);
        %end
    end
end 

