my_num = 23; % The number to initialise the cellular automata with
number_of_steps = 30;




world = ones(number_of_steps,round(number_of_steps/2));

colour_map = uint8(... % The colour map used to display results
    [255,206,173;
    0,0,0;
    64,64,64;
    255,255,255;
    128,128,128;
    255,0,0;
    181,255,22;
    251,106,0;
    255,216,0;
    127,0,0;
    0,127,127] );


XX = 11; % End of number cell

ZZ = 1; % Initialisation cell for binary zero

Z00 = 2; % Functional cells with low value
Z01 = 3;
%Z10 = 4;
Z11 = 5;

N00 = 6; % Functional cells with high value
%N01 = 7;
N10 = 8;
N11 = 9;

NN = 10; % Initialisation cell for binary one

% Convert starting number to initial binary
temp_num = my_num;
bin_length = ceil(log2(my_num));
start_num = zeros(1,bin_length + 2);
start_num(1) = ZZ;
start_num(end) = XX;
for k=(bin_length+1):-1:2
    if mod(temp_num,2) == 1
        start_num(k) = NN;
    else
        start_num(k) = ZZ;
    end
    temp_num = temp_num - mod(temp_num,2);
    temp_num = temp_num/2;
end
    


% Initialise the first row of the world
world(1,1:length(start_num)) = start_num;

% Run the steps of the cellular automata
for row = 2:size(world,1)
    for index = 2:size(world,2)

read_bar = world(row-1, index-1:index);

% Index and row are the corridinates of the cell that is being determined.
% Read_bar contains the values of the cell that will be used to determine
% the value of the cell being updated.

% The rules of the cellular automata
switch read_bar(2)
    case ZZ
        world (row,index) = read_bar(1); % Initialisation rule
        
    case Z00
        if read_bar(1) <N00
            world(row,index) = Z00;
        else
            world(row,index) = N10;
        end
    case Z01
         if read_bar(1) <N00
            world(row,index) = N00;
        else
            world(row,index) = Z11; %Z10
        end
%     case Z10
%         if read_bar(1) <N00
%             world(row,index) = Z01;
%         else
%             world(row,index) = N11;
%         end
    case Z11
        if read_bar(1) <N00
            world(row,index) = Z01;
        else
            world(row,index) = N11;
        end
    case N00
        if read_bar(1) <N00
            world(row,index) = Z00;
        else
            world(row,index) = N10;
        end
%     case N01
%         if read_bar(1) <N00
%             world(row,index) = Z00;
%         else
%             world(row,index) = N10;
%         end
    case N10
        if read_bar(1) <N00
            world(row,index) = N00; %N01
        else
            world(row,index) = Z11;
        end
    case N11
        if read_bar(1) <N00
            world(row,index) = Z01;
        else
            world(row,index) = N11;
        end
    case NN
        world (row,index) = read_bar(1); % Initialisation rule
        
    case XX % End of number rule
        if read_bar(1) < N00
            world(row,index) = XX;
        elseif N00 <= read_bar(1) && read_bar(1) <= NN
            world(row,index) = Z11;
        else
            world(row,index) = XX;
        end
    otherwise 
        world(row,index) = XX; % Failsafe sets the value of the cell to end of number
end

    end
end

% The completed timeline is now shown with the colour map.
figure(1)
imshow(world,colour_map)




