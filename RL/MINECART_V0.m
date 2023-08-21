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
        function Population = Initialization(obj,N)
        %Initialization - Generate multiple initial solutions.
        %
        %   P = obj.Initialization() randomly generates the decision
        %   variables of obj.N solutions and returns the SOLUTION objects.
        %
        %   P = obj.Initialization(N) generates N solutions.
        %
        %   This function is usually called at the beginning of algorithms.
        %
        %   Example:
        %       Population = Problem.Initialization()
        
            if nargin < 2
            	N = obj.N;
            end
            PopDec = zeros(N,obj.D);
            refs = repmat([0.0,0.0,-200.0],N,1)
            Type   = arrayfun(@(i)find(obj.encoding==i),1:5,'UniformOutput',false);
            if ~isempty(Type{1})        % Real variables
                PopDec(:,Type{1}) = unifrnd(repmat(obj.lower(Type{1}),N,1),repmat(obj.upper(Type{1}),N,1));
            end
            if ~isempty(Type{2})        % Integer variables
                PopDec(:,Type{2}) = round(unifrnd(repmat(obj.lower(Type{2}),N,1),repmat(obj.upper(Type{2}),N,1)));
            end
            if ~isempty(Type{3})        % Label variables
                PopDec(:,Type{3}) = round(unifrnd(repmat(obj.lower(Type{3}),N,1),repmat(obj.upper(Type{3}),N,1)));
            end
            if ~isempty(Type{4})        % Binary variables
                PopDec(:,Type{4}) = logical(randi([0,1],N,length(Type{4})));
            end
            if ~isempty(Type{5})        % Permutation variables
                [~,PopDec(:,Type{5})] = sort(rand(N,length(Type{5})),2);
            end
            Population = obj.Evaluation(PopDec,refs);
        end
    end
end 

