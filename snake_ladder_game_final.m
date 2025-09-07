function snake_ladder_game
    % Create the figure window
    f = figure('Position', [200, 200, 800, 600], 'Name', 'Snake and Ladder Game');

    % Load and display the game board image
    board_img = imread('snk.jfif'); % Load your board image here
    ax = axes(f, 'Position', [0.05, 0.25, 0.7, 0.7]); % Axes for board image
    imshow(board_img, 'Parent', ax);
    hold on;

    % Snakes and Ladders mapping (Key: start position, Value: end position)
    snakes = containers.Map([17, 54, 62, 64, 87, 93, 95, 98], [7, 34, 19, 60, 24, 73, 75, 78]);
    ladders = containers.Map([1, 4, 9, 21, 28, 36, 51, 71, 80], [38, 14, 31, 42, 84, 44, 67, 91, 100]);

    % Player positions and colors
    player_positions = [1, 1]; % Start positions for two players
    player_colors = {'r', 'b'}; % Red and Blue tokens for players
    player_turn = 1; % Player 1 starts first

    % Create dice roll button and text display
    dice_roll_button = uicontrol(f, 'Style', 'pushbutton', 'String', 'Roll Dice', ...
        'Position', [600, 400, 100, 50], 'FontSize', 14, 'Callback', @roll_dice);

    dice_result = uicontrol(f, 'Style', 'text', 'String', 'Dice: 0', ...
        'Position', [600, 350, 100, 30], 'FontSize', 14);

    player_turn_text = uicontrol(f, 'Style', 'text', 'String', 'Player 1 Turn', ...
        'Position', [600, 450, 150, 30], 'FontSize', 14);

    % Function to handle dice roll and player movement
    function roll_dice(~, ~)
        dice = randi(6); % Roll a dice (1 to 6)
        dice_result.String = ['Dice: ', num2str(dice)];

        % Move the current player
        new_position = player_positions(player_turn) + dice;
        if new_position > 100
            new_position = 100;
        end

        % Check for snakes or ladders
        if isKey(snakes, new_position)
            new_position = snakes(new_position); % Slide down snake
        elseif isKey(ladders, new_position)
            new_position = ladders(new_position); % Climb ladder
        end

        % Update the player's position
        player_positions(player_turn) = new_position;
        update_board();

        % Check for win
        if new_position == 100
            msgbox(['Player ', num2str(player_turn), ' Wins!'], 'Game Over');
            reset_game();
            return;
        end

        % Switch player turn
        player_turn = mod(player_turn, 2) + 1;
        player_turn_text.String = ['Player ', num2str(player_turn), ' Turn'];
    end

    % Function to update player positions on the board
    function update_board
        % Clear previous tokens
        cla(ax);
        imshow(board_img, 'Parent', ax);
        hold on;

        % Plot the players' tokens at the new positions
        for i = 1:2
            [x, y] = get_coordinates(player_positions(i));
            scatter(x, y, 200, player_colors{i}, 'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 2); 
            % Adjust '200' for token size if necessary
        end
    end

    % Function to reset the game
    function reset_game
        player_positions = [1, 1];
        player_turn = 1; % Reset to Player 1's turn
        player_turn_text.String = 'Player 1 Turn';
        update_board();
    end

    % Function to calculate the x, y coordinates on the board image
    function [x, y] = get_coordinates(position)
        % This logic assumes a 10x10 board, modify based on your board layout
        board_size = 10; % 10x10 board
        
        row = ceil(position / board_size); % Determine row number
        col = mod(position - 1, board_size) + 1; % Determine column number

        % Reverse column direction every other row for snake and ladder board
        if mod(row, 2) == 0
            col = board_size + 1 - col;
        end

        % Scale the x and y coordinates based on the board image size
        board_image_width = size(board_img, 2); % Get width of the image
        board_image_height = size(board_img, 1); % Get height of the image

        x_spacing = board_image_width / board_size;
        y_spacing = board_image_height / board_size;

        % Calculate the center coordinates of the square (x, y)
        x = (col - 0.5) * x_spacing;
        y = board_image_height - (row - 0.5) * y_spacing; % Reverse y for image coordinates
    end

    % Initialize the board
    update_board();
end








function snake_ladder_game
    %The figure window
    f=figure('Position',[200, 200, 800, 600],'Name','Snake and Ladder Game');
    %For diisplaying the game image
    board_img=imread('snk.jfif');
    ax=axes(f,'Position', [0.05,0.25,0.7,0.7]); % Creating axes
    imshow(board_img,'Parent',ax); %Displays the image
    hold on;
    % Declaring mapping for the game
    snakes=containers.Map([17,54,62,64,87,93,95,98], [7,34,19,60,36,73,75, 79]);
    ladders=containers.Map([1,4,9,21,28,36,51,72,80], [38,14,31, 42,84,44,67,91,99]);
    player_positions=[1,1]; % Starting position
    player_colors={'r','b'}; % Colours
    player_turn=1; % Player 1 starts first
    % Createing dice roll button and displaying texts
    dice_roll_button=uicontrol(f, 'Style', 'pushbutton', 'String', 'Roll Dice', ... %Using ... for readability
        'Position', [600,400,100,50], 'FontSize', 14, 'Callback', @roll_dice);

    dice_result = uicontrol(f, 'Style', 'text', 'String', 'Dice: 0', ...
        'Position', [600, 350, 100, 30], 'FontSize', 14);

    player_turn_text = uicontrol(f, 'Style', 'text', 'String', 'Player 1 Turn', ...
        'Position',[600, 450, 150, 30],'FontSize',14);
    % Creating a function to manuplate player movement and dice roll
    function roll_dice(~,~)
        dice=randi(6); % Allows only from 1 to 6
        dice_result.String = ['Dice: ',num2str(dice)];
        new_position=player_positions(player_turn)+dice;
        if new_position > 100
            new_position = 100;
        end
        % Checking for snakes or ladders
        if isKey(snakes,new_position) %checks for snake
            new_position=snakes(new_position);
        elseif isKey(ladders,new_position) %checks for ladder
            new_position=ladders(new_position);
        end
        % Adding or subtracting accordingly
        player_positions(player_turn)=new_position;
        update_board();
        if new_position==100 %Checking for winning
            cla(ax);
            msgbox(['Player ',num2str(player_turn),' Wins!'],'Game Over');
            reset_game();
            return;
        end
        % Switching player turn
        player_turn=mod(player_turn,2)+1;
        player_turn_text.String=['Player ',num2str(player_turn),' Turn'];
    end
    % To update position
    function update_board
        cla(ax); %For clearing
        imshow(board_img,'Parent',ax);
        hold on;
        % Displaying at new location
        for i=1:2
            [x,y]=get_coordinates(player_positions(i));
            scatter(x,y,200,player_colors{i},'filled','MarkerEdgeColor','k', 'LineWidth',2); 
        end
    end
    % To reset the game
    function reset_game
        player_positions=[1,1];
        player_turn=1; % Resets to player 1st turn
        player_turn_text.String = 'Player 1 Turn';
        update_board();
    end
    % Getting the coordinates of x and y
    function [x,y]=get_coordinates(position)
        board_size=10; % 10x10 board
        row=ceil(position/board_size); % Determines the row of player
        col=mod(position-1,board_size)+1; % Determines the column of player
        % For reversing the row and column
        if mod(row,2)==0
            col=board_size+1-col;
        end
        board_image_width=size(board_img,2); % Getting the width 
        board_image_height=size(board_img,1); % Get the height 
        x_spacing=board_image_width/board_size; % Horizontal spacing
        y_spacing=board_image_height/board_size; % Vertical spacing
        % Calculate the center coordinates of the square (x, y)
        x=(col-0.5)*x_spacing; % Horizontal position
        y=board_image_height-(row-0.5)*y_spacing; % Vertial position
    end
    update_board();
end


