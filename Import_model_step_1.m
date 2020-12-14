% StriRus import

LinkArray = SRD_GetLinkArrayFromURDF('UrdfFilePath','./urdf/strirus_gamma.urdf','ParseSTL',true);


Color_0_body = [1, 0, 0];
Color_1_body_bridge = [1, 1, 0];
Color_2_legs = [0.5, 0.5, 0.5];

% Body links
SRD_LinkSet_Color(LinkArray, 'base_footprint', Color_0_body); %Link 1
SRD_LinkSet_Color(LinkArray, 'body_1_part', Color_0_body); %Link 2
SRD_LinkSet_Color(LinkArray, 'body_2_part', Color_0_body); %Linl 13
SRD_LinkSet_Color(LinkArray, 'bridge_1_part', Color_1_body_bridge); %Link 11
SRD_LinkSet_Color(LinkArray, 'bridge_2_part', Color_1_body_bridge); %Link 12

% Left legs links
SRD_LinkSet_Color(LinkArray, 'leg_left_5', Color_2_legs); %Link 18
SRD_LinkSet_Color(LinkArray, 'leg_left_4', Color_2_legs); %Link 17
SRD_LinkSet_Color(LinkArray, 'leg_left_3', Color_2_legs); %Link 16
SRD_LinkSet_Color(LinkArray, 'leg_left_2', Color_2_legs); %Link 7
SRD_LinkSet_Color(LinkArray, 'leg_left_1', Color_2_legs); %Link 6
SRD_LinkSet_Color(LinkArray, 'leg_left_0', Color_2_legs); %Link 5

% Right legs links
SRD_LinkSet_Color(LinkArray, 'leg_right_5', Color_2_legs); %Link 21
SRD_LinkSet_Color(LinkArray, 'leg_right_4', Color_2_legs); %Link 20
SRD_LinkSet_Color(LinkArray, 'leg_right_3', Color_2_legs); %Link 19
SRD_LinkSet_Color(LinkArray, 'leg_right_2', Color_2_legs); %Link 10
SRD_LinkSet_Color(LinkArray, 'leg_right_1', Color_2_legs); %Link 9
SRD_LinkSet_Color(LinkArray, 'leg_right_0', Color_2_legs); %Link 8

InitialPosition =zeros(21,1);

SRD_save(LinkArray, 'LinkArray');
SRD_save(InitialPosition, 'InitialPosition');

Chain = SRD_Chain(LinkArray);
SRD_save(Chain, 'Chain');

SRD_SetupVisuals('AxisLimits', [-1; 1; -1; 1; -1; 1], ...
    'ViewAngle', [-37.5, 30], ...
    'ToDrawMeshes', true, ...
    'Animation_ToUseGrid', true, ...
    'Animation_ToUseGridMinor', true, ...
    'DrawRobot_Default_RobotColor', [0.6 0.3 0], ...
    'DrawRobot_Default_EdgeAlpha', 0.3, ...
    'DrawRobot_Default_FaceAlpha', 1, ...
    'DrawRobot_Default_LineWidth', 0.5, ...
    'DrawRobot_STL_FaceColor', [0.8 0.8 1.0], ...
    'DrawRobot_STL_EdgeColor', 'none', ...
    'DrawRobot_STL_FaceLighting', 'gouraud', ...
    'DrawRobot_STL_AmbientStrength', 0.15, ...
    'DrawRobot_STL_camlight', 'headlight', ...
    'DrawRobot_STL_material', 'metal', ...
    'ToDrawFrames', false, ...
    'DrawRobot_Frame_Scale', 0.2, ...
    'DrawRobot_Frame_LineWidth', 1);

DrawRobot_function = SRD_DrawRobot_get_function('DrawRobot_Type', 'STL', ... %'Default' or 'STL' or 'Custom'
    'DrawRobot_Custom_handle', [], ...
    'Function_Type', 'DrawGivenPosition', ... %'DrawGivenPosition' or 'DrawInitialPosition'  or 'DrawCurrentPosition'
    'Chain', Chain);

DrawRobot_function(InitialPosition, [])
SRD__make_default_scene('STL')