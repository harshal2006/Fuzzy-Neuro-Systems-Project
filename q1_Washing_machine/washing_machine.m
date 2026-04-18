clc; clear; close all;

% Create FIS
fis = mamfis('Name','WashingMachine');

% ---------------- INPUT 1: Dirt Level ----------------
fis = addInput(fis,[0 10],'Name','Dirt');

fis = addMF(fis,'Dirt','trimf',[0 0 5],'Name','Low');
fis = addMF(fis,'Dirt','trimf',[0 5 10],'Name','Medium');
fis = addMF(fis,'Dirt','trimf',[5 10 10],'Name','High');

% ---------------- INPUT 2: Load Size ----------------
fis = addInput(fis,[0 10],'Name','Load');

fis = addMF(fis,'Load','trimf',[0 0 5],'Name','Small');
fis = addMF(fis,'Load','trimf',[0 5 10],'Name','Medium');
fis = addMF(fis,'Load','trimf',[5 10 10],'Name','Large');

% ---------------- OUTPUT: Wash Time ----------------
fis = addOutput(fis,[0 60],'Name','Time');

fis = addMF(fis,'Time','trimf',[0 0 30],'Name','Short');
fis = addMF(fis,'Time','trimf',[15 30 45],'Name','Medium');
fis = addMF(fis,'Time','trimf',[30 60 60],'Name','Long');

% ---------------- RULES ----------------
ruleList = [
1 1 1 1 1;  % Low Dirt, Small Load -> Short
2 1 2 1 1;  % Medium Dirt, Small Load -> Medium
3 1 3 1 1;  % High Dirt, Small Load -> Long
1 3 2 1 1;  % Low Dirt, Large Load -> Medium
2 3 3 1 1;  % Medium Dirt, Large Load -> Long
3 3 3 1 1;  % High Dirt, Large Load -> Long
];

fis = addRule(fis,ruleList);

% ---------------- DISPLAY ----------------
figure;
subplot(3,1,1); plotmf(fis,'input',1); title('Dirt Membership Functions');
subplot(3,1,2); plotmf(fis,'input',2); title('Load Membership Functions');
subplot(3,1,3); plotmf(fis,'output',1); title('Time Membership Functions');

% ---------------- TEST SYSTEM ----------------
inputValues = [7 8]; % Dirt=7, Load=8
output = evalfis(fis,inputValues);

disp(['Wash Time Output: ', num2str(output)]);

% Rule Viewer
figure;
ruleview(fis);