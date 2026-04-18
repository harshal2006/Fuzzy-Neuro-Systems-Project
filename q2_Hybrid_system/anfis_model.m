lc; clear; close all;

% ---------------- LOAD DATA ----------------
data = load('data.txt');

% Split inputs and output
inputs = data(:,1:3);
output = data(:,4);

% ---------------- GENERATE INITIAL FIS ----------------
% 3 membership functions per input
fis = genfis1(data, 3, 'gbellmf');

% ---------------- TRAIN ANFIS ----------------
epoch_n = 50;

[trainedFis, trainError] = anfis(data, fis, epoch_n);

% ---------------- PLOT TRAINING ERROR ----------------
figure;
plot(trainError, 'LineWidth', 2);
title('ANFIS Training Error vs Epochs');
xlabel('Epochs');
ylabel('Error');
grid on;

% ---------------- TEST THE MODEL ----------------
testInput = [85 80 78]; % Example student

predictedOutput = evalfis(trainedFis, testInput);

disp('------------------------------');
disp(['Test Input (Attendance, Assignment, Test): ', num2str(testInput)]);
disp(['Predicted Performance Level: ', num2str(predictedOutput)]);
disp('------------------------------');

% ---------------- SAVE FIS ----------------
writeFIS(trainedFis, 'student_performance_fis');
testInput = [85 80 78];
predictedOutput = evalfis(trainedFis, testInput)