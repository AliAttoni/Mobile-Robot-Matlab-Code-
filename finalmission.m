clc; clear; close all;


L = 0.5;    
r = 0.1;     
dt = 0.1;    
max_time = 200;

x = 0; 
y = 0; 
theta = 0;


goal_x = input('Please enter x : ');
goal_y = input('Please enter y : ');
goal_theta = input('Please enter theta(Radian) : ');


k_rho = 0.8;       
k_alpha = 2.5;     
k_beta  = -1.1;    


figure;
hold on;
grid on;
axis equal;
xlabel('X (m)');
ylabel('Y (m)');
title('Move Robot');
plot(goal_x, goal_y, 'rx', 'MarkerSize',10, 'LineWidth',2); 
trajectory = plot(x, y, 'b-', 'LineWidth',1.5); 
robot_body = plot([x x+0.5*cos(theta)], [y y+0.5*sin(theta)], 'k-', 'LineWidth',2); 


for t = 0:dt:max_time
    
    
    dx = goal_x - x;
    dy = goal_y - y;
    rho = sqrt(dx^2 + dy^2);                 
    alpha = atan2(dy, dx) - theta;             
    beta = -theta - alpha + goal_theta;        
    
   
    alpha = atan2(sin(alpha), cos(alpha));
    beta  = atan2(sin(beta),  cos(beta));
    
   
    if rho < 0.1
        disp('the goal achieve');
        break;
    end
  
    v = k_rho * rho;             
    w = k_alpha * alpha + k_beta * beta;  %
    
    
    x = x + v * cos(theta) * dt;
    y = y + v * sin(theta) * dt;
    theta = theta + w * dt;
    theta = atan2(sin(theta), cos(theta)); 
    
   
    set(trajectory, 'XData', [get(trajectory,'XData') x], ...
                    'YData', [get(trajectory,'YData') y]);
    set(robot_body, 'XData', [x x+0.5*cos(theta)], ...
                    'YData', [y y+0.5*sin(theta)]);
    drawnow;
    
end

disp(['the last location : (', num2str(x), ', ', num2str(y), ')']);
disp(['the last angle : ', num2str(theta), ' Radian']);

