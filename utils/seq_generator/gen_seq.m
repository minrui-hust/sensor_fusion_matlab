clear all;

% simulation interval
sim_step = 0.001;
sim_duration = 60.00;
time = 0:sim_step:sim_duration;


% initial state
pos_0   = [0 0 0  ];
vel_0   = [0 1 0  ];
euler_0 = [0 0 0  ];
omega_0 = [0.2 0 0];


% specify force and torque
F = ones(3,size(time,2)).*sin(time);
T = ones(3,size(time,2)).*cos(time);

force  = timeseries(F, time);
torque = timeseries(T, time);


% sim
sim('rigid_6dof.slx');

% process output


p = pos.Data;
q = so3Ts3(dcm.Data)'; % TODO: need to check
v = vel.Data;
w = omega.Data;
a = acc.Data;
m = domega.Data;

seq = array2table([time' p q v w a m],'VariableNames',{'time' 'px' 'py' 'pz' 'qw' 'qx' 'qy' 'qz' 'vx' 'vy' 'vz' 'wx' 'wy' 'wz' 'ax' 'ay' 'az' 'mx' 'my' 'mz'});

writetable(seq, '/home/mr/Workspace/repo/sensor_fusion_matlab/sequences/seq3.txt');
