InitialPosition = SRD_get('InitialPosition');
Handler_IK_Model = SRD_get('Handler_IK_Model');
IC_Task = Handler_IK_Model.get_Task(InitialPosition);

ZeroOrderDerivativeNodes = {IC_Task(1), IC_Task(1) + 0.05;   % CoM chages
                            
                            IC_Task(2), IC_Task(2);          % Leg 3-L Z-axis
                            IC_Task(3), IC_Task(3);          % Leg 3-R Z-axis
                            IC_Task(4), IC_Task(4);          % Leg 0-L Z-axis
                            IC_Task(5), IC_Task(5);          % Leg 0-R Z-axis
                            
                            IC_Task(6), IC_Task(6);          % Leg 3-L Y-axis
                            IC_Task(7), IC_Task(7);          % Leg 3-R Y-axis
                            IC_Task(8), IC_Task(8);          % Leg 0-L Y-axis
                            IC_Task(9), IC_Task(9)};         % Leg 0-R Y-axis
                            % constraints
                     
FirstOrderDerivativeNodes = {0, '*'; % 0
                             0, 0;
                             0, 0;
                             0, 0;
                             0, 0;
                             
                             0, 0;
                             0, 0;
                             0, 0;
                             0, 0};
                         
SecondOrderDerivativeNodes = {0, '*'; % 0 
                              0, 0;
                              0, 0;
                              0, 0;
                              0, 0;
                              
                              0, 0;
                              0, 0;
                              0, 0;
                              0, 0}; 

TimeOfOneStage = 1;
TimeEnd = (size(ZeroOrderDerivativeNodes, 2) - 1)*TimeOfOneStage;
NodeTimes = (0:TimeOfOneStage:TimeEnd)';

Handler_IK_task = SRD_get_handler__IK_task__splines('NodeTimes', NodeTimes, ...
    'ZeroOrderDerivativeNodes', ZeroOrderDerivativeNodes, ...
    'FirstOrderDerivativeNodes', FirstOrderDerivativeNodes, ...
    'SecondOrderDerivativeNodes', SecondOrderDerivativeNodes, ...
    'OutOfBoundariesBehaviour', 'LastValue');

SRD_save(Handler_IK_task, 'Handler_IK_task');

%%
% Task results representation
TimeTable = Handler_IK_task.TimeStart:0.01:Handler_IK_task.TimeExpiration;

IK_Table = SRD_InverseKinematics_GenerateTable(...
    'Handler_IK_Model', Handler_IK_Model, ...
    'Handler_IK_task', Handler_IK_task, ...
    'InitialGuess', InitialPosition, ...
    'method', @SRD_InversePositionProblemSolver_lsqnonlin, ...
    'TimeTable', TimeTable);

SRD_InverseKinematics_GenerateTable_tester(...
    'Handler_IK_Model', Handler_IK_Model, ...
    'TimeTable', TimeTable, ...
    'IK_Table', IK_Table);

Handler_IK_Solution = SRD_get_handler__IK_solution__interp1(...
    'Handler_IK_Model_name', 'Handler_IK_Model', ...
    'Handler_IK_task_name', 'Handler_IK_task', ...
    'IK_Table', IK_Table, ...
    'TimeTable', TimeTable, ...
    'method', 'linear');%linear', 'nearest', 'next', 'previous', 'pchip', 'cubic', 'v5cubic', 'makima', or 'spline'
SRD_save(Handler_IK_Solution, 'Handler_IK_Solution')