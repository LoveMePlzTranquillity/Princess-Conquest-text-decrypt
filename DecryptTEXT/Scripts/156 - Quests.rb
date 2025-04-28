#==============================================================================
#    Quest Journal [VXA]
#    Version: 1.0.3
#    Author: modern algebra (rmrk.net)
#    Date: 24 September 2012
#    Support: http://rmrk.net/index.php/topic,45127.0.html
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Description:
#
#    This script provides a graphical interface for showing quest progress. It
#   is objective-based, meaning that you choose when to reveal objectives and 
#   you can set it so that they show up as complete or failed. That said, this
#   script does not build quests for you; it is only a supplementary scene for
#   showing them. As such, you need to event all of the quests yourself and
#   update quest progress via script call. Therefore, pay close attention to 
#   the instructions here and in the Editable Regions at lines 232 and 612.
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Instructions:
#
#    Paste this script into its own slot or slots, above Main and below
#   Materials. If you are using the menu access feature, you should put any 
#   other menu scripts above this one. 
#
#    All of the configuration is done in the QuestData module. While it is not 
#   necessary, it is recommended that you separate the configuration module 
#   from the rest of the script by cutting and pasting it into its own slot in
#   the Script Editor (as you will see if you have the demo). The reason for 
#   this is that, if and when this script gets updated, you can preserve the 
#   configuration section and only replace the other parts of the script. If 
#   you wish to do that, you must cut everything from the first line down to 
#   the final end of the module. The first lines of the body script should be 
#   the equals bar right above # ** Game_Quest. Again, it's up to you whether 
#   you do it.
#
#    You can go to EDITABLE REGION A at line 232 to configure the default 
#   settings for the script. All of these will work fine without modification,
#   of course, but even if do not want to configure now, you should familiarize 
#   yourself with all the settings so that you can make the best use of your 
#   script. I have included tons of settings so that you can make the Quest 
#   Journal unique for your game, even down to the order in which each section
#   of the info window is drawn. A brief description of each setting is 
#   included either to the right or directly above each constant.
#
#    EDITABLE REGION B is the real heart of the script however - this is where
#   you fill in all of the details for the quests. Read the instructions at 
#   line 612 very carefully!
#
#    You can activate and access a quest with this code in the Script event 
#   command:
#
#        quest(quest_id)
#          quest_id : the integer ID of the quest you want to access
#
#   From that, you can access or alter any relevant data stored in the quest, 
#   like name, description, objectives, etc... Example:
#         quest(1).name = "Rest in Pieces"
#
#    More relevantly, when it comes to controlling the progress of quests the
#   following codes can be used in a Script event command. The arguments are 
#   the same for each command so I only explain them once. All of them are 
#   pretty self-explanatory and using any of them will activate the quest 
#   (unless you are using the MANUAL REVEAL setting at line 267). 
#    
#        reveal_objective(quest_id, objective_id_1, ..., objective_id_n)
#            quest_id : the integer ID of the quest you want to access.
#            objective_id_1, ..., objective_id_n : a list of the IDs of the 
#              objectives you want to operate on. It can be as few as one or as 
#              many as all of them.
#          Will show the listed objectives in the Quest's information
#
#        conceal_objective(quest_id, objective_id_1, ..., objective_id_n)
#          Will hide the listed objectives in the Quest's information
#
#        complete_objective(quest_id, objective_id_1, ..., objective_id_n)
#          Changes the colour of the listed objectives to the completed colour.
#          The quest is completed once all prime objectives are.
#
#        uncomplete_objective (quest_id, objective_id_1, ..., objective_id_n)
#          Changes the status of the listed complete objectives back to active
#
#        fail_objective(quest_id, objective_id_1, ..., objective_id_n)
#          Changes the colour of the listed objectives to the failed colour.
#          The quest is failed once one prime objective is.
#
#        unfail_objective(quest_id, objective_id_1, ..., objective_id_n)
#          Changes the status of the listed failed objectives back to active
#
#        change_reward_status(quest_id, value)
#            value : either true or false. If excluded, defaults to true.
#          Totally optional, but this is just a personal switch which you can
#          turn on when the reward is given. You can then make it a condition 
#          so you don't reward the players more than once. (see line 180)
#
#  EXAMPLES:
#    reveal_objective(1, 0)
#      This would reveal the first objective of the quest with ID 1
#    complete_objective(6, 2, 3)
#      This would complete the third & fourth objectives of the quest with ID 6
#    change_reward_status(8)
#      This would set the reward switch to true for the quest with ID 8.
#
#   Another new feature is the ability to set rewards that will show up in the
#  menu (see EDITABLE REGION B). In addition to that, you can use the following
#  code to automatically distribute the specified rewards for a quest if the 
#  quest is complete and no reward has yet been given:
#
#        distribute_quest_rewards(quest_id)
#          quest_id : the ID of the quest whose rewards you want to distribute
#
#   Of course, it can only distribute the material rewards (items, weapons,
#   armors, gold, or exp). It won't distribute rewards you specify by string. 
#   To that end though, you can also use this code in a conditional branch and 
#   it will be satisfied only if it distributes the rewards. Thus, if you 
#   wanted to add some special rewards or do things like that, you can just put
#   that in the branch for when it is true. This feature is not really
#   recommended, since I think it is better to do it by events.
#
#    Other codes for the Script event command that can be useful are:
#    
#        reset_quest(quest_id)
#            quest_id : the integer ID of the quest you want to access.
#          This will re-initialize the quest, meaning all quest progress to 
#          date will be lost
#
#        delete_quest(quest_id)
#          Deactivates the quest and resets it
#
#        conceal_quest(quest_id)
#          Deactivates the quest so it won't show up in the scene, but progress
#          is saved
#
#        reveal_quest(quest_id)
#          Activates or reactivates the quest. This command is NECESSARY if 
#          MANUAL_REVEAL at line 284 is true or it has previously been 
#          concealed. Otherwise, it is sufficient just to operate on the quest
#
#        change_quest_access(:symbol)
#          :symbol must be one of six options (include the colon!):
#            :disable - prevents access to the quest scene (greys out in menu)
#            :enable - enables access to the quest scene
#            :disable_menu - this removes the quest option from the menu
#            :enable_menu - this adds the quest option to the menu
#            :disable_map - this prevents access by key from the map
#            :enable_map - this allows access by key to the map
#
#        change_quest_background("bg_filename", bg_opacity, bg_blend_type)
#            bg_filename   : the filename of the picture for the background in  
#              the Pictures folder
#            bg_opacity    : the opacity of the background graphic. If 
#              excluded, this defaults to the value of the setting at line 434.
#            bg_blend_type : the blend type of the background graphic. If 
#              excluded, this defaults to the value of the setting at line 437.
#
#        change_quest_windows ("windowskin_filename", tone, opacity)
#            windowskin_filename : the name of the Window graphic in the
#              System folder of Graphics
#            opacity             : the opacity of the windows. If excluded, 
#              this defaults to the value of the setting at line 423.
#            blend_type          : the blend_type of the windows. If excluded, 
#              this defaults to the value of the setting at line 426.
#
#    Also, there are a few codes that can be used in the Script command of a
#   conditional branch. I note here that all of these are optional. You could
#   use switch and variable checks and monitor quest progress solely through
#   events. However, these commands make it a little easier and they are:
# 
#        quest_revealed?(quest_id)
#            quest_id : the integer ID of the quest you want to access.
#          This is satisfied if the quest has been activated.
#
#        quest_complete?(quest_id)
#          This is satisfied if all prime objectives of the quest are complete
#
#        quest_failed?(quest_id)
#          This is satisfied if any prime objective of the quest is failed
#
#        quest_rewarded?(quest_id)
#          This is satisfied if you have changed the reward status to true.
#
#        objective_revealed?(quest_id, objective_id_1, ... objective_id_n)
#            objective_id_1, ..., objective_id_n : a list of the IDs of the 
#              objectives you want to operate on. It can be as few as one or as 
#              many as all of them.
#          This is satisfied if the listed objectives have been revealed
#
#        objective_active?(quest_id, objective_id_1, ... objective_id_n)
#          This is satisfied if all the listed objectives are revealed and
#          neither complete nor failed.
#
#        objective_complete?(quest_id, objective_id_1, ... objective_id_n)
#          This is satisfied if all the listed objectives have been completed
#
#        objective_failed?(quest_id, objective_id_1, ... objective_id_n)
#          This is satisfied if all the listed objectives have been failed
#
#    If you want to call the Quest scene from an event, you use the following 
#   code in a call script:
# 
#        call_quest_journal
#        call_quest_journal(quest_id)
#          quest_id : ID of the quest you want to open the scene on
#
#  If you do not specify a quest_id (line 198) then it will simply open the 
#  scene as it would normally. If you do specify a quest_id (line 199) then it
#  will open the scene on that quest so long as it has been revealed and it is
#  normally accessible through the quest menu.
#
#   Finally, the default way this script operates is that quests automatically
#  complete or fail based on the status of the prime objectives. However, you
#  can set it so that there are no prime objectives, in which case you can only
#  complete, fail, or (re)activate a quest manually through the following code
#  in a script call:
#
#        manually_complete_quest(quest_id)
#          quest_id : ID of the quest you want to manually complete
#        manually_fail_quest(quest_id)
#          quest_id : ID of the quest you want to manually fail
#        manually_activate_quest(quest_id)
#          quest_id : ID of the quest you want to manually activate
#==============================================================================

$imported ||= {}
$imported[:"MA_QuestJournal_1.0"] = true
$imported[:"MA_QuestJournal_1.0.1"] = true

#==============================================================================
# *** QuestData
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This module contains all the configuration data for the quest journal
#==============================================================================

module QuestData
  #\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  #  BEGIN Editable Region A
  #||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  #  MENU_ACCESS - If true, you can access the quest journal through a command 
  # in the menu. If false, there will be no such command.
  MENU_ACCESS = true
  #  MENU_INDEX - If MENU_ACCESS is true, this determines where it appears
  MENU_INDEX = 4
  #  MAP_ACCESS - If true, this allows you to access the quest journal by 
  # pressing a key on the map.
  MAP_ACCESS = true
  #  MAP_BUTTON - If MAP_ACCESS is true, this determines which button calls the
  # Quest Journal
  MAP_BUTTON = :J
  #  OPEN_TO_LAST_REVEALED_QUEST - If true, then the first time you open the
  # quest journal after revealing a new quest, it will open to the new quest.
  OPEN_TO_LAST_REVEALED_QUEST = true
  #  OPEN_TO_LAST_CHANGED_QUEST - If true, then the Quest Journal will open to
  # the last quest whose objective status has changed.
  OPEN_TO_LAST_CHANGED_QUEST = false
  #  LIST_WINDOW_WIDTH - The width, in pixels, of the List Window
  LIST_WINDOW_WIDTH = 290
  #  BASIC_DATA_TYPES  - This lets you set up additional types of data. Just
  # include an identifying signal in the Array. Then, you will need to give 
  # each signal an icon (in the ICONS hash at line 322) and a signal text (in 
  # the VOCAB array at line 333, though it can be an empty string). Then, you 
  # can set the data itself when setting up quests by simply adding a:
  #    q[:symbol] = ""
  # line to the quest. You will also need to include the data type somewhere in
  # the DATA_LAYOUT at line 306. As an example of this, I have included :client
  # and :location by default. You can CTRL+F for anything in this section with
  # one of those symbols (excluding :) and you will there need to add something
  # for any new data types you add.
  BASIC_DATA_TYPES = [:client, :location]
  #  BASIC_DATA_WIDTH - This determines how much room, in pixels, is given to  
  # any basic data types you set up in the data window.
  BASIC_DATA_WIDTH = 300
  #  CONCURRENT_ACTIVITY - If true, then when in the Quest Journal scene, you
  # can switch categories or scroll down the quest list at the same time. If
  # false, you will first need to select a category before you can start 
  # scrolling through the quest list.
  CONCURRENT_ACTIVITY = true
  #  HIDE_CATEGORY_CURSOR - If true, then the Category Window will not have a
  # cursor and will instead just highlight the currently selected category. 
  # This is best when CONCURRENT_ACTIVITY is true.
  HIDE_CATEGORY_CURSOR = true
  #  SHOW_QUEST_ICONS - If true, then the icon you choose for each quest will
  # be displayed to the left of its name in the Quest List window
  SHOW_QUEST_ICONS = true
  #  MANUAL_REVEAL - If false, then quests will be revealed the moment you 
  # first reveal, complete, or fail an objective. If this is true, you will
  # need to specifically reveal each quest via a separate script call:
  #    reveal_quest(quest_id)
  MANUAL_REVEAL = false
  #  DATA_LAYOUT - This controls the way that the quest window lays out all of
  # the relevant data. If you set one of the entries to be an array, then any
  # of the commands there will be drawn at the same y. With exception to :line,
  # none of the commands will be drawn if the quest is not set to have that
  # particular data. The symbols are:
  #    :line        - Draws a horizontal line across the window.
  #    :name        - Draws the name of the quest
  #    :level       - Draws the level of the quest
  #    :banner      - Draws the banner for the quest
  #    :client      - Draws the client set in the quest   (basic data)
  #    :location    - Draws the location set in the quest (basic data)
  #    :description - Draws the quest's description
  #    :objectives  - Draws all the quest's objectives that have been revealed
  #    :rewards     - Draws whatever rewards have been set
  #
  # You will also need to add an entry for any new BASIC_DATA that you place
  # in BASIC_DATA_TYPES at line 264.
  #
  # Remember to place a comma after each entry. Also note that this is only the
  # default layout. You can set a different layout for any quest, and when 
  # viewing that quest, it will be the custom layout that is shown.
  DATA_LAYOUT = [
    [:line, :name], 
    :level,
    :line,
    :banner, 
    :client, 
    :location, 
    :description, 
    :objectives, 
    [:line, :rewards], 
    :line,
  ] # <= Do not touch.
  #  ICONS - This is where you setup many of the icons used in the script. The
  # purpose of each is listed next to it. Also, if you make any custom 
  # categories, you NEED to give them an icon by placing a line like the 
  # others. So, if the new custom category is :romance then you would need to
  # set it like this:
  #    romance:     107,
  ICONS = {
    all:         226, # The icon for the All Quests category
    active:      236, # The icon for the Active Quests category
    complete:    238, # The icon for the Complete Quests category
    failed:      227, # The icon for the Failed Quests category
    client:      121, # The icon for client data. If none wanted, set to 0
    location:    231, # The icon for location data. If none wanted, set to 0
    reward_gold: 626, # The icon for gold rewards. If none wanted, set to 0
    reward_exp:  591, # The icon for exp rewards. If none wanted, set to 0
  } # <= Do not touch.
  #  VOCAB - This lets you choose some of the words used in the quest scene
  VOCAB = {
    # menu_label:  The command name in the menu if MENU_ACCESS is true
    menu_label:       "Quests",
    # scene_label: The label at the top of the scene. If empty, no window
    scene_label:      "Quest Journal", 
    # description: The heading to identify the description
    description:      "Description",
    # objectives: The heading to identify the objectives
    objectives:       "Objectives",
    # objective_bullet: The bullet which shows up to the left of every
    #  objective. If %d is included, it shows the objective's ID.
    objective_bullet: "-",
    # rewards: The heading to identify the rewards.
    rewards:          "Rewards",
    # reward_amount: For item rewards, this is the text to show the amount. 
    #  It should include %d to show the amount.
    reward_amount:    "x%d",
    # reward_gold: Text to identify gold rewards
    reward_gold:      "Swirlies:",
    # reward_exp: Text to identify exp rewards
    reward_exp:       "Knights INC EXP:",
    # level: If LEVEL_ICON is 0, this is the text which precedes the level
    level:        "Rank: ",
    # location: The text label for quest location
    location:         "Location:",
    # location: The text label for quest client
    client:           "Client:",
  } # <= Do not touch.
  #  CATEGORIES - This array allows you to set which categories are available 
  # in the Quest scene. The default categories are :all, :active, :complete,
  # and :failed, and their names are self-explanatory. You can add custom
  # categories as well, but note that you will need to make sure that each new
  # category has an icon set in the ICONS hash, as well as a label set in the
  # CATEGORY_VOCAB hash (if you are using SHOW_CATEGORY_LABEL). It is also 
  # advisable to give it a sort type, unless you are fine with it being sorted
  # by ID, as is default.
  CATEGORIES = [:active, :complete, :failed]
  #  SHOW_CATEGORY_LABEL - This allows you to choose whether to show the name
  # of the currently selected category. If true, it will choose the name out
  # of the CATEGORY_VOCAB hash.
  SHOW_CATEGORY_LABEL = true
  #  CATEGORY_LABEL_IN_SAME_WINDOW - If SHOW_CATEGORY_LABEL is true, then this
  # options lets you choose whether the label is shown in the same window as 
  # the category icons or in a separate window below. true = same window.
  CATEGORY_LABEL_IN_SAME_WINDOW = true
  #  CATEGORY_VOCAB - If SHOW_CATEGORY_LABEL is true, this hash lets you set the
  # label for each category. For any custom categories you create, you will 
  # need to add a line for each below and in the same format:
  #    :category => "Label",
  # Don't forget to add the comma at the end of each line.
  CATEGORY_VOCAB = {
    #:all =>      "All Quests",      # The label for the :all category
    :active =>   "Active Quests",   # The label for the :active category
    :complete => "Completed", # The label for the :complete category
    :failed =>   "Failed Quests",   # The label for the :failed category
  } # <= Do not touch.
  #  SORT_TYPE - This hash allows you to choose how each category is sorted. 
  # For each category, default or custom, you can set a different sort method
  # There are seven options to choose from:
  #    :id - The quests are sorted from lowest to highest ID
  #    :alphabet - The quests are sorted in alphabetical order
  #    :level - The quests are sorted from the lowest to highest level
  #    :reveal - The quests are sorted from most recently revealed on. 
  #            Every time a new quest is revealed, it will be at the top.
  #    :change - The quests are sorted from the one whose status most recently
  #            changed on. So, every time an objective is modified, that quest
  #            will be thrown to the top.
  #    :complete - The quests are sorted from the most recently completed on.
  #            Every time a quest is completed, it will be thrown to the top.
  #    :failed - The quests are sorted from the most recently failed on. 
  #            Every time a quest is failed, it will be thrown to the top.
  #
  # Additionally, you can put _r at the end of any of the sort options and it
  # will reverse the order. So, for instance, if the sort method for a category
  # is :alphabet_r, then the quests will show up from Z-A
  SORT_TYPE = {
   # :all =>      :id,       # Sort type for the All Quests category
    :active =>   :change,   # Sort type for the Active Quests category
    :complete => :complete, # Sort type for the Complete Quests category
    :failed =>   :failed,   # Sort type for the Failed Quests category
  } # <= Do not touch.
  #  WINDOWSKIN - The windowskin for each window in the Quest scene. It must
  # refer to a graphic in the System folder of Graphics. If set to false, then
  # it will use whatever windowskin is default. If you are using a script which
  # lets the player choose the windowskin, false is the recommended value.
  WINDOWSKIN = "Qtry"
  #  WINDOW_TONE - The tone for each window. It must be an array in the form: 
  #      WINDOW_TONE = [red, green, blue, gray]
  # gray can be excluded, but the other three must be present. If you set this
  # value to false, then the windows will have whatever tone is default.
  WINDOW_TONE = false
  #  WINDOW_OPACITY - The opacity of the windows in the Quest scene. If set to
  # false, it will use the default opacity for windows.
  WINDOW_OPACITY = false
  #  BG_PICTURE - This is a string referring to a picture in the Picture folder
  # of Graphics. If set to "", then there will be no picture. Otherwise, it 
  # will display the selected picture below the windows but above the map in
  # the Quest scene.
  BG_PICTURE = "QuestBG"
  #  BG_OPACITY - This allows you to set the opacity of the background picture,
  # if you have selected one.
  BG_OPACITY = 255
  #  BG_BLEND_TYPE - This allows you to set the blend type of the background
  # picture, if you have selected one.
  BG_BLEND_TYPE = 0 
  #  DESCRIPTION_IN_BOX - This is a graphical option, and it allows you to 
  # choose whether the description should be shown in a box.
  DESCRIPTION_IN_BOX = false
  #  LEVEL_ICON - This sets how levels are shown. If set to an integer, then it
  # will draw the same icon numerous times up to the level of the quest. Ie. If
  # the level's quest is 1, then the icon will only be drawn once, but if the 
  # level's quest is 4, it will be drawn 4 times. LEVEL_ICONS_SPACE determines
  # the space between them. If you set LEVEL_ICON to 0, however, then it will
  # instead draw a signal for the level, corresponding to that index in the 
  # LEVEL_SIGNALS array. If the LEVEL_SIGNALS array is empty, then it will just
  # draw the integer for the level. Finally, LEVEL_ICON can also be an array of
  # integers, in which case the level will be represented only by the icon set
  # which corresponds to it in the array.
  LEVEL_ICON = 0
  #  LEVEL_ICONS_SPACE - If LEVEL_ICON is an integer, this is the amount of
  # space between each time the icon is drawn.
  LEVEL_ICONS_SPACE = 32
  #  LEVEL_SIGNALS - If LEVEL_ICON is 0, this allows you to set what string
  # should be the signal for each level. If this array is empty, then it will
  # just draw the level integer. Ie. if the Quest is Level 4, it will draw 4.
  LEVEL_SIGNALS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  #  COLOURS - This lets you change the colour for various aspects of the 
  # quest scene. Each can be set in one of three ways:
  #    :symbol - If you use a symbol, the colour will be the result of calling 
  #      the method of the same name. For instance, if you set something to 
  #      :system_color, it will set the colour to the result of the Window_Base
  #      system_color method.
  #    Integer - If you set the colour to an integer, then it will take its 
  #      colour from the windowskin palette, just like using \c[x] in messages.
  #    Array - You can also set the rgba values directly with an array in the
  #      format: [red, green, blue, alpha]. alpha can be excluded, but you must
  #      have values for red, green, and blue.
  COLOURS = {
    # active: This sets the colour for active quests in the list and the name
    #  of the active quest when shown in the data window.
    active:           :normal_color,
    # complete: This sets the colour for complete quests in the list and the 
    #  name of the complete quest when shown in the data window.
    complete:         3,
    # failed: This sets the colour for failed quests in the list and the name
    #  of the failed quest when shown in the data window.
    failed:           10,
    # line:  This sets the colour for lines or boxes drawn in the quest scene
    line:             :system_color,
    # line_shadow:  This sets the colour of the shadow for lines or boxes drawn 
    #  in the quest scene
    line_shadow: [0, 0, 0, 128],
    # scene_label: This sets the colour for the scene label, if shown
    scene_label:      :system_color,
    # category_label: This sets the colour for the category label, if shown
    category_label:   :normal_color,
    # level_signal: This sets the colour for the level signal, if shown
    level_signal:     :normal_color,
    # objective_bullet: This sets the colour for objectives; if set to 
    #  :maqj_objective_color, it will reflect the completion status of the
    #  objective, but you can change it to something else if you prefer
    objective_bullet: :maqj_objective_color,
    # reward_amount: The colour of the item amount, when shown
    reward_amount:    :normal_color,
    # heading: The colour of any headings in the script, like "Description"
    heading:          :system_color,
    # basic_label: For basic data, like client, the colour of the label
    basic_label:      :system_color,
    # basic_value: For basic data, like client, the colour of the value
    basic_value:      :normal_color,
  } # <= Do not touch.
  #  HEADING_ALIGN - This sets the alignment for the aspects listed. 0 is Left;
  # 1 is Centre; 2 is Right
  HEADING_ALIGN = {
    description: 0, # Alignment for the Description heading
    objectives:  0, # Alignment for the Objectives heading
    rewards:     1, # Alignment for the Rewards heading
    level:       1  # Alignment when showing the level
  } # <= Do not touch.
  #````````````````````````````````````````````````````````````````````````````
  #    Font Aspects
  # 
  #  All of the following options (FONTNAMES, FONTSIZES, FONTBOLDS, and 
  # FONTITALICS) allow you to alter the fonts used for various aspects of the 
  # scene. The only one listed there by default is normal:, which is the 
  # font used by default for the entire scene. However, you can change the  
  # fonts for almost any aspect - all you need to do is add a line like so:
  #
  #    description: value,
  #
  # and that will change that font aspect when drawing the description. The 
  # following symbols are available for changing:
  #
  #   normal:         The default font used for every part of the scene
  #   list:           The font used in the List Window
  #   scene_label:    The font used when drawing the Scene Label, if shown
  #   category_label: The font used when drawing the Category Label, if shown
  #   heading:        The font used when drawing any headings, like "Description"
  #   name:           The font used when drawing the quest name in data window
  #   description:    The font used when drawing the Description
  #   objectives:     The font used when drawing the objectives
  #   rewards:        The font used when drawing the rewards
  #   client:         The font used when drawing the client
  #   location:       The font used when drawing the location
  #
  # For any of them, you need to set a value. What the value can be depends
  # on which font aspect you are changing and is described below, but for any
  # of them setting it to the false will mean it will simply use the default
  #
  # For any that you add, remember that you must put a comma after the value.
  #````````````````````````````````````````````````````````````````````````````
  #  FONTNAMES - Here you can change the font used for any of the various 
  # options. It can take any of the following types of values:
  #     false    - The default font will be used
  #     "String" - The font with the name "String" will be used.
  #     [Array]  - The array must be in the form: ["String1", "String2", ...]
  #               The font used will be the first one in the array that the 
  #               player has installed.
  #
  #  EXAMPLES:
  #
  #    normal:      false,
  #      The font used for unaltered aspects of the scene is the default font
  #    scene_label: "Algerian",
  #      The font used for the Scene Label will be Algerian.
  #    description: ["Cambria", "Times New Roman"],
  #      The font used when drawing the description will be Cambria if the
  #      player has Cambria installed. If the player does not have Cambria 
  #      installed, then the font used will be Times New Roman
  FONTNAMES = {
    normal: "Porn Star Academy", # normal: the default font name 
  } # <= Do not touch.
  #  FONTSIZES - Here you can change the size of the font. There are two types
  # of values you can set:
  #    false   - The default fontsize will be used
  #    Integer - The fontsize will be equal to the value of the Integer.
  #  
  # For everything but the label windows, this shouldn't exceed 24, since that 
  # is the line_height. However, for scene_label: and category_label:, the size 
  # of the window will be adjusted to whatever size you set the font.
  FONTSIZES = {
    normal:         false, # normal: default font size
    scene_label:    26,    # scene_label: fontsize for the Scene Label window
    category_label: 22,    # category_label: fontsize for Category Label window
  } # <= Do not touch.
  #  FONTBOLDS - Here you can set whether the font will be bolded. You can set 
  # it to either false, in which case it will not be bolded, or true, in which 
  # case it will be bolded.
  FONTBOLDS = {
    scene_label:  false, # scene_label: whether font is bold for Scene Label
    heading:      false, # heading: whether font is bold for the headings
    level_signal: false, # level_signal: whether font is bold for level
  } # <= Do not touch.
  #  FONTITALICS - Here you can set whether the font will be italicized. You
  # can set it to either false, in which case it will not be italicized, or 
  # true, in which case it will be italicized.
  FONTITALICS = {
  }
  #||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  #  END Editable Region A
  #//////////////////////////////////////////////////////////////////////////
  CATEGORIES = [:all] if !CATEGORIES || CATEGORIES.empty?
  VOCAB.default = ""
  ICONS.default = 0
  CATEGORY_VOCAB.default = ""
  SORT_TYPE.default = :id
  COLOURS.default = :normal_color
  HEADING_ALIGN.default = 0
  FONTNAMES.default = false
  FONTSIZES.default = false
  FONTBOLDS.default = false
  FONTITALICS.default = false
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Setup Quest
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def self.setup_quest(quest_id)
    q = { objectives: [] }
    case quest_id
    #\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    #  BEGIN Editable Region B
    #||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    #    Quest Setup
    #
    #  This is where you set up the data for every quest in the game. While
    # it may seem complicated, I urge you to pay attention and, once you get
    # the hang of it, I am sure it will quickly become second nature. 
    #
    #  Every single quest should be set up in the following format, but note
    # that if you are not setting anything for a particular aspect, you can 
    # delete that line. Anyway, this is what each quest should look like, with
    # the values on the left being the default values if you don't set them:
    #
    #  when quest_id
    #   q[:name]              = "??????"
    #   q[:icon_index]        = 0
    #   q[:level]             = 0
    #   q[:description]       = ""
    #   q[:banner]            = ""
    #   q[:banner_hue]        = 0
    #   q[:objectives][0]     = ""
    #   q[:objectives][1]     = ""
    #   q[:objectives][2]     = ""
    #   q[:objectives][n]     = ""
    #   q[:prime_objectives]  = [0, 1, 2, n]
    #   q[:custom_categories] = []
    #   q[:client]            = ""
    #   q[:location]          = ""
    #   q[:rewards]           = []
    #   q[:common_event_id]   = 0
    #   q[:layout]            = false
    #
    #  For each line, with the exception of objectives, it is only the value on 
    # the right of the equals sign that you will need to change. Now I will 
    # explain each line:
    #
    # when quest_id
    #    quest_id - is an integer of your choosing, and this is how you 
    #        reference a quest in order to advance and do anything else. It 
    #        must be unique for every quest; if you use 1 for the first quest, 
    #        you cannot use 1 for any other quest.
    #
    #   q[:name]              = ""
    #     "" - This line sets the name of the quest which shows in the Quest 
    #        List.
    #   
    #   q[:icon_index]        = 0
    #     0  - This line sets the icon to be used for this quest. It will show
    #        to the left of the quest's name in the Quest List.
    #
    #   q[:level]             = 0
    #     0  - This line sets the level of the quest. If 0, no level will be
    #        shown. See the level options at lines 441-458 for more detail.
    #   
    #   q[:description]       = ""
    #     "" - This line sets the description of the quest. You can use message 
    #        codes in this string, but if you are using "" then you need to use
    #        \\ to identify codes and not just \. Ie. It's \\v[x], not \v[x]
    #
    #   q[:objectives][0]     = ""
    #   q[:objectives][1]     = ""
    #   q[:objectives][2]     = ""
    #   q[:objectives][n]     = ""
    #  Objectives are slightly different. Notice that after q[:objectives] on
    # each line there is an integer enclosed in square brackets:
    #    [n] - This is the ID of the objective, and n MUST be an integer. No 
    #       quest can have more than one objective with the same ID. This is 
    #       how you identify which objective you want to reveal, complete or 
    #       fail. That said, you can make as many objectives as you want, as 
    #       long as you give them all distinct IDs. The IDs should be in 
    #       sequence as well, so there shouldn't be a q[:objectives][5] if 
    #       there is no q[:objectives][4].
    #     "" - This is the text of the objective. You can use message codes in 
    #        this string, but if you are using "" then you will need to use 
    #        \\ to identify codes and not just \. Ie: It's \\v[x], not \v[x]
    #
    #   q[:prime_objectives]  = [0, 1, 2, n]
    #     [0, 1, 2, n] - This array determines what objectives need to be 
    #        completed in order for the quest to be complete. In other words, 
    #        all of the objectives with the IDs in this array need to be 
    #        complete for the quest to be complete. If any one of them is 
    #        failed, the quest will be failed. If you remove this line 
    #        altogether, then all objectives are prime. If you set this to [],
    #        then the quest will never be automatically completed or failed and
    #        you need to use the manual options described at lines 208-219.
    #
    #   q[:custom_categories] = []
    #     [] - This allows you to set an array of custom categories for this
    #        quest, whiich means this quest will show up in each of those 
    #        categories if you add it to the CATEGORIES array at line 370.
    #        Note that each category you make must be identified by a unique 
    #        :symbol, and you must set up all the category details for that 
    #        :symbol. 
    #
    #   q[:banner]            = ""
    #     "" - This line sets the banner to be used for a quest. It must be the
    #        filename of an image in the Pictures folder of Graphics.
    #
    #   q[:banner_hue]        = 0
    #     0 - The hue of the banner graphic, if used
    #
    #   q[:client]            = ""
    #     "" - This line sets the client name for this quest. (basic data)
    #
    #   q[:location]          = ""
    #     "" - This line sets the location of the quest. (basic data)
    #
    #   q[:rewards]           = []
    #    [] - In this array, you can identify particular rewards that will 
    #       show up. Each reward should be in its own array and can be any of
    #       the following:
    #          [:item, ID, n],
    #          [:weapon, ID, n],
    #          [:armor, ID, n],
    #          [:gold, n],
    #          [:exp, n],
    #       where ID is the ID of the item, weapon or armour you want
    #       distributed and n is the amount of the item, weapon, armor, gold, 
    #       or experience you want distributed. Additionally, you can also set
    #       some text to show up in the rewards format but which wouldn't be
    #       automatically distributed. You would need to specify that type of
    #       reward text in the following format:
    #          [:string, icon_index, "string", "vocab"],
    #       where icon_index is the icon to be shown, "string" is what you 
    #       would show up as the amount, and "vocab" is what would show up as a
    #       label between the icon and the amount.
    #      
    #
    #   q[:common_event_id]   = 0
    #     0  - This allows you to call the identified common event immediately
    #        and automatically once the quest is completed. It is generally 
    #        not recommended, as for most quests you should be controlling it
    #        enough not to need this feature.
    #
    #   q[:layout]            = false
    #     false - The default value for this is false, and when it is false the
    #        layout for the quest will be inherited from the default you set at
    #        302. However, you can also give the quest its own layout - the 
    #        format would be the same as you set for the default at line 307.
    #  
    # Template:
    #
    #  When making a new quest, I recommend that you copy and paste the
    # following template, removing whichever lines you don't want to alter. 
    # Naturally, you need to remove the #~. You can do so by highlighting
    # the entire thing and pressing CTRL+Q:
#~     when 2 # <= REMINDER: The Quest ID MUST be unique
#~       q[:name]              = "??????"
#~       q[:icon_index]        = 0
#~       q[:level]             = 0
#~       q[:description]       = ""
#~       # REMINDER: You can make as many objectives as you like, but each must 
#~       # have a unique ID.
#~       q[:objectives][0]     = "" 
#~       q[:objectives][1]     = ""
#~       q[:objectives][2]     = ""
#~       q[:prime_objectives]  = [0, 1, 2]
#~       q[:custom_categories] = []
#~       q[:banner]            = ""
#~       q[:banner_hue]        = 0
#~       q[:client]            = ""
#~       q[:location]          = ""
#~       q[:rewards]           = []
#~       q[:common_event_id]   = 0
    when 1 # Quest 1 - Kelp and Rice
      q[:name]              = "Food Fetchers"
      q[:level]             = 1
      q[:icon_index]        = 310
      q[:description]       = "Faun's Tavern is running low on some ingredients. Earn some favor and save them some money by heading out and gathering some \\v[1209] and \\v[1210] in the wild!"
      q[:objectives][0]     = "Harvest some \\i[\\v[1211]] \\v[1209]."
      q[:objectives][1]     = "Pull some \\i[\\v[1212]] \\v[1210]."
      q[:objectives][2]     = "Deliver the Goods to the Guild's Reception."
      #q[:objectives][3]     = "Escort Ladia back to Boris"
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "TavFQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Faun Princess"
      q[:location]          = "The World Map"
      q[:common_event_id]   = 0
      @exx = 100
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end          
      q[:rewards]           = [
        #[:item, 1, 3],
        [:gold, 400],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 2 # Quest 2 - Milkathlon
      q[:name]              = "Till the Cows Come Home"
      q[:level]             = 2
      q[:icon_index]        = 581
      q[:description]       = "The Maiden's Dairies are having an event! Show everyone who's got the real horns of a bull around here and take home the gold!"
      q[:objectives][0]     = "Win the Milk Run."
      q[:objectives][1]     = "Get some  Milk as a 'Souvenir'."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = "Escort Ladia back to Boris"
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "HolQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Milk Maiden #2"
      q[:location]          = "Maiden's Dairies"
      q[:common_event_id]   = 0
      @exx = 200
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end   
      q[:rewards]           = [
        #[:item, 1, 3],
        [:gold, 600],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 3 # Quest 3 - Ores
      q[:name]              = "Crystal Fever"
      q[:level]             = 2
      q[:icon_index]        = 866
      q[:description]       = "Knight's INC wants a full report on the remains of the the kobolds' Reign. Investigate the Kobold Mines and find out if it's safe to try and salvage it. Make sure to pack some hammers or blunt weapons to break through any rocks."
      q[:objectives][0]     = "Reach the deepest part of the Mine."
      q[:objectives][1]     = "Crack the Crystal Lizard that's moved into the Mine."
      q[:objectives][2]     = "Report your findings back to Knights INC."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "CryMQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Kobold's Mines"
      q[:common_event_id]   = 0
      @exx = 250
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end   
      q[:rewards]           = [
        [:item, 107, 1],
        [:gold, 800],
        [:exp, @exx],
      ]
      q[:layout]            = false
            when 15 # Quest 15 - Tea Party
      q[:name]              = "A Spot of Tea"
      q[:level]             = 2
      q[:icon_index]        = 571
      q[:description]       = "The Princesses are meeting together to discuss affairs in an official Tea Party. Knights INC shall act as a neutral party and must provide a trustworthy guard. Sadly, you'll have to do."
      q[:objectives][0]     = "Meet one of the Dragon Carriages around the Kingdom, when a Tea Party is about to begin."
      q[:objectives][1]     = "Stay in your post until the meeting ends."
      q[:objectives][2]     = "Report the Tea Party's results to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "DQEbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Queen's Castle - Tea Party Room"
      q[:common_event_id]   = 0
      @exx = 250
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end   
      q[:rewards]           = [
       [:gold, 650],
       [:exp, @exx],
      ]
      q[:layout]            = false
      when 4 # Quest 4 - Human Help
      q[:name]              = "Oh the Humanity I"
      q[:level]             = 3
      q[:icon_index]        = 565
      q[:description]       = "The Army of the Human Princess needs to upgrade their equipment to get an edge in an upcoming battle. In particular, a general in the army has heard of some top quality armor within the kingdom that he wants for himself. Bring it to him and prove your loyalty to the cause!"
      q[:objectives][0]     = $data_armors[$game_variables[959]].name
      q[:objectives][1]     = "Once you deliver it to the humans, report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "HumQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Human Warmonger"
      q[:location]          = "Human Town"
      q[:common_event_id]   = 0
      @exx = 350
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end   
      q[:rewards]           = [
        [:weapon, 101, 0],
        [:item, 111, 0],
        [:exp, @exx],
      ]
      when 5 # Quest 5 - Human Help
      q[:name]              = "Oh the Humanity II"
      q[:level]             = 3
      q[:icon_index]        = 565
      q[:description]       = "Members of the human army have been stirring for war and want to make sure they have the advantage. A warmongering official wants a rare weapon he's heard of to rally the troops to battle. Find this weapon and make sure it goes to the Human Kingdom's side to prove whose side you're on!"
      q[:objectives][0]     = $data_weapons[$game_variables[957]].name
      q[:objectives][1]     = "Once you deliver it to the humans, report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "HumQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Human Warmonger"
      q[:location]          = "Human Town"
      q[:common_event_id]   = 0
      @exx = 350
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end    
      q[:rewards]           = [
        [:armor, 101, 0],
        [:item, 111, 0],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 6 # Quest 6 - Golem Help
      q[:name]              = "I Can Rock Your World"
      q[:level]             = 3
      q[:icon_index]        = 564
      q[:description]       = "The golems are working on a project that will apparently assist in improving the good of the land. They cannot progress without a special ore that can only be found in peculiar rocks scattered across the continent. Please lend your cooperation and deliver one to them."
      q[:objectives][0]     = "Smash rocks in the wild and find an \\i[824] Aleph Stone."
      q[:objectives][1]     = "Deliver the \\i[824] Aleph Stone to the Guardian at the Golem Kingdom's entrance."
      q[:objectives][2]     = "Report your success to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "GolQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Golem Guardian"
      q[:location]          = "Golem Princess' Tower"
      q[:common_event_id]   = 0
      @exx = 350
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end     
      q[:rewards]           = [
        [:item, 113, 0],
        [:gold, 750],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 7 # Quest 7 - Insect Help
      q[:name]              = "Don't You Egg Me On"
      q[:level]             = 3
      q[:icon_index]        = 566
      q[:description]       = "The Hive' insects have a new brood of eggs ready to hatch, but are short on numbers to protect them from predators. They need a capable, preferably handsome bodyguard for just a little while. Applicants who are not eaten will have a clutch named after them."
      q[:objectives][0]     = "Report to the Hive's Egg Chambers for your post."
      q[:objectives][1]     = "Protect the eggs from the invaders."
      q[:objectives][2]     = "Report the safety of the eggs to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "InsQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "An Insect egg-warden"
      q[:location]          = "Insect's Hive"
      q[:common_event_id]   = 0
      @exx = 500
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end    
      q[:rewards]           = [
        [:item, 114, 0],
        [:gold, 900],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 8 # Quest 8 - Skeleton Help
      q[:name]              = "That Stiff Feeling"
      q[:level]             = 3
      q[:icon_index]        = 567
      q[:description]       = "The Skeleton Princess' troops overslept and can't move! They need some warm, meaty hands to help limber them up and get them back into shape."
      q[:objectives][0]     = "Go to the Frozen Church and find the 'Bonesetting Room'"
      q[:objectives][1]     = "Get the Skeleton Troops moving again."
      q[:objectives][2]     = "Go back to the Guild before the skeletons jump your bones."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "SkeQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Skeleton Princess"
      q[:location]          = "Frozen Church"
      q[:common_event_id]   = 0
      @exx = 350
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end    
      q[:rewards]           = [
        [:item, 115, 0],
        [:item, 300, 5],
        [:gold, 800],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 9 # Quest 9 - Desert Help
    if $game_switches[1448] == true  
      q[:name]              = "[Advanced] Dancing Djinn" 
      q[:level]             = 11
    else    
      if $game_switches[1315] == true
      q[:name]              = "Dance Till They Drop +"  
      q[:level]             = 9 
    else
      q[:name]              = "Dance Till They Drop"
      q[:level]             = 3 
    end
    end
      q[:icon_index]        = 561
      q[:description]       = "To liven up the Moon Festival, and solidify the friendship between the Guild and the Desert Reign, one of us should join their traditional dance exhibition and do it well!"
      q[:objectives][0]     = "Talk to Dancer on the stage during a Moon Festival and get movin'!"
      q[:objectives][1]     = "Please the stars with your dance!"
      q[:objectives][2]     = "Report the stars' pleasure to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [1, 2]
      q[:custom_categories] = []
      q[:banner]            = "DesDQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Desert Princess"
      q[:location]          = "Festival Plaza"
      q[:common_event_id]   = 0
      @exx = 1
      if $game_switches[1315] == false
      @exx = 450
        else
      @exx = 1750
      end
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end    
     if $game_switches[1448] == true  
      q[:rewards]           = [
        [:armor, 321, 1],
        [:item, 116, 4],
        [:item, 245, 2],
        [:gold, 2500],
      ]
    else          
      if $game_switches[1315] == false
      q[:rewards]           = [
        [:item, 116, 2],
        [:item, 245, 1],
        [:gold, 550],
        [:exp, @exx],
      ]
    else
      q[:rewards]           = [
        [:item, 116, 4],
        [:item, 245, 2],
        [:gold, 2000],
        [:exp, @exx],
      ]      
    end
    end
      q[:layout]            = false
      when 10 # Quest 10 - The haunted house
      q[:name]              = "Who We Calling?"
      q[:level]             = 3
      q[:icon_index]        = 562
      q[:description]       = "Some ghosts are haunting an old wing of the Ghost Princess' mansion... Well, that's normal, but this wing in particular has some unwanted and evil ghosts, so the rest of the ghosts want them gone. Please come and help kick them out!"
      q[:objectives][0]     = "Report to the Ghostly Citizen for your job."
      q[:objectives][1]     = "Exorcise the screaming specters in the Cloister."
      q[:objectives][2]     = "[Optional] Don't get spotted. Not even once!"
      q[:objectives][3]     = "Report that the mansion is now slightly less haunted to the Guild."
      q[:prime_objectives]  = [0, 1, 3]
      q[:custom_categories] = []
      q[:banner]            = "GhoAffQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Ghostly Citizen"
      q[:location]          = "Ghost Princess' Mansion - Old Cloister"
      q[:common_event_id]   = 0
      @exx = 750
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end    
      q[:rewards]           = [
        [:item, 117, 0],
        [:gold, 850],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 11 # Quest 11 - Goblin Help
      q[:name]              = "The People Persons"
      q[:level]             = 3
      q[:icon_index]        = 563
      q[:description]       = "The Goblin's lucrative trade business needs some more handymen to help escort some of their delicate part time employees to some important clients. This honest work will show you want to support the Goblin cause!"
      q[:objectives][0]     = "Report to the Clerk at the Goblin City for more details."
      q[:objectives][1]     = "Escort your 'charge' to \\v[1076] : \\v[1077]."
      q[:objectives][2]     = "Report the delivery to the Guild"
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "GobSQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Slave Market Clerk"
      q[:location]          = "Goblin City"
      q[:common_event_id]   = 0
      @exx = 450
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:item, 118, 0],
        [:gold, 1000],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 12 # Quest 12 - Slime Help
      q[:name]              = "Fouled waters"
      q[:level]             = 3
      q[:icon_index]        = 560
      q[:description]       = "The Slimes Reign's water supply has been contaminated with some sort of poison! They need someone to go investigate the source and hopefully get rid of it while the slimes work on cleaning the water out before the pollution spreads too far to handle."
      q[:objectives][0]     = "Reach the Slimes' Spring and search for the cause of the pollution."
      q[:objectives][1]     = "Eradicate the poisonous plants!"
      q[:objectives][2]     = "Report the incident to Knight's INC."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "SlimeCQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Slime Water Surveyor"
      q[:location]          = "Slimes' Spring"
      q[:common_event_id]   = 0
      @exx = 400
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:item, 112, 0],
        [:gold, 700],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 13 # Quest 13 - Sperm Collector #1
      q[:name]              = "See Man's Collection - I"
      q[:level]             = 4
      q[:icon_index]        = 630
      q[:description]       = "Knight's INC has received an odd request for the... sexual fluids of a certain Monster. Yes, really. It's as dubious as they come, but it pays well, so if you really want to, go and get to work. Please do not report to us how you got the requested goods."
      q[:objectives][0]     = $data_items[$game_variables[977]].name
      q[:objectives][1]     = "Deliver the samples to the Client's 'Lab' in the sewers near the Frozen Church."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "SewQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Mysterious Man"
      q[:location]          = "Skeleton's Sewers"
      q[:common_event_id]   = 0
      @exx = 500
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:gold, 1500],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 14 # Quest 14 - Safety first
      q[:name]              = "Princess Purity"
      q[:level]             = 1
      q[:icon_index]        = 630
      q[:description]       = "The Continent is a dangerous place, especially for ladies! If you're playing escort and white knight, you should head to the Chapel near the Human Reign for guidance."
      q[:objectives][0]     = "Go to the Chapel and get lectured about Corruption and how to keep it low."
      q[:objectives][1]     = "Report back to Knight's INC for some real work!"
      # q[:objectives][2]     = "Report back to Knight's INC for some real work!"
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "ChurchQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "???"
      q[:location]          = "Chapel"
      q[:common_event_id]   = 0
      @exx = 150
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:gold, 250],
        [:exp, @exx],
      ]
      q[:layout]            = false
            when 16 # Quest 16 - Human P disappeared
      q[:name]              = "Our Personable Pretty Princess"
      q[:level]             = 1
      q[:icon_index]        = 565
      q[:description]       = "The Human Princess has suddenly vanished from the castle! She's left a map on the throne that seems to indicate she was heading south for some reason. She can't have gone far, but the wilds are dangerous. Hurry and catch her before you lose her trail!"
      q[:objectives][0]     = "Search South of the Castle for any signs of the Princess."
      q[:objectives][1]     = "Save the Princess from the Goblin Camp!"
      #q[:objectives][2]     = "Report a successful rescue to Knight's INC."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "HumWQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Human Princess"
      q[:location]          = "Goblin bandits' campsite"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:gold, 500],
      ]
      q[:layout]            = false
            q[:layout]            = false
      when 17 # Quest 17 - Drider awaken
      q[:name]              = "Living Under A Rock"
      q[:level]             = 1
      q[:icon_index]        = 564
      q[:description]       = "Golem Princess seems very out of it. It might be a good idea to investigate the area on your own and see if something weird is going on among the golems."
      q[:objectives][0]     = "Search the Golem Tower for signs of wrongdoing."
      q[:objectives][1]     = "Something's invaded the Tower! Report your findings to the Princess!"
      q[:objectives][2]     = "Stomp this Creepy crawly of a royal down."
      q[:objectives][3]     = "Check on Golem Princess."
      q[:prime_objectives]  = [3]
      q[:custom_categories] = []
      q[:banner]            = "GolTQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Golem Princess"
      q[:location]          = "Golem Tower"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false
      when 18 # Quest 18 - Clockwork
      q[:name]              = "The Key To Her Heart"
      q[:level]             = 1
      q[:icon_index]        = 564
      q[:description]       = "The Golem Princess has asked you to retrieve her 'heart'. She mumbled something about a Desert. There must be clues there..."
      q[:objectives][0]     = "\\i[531] Find the Clockwork Core."
      q[:objectives][1]     = "Give the Core to the Princess."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "GolHQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Golem Princess"
      q[:location]          = "Around the desert..."
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:gold, 5000],
      ]
      q[:layout]            = false
      when 19 # Quest 19 - salts
      q[:name]              = "Slimy Sea Salts"
      q[:level]             = 1
      q[:icon_index]        = 560
      q[:description]       = "Slime Princess desires a special treat that's only available from the Merchant Princess. Wait for her to show up in the Slime Meadow and purchase some \\i[819] Slime Salts as a gift for Slime Princess!"
      q[:objectives][0]     = "Buy some \\i[819] Slime Salts from Merchant Princess."
      q[:objectives][1]     = "Surprise Slime Princess with your gift!"
      #q[:objectives][2]     = "" 
      #q[:objectives][3]     = "" 
      q[:prime_objectives]  = [1]
      q[:custom_categories] = []
      q[:banner]            = "SlimeQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Slime Princess"
      q[:location]          = "Slime Princess' Meadow"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:gold, 500],
      ]
      q[:layout]            = false
      when 20 # Quest 20 - Hunt the rebel down!
      q[:name]              = "Flycatcher"
      q[:level]             = 1
      q[:icon_index]        = 566
      q[:description]       = "The Insect Princess has heard of a rising insurgence from the remains of a fallen reign. This Hive is all about unity and serving the queen, so go tell these wannabe rebels to buzz off!"
      q[:objectives][0]     = "Find and investigate the camp near the Hive."
      q[:objectives][1]     = "Swat out some rebels."
      q[:objectives][2]     = "Report to Insect Princess."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "InsKQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Insect Princess"
      q[:location]          = "Insect's Hive"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:item, 114, 0],
        [:gold, 1500],
      ]
      q[:layout]            = false
      when 21 # Quest 21 - Bone Rattles
      q[:name]              = "Samba de Esqueleto"
      q[:level]             = 1
      q[:icon_index]        = 567
      q[:description]       = "Skeleton Princess has lost her precious dowry during her unwanted slumber. She needs you to go find her favorite instrument, her... rattles. She promises she throws a real good samba. She also suspects the Golems probably had something to do with them disappearing."
      q[:objectives][0]     = "Shake the Golems down for the \\i[634] Bone Rattles."
      q[:objectives][1]     = "Deliver the Bone Rattles to the Princess"
      #q[:objectives][2]     = "Optional: Escape the Skeleton Mansion before the Princess can throw you a party."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "SkeHQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Skeleton Princess"
      q[:location]          = "Golem Tower"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:gold, 800],
      ]
            q[:layout]            = false
      when 22 # Quest 22 - Save Sphinx Princess
      q[:name]              = "Clawing Your Way Ahead"
      q[:level]             = 1
      q[:icon_index]        = 561
      q[:description]       = "Desert Princess hasn't heard from her companion the Sphinx Princess since their last meeting. She's worried the haughty cat has gotten caught up in some kind of trouble and wants someone to go investigate her Pyramid."
      q[:objectives][0]     = "Search for Sphinx Princess in her Pyramid"
      q[:objectives][1]     = "Knock Skulls with Crusader Princess."
      #q[:objectives][2]     = "Head on over to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "DesSQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Desert Princess"
      q[:location]          = "Sphinx's Pyramid"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:gold, 800],
      ]
            q[:layout]            = false
      when 23 # Quest 23 - Package Delivery
      q[:name]              = "Thinking Greens"
      q[:level]             = 1
      q[:icon_index]        = 563
      q[:description]       = "The Goblin Princess wants to see how faithful and compatible you are. To this she's given you a test. Deliver the \\i[915] Goblin's Package to a merchant in the Human Castle and sell it without checking what's inside. Time to practice your shady businessman act!"
      q[:objectives][0]     = "Bring the \\i[915] Goblin's Package to the merchant without opening it."
      q[:objectives][1]     = "Sell the \\i[915] Goblin's Package to the merchant."
      q[:objectives][2]     = "Optional: Sell the \\i[915] Goblin's Package for at least 650 \\i[626] Swirlies"
      q[:objectives][3]     = "Report to the Slave Market Clerk at the Goblin Town."
      q[:prime_objectives]  = [0, 1, 3]
      q[:custom_categories] = []
      q[:banner]            = "GobSQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Goblin Princess"
      q[:location]          = "Human Town"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      [:item, 118, 0],
      ]
            q[:layout]            = false
      when 24 # Quest 24 - Kobold Plug
      q[:name]              = "A Kobolds' Best Friend"
      q[:level]             = 1
      q[:icon_index]        = 568
      q[:description]       = "Kobold Princess has been getting very restless and claims to have lost a very important treasure when the Kobold reign fell. Head to the ruins of the Kobolds' Fortress and find her 'special gem'."
      q[:objectives][0]     = "Find a \\i[549] Gemstone hidden in the Kobolds' Fortress remnants."
      q[:objectives][1]     = "Give the odd gem to the Princess next time you set up camp."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "KobFriendQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Kobold Princess"
      q[:location]          = "Kobolds' Fortress"
      q[:common_event_id]   = 0
      q[:rewards]           = [
       ]
       q[:layout]            = false
         when 25 # Quest 25 - Slime Pool
      q[:name]              = "Bubbling Emotions"
      q[:level]             = 1
      q[:icon_index]        = 560
      q[:description]       = "The Slime Princess is homesick and told you about a special pond that's important to her. Help her sneak back into the Slime Meadow and reach the pond in her throne room. She mentioned a secret passage into the inner parts of the Meadow that should take you there."
      q[:objectives][0]     = "Go to the Slime Meadow at night."
      q[:objectives][1]     = "Find the hidden passage. Avoid any attention and guards."
      q[:objectives][2]     = "Sneak into the Princess' former throne room."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "SlimeCQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Slime Princess"
      q[:location]          = "Slime Princess' Meadow"
      q[:common_event_id]   = 0
      q[:rewards]           = [
       ]
       q[:layout]            = false
      when 26 # Quest 26 - Pantsu steal
      q[:name]              = "Garnering Garments"
      q[:level]             = 4
      q[:icon_index]        = 637
      q[:description]       = "An anonymous Princess saw her stolen panties in Merchant Princess' stall, but was too embarrassed to confront her about it. Retrieve the stolen panties and bring them back to the one you deem to be the rightful owner!"
      q[:objectives][0]     = "Retrieve the stolen panties from Merchant Princess."
      q[:objectives][1]     = "Use Merchant Princess' info to figure out who owns the panties and return them."
      q[:objectives][2]     = "Report to the Guild and wash your hands."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "TavMQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "??? Princess"
      q[:location]          = "??? Princess' Castle"
      q[:common_event_id]   = 0
      @exx = 500
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
      [:item, 119, 0],
      [:gold, 400],
      [:exp, @exx],
       ]
       q[:layout]            = false
      when 27 # Quest 27 - Dragon Route
      q[:name]              = "Red Rising"
      q[:level]             = 1
      q[:icon_index]        = 576
      q[:description]       = "The Dragon Queen doubts your loyalty, but has been convinced to give you a chance to prove your worth. She has some tasks for you to do and won't give you much time to do them. It looks like she has plans..."
      q[:objectives][0]     = "Rebuild the Dragon Princess' hoard."
      q[:objectives][1]     = "Sabotage the strongest reign on behalf of the Dragon Queen"
      q[:objectives][2]     = "Report to the Queen"
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "DP1HoardQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Dragon Queen"
      q[:location]          = "Dragon Queen's Castle"
      q[:common_event_id]   = 0
      q[:rewards]           = [
       ]
       q[:layout]            = false
      when 28 # Quest 28 - Tea Party S
      q[:name]              = "A Spot of Tea, South"
      q[:level]             = 2
      q[:icon_index]        = 571
      q[:description]       = "A few Princesses are meeting together to discuss affairs in an official Tea Party. Knights INC shall act as a neutral party and must provide a trustworthy guard. Sadly, you'll have to do."
      q[:objectives][0]     = "Report to your guard duty at the Goblin City"
      q[:objectives][1]     = "Stay in your post until the meeting ends. Let no one inside."
      q[:objectives][2]     = "Report the Tea Party's results to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "TeaSQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Tea Room"
      q[:common_event_id]   = 0
      @exx = 250
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
       [:gold, 650],
       [:exp, @exx],
      ]
      q[:layout]            = false
      when 29 # Quest 29 - Play with Moth
      q[:name]              = "Whimsical Butterflies"
      q[:level]             = 3
      q[:icon_index]        = 577
      q[:description]       = "The Moth Princess seems bored and lonely. It'll be hard to really talk to her or get things done if she keeps sulking like this. Go talk to the Moth Ministers for more information and help them get the Princess back in shape!"
      q[:objectives][0]     = "Get the details from the Moth Ministry of Entertainment."
      q[:objectives][1]     = "Find the goblins playing Hide and Seek in Moth's Forest."
      q[:objectives][2]     = "Stop playing around and report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "MotQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Moth Ministry of Entartainment"
      q[:location]          = "Moth's Forest"
      q[:common_event_id]   = 0
      @exx = 550
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
       [:item, 120, 0],
       [:gold, 650],
       [:exp, @exx],
      ]
      q[:layout]            = false
              when 30 # Quest 30 - Amelie q
       q[:name]             = "Happy Family Reunion"
      q[:level]             = 4
      q[:icon_index]        = 569
      q[:description]       = "A renowned Paladin has gone missing after putting in a request for the Guild to help him find his daughter. This quest has turned into a double search party. Investigate his house in the Human Town and then go find him and his daughter."
      q[:objectives][0]     = "Search the Paladin's house for clues about him and his daughter."
      q[:objectives][1]     = "Clues seem to point toward the Paladin going on a quest. Investigate the HUGETREASURE Dungeon."
      q[:objectives][2]     = "The Paladin was holding onto a pristine cross-shaped relic. Perhaps the Church might be able to identify it?"
      q[:objectives][3]     = "Deliver the relic to Amelie."
      q[:objectives][4]     = "Report your search to the Guild."
      q[:prime_objectives]  = [0, 1, 2, 3, 4]
      q[:custom_categories] = []
      q[:banner]            = "TavQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Humans Princess' Town"
      q[:common_event_id]   = 0
      q[:rewards]           = [
       [:gold, 2000],
      ]
      q[:layout]            = false
          when 31 # Quest 31 - Help Cat
      q[:name]              = "Help Cat"
      q[:level]             = 3
      q[:icon_index]        = 578
      q[:description]       = "Show your support for Cat Princess! Bring her children to play with"
      q[:objectives][0]     = ""
      q[:objectives][1]     = ""
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = "Search for Amelie and deliver the girl her father's keepsake"
      #q[:objectives][4]     = "Report to the Guild."
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = ""
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Cat Princess' Village"
      q[:common_event_id]   = 0
      @exx = 550
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
       [:item, 121, 0],
       [:gold, 650],
       [:exp, @exx],
      ]      
      q[:layout]            = false
       when 32 # Quest 32 - Hum Revenge
      q[:name]              = "Hands Tied"
      q[:level]             = 1
      q[:icon_index]        = 565
      q[:description]       = "Human Princess has disappeared from camp after your training session! She seemed oddly determined the last time you saw her. You need to think about where she might've gone before she picks a fight she can't win! You get the feeling she may have gone somewhere you've both been to..."
      q[:objectives][0]     = "Figure out where the Princess went."
      q[:objectives][1]     = "Kill the leader of the Goblin Bandits."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "HumWQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Human Princess"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
       ]
       q[:layout]            = false
       when 33 # Quest 33 - Sperm Collector #2
      q[:name]              = "See Man's Collection - II"
      q[:level]             = 5
      q[:icon_index]        = 630
      q[:description]       = "Knight's INC has received another odd request for sexual fluids of a certain Monster. We won't ask any questions as long as the pay goes through, so if you really want to take this job, just go get to work."
      q[:objectives][0]     =  $data_items[$game_variables[977]].name
      q[:objectives][1]     = "Deliver the samples to the client's 'Lab' in the sewers near the Frozen Church."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "SewQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Mysterious Man"
      q[:location]          = "Skeleton's Sewers"
      q[:common_event_id]   = 0
      if $game_variables[628] == 20
        
      elsif $game_variables[628] == 120
        
      elsif $game_variables[628] == 1020
        
      end  
      q[:rewards]           = [
        [:gold, 3000],
        [:exp, 850],
      ]
      q[:layout]            = false
       when 34 # Quest 34 - Elite hunt
      q[:name]              = "Monster Killer Turbo"
      q[:level]             = 5
      q[:icon_index]        = 866
      q[:description]       = "The population of a certain monster has gotten a bit too dense for the Kingdom's, and our guild's, liking. If you want to prove your worth, go and kill one of their Elites to cut their numbers and strength down. You'll rarely see one within a hoard of their normal members, so just try and identify it."
      q[:objectives][0]     = $game_variables[1704]
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "EhuntQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      @exx = 900
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:item, 75, 3], 
        [:gold, 1500],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 35 # Quest 35 - ShipQ
      q[:name]              = "Ship Searching Sea Blues"
      q[:level]             = 5
      q[:icon_index]        = 569
      q[:description]       = "An unmarked, unknown ship has been trailing among the shores of the Northern Ports. Rumors have started spreading about what it might be doing. Go figure out who's manning that ship before things get out of hand!"
      q[:objectives][0]     = "Find the Ship and get aboard."
      q[:objectives][1]     = "'Guests' can't stay on the ship when it undocks. Find a way to infiltrate it and remain aboard anyway."
      q[:objectives][2]     = "Sneak your way to the Captain's cabin."
      q[:objectives][3]     = "Report your findings to the Guild."
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "PirQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Northern Region's docks"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:gold, 1500],
      ]
      q[:layout]            = false
      when 36 # Quest 36 - A trophy for Cat
      q[:name]              = "Trophy (Hunting) Wife"
      q[:level]             = 1
      q[:icon_index]        = 578
      q[:description]       = "The Cat Princess wants to test your skills as a slayer of Monsters and also wants a new trophy for her collection, one that fits a true hunter like her. Find and kill an Elite Monster to really impress her and show off your own hunting abilities."
      q[:objectives][0]     = "Kill an Elite Monster. Elites will rarely appear in groups of regular monsters."
      q[:objectives][1]     = "Bring the remains to Cat Princess."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "CatHQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Cat Princess"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:item, 121, 1],
      ]
      q[:layout]            = false
      when 37 # Quest 37 - Cat Q
      q[:name]              = ""
      q[:level]             = 1
      q[:icon_index]        = 578
      q[:description]       = ""
      q[:objectives][0]     = ""
      q[:objectives][1]     = ""
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "CatHQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Cat Princess"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:item, 121, 1],
      ]
      q[:layout]            = false
      when 38 # Quest 38 - Dog Q Step
      q[:name]              = "Of Greater Scales"
      q[:level]             = 4
      q[:icon_index]        = 569
      q[:description]       = "A mysterious contractor has contacted you to assist them in retrieving an ancient artifact, said to hold the power to slay great monsters, even gods and tyrants. They're waiting to meet you, in a place 'filled with magic.'"
      q[:objectives][0]     = "Use the clues to meet the contractor."
      q[:objectives][1]     = "Find the \\i[834] Queen's Scale in the depths of the mansion."
      q[:objectives][2]     = "Deliver the \\i[834] Queen's Scale to Dusk Princess"
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "DuskEQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "???"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false
      when 39 # Quest 39 - 2 birbs
      q[:name]              = "Two Birds With One Stone"
      q[:level]             = 4
      q[:icon_index]        = 569
      q[:description]       = "A recently jailed man wants to hire an adventurer to help him prove his innocence. He's done some good service for the Guild before, so we've accepted his request despite his criminal status. Please visit him in jail and hear him out."
      q[:objectives][0]     = "Go to the Gazer Prison and speak to your client."
      q[:objectives][1]     = "Enter Crowley's Laboratory and put a stop to the miasma."
      q[:objectives][2]     = "Deal with Calamitas, one way or another."
      q[:objectives][3]     = "Report to the Guild."
      q[:prime_objectives]  = [0, 1, 2, 3]
      q[:custom_categories] = []
      q[:banner]            = "CroPQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "???"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      @exx = 850
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
      [:gold, 2500],
      [:exp, @exx],
      ]
      q[:layout]            = false
      when 40 # Quest 40 - Celery Root
      q[:name]              = "The Root of the problem.."
      q[:level]             = 1
      q[:icon_index]        = 579
      q[:description]       = "The Second Dragon Princess has tasked you with gathering some Celery Root for a project of hers. Since it's apparently witchcraft, you might as well go shake a witch down for their own stock."
      q[:objectives][0]     = "Find a proper, classical witch."
      q[:objectives][1]     = "Get the \\i[206] Celery Root from the Witch's Hut, however you must."
      q[:objectives][2]     = "Bring the \\i[206] Celery Root back to the Dragon Princess."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "WitchQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Dragon Princess II"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false
      when 41 # Quest 41 - Trevor Book
      q[:name]              = "Love's Paper Trail"
      q[:level]             = 1
      q[:icon_index]        = 579
      q[:description]       = "The Second Dragon Princess wishes to find some new scientific text for her research. There's apparently a famed book out there that's in limited print and might be sold by a specialized merchant. Of course, you'll go shopping for her. Of course, you'll use your own money for it. What kind of research is it? Oh, sexual practices, of course."
      q[:objectives][0]     = "Find a merchant that sells adult-themed goods."
      q[:objectives][1]     = "Purchase the 'Research Paper' from Trevor."
      q[:objectives][2]     = "Give the book to Dragon Princess II."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "DP2BookQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Dragon Princess II"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false 
      when 42 # Quest 42 - ArcaneP
      q[:name]              = "An Arcane Force to be Reckoned With"
      q[:level]             = 1
      q[:icon_index]        = 579
      q[:description]       = "The Second Dragon Princess wants you to go look for and investigate (loot) one of the laboratories of the fabled Wizard Master. Rumor has it he had been conducting experiments with a new source of magical energy before having to abandon the lab. Dragons fully enforce the 'Keep' part of Finders Keepers."
      q[:objectives][0]     = "Find the frozen cave in the most southern regions of the Continent."
      q[:objectives][1]     = "Search through the Wizard Master's lab for his 'magic source'."
      q[:objectives][2]     = "Touch the glowy magics for science."
      q[:objectives][3]     = "Report to the Dragon Princess."
      q[:prime_objectives]  = [0, 1, 2, 3]
      q[:custom_categories] = []
      q[:banner]            = "ArcaneQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Dragon Princess II"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false
      when 43 # Quest 43 - Food for kobolds
      q[:name]              = "The Rational Thing"
      q[:level]             = 1
      q[:icon_index]        = 568
      q[:description]       = "Knight's INC. is interested and agrees to starting business with the fledgling Kobolds to try and restore their reign. And the first part of business is... well, business! Do some jobs for the Guild and tavern and they'll trade some supplies for your venture. The chefs have a bit of a pest issue they'd like dealt with..."
      q[:objectives][0]     = "Talk to the tavern cook at night and assess the situation"
      q[:objectives][1]     = "Defend the Faun's Tavern from those.... beasts!"
      q[:objectives][2]     = "Report to the Guild."
      q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "RationsQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Faun's Tavern"
      q[:common_event_id]   = 0
      @exx = 350
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
       [:item, 212, 1],
       [:exp, @exx],
      ]   
      q[:layout]            = false         
      when 44 # Quest 44 - Lost Stockings
      q[:name]              = "Fairied Away"
      q[:level]             = 1
      q[:icon_index]        = 580
      q[:description]       = "Fairy Princess' bracelet has been stolen! She needs your help to retrieve it"
      q[:objectives][0]     = "Find the culprit behind the theft"
      q[:objectives][1]     = "Get the \\i[611] Pixie's Bracelet back"
      q[:objectives][2]     = "Report to Fairy Princess"
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "FaiQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Fairy Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]   
      q[:layout]            = false
when 45 # Quest 45 - Milk Time
      q[:name]              = "The Milky Way"
      q[:level]             = 4
      q[:icon_index]        = 581
      q[:description]       = "The Holstaurs have been having some problems keeping up with the recent rush in customers. Some part time help could really help bolster their staff numbers! Cow haters and people allergic to milk need not apply."
      q[:objectives][0]     = "Go to the Milk Bar and talk to the Milk Maiden at the counter."
      q[:objectives][1]     = "Gently milk Holstaur Princess."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]    = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "HolMQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Holstaur Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      @exx = 1000
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
      [:armor, 139, 0],
      [:gold, 1000],
      [:exp, @exx],
      ]   
      q[:layout]            = false    
      when 46 # Quest 46 - Rocky Tunnels
      q[:name]              = "That Classic Cave Grind"
      q[:level]             = 1
      q[:icon_index]        = 582
      q[:description]       = "There's been an influx of beasts invading the tunnels surrounding the Clocktown. Head into the caves, find Mouse Princess' sister, and help stop the beasts from expanding their territory!"
      q[:objectives][0]     = "Find Miss Borne in the Rocky Tunnels."
      q[:objectives][1]     = "Defend this point from the attacking beasts."
      q[:objectives][2]     = "Get back to the Princess and report a job well done."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "MouTunQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Mouse Princess"
      q[:location]          = "Rocky Tunnels"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]   
      q[:layout]            = false   
      when 47 # Quest 47 - Assist MouseP
      q[:name]              = "Just Cogs in the Machine"
      q[:level]             = 3
      q[:icon_index]        = 582
      q[:description]       = "The machines defending the Clocktown are in need of some maintenance to make sure there's no unforeseen accidents or convenient malfunctions anytime soon. Go down to the Tunnels, find the Hourly Sister in charge of the repairs, and see what she needs to get things fixed up and new again."
      q[:objectives][0]     = "Find Hourly Sister #9 in the Rocky Tunnels."
      q[:objectives][1]     = "Find 5 \\i[610] Cogs and bring them to the Hourly Sister."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "MouQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Rocky Tunnels"
      q[:common_event_id]   = 0
      @exx = 550
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end 
      q[:rewards]           = [
        [:item, 122, 1],
        [:gold, 550],
        [:exp, @exx],
      ]
      q[:layout]            = false
      when 48 # Quest 48 - Find Crestie
      q[:name]              = "No Need To Lose Your Head"
      q[:level]             = 0
      q[:icon_index]        = 585
      q[:description]       = "The headless body of Dullahan Princess would very much like to find her more talkative half, Crest Princess. Well, Armor Princess doesn't really like it, but she kinda needs her anyway. Either way, you've been drafted to assist her in this endeavor. Now you just need clues on where Crest Princess might be..."
      q[:objectives][0]     = "Search for Crest Princess."
      q[:objectives][1]     = "Crest Princess is somewhere in the Pyramid! Find her before she gets into trouble!"
      q[:objectives][2]     = "Reunite Dullahan Princess at the Tavern."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 2]
      q[:custom_categories] = []
      q[:banner]            = ""
      q[:banner_hue]        = 0
      q[:client]            = "Armor Princess"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false      
      when 49 # Quest 49 - Rabbit Help
      if $game_switches[3333] == true
      q[:name]              = "Lunatic Delivery +"      
    else
      q[:name]              = "Lunatic Delivery"
      end    
      q[:level]             = 3
      q[:icon_index]        = 583
      q[:description]       = "Show your support for Rabbit Princess! Harvest and deliver grapes for her neighbours! They ripen only at night."
      q[:objectives][0]     = "\\i[296] Gather 5 Ripe Grapes from the Cotton Vineyards."
      q[:objectives][1]     = "Deliver the grapes to \\v[3657]."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "RabQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Rabbit Vineyards"
      q[:common_event_id]   = 0
      @exx = 650
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      if $game_switches[3333] == true
        q[:rewards]           = [
        [:item, 123, 2],
        [:item, 242, 2],        
        [:gold, 750],
        [:exp, @exx],
      ]          
    else
        q[:rewards]           = [      
        [:item, 123, 1],
        [:item, 242, 1],        
        [:gold, 250],      
        [:exp, @exx],
      ]
      end
      q[:layout]            = false           
       when 50 # Quest 50 - Small world
      q[:name]              = "Tinhead Talker"
      q[:level]             = 6
      q[:icon_index]        = 571
      q[:description]       = "In a busy and volatile time like this it is important to see the thoughts of the populace. Go to the places people gather at most and talk to members of all the species that make up the Kingdom and get some data about them and their relations."
      q[:objectives][0]     = "Speak to a Human"
      q[:objectives][1]     = "Speak to a Slime"
      q[:objectives][2]     = "Speak to a Golem"
      q[:objectives][3]     = "Speak to an Insect"
      q[:objectives][4]     = "Speak to a Skeleton"
      q[:objectives][5]     = "Speak to a Succubus"
      q[:objectives][6]     = "Speak to a Ghost"
      q[:objectives][7]     = "Speak to a Goblin"
      q[:objectives][8]     = "Speak to a Moth"
      q[:objectives][9]     = "Speak to a Cat"
      q[:objectives][10]    = "Speak to a Dog"
      q[:objectives][11]    = "Speak to a Mouse"
      q[:objectives][12]    = "Speak to a Rabbit"
      q[:objectives][13]    = "Speak to a Finhead"
      q[:objectives][14]    = "Speak to a Bird"
      q[:objectives][15]    = "Speak to an Oni"
      q[:objectives][16]    = "Speak to a Plant"      
      q[:objectives][17]    = "Report to the Guild."     
      q[:prime_objectives]  = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
      q[:custom_categories] = []
      q[:banner]            = "TinheadQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Gathering Spots"
      q[:common_event_id]   = 0
      @exx = 1200
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end 
      q[:rewards]           = [
        [:gold, 5000],
        [:exp, @exx],
      ]
      q[:layout]            = false     
      when 51 # Quest 51 - Coco and Gerard
      q[:name]              = "Because It's Rabbit Season"
      q[:level]             = 0
      q[:icon_index]        = 583
      q[:description]       = "Two Rabbit kids, Coco and Gerald, have disappeared! Search the Vineyards for clues on where they might be before they get hurt or Rabbit Princess's hair starts to gray! Hopefully they're just playing hide and seek..."
      q[:objectives][0]     = "Search the Rabbit Vineyards for signs of the petit rabbits"
      q[:objectives][1]     = "Investigate the warehouse and keep the kids out of trouble."
      q[:objectives][2]     = "You've become a Rabbit! Find a way to change back or face a life of hopping and ear petting!"
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0,1,2]
      q[:custom_categories] = []
      q[:banner]            = "ColonyQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Rabbit Princess"
      q[:location]          = "Rabbit Vineyards"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false          
      when 52 # Quest 52 - ADV Cuccos
      q[:name]              = "[Advanced] King of the Cuccs"
      q[:level]             = 11
      q[:icon_index]        = 866
      q[:description]       = "A swarm of dangerous predators known as King Cuccos have invaded the Tree Canopy. Head over there and do some population control before they ruin the territory completely!"
      q[:objectives][0]     = "Kill all the King Cuccos in the Forest."
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "EhuntQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = "The Tree Canopy"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:gold, 8500],
      ]
      q[:layout]            = false   
      when 53 # Quest 53 - Bunnygirl costumes
      q[:name]              = "My Dear Love"
      q[:level]             = 7
      q[:icon_index]        = 583
      q[:description]       = "The population and birth rates within the Kingdom have been on a recent decline. We at Knight's INC find this to be problematic. Enlist Rabbit Princess' nurse Dear and do some promoting to show some ladies the wonders of motherhood!"
      q[:objectives][0]     = "Speak to Dear. She's right next to you."
      q[:objectives][1]     = "Bring her a \\v[3663] Progeny. You know what to do."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "ProgTavQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = ""
      q[:common_event_id]   = 0
      @exx = 1000
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
      [:armor, 202, 0],
      [:gold, 1000],
      [:exp, @exx],
      ]   
      q[:layout]            = false       
      when 54 # Quest 54 - Komachi BFLY
      q[:name]              = "A Bug's Death"
      q[:level]             = 0
      q[:icon_index]        = 586
      q[:description]       = "Komachi is hungry but cannot move from her cave! Bring her Butterflies or she won't survive!"
      q[:objectives][0]     = "Gather 3 \\i[613] Butterflies around the Kingdom."
      q[:objectives][1]     = "Feed the butterflies to Komachi."
      #q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "KomaQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Komachi, the Weaver"
      q[:location]          = "Hidden Room - Rocky Slope"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      [:armor, 199, 0],
      ]   
      q[:layout]            = false   
      when 55 # Quest 55 - Drider Gone
      q[:name]              = "Along Came A Drider"
      q[:level]             = 0
      q[:icon_index]        = 584
      q[:description]       = "The Drider Princess has decided to peacefully move away and live the life of a hermit after her defeat. According to her last words, she's decided to settle somewhere in the Southern half of the Continent. Go see if she's doing okay and/or not causing any trouble. Most likely, she would have found somewhere dark and secluded to call her new home."
      q[:objectives][0]     = "Find and check up on Drider Princess."
      #q[:objectives][1]     = ""
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0]
      q[:custom_categories] = []
      q[:banner]            = "DriHQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Drider Princess"
      q[:location]          = "Southern Region"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]   
      q[:layout]            = false       
      when 56 # Quest 56 - Lost Bell
      q[:name]              = "For Whom the Bell Tolls"
      q[:level]             = 0
      q[:icon_index]        = 587
      q[:description]       = "Harvest Princess' precious treasure the \\i[574] Cardinal Bell has gone missing. The gentle Princess doesn't want to believe it's been stolen, but can't investigate herself and needs a brave and reliable person to search anyway. Find the bell's trail and bring it back no matter what."
      q[:objectives][0]     = "Search the last place the Bell was spotted for clues."      
      q[:objectives][1]     = "Follow the trail of flour inside the Princess' house."
      q[:objectives][2]     = "Find where the mysterious key goes."
      q[:objectives][3]     = "Report the culprit to Harvest Princess"
      q[:objectives][4]     = "Infiltrate the Old Granary and get to the bottom of this."    
      q[:prime_objectives]  = [0, 1, 2, 3, 4]
      q[:custom_categories] = []
      q[:banner]            = "HarCQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Harvest Princess"
      q[:location]          = "Harvest Reign"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]   
      q[:layout]            = false       
      when 57 # Quest 57 - Support Harvest Princess
      q[:name]              = "Featherbrain Frights"
      q[:level]             = 3
      q[:icon_index]        = 587
      q[:description]       = "The Fields' Scarecrows seemed to have lost their effect, leading to the fields getting overrun with crows. Head over and support the Farmers to show the Harvest Princess your support!"
      q[:objectives][0]     = "[Optional] Reach the Scarecrow Fields during daytime and talk with the Farmers for advice and directions."
      q[:objectives][1]     = "Chase the crows out of the fields."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [1, 2]
      q[:custom_categories] = []
      q[:banner]            = "HarQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = "Scarecrow Fields"
      q[:common_event_id]   = 0
      @exx = 450
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:item, 124, 1],   
        [:gold, 250],      
        [:exp, @exx],
      ]
      q[:layout]            = false  
      when 58 # Quest 58 - Eggs
      q[:name]              = "Where I Eggcel"
      q[:level]             = 7
      q[:icon_index]        = 300
      q[:description]       = "Our guild wishes to research the egg laying species of the Kingdom to see how they and their young differ from those of more conventional births. Please bring us one egg from any (sapient) species. PLEASE do not steal one or harm it."
      q[:objectives][0]     = "Bring Dear an unhatched egg."
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "DearEggQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = ""
      q[:common_event_id]   = 0
      @exx = 1500
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:armor, 195, 1],   
        [:gold, 500],      
        [:exp, @exx],
      ]
      q[:layout]            = false 
      when 59 # Quest 59 - Eggs II
      q[:name]              = "Tomorrow's Eggciting Youth"
      q[:level]             = 8
      q[:icon_index]        = 300
      q[:description]       = "Our guild is continuing the study of the egg laying members of our society. The next step is to examine an egg near birth. For now, bring another egg to Dear, except this time it should be one that is close to hatching."
      q[:objectives][0]     = "Bring Dear an egg close to the hatching point."
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "DearEggQ2bannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = ""
      q[:common_event_id]   = 0
      @exx = 2500
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:armor, 196, 1],   
        [:gold, 750],     
        [:exp, @exx],
      ]
      q[:layout]            = false   
      when 60 # Quest 60 - Sewers Key
      q[:name]              = "Down the drain!"
      q[:level]             = 5
      q[:icon_index]        = 589
      q[:description]       = "A Princess who wishes to remain anonymous has lost an item into the Kingdom's sewer system and requested someone investigate and find it. Frog Princess probably knows the quickest way into the sewer depths, so go request her aid as well."
      q[:objectives][0]     = "Find and speak to Frog Princess to gain access to the sewers."
      q[:objectives][1]     = "Search for the \\i[545] Fire Ivy Leaf within the sewer."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "SewFQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:item, 283, 1],   
        [:gold, 250],      
      ]
      q[:layout]            = false       
      when 61 # Quest 61 - Crack Repair
      q[:name]              = ""
      q[:level]             = 4
      q[:icon_index]        = 284
      q[:description]       = ""
      q[:objectives][0]     = ""
      q[:objectives][1]     = ""
      q[:objectives][2]     = ""
      q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2, 3]
      q[:custom_categories] = []
      q[:banner]            = "WyvCQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = ""
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:item, 254, 0],  
        [:armor, 241, 1],             
      ]
      q[:layout]            = false           
      when 62 # Quest 62 - Wyv Route
      q[:name]              = "On The Wings Of Revenge"
      q[:level]             = 0
      q[:icon_index]        = 632
      q[:description]       = "The Wyvern Princess has had her friends slaughtered and was almost mind controlled. Her only goal now is to find who did it, why, and then get revenge. You've decided to assist her, so follow the clues and hunt down the culprits down."
      q[:objectives][0]     = "Search for someone tech savvy that might know about the \\i[608] Cracked Beast Choker."
      q[:objectives][1]     = "Search the Northern Portside Cities for clues about the 'Minister'."
      q[:objectives][2]     = "Why does the Church of Conquest want Wyvern? Go and investigate."
      q[:objectives][3]     = "Your target is related to the Kingdom Above. Find a way to reach the skies and look for clues."
      q[:objectives][4]     = "Meet the informant at night in the back garden of the Queen's Castle."
      q[:objectives][5]     = "Wyvern Princess got taken by the enemy! Look for the door that gets opened by the \\i[714] Study Key, that's the only way to discover where Dusk headed to!"    
      q[:objectives][6]     = "Find where Dusk brought Wyvern Princess and free her!" 
      #q[:objectives][7]     = "" 
      q[:prime_objectives]  = [0, 1, 2, 3, 4, 5, 6]
      q[:custom_categories] = []
      q[:banner]            = "WyvQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Wyvern Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false        
      when 63 # Quest 63 - League of Explorers I
      q[:name]              = "The Explorers: Water You Waiting For?"
      q[:level]             = 0
      q[:icon_index]        = 284
      q[:description]       = "The League of Explorers has shared information on a Kingdom that rests under the great sea. Knights INC. wants you to obtain and test the equipment that will supposedly allow you to explore this new territory."
      q[:objectives][0]     = "Obtain a pair of \\i[737] Fish Lungs."
      q[:objectives][1]     = "Enter the Underwater Kingdom."
      q[:objectives][2]     = "Dry off and report your success at the Guild."
      q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = ""
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false         
      when 64 # Quest 64 - League of Explorers II
      q[:name]              = "The Explorers: Making A Big Stink"
      q[:level]             = 0
      q[:icon_index]        = 284
      q[:description]       = "The League of Explorers has shared information of a Kingdom clouded by toxic fogs and wildlife hidden deep in the south. Knights INC. wants you to obtain and test the equipment that will supposedly allow you to explore this new territory."
      q[:objectives][0]     = "Obtain the custom \\i[639] G4sM-ausk."
      q[:objectives][1]     = "Enter the Poisonous Kingdom."
      q[:objectives][2]     = "Decontaminate yourself and report your success at the Guild."
      q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = ""
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false         
      when 65 # Quest 65 - League of Explorers III
      q[:name]              = "The Explorers: Stretching Your Wings"
      q[:level]             = 0
      q[:icon_index]        = 284
      q[:description]       = "The League of Explorers has shared information of a Kingdom hidden right above ours, resting atop the clouds themselves. Knights INC. wants you to obtain and test the equipment that will supposedly allow you to explore this new territory."
      q[:objectives][0]     = "Obtain a set of \\i[620] Cucco Wings."
      q[:objectives][1]     = "Enter the Kingdom Above."
      q[:objectives][2]     = "Report to the Guild."
      q[:objectives][3]     = "Pluck the feathers off your suit and report your success at the Guild."
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = ""
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false        
      when 66 # Quest 66 - The Ironclad Gigolo - I
      q[:name]              = "The Ironclad Gigolo - I"
      q[:level]             = 5
      q[:icon_index]        = 630
      q[:description]       = "In order to promote Peace & Control in every corner of the Kingdom the 'Knights INC' will carry out its plan, and you knights have an important role in it!"
      q[:objectives][0]     = "Copulate with a \\v[3879] citizen! Royal lineage not allowed."
      q[:objectives][1]     = "Report to the Guild."
      q[:objectives][2]     = ""
      q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "GigoloQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = ""
      q[:common_event_id]   = 0
      @exx = 1200
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
       [:item, 287, 1], 
       [:gold, 450],
       [:exp, @exx],
      ]
      q[:layout]            = false        
      when 67 # Quest 67 - The Ironclad Gigolo - II
      q[:name]              = "The Ironclad Gigolo - II"
      q[:level]             = 7
      q[:icon_index]        = 630
      q[:description]       = "In order to promote Peace & Control in every corner of the Kingdom the 'Knights INC' will carry out its plan, and you knights have an important role in it! Only the rarest races this time."
      q[:objectives][0]     = "Copulate with a \\v[3879]! Royal lineage not allowed."
      q[:objectives][1]     = "Report to the Guild."
      q[:objectives][2]     = ""
      q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "GigoloQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC"
      q[:location]          = ""
      q[:common_event_id]   = 0
      @exx = 1500
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
       [:item, 288, 1], 
       [:gold, 950],
       [:exp, @exx],
      ]
      q[:layout]            = false 
      when 68 # Quest 68 - Queen Ass #1
      q[:name]              = "Keep Order!"
      q[:level]             = 4
      q[:icon_index]        = 590
      q[:description]       = "Dusk Princess wants you to increase your reputation with the Queen of the Kingdom. To begin with, step in pitched battles between two reigns. Subjects of the same Queen shouldn't fight each other!"
      q[:objectives][0]     = "Fight and win 3 pitched battles!"
      q[:objectives][1]     = "Report to the Guild."
      q[:objectives][2]     = ""
      q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "DQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Dragon Queen"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
       [:item, 244, 1], 
       [:gold, 750],
      ]
      q[:layout]            = false        
      when 69 # Quest 69 - Queen Ass #2
      q[:name]              = "Enforce Order!"
      q[:level]             = 6
      q[:icon_index]        = 590
      q[:description]       = "Dusk Princess wants you to increase your reputation with the Queen of the Kingdom. To continue, end a war between two reigns by dealing with either one of their Princesses. The weak should fear the dragon!"
      q[:objectives][0]     = "Intervene in a war between two Princesses by solving, in any way, a siege!"
      q[:objectives][1]     = "Report to the Guild."
      q[:objectives][2]     = ""
      q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "DQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Dragon Queen"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
       [:item, 244, 3], 
       [:gold, 2250],
      ]
      q[:layout]            = false  
      when 70 # Quest 70 - Queen Ass #3
      q[:name]              = "Export Order!"
      q[:level]             = 8
      q[:icon_index]        = 590
      q[:description]       = "Dusk Princess wants you to increase your reputation with the Queen of the Kingdom. To finish spreading the dragon's rule convince a warring Princess to step down from her throne or... deal with her"
      q[:objectives][0]     = "Intervene in a war between two Princesses by solving a siege, without recruting the sieged Princess!"
      q[:objectives][1]     = "Report to the Guild."
      q[:objectives][2]     = ""
      q[:objectives][3]     = ""
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "DQbannerT" 
      q[:banner_hue]        = 0
      q[:client]            = "Dragon Queen"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
       [:item, 244, 5], 
       [:gold, 3750],
      ]
      q[:layout]            = false 
      when 71 # Quest 71 - Ske Route
      q[:name]              = "I will (not) marry you!"
      q[:level]             = 0
      q[:icon_index]        = 567
      q[:description]       = "Skeleton Princess bluntly turned you down, saying she won't marry you. You've set your mind though, you WILL propose to her again in a way she cannot refuse!"
      q[:objectives][0]     = "In order to get closer to Skeleton Princess, recruit her in your team. By any means necessary"
      q[:objectives][1]     = "Complete: The battlefield of love!"
      q[:objectives][2]     = "Complete: An army of guests!"
      q[:objectives][3]     = "Complete: Till death do YOU part!"
      q[:objectives][4]     = "Get back to your Princess and fulfill your promise!"   
      #q[:objectives][5]     = ""      
      q[:prime_objectives]  = [0, 1, 2, 3, 4]
      q[:custom_categories] = []
      q[:banner]            = "SkeHQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Skeleton Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false   
      when 72 # Quest 72 - Gho Barrier
      q[:name]              = "Invincible Under the Moon"
      q[:level]             = 0
      q[:icon_index]        = 562
      q[:description]       = "Ghost Princess sleeps during daytime and her whole reign is protected by a barrier during night-time. In order to meet the Princess while she's awake you need to lift the barrier protecting her first!"
      q[:objectives][0]     = "Find the source of the barrier's power."
      q[:objectives][1]     = "Find the 4 ghosts that are keeping it up and deal with the barrier!"
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = ""      
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "GhoBQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Ghost Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false      
      when 73 # Quest 73 - Gho Route
      q[:name]              = "Spodomantic"
      q[:level]             = 0
      q[:icon_index]        = 562
      q[:description]       = "You have tasked yourself with discovering the secrets hidden within the Ghost Princess' \\i[640] Ashes. Unable to properly communicate with her, you'll need to figure out her directions and find some help!"
      q[:objectives][0]     = "In order to investigate further about the \\i[640] Ghost Ashes, recruit her in your team"
      q[:objectives][1]     = "Follow Ghost Princess's directions."
      q[:objectives][2]     = "Search for \\i[956] Mary-Annette in the Kingdom! She's probably hiding outside the Princesses' domains."
      q[:objectives][3]     = "Someone's found the Spodomancer before you did, but you may still be able to retrieve information inside her abandoned house. Head to the Slums in the Human Town."
      q[:objectives][4]     = "Obtain \\i[829] Catalyst Dagger, \\i[673] Prayer: Life Breath, \\i[656] Nya-Nya Doll, and the \\i[665] Death Not for the Ritual."
      q[:objectives][5]     = "With everything ready, it's time to go back to the place most strongly tied to the Curse. Go to Ghost's Manor."
      q[:objectives][6]     = "Perform the Curse Rebinding Ritual and exorcise the manifestation of Ghost's Curse."
      q[:prime_objectives]  = [0, 1, 2, 3, 4, 5, 6]
      q[:custom_categories] = []
      q[:banner]            = "GhoQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Ghost Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false    
      when 74 # Quest 74 - Sea Pass
      q[:name]              = "The Sea Pass"
      q[:level]             = 0
      q[:icon_index]        = 585
      q[:description]       = "In order to be allowed to reach the Sea Reign, you'll need to prove your friendliness to Hammerhead Princess! One of the cargoes supposed to arrive to the Port got lost. Retrieve it and deliver it to Hammerhead Princess."
      q[:objectives][0]     = "Find the \\i[920] Lost Shipment. It's supposed to be washed up on a northern shore."
      q[:objectives][1]     = "Deliver it to one of Hammerhead Princess' sharkmen."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "SeaHamQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Hammerhead Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      [:item, 294, 1],
      ]
      q[:layout]            = false       
      when 75 # Quest 75 - Look for a Church! 
      q[:name]              = "The battlefield of love!"
      q[:level]             = 0
      q[:icon_index]        = 567
      q[:description]       = "Skeleton Princess wants the perfect venue for the ceremony! She asked for majestic skeletal dragons being there, or she will (not) marry you!"
      q[:objectives][0]     = "Search for a suitable place for the ceremony."
      q[:objectives][1]     = "Secure the place."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = ""   
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "SkeHQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Skeleton Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false         
      when 76 # Quest 76 - Build her an army! Of guests!
      q[:name]              = "An army of guests!"
      q[:level]             = 0
      q[:icon_index]        = 567
      q[:description]       = "Skeleton Princess wants her people to be there when she will (not) marry you! Buy, kill, breed, conjure!"
      q[:objectives][0]     = "Obtain 20 skeletons."
      q[:objectives][1]     = "Dress them up for the occasion."
      q[:objectives][2]     = "[Optional] Obtain the \\i[667] Bone Magnet."
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0, 1]
      q[:custom_categories] = []
      q[:banner]            = "SkeHQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Skeleton Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false   
      when 77 # Quest 77 - Till death do YOU part!
      q[:name]              = "Till death do YOU part!"
      q[:level]             = 0
      q[:icon_index]        = 567
      q[:description]       = "Skeleton Princess wants you to be able to stay by her side forever, before she can consider (not) marrying you! Time to show how serious you are about it!"
      q[:objectives][0]     = "Equip the \\i[538] Undeath Rosary and go meet your own demise OR find a way to beat her at her own game!"
      #q[:objectives][1]     = ""
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0]
      q[:custom_categories] = []
      q[:banner]            = "SkeHQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Skeleton Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false       
      when 78 # Quest 78 - Ninja Heist
      q[:name]              = "The Heist!"
      q[:level]             = 0
      q[:icon_index]        = 701
      q[:description]       = "A poor catgirl gave you the code to enter the Mice's bank, the Rattesein's Caveau! Find your way in and get her what she asked for. Nya!"
      q[:objectives][0]     = "Reach the Caveau and use the combination she gave you."
      q[:objectives][1]     = "Get the \\i[535] Shadow Scarf."
      q[:objectives][2]     = "Wait for her to contact you again."
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0, 1, 2]
      q[:custom_categories] = []
      q[:banner]            = "NinQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "'Poor Catgirl'"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false    
       when 79 # Quest 79 - ADV POTUS
      q[:name]              = "[Advanced] P.O.T.U.S."
      q[:level]             = 11
      q[:icon_index]        = 866
      q[:description]       = "A pack of dangerous predators known as Hippopotus have invaded the Rumble Jungle. Head over there and do some population control before they ruin the territory completely!"
      q[:objectives][0]     = "Kill all the Hippopotus in the Rumble Jungle."
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "HipQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = "Rumble Jungle"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:gold, 8500],
      ]     
      q[:layout]            = false
       when 80 # Quest 80 - Assist Finhead
      q[:name]              = "Treading Water"
      q[:level]             = 3
      q[:icon_index]        = 702
      q[:description]       = "Finhead Princess is concerned the 'land-dwellers' may be polluting the water around the Kingdom. Provide her Water Surveyor some samples!"
      q[:objectives][0]     = "Use the \\i[750] Empty Water Flask to gather a sample of water from the \\v[275]"
      q[:objectives][1]     = "Deliver it to the Water Surveyor, outside the Diamond Seashell."
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0,1,2]
      q[:custom_categories] = []
      q[:banner]            = "FinQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = ""
      q[:common_event_id]   = 0
      @exx = 650
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [      
        [:item, 125, 1],    
        [:gold, 250],      
        [:exp, @exx],
      ] 
      q[:layout]            = false
       when 81 # Quest 81 - Cat Route
      q[:name]              = "Leader of the Pack"
      q[:level]             = 0
      q[:icon_index]        = 578
      q[:description]       = "Cat Princess' pride is wounded, help her track down The Beast that attacked while the two of you were having 'fun' in your tent."
      q[:objectives][0]     = "Complete: The pack needs claws."
      q[:objectives][1]     = "Complete: Track 'it' down."
      q[:objectives][2]     = "Preparations are complete, it's time to strike! Camp in the Kingdom Below and get your pride ready!"
      q[:objectives][3]     = "You were no match for her. The prideful Cat Princess wandered off."
      q[:objectives][4]     = "Cats can recognize their kin! Follow the tracks the Princess left behind her with the help of your cat companions!"      
      q[:objectives][5]     = "Something has happened to the Princess by the Moon Pond. Her tracks disappeared once you got there. There's no trail to follow anymore..."  
      q[:objectives][6]     = "Complete: Nature of the Beast"      
      q[:objectives][7]     = "You have both the Nekomata and the Bakeneko with you, but Cat Princess didn't return yet."  
      q[:objectives][8]     = "Fight Gat, Dragon Princess. The Beast." 
      q[:objectives][9]     = "Discover what happened to Cat Princess by the Moon Pond."
      q[:prime_objectives]  = [0,1,2,3,4,5,6,7,9]
      q[:custom_categories] = []
      q[:banner]            = "CatRBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Cat Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [     
      ] 
      q[:layout]            = false
       when 82 # Quest 82 - Cat Route
      q[:name]              = "The pack needs claws."
      q[:level]             = 0
      q[:icon_index]        = 578
      q[:description]       = "Cat Princess needs a pack of proficient hunters to fight The Beast. Get what she asks for before confronting it."
      q[:objectives][0]     = "Put together a pride formed by the Knight, Cat Princess and 2 other felines."
      q[:objectives][1]     = "Every party member needs to be of Level 5 or above."
      q[:objectives][2]     = "Every party member, except the Knight, needs to have at least 4 \\i[668] Power."
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""        
      q[:prime_objectives]  = [0,1,2]
      q[:custom_categories] = []
      q[:banner]            = "CatRBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Cat Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [     
      ]       
      q[:layout]            = false
       when 83 # Quest 83 - Cat Route
      q[:name]              = "Track 'it' down."
      q[:level]             = 0
      q[:icon_index]        = 578
      q[:description]       = "Use Cat Princess heightened senses to search for The Beast's lair. Have Cat Princess lead your team and search around the Kingdom for tracks."
      q[:objectives][0]     = "Reach the entrance of The Beast's lair."
      q[:objectives][1]     = "[Optional] Get your hands on \\i[682] Poison Resisting gear for your Pride!"
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""       
      q[:prime_objectives]  = [0]
      q[:custom_categories] = []
      q[:banner]            = "CatRBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Cat Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [     
      ]            
      q[:layout]            = false
      when 84 # Quest 84 - Ninja Revenge
      q[:name]              = "Paw-Mark of the Ninja"
      q[:level]             = 0
      q[:icon_index]        = 701
      q[:description]       = "That 'poor catgirl' you've helped in the Clocktown came to your Campsite and took back the \\i[535] Shadow Scarf, without paying her debt to the Rattesein. She has to be stopped before someone gets hurt."
      q[:objectives][0]     = "Find Ninja Princess, convince her to come with you to the Clocktown. Search in rundown locations first, places fit for a thief."
      q[:objectives][1]     = "She tricked you again! Don't hang your head in shame and try to catch her off-guard next time!"
      q[:objectives][2]     = "You've found her hideout! Make sure next time she won't get away..."
      q[:objectives][3]     = "Find another way to stop her."
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [3]
      q[:custom_categories] = []
      q[:banner]            = "Nin2QbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Ninja Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false         
      when 85 # Quest 85 - Trench Investigation
      q[:name]              = "Trench Investigation"
      q[:level]             = 0
      q[:icon_index]        = 702
      q[:description]       = "Something's going on under the surface of the Diamond Seashell. The Princess won't open up to someone that doesn't know anything about it, you have figure it out yourself. The Ambassador and the Princess mentioned a 'trench' and jewel extractions..."
      q[:objectives][0]     = "Investigate the areas surrounding the Diamond Seashell."
      q[:objectives][1]     = "Confront Finhead Princess with the information you've gathered."
      q[:objectives][2]     = "You can't leave the Diamond Seashell by the order of the Princess. Go talk her and clean your name!"
      q[:objectives][3]     = "Finhead Princess waits for you in the Chiseled Tunnel, accompany her to meet Dragon Princess IV. No guard will be assigned to protect the passage at night. Make sure you're back before morning comes!"
      q[:objectives][4]     = "An unusually large Spinel Hermit got Finhead Princess! Save her before it reaches its lair!"
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0,1,2,3,4]
      q[:custom_categories] = []
      q[:banner]            = "FinTreQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Finhead Princess"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false       
      when 86 # Quest 86 - Shogun and Daimyo
      q[:name]              = "[Advanced] Shogun and Daimyo"
      q[:level]             = 11
      q[:icon_index]        = 866
      q[:description]       = "The infamous duo is back, and they're a little too close to the Diamond Seashell! Dispose of the crustacean duo in the Chiseled Tunnel. Crunchy!"
      q[:objectives][0]     = "Kill the 2 Chiseled Crabs: Shogun and Daimyo!"
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "ShogQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = "Chiseled Tunnel"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:gold, 9500],
      ]     
      q[:layout]            = false          
      when 87 # Quest 87 - To Neverland
      q[:name]              = "To Neverland"
      q[:level]             = 9
      q[:icon_index]        = 590
      q[:description]       = "The new big thing in the Queen Spire is to obtain and raise a girl from the Kingdom as yours! If you want your kid to live as a privileged elite, bring one at the Sky Lift."
      q[:objectives][0]     = "Meet the Courtesan and deliver to Her Grace a female Progeny of yours."
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "DQEbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Rabbit Courtesan"
      q[:location]          = "Sky Lift"
      q[:common_event_id]   = 0
      @exx = 2000
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:armor, 338, 0],     
        [:gold, 3000],        
        [:exp, @exx],
      ]     
      q[:layout]            = false          
      when 88 # Quest 88 - 
      q[:name]              = ""
      q[:level]             = 10
      q[:icon_index]        = 866
      q[:description]       = ""
      q[:objectives][0]     = ""
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "DQEbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Slime Courtesan"
      q[:location]          = ""
      q[:common_event_id]   = 0
      @exx = 2500
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:armor, 327, 0],
        [:gold, 3000],        
        [:exp, @exx],      
      ]     
      q[:layout]            = false     
      when 89 # Quest 89 - Free Wendigo
      q[:name]              = "Free Wendigo"
      q[:level]             = 10
      q[:icon_index]        = 866
      q[:description]       = ""
      q[:objectives][0]     = ""
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "DQEbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Slime Courtesan"
      q[:location]          = ""
      q[:common_event_id]   = 0
      @exx = 2500
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:armor, 327, 0],
        [:gold, 3000],        
        [:exp, @exx],      
      ]     
      q[:layout]            = false        
      when 90 # Quest 90 - Chisel
      q[:name]              = "The Chisel"
      q[:level]             = 10
      q[:icon_index]        = 866
      q[:description]       = "A dangerous crustacean has been sighted in the tunnels around the Jewel Trench. Dive to its lair and defeat it!"
      q[:objectives][0]     = "Kill the Chiseled Crab in the tunnels."
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "ShogQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = "Chiseled Tunnel"
      q[:common_event_id]   = 0
      @exx = 5000
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:gold, 5000],      
        [:exp, @exx], 
      ]     
      q[:layout]            = false     
      when 91 # Quest 91 - Queen Cucca
      q[:name]              = "Killer Queens"
      q[:level]             = 10
      q[:icon_index]        = 866
      q[:description]       = "A dangerous avian has been sighted in the Party Poppers Nest. Fly there and defeat it!"
      q[:objectives][0]     = "Kill the Queen Cucca in the Kingdom Above."
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "PartyQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = "Party Poppers Nest"
      q[:common_event_id]   = 0
      @exx = 5000
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:gold, 5000],      
        [:exp, @exx],      
      ]     
      q[:layout]            = false      
      when 92 # Quest 92 - Nature of the Beast
      q[:name]              = "Nature of the Beast"
      q[:level]             = 0
      q[:icon_index]        = 578
      q[:description]       = "From the Campsite, send your pride around the Kingdom looking for clues! Someone got to know about the Princess!"
      q[:objectives][0]     = "There's rumors a catgirl will be put on sale in a Goblin auction soon... could it be her?"
      q[:objectives][1]     = "Somebody reported to the Guild there's a ferocious cat wrecking havoc and death... could it be her?"
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "CatR2bannerT"
      q[:banner_hue]        = 0
      q[:client]            = ""
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]     
      q[:layout]            = false      
      when 93 # Quest 93 - Bakeneko
      q[:name]              = "Feral and Savage"
      q[:level]             = 10
      q[:icon_index]        = 866
      q[:description]       = "An unusual monster has been sighted in the Chapel! It's dangerous, go deal with it before someone gets hurt!"
      q[:objectives][0]     = "Slay the monster attacking the Chapel!"
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "CatR3bannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = "Chapel"
      q[:common_event_id]   = 0
      @exx = 6000
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:gold, 7500],      
        [:exp, @exx],      
      ]     
      q[:layout]            = false         
      when 94 # Quest 94 - Flow
      q[:name]              = "Go with the Flow"
      q[:level]             = 0
      q[:icon_index]        = 754
      q[:description]       = "In her hidden laboratory, a clocktown mouse named Rin needs your help! Reach the location and obtain the code she needs!"
      q[:objectives][0]     = "Reach \\v[6305] and use the \\i[753] Flow-RDR!"
      q[:objectives][1]     = "Bring that code back to Rin."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "Talk to her!"      
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "RinbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Rin"
      q[:location]          = "?"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]     
      q[:layout]            = false  
       when 95 # Quest 95 - Assist Mermaid
      q[:name]              = "De Profundis"
      q[:level]             = 3
      q[:icon_index]        = 703
      q[:description]       = "Finally, the mermaids have decided they'll ask for the Guild's help! Could this be the beginning of the cooperation between the elusive merfolk and the rest of the Kingdom? Something's troubling them in their depths, go offer their Princess the Guild's assistance!"
      q[:objectives][0]     = "Meet the Raid Leader at the entrance of the Abyssal Seat. She will explain you what's troubling the mermaids."
      q[:objectives][1]     = "The \\v[6221] are building weapons against the mermaids! Head to the Mermaid Grotto and raid them! Destroy their device!"
      q[:objectives][2]     = "Report to the Guild."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0,1,2]
      q[:custom_categories] = []
      q[:banner]            = "RaidQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = "Mermaid Bottom"
      q[:common_event_id]   = 0
      @exx = 750
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [      
        [:item, 126, 1],    
        [:gold, 350],      
        [:exp, @exx],
      ]    
      q[:layout]            = false  
       when 96 # Quest 96 - Slime Route
      q[:name]              = "The Times They Are A-Bubblin'"
      q[:level]             = 0
      q[:icon_index]        = 560
      q[:description]       = "A path for slimes to regain their status in the Kingdom has opened! Slime Princess needs YOU to help all the other royals see how Great the slimy menace can get!"
      q[:objectives][0]     = "Dusk Princess told you something is happening into the Slime Pool, the pond from which newborn slimes spawn. Go there accompanied by Slime Princess and try triggering its activation again!"
      q[:objectives][1]     = "The worst has happened! Slime and Dusk Princess both fell into the bubbling pool and the Slime Titan has risen from its depths! Get to safety!"
      q[:objectives][2]     = "The whole Kingdom will soon be enveloped into a slimy, bubbling, death. Find a way to stop it and keep it far from castles!"
      q[:objectives][3]     = "You've halted the Titan! It reached the Frozen Islands to the North and its body got viscous enough for you to enter it 'safely'."
      q[:objectives][4]     = "Reach the Core."
      q[:objectives][5]     = "Free the Princess' Core from its Dusk-y corruption!"
      q[:prime_objectives]  = [0,1,2,3,4,5]
      q[:custom_categories] = []
      q[:banner]            = "SlimeRbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Slime Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [   
      ]       
      q[:layout]            = false        
      when 97 # Quest 97 - Queen Infantry
      q[:name]              = "Queen Troopers"
      q[:level]             = 10
      q[:icon_index]        = 590
      q[:description]       = "Use the \\i[763] Hero Banner to gather promising recruits for the Dragon Queen's army. They will be trained into elite warriors and fight against the Kingdom's enemies!"
      q[:objectives][0]     = "Meet the Courtesan at the Sky Lift and deliver to Her Grace a Progeny you've recruited with at least 5 \\i[668] Power."
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = ""      
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "DQEbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Cat Courtesan"
      q[:location]          = "Sky Lift"
      q[:common_event_id]   = 0
      @exx = 4500
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [       
        [:exp, @exx],      
      ]     
      q[:layout]            = false  
      when 98 # Quest 98 - Deep Investigation
      q[:name]              = "Deep Investigation"
      q[:level]             = 0
      q[:icon_index]        = 703
      q[:description]       = "Legend has it that mermaids were driven out from their old home centuries ago, after the war, exiled to the depths of the Kingdom. Is the Princess' enmity towards the Dragon Queen and the rest of her Kingdom baseless? An old 'fishhead' told her about that legend, but went lost in the Deep Merk since."
      q[:objectives][0]     = "Look around the Mermaid's Reign for any trace left by the 'old fishhead'"
      q[:objectives][1]     = "You've found a \\i[776] Strange Barnacle inside the Spika's Nest! Report your discovery to Mermaid Princess."
      q[:objectives][2]     = "The mysterious sage, Old Barnacle, has been eaten by a nasty Spika. The Princess believes that it's a sign from the Abyss. You have to hunt it down!"
      q[:objectives][3]     = "The barnacled finhead you've freed from the monster's belly told you that the secret of the mermaids' past is kept hidden somewhere way, way deeper than the Deep Merk. To reach out for the truth yourself the Princess is a key piece."
      q[:objectives][4]     = "The \\i[773] Selkie Harp seems to be able to transform anyone into a mermaid, every trace of one's past self lost forever. What is the meaning of this? Go meet Old Barnacle again."
      q[:objectives][5]     = "The truth about the mermaids' past has been revealed."
      q[:prime_objectives]  = [0,1,2,3,4,5]
      q[:custom_categories] = []
      q[:banner]            = "MerRbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Mermaid Princess"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false  
      when 99 # Quest 99 - Deep Blues in the Sea
      q[:name]              = "Deep Blues in the Sea"
      q[:level]             = 0
      q[:icon_index]        = 703
      q[:description]       = "The monster of the Abyss has taken a mermaid, and you saw another mermaid chase after it into the Dark Abyss south of the reign. The Princess has no mermaids to spare in a rescue attempt, but you aren't a mermaid, are you? Brave the depths, if you believe it's right."
      q[:objectives][0]     = "Enter the Deep Merk and find the two Mermaids."
      q[:objectives][1]     = "Bring the Mermaids home. Alive and in one piece, preferably."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "" 
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "DeepQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Lost Mermaids"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
        [:item, 126, 1],        
      ]
      q[:layout]            = false      
      when 100 # Quest 100 - SpikaQ
      q[:name]              = "Lurker in the Abyss"
      q[:level]             = 10
      q[:icon_index]        = 866
      q[:description]       = "Dangerous squid-like monsters, Spika, have been attacking ships all around the seas. Hidden in the dark depths of the Deep Merk, the Guild has to strike before they go even farther from their territory."
      q[:objectives][0]     = "Kill a Spika in the Deep Merk."
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "" 
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "DeepQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC."
      q[:location]          = "Deep Merk"
      q[:common_event_id]   = 0
      @exx = 5000
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
        [:gold, 5000],      
        [:exp, @exx],         
      ]
      q[:layout]            = false       
      when 101 # Quest 101 - Of Curses
      q[:name]              = "Of Curses"
      q[:level]             = 0
      q[:icon_index]        = 562
      q[:description]       = ""
      q[:objectives][0]     = "Find"
      q[:objectives][1]     = "Find"
      q[:objectives][2]     = "Find"
      q[:objectives][3]     = "Find"
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "" 
      q[:prime_objectives]  = [0,1,2,3]
      q[:custom_categories] = []
      q[:banner]            = "GhoQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Mary-Annette"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false        
      when 102 # Quest 102 - AntiPrunaQ
      q[:name]              = "Pruning Pruna"
      q[:level]             = 7
      q[:icon_index]        = 955
      q[:description]       = "Someone's gathering intel on the Princesses of the Kingdom. The Knight's INC. can't condone such shady acts, you're asked to get rid of the little spies."
      q[:objectives][0]     = "Find a Rose Buddies troop spying on a Princess and deal with it swiftly!"
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "" 
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "PrunaQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knights INC."
      q[:location]          = ""
      q[:common_event_id]   = 0
      @exx = 1350
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [
       [:gold, 750],
       [:exp, @exx],
      ]
      q[:layout]            = false   
      when 103 # Quest 103 - PrunaQ
      q[:name]              = "Game of Thorns"
      q[:level]             = 0
      q[:icon_index]        = 955
      q[:description]       = "Spread the seed! Pruna wants you to plant one of her \\i[830] Buds somewhere in the Kingdom! Do so to earn her trust!"
      q[:objectives][0]     = "Plant the bud of a Rose Buddy inside any Reign's castle."
      q[:objectives][1]     = "Report to Pruna and earn your reward!"
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "" 
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "BudQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Pruna, Queen of Spines"
      q[:location]          = ""
      q[:common_event_id]   = 0
      q[:rewards]           = [
       [:armor, 479,1],
      ]
      q[:layout]            = false        
      when 104 # Quest 104 - Migraine Pills
      q[:name]              = "One Bird With Two Pills"
      q[:level]             = 0
      q[:icon_index]        = 974
      q[:description]       = ""
      q[:objectives][0]     = "[Optional] Find the Dragon Carriage the Princess had prepared for you and ride to the Queen's Castle!"
      q[:objectives][1]     = "Get Bird Princess' \\i[983] Migraine Medication by the castle's gates."
      q[:objectives][2]     = "Deliver the medicine to Bird Princess."
      #q[:objectives][3]     = ""
      #q[:objectives][4]     = ""
      #q[:objectives][5]     = "" 
      q[:prime_objectives]  = [1,2]
      q[:custom_categories] = []
      q[:banner]            = "BirMQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Bird Princess"
      q[:location]          = "Kingdom Above"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]
      q[:layout]            = false         
       when 105 # Quest 105 - Assist Bird
      q[:name]              = "STAMP the Competition"
      q[:level]             = 3
      q[:icon_index]        = 974
      q[:description]       = "A Princess has bitten more than she can chew. To help the birds, which do not chew, head to the Launchpad of their Reign and sit in front of the Kingdom's map to enact the the law of the Queen."
      q[:objectives][0]     = "Use a \\i[985] Bird Stamp to reprimand a Reign at war with at least 2 other Reigns."
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "BirQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = "Talon Launchpad"
      q[:common_event_id]   = 0
      @exx = 750
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [      
        [:item, 127, 1],    
        [:item, 388, 0],    
        [:exp, @exx],
      ]    
      q[:layout]            = false       
       when 106 # Quest 106 - Save Birb
      q[:name]              = "One Cage for Another"
      q[:level]             = 0
      q[:icon_index]        = 974
      q[:description]       = "An arrogant courtesan has abducted one of Bird Princess's subjects and sentenced them to Gazer Prison! The Queen herself has given you the key to their freedom. You just have to not get caught..."
      q[:objectives][0]     = "Free the Bird Prisoner in Gazer Prison. Do not get caught."
      q[:objectives][1]     = "Escape the Prison."
      q[:objectives][2]     = "Report back to Bird Princess."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0,1,2]
      q[:custom_categories] = []
      q[:banner]            = "PrisQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Bird Princess"
      q[:location]          = ""
      q[:common_event_id]   = 0      
      q[:rewards]           = [   
      ]    
      q[:layout]            = false        
       when 107 # Quest 107 - Moss Quest
      q[:name]              = "Can You Feel My Heart Clumping"
      q[:level]             = 0
      q[:icon_index]        = 1037
      q[:description]       = "Your antisocial, damp, squishy little Moss friend has expressed her impatience over finding a new home after joining you. It may be best to get around to finally do so if she truly is having problems following you around. She’s already mentioned what she’s looking for in a home. Surely you must already know a place like that..."
      q[:objectives][0]     = "Find somewhere Secluded, Underground, and where a lot of water goes through."
      #q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0]
      q[:custom_categories] = []
      q[:banner]            = "MossQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Moss Princess"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [     
      ]    
      q[:layout]            = false         
       when 108 # Quest 108 - OniArenaQ
      q[:name]              = "Chump or Champ"
      q[:level]             = 0
      q[:icon_index]        = 1104
      q[:description]       = "You've befriended the Oni Princess, but to truly enter her inner circle she's laid it out cleanly. To prove yourself you'll need to be the Champion of Champions and conquer the Colosseum completely! Maybe then, you can conquer her...!!"
      q[:objectives][0]     = "Challenge the Oni around the Oni Crater in Sumo Battles as part of your Champion Training and win 3 Sumo Battles."
      q[:objectives][1]     = "Win against each of the 5 Colosseum Champions at least once."
      q[:objectives][2]     = "Brag to Oni Princess about your Championship."
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0,1,2]
      q[:custom_categories] = []
      q[:banner]            = "OniQBannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Oni Princess"
      q[:location]          = "Oni Colosseum"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      [:item, 404, 1],
      ]    
      q[:layout]            = false    
       when 109 # Quest 109 - MothRoute
      q[:name]              = "The Melancholy and Disappearance of Moth"
      q[:level]             = 0
      q[:icon_index]        = 577
      q[:description]       = "After many countless nights of the Moth Princess behaving strangely around you and your health deteriorating, you have a heart to heart with her and seem to have come to an understanding. However, while adventuring, the Princess has vanished without a trace! You feel a dangerous sense of foreboding, and rush to find her..."
      q[:objectives][0]     = "Search for the Princess. Think of where the Moth Princess might go..."
      q[:objectives][1]     = "A strange air has filled the Moth's Forest. This can't be a coincidence. Investigate the Moth Reign."
      q[:objectives][2]     = "The Princess has been sealed within her special Tree, with 4 strange nightmares being the key to her room. Find and slay them all!"
      q[:objectives][3]     = "You feel as if this strange nightmare is beginning to unravel... it's time to return to the Princess and wake her up."
      q[:prime_objectives]  = [0,1,2,3]
      q[:custom_categories] = []
      q[:banner]            = "MotQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Moth Princess"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]    
      q[:layout]            = false    
       when 110 # Quest 110 - PlantThrone
      q[:name]              = "Refinding your Roots" 
      q[:level]             = 0
      q[:icon_index]        = 1293
      q[:description]       = "Strife fills the jungles of the Plant Reign as infighting grows each day. The Princess refuses to step in as the different types of Plantfolk are separating from each other and forming factions! You've heard tales of a cavern opening up in the ruins nearby. Maybe there will be a clue on how to stop all this!"
      q[:objectives][0]     = "Ask around the Plant Reign for more information on the situation and where to find the suspicious cave."
      q[:objectives][1]     = "Investigate the Downroot Dungeon."
      q[:objectives][2]     = "The way has been blocked, it's impossible for you to go through. Maybe you can finally convince the Princess that there's a problem to solve...!"
      q[:objectives][3]     = "With the Princess' help, reach the bottom of the Downroot Dungeon!"
      q[:prime_objectives]  = [0,1,2,3]
      q[:custom_categories] = []
      q[:banner]            = "PlaQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Plant Princess"
      q[:location]          = "Plant Ruins"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]    
      q[:layout]            = false         
       when 111 # Quest 111 - Nightmares
      q[:name]              = "The Restless Kingdom" 
      q[:level]             = 0
      q[:icon_index]        = 577
      q[:description]       = "Are you having another bad dream, Princess? It's okay. Someone's there to protect you from the monsters in the dark. Once you wake up, you'll forget you were even scared at all."
      q[:objectives][0]     = "Defeat the Stalker in the Crowded City."
      q[:objectives][1]     = "Defeat the Lure clipping the Wings of the Kingdom."
      q[:objectives][2]     = "Defeat the Terror burning the Sea."
      q[:objectives][3]     = "Defeat the Hunter waiting for the hero in the Forest."
      q[:prime_objectives]  = [0,1,2,3]
      q[:custom_categories] = []
      q[:banner]            = "MotQ2bannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Moth Princess"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]    
      q[:layout]            = false   
       when 112 # Quest 112 - Assist Plant
      q[:name]              = "House of Butterflies"
      q[:level]             = 3
      q[:icon_index]        = 1293
      q[:description]       = "Little bugs and critters are vital to help plants thrive! There's never enough of them in the Plant Ruins, and its people love to be surrounded by them. You're asked to bring more!"
      q[:objectives][0]     = "Talk to the Butterfly Fan near the entrance of the Reign and deliver her 3 (healthy) \\i[613] Butterflies!"
      q[:objectives][1]     = "Report to the Guild."
      #q[:objectives][2]     = ""
      #q[:objectives][3]     = ""
      q[:prime_objectives]  = [0,1]
      q[:custom_categories] = []
      q[:banner]            = "PlaQbannerT2"
      q[:banner_hue]        = 0
      q[:client]            = "Knight's INC"
      q[:location]          = "Plant Ruins"
      q[:common_event_id]   = 0
      @exx = 550
      if $game_variables[628] == 20
        @exx *= 1.5
      elsif $game_variables[628] == 120
        @exx *= 2
      elsif $game_variables[628] == 1020
        @exx *= 2
      end
      q[:rewards]           = [      
        [:item, 164, 1],    
        [:exp, @exx],
      ]    
      q[:layout]            = false    
       when 113 # Quest 113 - MouRoute
      q[:name]              = "Twelve on the Dot" 
      q[:level]             = 0
      q[:icon_index]        = 582
      q[:description]       = "After an incident, the youngest of the Hourly Sisters of Clocktown was declared missing. After encouraging the Mouse Princess to not give up on finding her, you've gotten the idea to begin your own investigation! Time to fix this broken clock..."
      q[:objectives][0]     = "Return to Clocktown with Mouse Princess in your party and ask her sisters for help in finding any clues or leads."
      q[:objectives][1]     = "The Hourly Sisters might need some help jogging it, though. Complete all of their favors to help them remember what happened that day."
      q[:objectives][2]     = "Gather all of the Hourly Sisters together so you can finally click everything into place."
      q[:objectives][3]     = "A missing gear has finally clicked into place! A reclusive Mouse called Rin was a known good friend of the 12th sister! Find her and see if she knows anything!"
      q[:objectives][4]     = "A strange machine and another realm called The Flow... Use Rin's machine, find that mouse, and make the clock finally strike twelve again!"
      q[:prime_objectives]  = [0,1,2,3,4]
      q[:custom_categories] = []
      q[:banner]            = "MouRbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Mouse Sisters"
      q[:location]          = "???"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]    
      q[:layout]            = false        
       when 114 # Quest 114 - SisHelp
      q[:name]              = "Assist the Hourly Sisters" 
      q[:level]             = 0
      q[:icon_index]        = 582
      q[:description]       = "The Hourly Sisters need your help recalling what happened the day the 12th disappeared! Meet all of them individually and help them out."
      q[:objectives][0]     = "Assist Socket."
      q[:objectives][1]     = "Assist Chime."
      q[:objectives][2]     = "Assist Christine."
      q[:objectives][3]     = "Assist Sata."
      q[:objectives][4]     = "Assist Pin."
      q[:objectives][5]     = "Assist Reela."
      q[:objectives][6]     = "Assist Miss Borne."
      q[:objectives][7]     = "Assist Loretta."
      q[:objectives][8]     = "Assist Helah."
      q[:objectives][9]     = "Assist Lola."
      q[:prime_objectives]  = [0,1,2,3,4,5,6,7,8,9]
      q[:custom_categories] = []
      q[:banner]            = "MouR2bannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Hourly Sisters"
      q[:location]          = "Clocktown"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]    
      q[:layout]            = false      
       when 115 # Quest 115 - Shadow Q
      q[:name]              = "Kept in the Dark" 
      q[:level]             = 0
      q[:icon_index]        = 1471
      q[:description]       = "Your visit to the Shadow Reign has gone completely wrong. Trapped in time, you discover the entire Reign is under some kind of curse or spell. With the Princess' hint towards the way out and potential answers, you'll have to uncover some big secrets to free the Shadows of their plight..."
      q[:objectives][0]     = "Find a way to activate the \\i[1423] Glass Turtle and leave the Shadow Reign"
      q[:objectives][1]     = "It appears you've traveled back in time to before you ever entered the Shadow Reign... Someone in the Black Landing surely must know more about all this!"
      q[:objectives][2]     = "You've encountered Dragon Princess V, but she doesn't seem keen on sharing more information than she's allowed to. It's clear now that the Church is deeply involved in all this. Perhaps there might be more information in their headquarters..."
      q[:objectives][3]     = "You've obtained the \\i[1475] Shadow Record. Does this hold the key to uncovering the Shadow Reign's secrets? Bring your findings to the Shadow Princess."
      q[:prime_objectives]  = [0,1,2,3]
      q[:custom_categories] = []
      q[:banner]            = "ShaQbannerT"
      q[:banner_hue]        = 0
      q[:client]            = "Shadow Princess"
      q[:location]          = "Shadow Reign"
      q[:common_event_id]   = 0
      q[:rewards]           = [
      ]    
      q[:layout]            = false        
    #||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    #  END Editable Region B
    #//////////////////////////////////////////////////////////////////////
    end
    q
  end
end

#==============================================================================
# *** DataManager
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    aliased method - self.extract_save_contents
#==============================================================================

class << DataManager
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Extract Save Contents
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias maqj_extractsavecons_2kw5 extract_save_contents
  def extract_save_contents(*args, &block)
    maqj_extractsavecons_2kw5(*args, &block) # Call Original Method
    if $game_party.quests.nil?
      $game_party.init_maqj_data
      $game_system.init_maqj_data
    end
  end
end

#==============================================================================
# ** MAQJ_SortedArray
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This module mixes in to an array to maintain the sorted order when inserting
#==============================================================================

module MAQJ_SortedArray
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Insert to Array
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def maqj_insert_sort(el, &block)
    index = bsearch_index(el, 0, size, &block)
    index ? insert(index, el) : push(el)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Retrieve Index from Binary Search
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def bsearch_index(el, b = 0, e = size, &block)
    return bsearch_index(el, b, e) { |a,b| a <=> b } if block.nil?
    return b if b == e # Return the discovered insertion index
    return if b > e
    m = (b + e) / 2    # Get Middle
    block.call(el, self[m]) > 0 ? b = m + 1 : e = m 
    bsearch_index(el, b, e, &block) 
  end
end

#==============================================================================
# ** Game_Quest
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This class holds all instance data for a quest
#==============================================================================

class Game_Quest
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  attr_reader   :id                  # Unique identifier for this quest
  attr_reader   :name                # The name to be shown for the quest
  attr_reader   :level               # The level of difficulty of the quest
  attr_reader   :objectives          # An array of objective strings
  attr_reader   :prime_objectives    # An array of crucial objective IDs
  attr_reader   :revealed_objectives # An array of revealed objective IDs
  attr_reader   :complete_objectives # An array of completed objective IDs
  attr_reader   :failed_objectives   # An array of failed objective IDs
  attr_reader   :custom_categories   # An array of category symbols
  attr_accessor :icon_index          # Icon associated with this quest
  attr_accessor :common_event_id     # ID of common event to call upon complete
  attr_accessor :description         # The description for the quest
  attr_accessor :banner              # Picture shown to represent the quest
  attr_accessor :banner_hue          # The hue of the banner
  attr_accessor :layout              # The layout of this quest in scene
  attr_accessor :rewards             # An array of rewards to show
  attr_accessor :reward_given        # Boolean tracking if quest was rewarded
  attr_accessor :concealed           # Whether or not the quest is visible
  attr_accessor :manual_status       # Quest status if not using prime objectives
  QuestData::BASIC_DATA_TYPES.each { |data_type| attr_accessor(data_type) }
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize(quest_id)
    @id = quest_id
    @concealed = default_value_for(:concealed)
    @reward_given = default_value_for(:reward_given)
    reset
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reset
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reset
    data = QuestData.setup_quest(@id)
    data_symbol_array.each { |meth| instance_variable_set(:"@#{meth}", 
      data[meth] ? data[meth] : default_value_for(meth)) }
    @revealed_objectives = [].send(:extend, MAQJ_SortedArray)
    @complete_objectives = [].send(:extend, MAQJ_SortedArray)
    @failed_objectives =   [].send(:extend, MAQJ_SortedArray)
    @manual_status = default_value_for(:manual_status)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Data Symbol Array
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def data_symbol_array
    [:name, :level, :objectives, :prime_objectives, :custom_categories, 
      :icon_index, :description, :banner, :banner_hue, :common_event_id, 
      :layout, :rewards] + QuestData::BASIC_DATA_TYPES
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Default Value
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def default_value_for(method)
    case method
    when :name then "??????"
    when :description, :banner then ""
    when :level, :banner_hue, :icon_index, :common_event_id then 0
    when :objectives, :rewards, :custom_categories then []
    when :prime_objectives then Array.new(objectives.size) { |x| x }
    when :concealed then QuestData::MANUAL_REVEAL
    when :manual_status then :active
    when :layout, :reward_given then false
    else ""
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reveal/Conceal Objective
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reveal_objective(*obj)
    valid_obj = obj.select {|x| x < objectives.size && !@revealed_objectives.include?(x) }
    valid_obj.each {|i| @revealed_objectives.maqj_insert_sort(i) }
    quest_status_changed unless valid_obj.empty?
  end
  def conceal_objective(*obj)
    quest_status_changed unless (obj & @revealed_objectives).empty?
    obj.each { |obj_id| @revealed_objectives.delete(obj_id) }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Complete/Uncomplete Objective
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def complete_objective(*obj)
    valid_obj = obj.select {|x| x < objectives.size && !@complete_objectives.include?(x) }
    reveal_objective(*valid_obj)
    unfail_objective(*valid_obj)
    was_complete = status?(:complete)
    valid_obj.each {|i| @complete_objectives.maqj_insert_sort(i) }
    quest_status_changed unless valid_obj.empty?
    # If just completed
    if status?(:complete) && !was_complete
      $game_temp.reserve_common_event(common_event_id)
      $game_party.quests.add_to_sort_array(:complete, @id)
    end
  end
  def uncomplete_objective(*obj)
    quest_status_changed unless (obj & @complete_objectives).empty?
    obj.each { |obj_id| @complete_objectives.delete(obj_id) }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Fail/Unfail Objective
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def fail_objective(*obj)
    valid_obj = obj.select {|x| x < objectives.size && !@failed_objectives.include?(x) }
    reveal_objective(*valid_obj)
    uncomplete_objective(*valid_obj)
    was_failed = status?(:failed)
    valid_obj.each {|i| @failed_objectives.maqj_insert_sort(i) }
    quest_status_changed unless valid_obj.empty?
    $game_party.quests.add_to_sort_array(:failed, @id) if status?(:failed) && !was_failed
  end
  def unfail_objective(*obj)
    quest_status_changed unless (obj & @failed_objectives).empty?
    obj.each { |obj_id| @failed_objectives.delete(obj_id) }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Updates when the quest status has been changed
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def quest_status_changed
    $game_party.quests.add_to_sort_array(:change, @id) 
    $game_system.last_quest_id = @id if QuestData::OPEN_TO_LAST_CHANGED_QUEST
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Objective Status?
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def objective_status?(status_check, *obj)
    return false if obj.empty?
    case status_check
    when :failed   then !(obj & @failed_objectives).empty?
    when :complete then obj.size == (obj & @complete_objectives).size
    when :revealed then obj.size == (obj & @revealed_objectives).size
    when :active then objective_status?(:revealed, *obj) && 
      !objective_status?(:complete, *obj) && !objective_status?(:failed, *obj)
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Status?
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def status?(status_check)
    case status_check
    when :failed  
      @prime_objectives.empty? ? @manual_status == :failed : 
        !(@failed_objectives & @prime_objectives).empty?
    when :complete
      @prime_objectives.empty? ? @manual_status == :complete : !status?(:failed) && 
        ((@prime_objectives & @complete_objectives) == @prime_objectives)
    when :active then !concealed && !status?(:complete) && !status?(:failed)
    when :reward then @reward_given
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Name
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def name=(new_name)
    @name = new_name
    $game_party.quests.add_to_sort_array(:alphabet, @id) if $game_party && 
      $game_party.quests
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Level
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def level=(new_lvl)
    @level = new_lvl
    $game_party.quests.add_to_sort_array(:level, @id) if $game_party && 
      $game_party.quests
  end
end

#==============================================================================
# ** Game_Quests 
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This is a wrapper for an array holding Game_Quest objects
#==============================================================================

class Game_Quests
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize
    @data = {}
    @sort_arrays = {
      reveal: [], change: [], complete: [], failed: [],
      id:       [].send(:extend, MAQJ_SortedArray),
      alphabet: [].send(:extend, MAQJ_SortedArray),
      level:    [].send(:extend, MAQJ_SortedArray)
    }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Get Quest
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def [](quest_id)
    reset_quest(quest_id) if !@data[quest_id]
    @data[quest_id]
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Quest <- Not sure when this would ever be useful.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def []=(quest_id, value)
    @data[quest_id] = value
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * List
  #    list_type : the type of list to return
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def list(list_type = :all, sort_type = $game_system.quest_sort_type[list_type])
    sort_type_s = sort_type.to_s
    reverse = !(sort_type_s.sub!(/_r$/, "")).nil?
    sort_type = sort_type_s.to_sym
    list = @sort_arrays[sort_type].select { |quest_id| include?(quest_id, list_type) }
    list.reverse! if reverse
    list.collect { |quest_id| @data[quest_id] }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Include?
  #    determines whether to include a particular quest depending on list type
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def include?(quest_id, list_type = :all)
    return false if !revealed?(quest_id)
    case list_type
    when :all then true
    when :complete, :failed, :active then @data[quest_id].status?(list_type)
    else
      @data[quest_id].custom_categories.include?(list_type)
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Revealed? 
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def revealed?(quest_id)
    (!@data[quest_id].nil? && !@data[quest_id].concealed)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Setup Quest
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def setup_quest(quest_id)
    return if @data[quest_id]
    @data[quest_id] = Game_Quest.new(quest_id)
    # Open to this quest next time the QJ is opened
    $game_system.last_quest_id = quest_id if QuestData::OPEN_TO_LAST_REVEALED_QUEST
    # Save sorting order in separate arrays to avoid re-sorting every time
    @sort_arrays.keys.each { |sym| add_to_sort_array(sym, quest_id) }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Delete Quest
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def delete_quest(quest_id)
    @data.delete(quest_id)
    @sort_arrays.values.each { |ary| ary.delete(quest_id) }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reset Quest
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reset_quest(quest_id)
    delete_quest(quest_id)
    setup_quest(quest_id)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Add to Sorted Array
  #    sort_type : array to alter
  #    quest_id  : ID of the quest to add.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def add_to_sort_array(sort_type, quest_id)
    @sort_arrays[sort_type].delete(quest_id) # Make sure always unique
    case sort_type
    when :reveal, :change, :complete, :failed
      @sort_arrays[sort_type].unshift(quest_id)
    when :id
      @sort_arrays[sort_type].maqj_insert_sort(quest_id)
    when :alphabet 
      @sort_arrays[sort_type].maqj_insert_sort(quest_id) { |a, b| @data[a].name.downcase <=> @data[b].name.downcase }
    when :level
      @sort_arrays[sort_type].maqj_insert_sort(quest_id) { |a, b| @data[a].level <=> self[b].level }
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Find Location
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def find_location(quest_id, cat = nil)
    if revealed?(quest_id)
      categories = $game_system.quest_categories.dup
      # If cat specified, check in that category first.
      if cat && categories.include?(cat)
        categories.delete(cat)
        categories.unshift(cat)
      end
      for category in categories # Check all categories
        index = list(category).index(@data[quest_id])
        return category, index if index != nil
      end
    end
    return nil, nil
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Clear
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def clear
    @data.clear
  end
end

#==============================================================================
# ** Game System
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    new attr_accessor - quest_menu_access; quest_map_access; quest_sort_type;
#      quest_bg_picture; quest_bg_opacity; quest_windowskin; 
#      quest_window_opacity; quest_access_disabled; last_quest_cat; 
#      last_quest_id
#    aliased methods - initialize
#    new methods - init_maqj_data
#==============================================================================

class Game_System
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  attr_reader   :quest_menu_access     # Whether the scene is called from menu
  attr_accessor :quest_map_access      # Whether the scene is called from map
  attr_accessor :quest_sort_type       # The sort types for each category
  attr_accessor :quest_bg_picture      # The filename of the background picture
  attr_accessor :quest_bg_opacity      # The opacity of the background picture
  attr_accessor :quest_bg_blend_type   # The blend type of the background pic
  attr_accessor :quest_windowskin      # The windowskin used for the scene
  attr_accessor :quest_window_tone     # The tone of windows in the scene
  attr_accessor :quest_window_opacity  # The opacity of windows in the scene
  attr_accessor :quest_access_disabled # Whether access to Quests is disabled
  attr_accessor :quest_categories      # The categories to show in the scene
  attr_accessor :quest_scene_label     # The label to show in the scene
  attr_accessor :last_quest_cat        # The category to open to
  attr_accessor :last_quest_id         # The ID to open to
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias maqj_initialze_2cy9 initialize
  def initialize(*args, &block)
    maqj_initialze_2cy9(*args, &block)
    init_maqj_data
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Initialize Quest Data
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def init_maqj_data
    # Initialize new variables
    self.quest_menu_access = QuestData::MENU_ACCESS
    @quest_map_access = QuestData::MAP_ACCESS
    @quest_sort_type = QuestData::SORT_TYPE
    @quest_bg_picture = QuestData::BG_PICTURE
    @quest_bg_opacity = QuestData::BG_OPACITY
    @quest_bg_blend_type = QuestData::BG_BLEND_TYPE
    @quest_windowskin = QuestData::WINDOWSKIN
    @quest_window_tone = QuestData::WINDOW_TONE
    @quest_window_opacity = QuestData::WINDOW_OPACITY
    @quest_access_disabled = false
    @quest_categories = QuestData::CATEGORIES
    @quest_scene_label = QuestData::VOCAB[:scene_label]
    @last_quest_cat = @quest_categories[0]
    @last_quest_id = 0
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Quest Menu Access
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def quest_menu_access=(boolean)
    @quest_menu_access = boolean
    maic_inserted_menu_commands.delete(:quest_journal)
    maic_inserted_menu_commands.push(:quest_journal) if @quest_menu_access 
    maic_inserted_menu_commands.sort!
  end
end

#==============================================================================
# ** Game_Party
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    new attr_reader - quests
#    aliased method - initialize
#    new method - init_maqj_data
#==============================================================================

class Game_Party
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  attr_reader :quests
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias maqj_intiaze_2si9 initialize
  def initialize(*args, &block)
    maqj_intiaze_2si9(*args, &block) # Call Original Method
    init_maqj_data
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Initialize Quests
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def init_maqj_data
    @quests = Game_Quests.new # Initialize @quests
  end
end

#==============================================================================
# ** Game_Interpreter
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    new methods - change_quest_access; change_quest_background;
#      change_quest_windows; setup_quest; delete_quest; reset_quest; quest; 
#      reveal_quest; conceal_quest; manually_complete_quest;
#      manually_fail_quest; reveal_objective; conceal_objective; 
#      complete_objective; uncomplete_objective; fail_objective; 
#      unfail_objective; quest_revealed?; quest_complete?; quest_active?; 
#      quest_failed?; objective_complete?; objective_active?; 
#      objective_failed?; distribute_quest_rewards; distribute_quest_reward;
#      call_quest_journal
#==============================================================================

class Game_Interpreter
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Change Quest Access
  #    sym : symbol representing what aspect of access is being changed
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def change_quest_access(sym)
    case sym
    when :enable then $game_system.quest_access_disabled = false
    when :disable then $game_system.quest_access_disabled = true
    when :enable_menu then $game_system.quest_menu_access = true 
    when :disable_menu then $game_system.quest_menu_access = false 
    when :enable_map then $game_system.quest_map_access = true 
    when :disable_map then $game_system.quest_map_access = false 
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Change Quest Background
  #    picture : picture to show in the scene's background
  #    opacity : opacity of the picture shown in the scene's background
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def change_quest_background(picture, opacity = $game_system.quest_bg_opacity,
      blend_type = $game_system.quest_bg_blend_type)
    $game_system.quest_bg_picture = picture
    $game_system.quest_bg_opacity = opacity
    $game_system.quest_bg_blend_type = blend_type
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Change Quest Windows
  #    skin    : windowskin name to use in the scene
  #    tone    : tone for the windowskin
  #    opacity : opacity of windows in the scene
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def change_quest_windows(skin, tone = $game_system.quest_window_tone, 
      opacity = $game_system.quest_window_opacity)
    $game_system.quest_windowskin = skin
    $game_system.quest_window_tone = tone
    $game_system.quest_window_opacity = opacity
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Setup/Delete/Reset Quest
  #    quest_id : ID of the quest to be setup or deleted or reset
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  [:setup_quest, :delete_quest, :reset_quest].each { |method|
    define_method(method) do |quest_id| 
      $game_party.quests.send(method, quest_id)
    end
  }
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Retrieve Quest
  #    quest_id : ID of the quest to retrieve
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def quest(quest_id);         $game_party.quests[quest_id];      end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reveal/Conceal Quest 
  #    quest_id : ID of the quest to be revealed or concealed
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reveal_quest(quest_id);  quest(quest_id).concealed = false; end
  def conceal_quest(quest_id); quest(quest_id).concealed = true;  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Manually Complete/Fail Quest 
  #    quest_id : ID of the quest to be revealed or concealed
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def manually_complete_quest(quest_id)
    quest(quest_id).prime_objectives.clear
    quest(quest_id).manual_status = :complete
  end
  def manually_fail_quest(quest_id)
    quest(quest_id).prime_objectives.clear
    quest(quest_id).manual_status = :failed
  end
  def manually_activate_quest(quest_id)
    quest(quest_id).manual_status = :active
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reveal/Complete/Fail/Conceal/Uncomplete/Unfail Objective
  #    quest_id : ID of the quest whose objectives will be modified
  #    *obj     : IDs of objectives to reveal or complete or fail (or opposite)
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  [:reveal_objective, :complete_objective, :fail_objective, :conceal_objective,
  :uncomplete_objective, :unfail_objective].each { |method|
    define_method(method) do |quest_id, *obj| 
      quest(quest_id).send(method, *obj)
    end
  }
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Quest Revealed?
  #    quest_id : ID of the quest you are checking is revealed
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def quest_revealed?(quest_id)
    $game_party.quests.revealed?(quest_id)
  end
  [:complete, :failed, :active].each { |method|
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # * Quest Complete/Failed/Active?
    #    quest_id : ID of the quest whose completion status is being checked
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    define_method(:"quest_#{method}?") do |quest_id| 
      quest_revealed?(quest_id) && quest(quest_id).status?(method) 
    end
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # * Objective Complete/Failed/Active?
    #    quest_id : ID of the quest whose objectives are being checked
    #    *obj     : IDs of objectives to check completion status
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    define_method(:"objective_#{method}?") do |quest_id, *obj| 
      quest_revealed?(quest_id) && quest(quest_id).objective_status?(method, *obj) 
    end
  }
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Objective Revealed?
  #    quest_id : ID of the quest you are checking is revealed
  #    *obj     : IDs of objectives to check completion status
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def objective_revealed?(quest_id, *obj)
    quest_revealed?(quest_id) && quest(quest_id).objective_status?(:revealed, *obj) 
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Quest Rewarded?
  #    quest_id : ID of the quest you are checking is revealed
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def quest_rewarded?(quest_id)
    quest_revealed?(quest_id) && quest(quest_id).status?(:reward)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Change Reward Status
  #    quest_id : ID of the quest you are checking is revealed
  #    value    : true or false
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def change_reward_status(quest_id, value = true)
    quest(quest_id).reward_given = value
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Distribute Rewards
  #    quest_id : ID of the quest whose rewards are to be distributed
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def distribute_quest_rewards(quest_id)
    if quest_revealed?(quest_id) && !quest_rewarded?(quest_id)
      params = @params.dup
      change_reward_status(quest_id, true)
      quest(quest_id).rewards.each { |reward| distribute_quest_reward(reward) }
      @params = params
      true
    else
      false
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Distribute Reward
  #    reward : an array identifying the reward
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def distribute_quest_reward(reward)
    @params = [reward[1], 0, 0, (reward[2] ? reward[2] : 1)]
    case reward[0]
    when :item, 0 then   command_126 # Item
    when :weapon, 1 then command_127 # Weapon
    when :armor, 2 then  command_128 # Armor
    when :gold, 3   # Gold
      @params = [0, 0, reward[1] ? reward[1] : 0]
      command_125
    when :exp, 4    # Exp
      @params = [0, 0, 0, 0, reward[1] ? reward[1] : 0, true]
      command_315
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Call Quest Journal
  #    quest_id : ID of the quest to open the journal to
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def call_quest_journal(quest_id = nil)
    change_quest_background("QuestBG.png")
    change_quest_windows("QTry.png")
    return if $game_party.in_battle
    $game_system.last_quest_id = quest_id if quest_id
    SceneManager.call(Scene_Quest)
    Fiber.yield
  end
end

unless $imported[:"MA_ParagraphFormat_1.0"]
#==============================================================================
# ** MA_Window_ParagraphFormat
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This module inserts into Window_Base and provides a method to format the
# strings so as to go to the next line if it exceeds a set limit. This is 
# designed to work with draw_text_ex, and a string formatted by this method 
# should go through that, not draw_text.
#==============================================================================

module MA_Window_ParagraphFormat
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Calc Line Width
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def mapf_calc_line_width(line, tw = 0, contents_dummy = false)
    return tw if line.nil?
    line = line.clone
    unless contents_dummy
      real_contents = contents # Preserve Real Contents
      # Create a dummy contents
      self.contents = Bitmap.new(contents_width, 24)
      reset_font_settings
    end
    pos = {x: 0, y: 0, new_x: 0, height: calc_line_height(line)}
    while line[/^(.*?)\e(.*)/]
      tw += text_size($1).width
      line = $2
      # Remove all ancillaries to the code, like parameters
      code = obtain_escape_code(line)
      # If direct setting of x, reset tw.
      tw = 0 if ($imported[:ATS_SpecialMessageCodes] && code.upcase == 'X') ||
        ($imported["YEA-MessageSystem"] && code.upcase == 'PX')
      #  If I need to do something special on the basis that it is testing, 
      # alias process_escape_character and differentiate using @atsf_testing
      process_escape_character(code, line, pos)
    end
    #  Add width of remaining text, as well as the value of pos[:x] under the 
    # assumption that any additions to it are because the special code is 
    # replaced by something which requires space (like icons)
    tw += text_size(line).width + pos[:x]
    unless contents_dummy
      contents.dispose # Dispose dummy contents
      self.contents = real_contents # Restore real contents
    end
    return tw
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Format Paragraph
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def mapf_format_paragraph(text, max_width = contents_width)
    text = text.clone
    #  Create a Dummy Contents - I wanted to boost compatibility by using the 
    # default process method for escape codes. It may have the opposite effect, 
    # for some :( 
    real_contents = contents # Preserve Real Contents
    self.contents = Bitmap.new(contents_width, 24)
    reset_font_settings
    paragraph = ""
    while !text.empty?
      text.lstrip!
      oline, nline, tw = mapf_format_by_line(text.clone, max_width)
      # Replace old line with the new one
      text.sub!(/#{Regexp.escape(oline)}/m, nline)
      paragraph += text.slice!(/.*?(\n|$)/)
    end
    contents.dispose # Dispose dummy contents
    self.contents = real_contents # Restore real contents
    return paragraph
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Format By Line
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def mapf_format_by_line(text, max_width = contents_width)
    oline, nline, tw = "", "", 0
    loop do
      #  Format each word until reach the width limit
      oline, nline, tw, done = mapf_format_by_word(text, nline, tw, max_width)
      return oline, nline, tw if done
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Format By Word
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def mapf_format_by_word(text, line, tw, max_width)
    return line, line, tw, true if text.nil? || text.empty?
    # Extract next word
    if text.sub!(/([ \t\r\f]*)(\S*)([\n\f]?)/, "") != nil
      prespace, word, line_end = $1, $2, $3
      ntw = mapf_calc_line_width(word, tw, true)
      pw = contents.text_size(prespace).width
      if (pw + ntw >= max_width)
        # Insert
        if line.empty?
          # If one word takes entire line
          return prespace + word, word + "\n", ntw, true 
        else
          return line + prespace + word, line + "\n" + word, tw, true
        end
      else
        line += prespace + word
        tw = pw + ntw
        # If the line is force ended, then end 
        return line, line, tw, true if !line_end.empty?
      end
    else
      return line, line, tw, true
    end
    return line, line, tw, false
  end
end

class Window_Base
  include MA_Window_ParagraphFormat
end

$imported[:"MA_ParagraphFormat_1.0"] = true
end

#==============================================================================
# *** MAQJ Window_QuestBase
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This module mixes in with all quest windows
#==============================================================================

module MAQJ_Window_QuestBase
  attr_reader :maqj_objective_color
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize(*args, &block)
    super(*args, &block)
    reset_font_settings
    set_data_font(:normal)
    @maqj_default_font = contents.font.dup
    # Change the windowskin, tone if they are set to be changed
    self.windowskin = Cache.system($game_system.quest_windowskin) if $game_system.quest_windowskin
    self.opacity = $game_system.quest_window_opacity if $game_system.quest_window_opacity
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reset Font Settings
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reset_font_settings(*args, &block)
    super(*args, &block)
    set_data_font(@maqj_font_data_type) if @maqj_font_data_type
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Data Font
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def set_data_font(data_type)
    @maqj_default_font = contents.font.dup unless @maqj_default_font
    contents.font.name = QuestData::FONTNAMES[data_type] ? 
      QuestData::FONTNAMES[data_type] : @maqj_default_font.name
    contents.font.size = QuestData::FONTSIZES[data_type] ? 
      QuestData::FONTSIZES[data_type] : @maqj_default_font.size
    contents.font.bold = QuestData::FONTBOLDS.keys.include?(data_type) ? 
      QuestData::FONTBOLDS[data_type] : @maqj_default_font.bold
    contents.font.italic = QuestData::FONTITALICS.keys.include?(data_type) ?
      QuestData::FONTITALICS[data_type] : @maqj_default_font.italic
    case data_type
    when :objectives then change_color(@maqj_objective_color) if @maqj_objective_color
    when :name then change_color(quest_name_colour(@quest)) if @quest
    else
      change_color(text_color(QuestData::COLOURS[data_type])) if QuestData::COLOURS.keys.include?(data_type)
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Horizontal Line
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_horizontal_line(y, h = 2)
    contents.fill_rect(0, y, contents_width, h, text_color(QuestData::COLOURS[:line]))
    contents.fill_rect(0, y + h, contents_width, [h / 2, 1].max, text_color(QuestData::COLOURS[:line_shadow]))
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * MA Text Color
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def text_color(param)
    begin 
      colour = case param
      when Integer then super(param) rescue normal_color
      when Symbol then send(param) rescue normal_color
      when Array then Color.new(*param) rescue normal_color
      else
        normal_color
      end
    end
    colour.is_a?(Color) ? colour : normal_color
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Quest Name Colour
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def quest_name_colour(quest = @quest)
    return if !quest
    quest = $game_party.quests[quest] if quest.is_a?(Integer)
    s = [:failed, :complete, :active].find { |status| quest.status?(status) }
    text_color(QuestData::COLOURS[s])
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Quest Objective Colour
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def quest_objective_colour(quest, obj_id)
    return if !quest
    quest = $game_party.quests[quest] if quest.is_a?(Integer)
    s = [:failed, :complete, :active].find { |status| quest.objective_status?(status, obj_id) }
    text_color(QuestData::COLOURS[s])
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update Tone
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update_tone
    $game_system.quest_window_tone ? 
      self.tone.set(*$game_system.quest_window_tone) : super
  end
end

unless $imported[:"MA_IconHorzCommand_1.0"]
#==============================================================================
# ** Window_MA_IconHorzCommand
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window is a base window to show a horizontal command window populated
# with icons.
#==============================================================================

class Window_MA_IconHorzCommand < Window_HorzCommand
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Public Instance Variable
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  attr_reader   :observing_procs
  attr_accessor :cursor_hide
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize(*args, &block)
    @observing_procs = {}
    super(*args, &block)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Column Max
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def col_max; [(width - standard_padding) / (24 + spacing), item_max].min; end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Item
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def item
    @list[index] ? @list[index][:symbol] : nil
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Enabled? / Current Item Enabled?
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def enable?(index); self.index == index; end
  def current_item_enabled?; !current_data.nil?; end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Item
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_item(index)
    rect = item_rect(index)
    contents.clear_rect(rect)
    draw_icon(@list[index][:ext], rect.x + ((rect.width - 24) / 2), rect.y, enable?(index))
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Index
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def index=(index)
    old_index = self.index
    super(index)
    draw_item(old_index)
    draw_item(self.index)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Frame Update
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update
    super
    @observing_procs.values.each { |block| block.call(item) }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Add/Remove Observing Window
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def add_observing_proc(id, &block)
    @observing_procs[id] = block
    update
  end
  def remove_observing_proc(id)     ; @observing_procs.delete(id) ; end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update Cursor
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update_cursor
    super
    cursor_rect.empty if @cursor_hide
  end
end
$imported[:"MA_IconHorzCommand_1.0"] = true
end

#==============================================================================
# ** Window_QuestCategory
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window allows the player to switch between quest categories.
#==============================================================================

class Window_QuestCategory < Window_MA_IconHorzCommand
  include MAQJ_Window_QuestBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize(x, y, categories = $game_system.quest_categories)
    @cursor_hide = QuestData::HIDE_CATEGORY_CURSOR
    @categories = categories
    super(x, y)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Window Width
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def window_width; QuestData::LIST_WINDOW_WIDTH; end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Category=
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def category=(category)
    self.index = @categories.index(category) if @categories.include?(category)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Make Command List
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def make_command_list
    @categories.each { |cat| 
      add_command("", cat, false, QuestData::ICONS[cat]) }
  end
end

#==============================================================================
# ** Window QuestLabel
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window simply shows a label for the Quests scene
#==============================================================================

class Window_QuestLabel < Window_Base
  include MAQJ_Window_QuestBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize(x, y, label = "")
    super(x, y, window_width, window_height)
    refresh(label)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reset Font Settings
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reset_font_settings; set_data_font(:scene_label); end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Window Attributes
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def window_width
    w = ($game_system.quest_categories.size > 1 || QuestData::SHOW_CATEGORY_LABEL) ? 
      Graphics.width - QuestData::LIST_WINDOW_WIDTH : QuestData::LIST_WINDOW_WIDTH
  end
  def window_height; line_height + (standard_padding*2); end
  def line_height(*args)
    line_h = super(*args)
    QuestData::FONTSIZES[:scene_label] ? 
      [QuestData::FONTSIZES[:scene_label], line_h].max : line_h
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Refresh
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def refresh(label = @label)
    @label = label.is_a?(String) ? convert_escape_characters(label) : ""
    contents.clear
    reset_font_settings
    tw = mapf_calc_line_width(@label)
    draw_text_ex((contents_width - tw) / 2, 0, @label)
  end
end

#==============================================================================
# ** Window QuestLabel
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window simply shows a label for category currently selected
#==============================================================================

class Window_QuestCategoryLabel < Window_QuestLabel
  include MAQJ_Window_QuestBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Reset Font Settings
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def reset_font_settings; set_data_font(:category_label); end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Window Attributes
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def window_width; QuestData::LIST_WINDOW_WIDTH; end
  def line_height(*args)
    line_h = super(*args)
    QuestData::FONTSIZES[:category_label] ? 
      [QuestData::FONTSIZES[:category_label], line_h].max : line_h
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Category
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def category=(category)
    return if @category == category
    @category = category
    refresh(QuestData::CATEGORY_VOCAB[category])
  end
end

#==============================================================================
# ** Window_QuestCategoryDummy
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window shows up behind the category and category label window 
#==============================================================================

class Window_QuestCategoryDummy < Window_Base
  include MAQJ_Window_QuestBase
end

#==============================================================================
# ** Window_QuestList
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window shows all quests in a selected category.
#==============================================================================

class Window_QuestList < Window_Selectable
  include MAQJ_Window_QuestBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize(x, y, width, height)
    super
    @data = []
    self.index = 0
    activate
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Category
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def category=(category)
    return if @category == category
    @category = category
    refresh
    self.index = 0
    update_help if @help_window
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Get Quest
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def item; @data && index >= 0 ? @data[index] : nil; end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Column/Item Max
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def col_max; 1; end
  def item_max; @data ? @data.size : 1; end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Whether it should be drawn enabled
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def enable?(item); true; end
  def current_item_enabled?
    (@help_window && @help_window.maqj_visible_height < @help_window.contents_height)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Make Item List
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def make_item_list
    @data = @category ? $game_party.quests.list(@category) : []
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Item
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_item(index)
    quest = @data[index]
    if quest
      rect = item_rect_for_text(index)
      if QuestData::SHOW_QUEST_ICONS
        draw_icon(quest.icon_index, rect.x, rect.y, enable?(quest))
        rect.x += 24
        rect.width -= 24
      end
      change_color(quest_name_colour(quest), enable?(quest))
      draw_text(rect, quest.name)
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Refresh
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def refresh
    make_item_list
    create_contents
    set_data_font(:list)
    draw_all_items
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update Help
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update_help
    @help_window.quest = item
  end
end

#==============================================================================
# ** Window_QuestData 
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This window shows all quest data
#==============================================================================

class Window_QuestData < Window_Selectable
  include MAQJ_Window_QuestBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Object Initialization
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def initialize(x, y, w, h, layout = QuestData::DATA_LAYOUT)
    @dest_scroll_oy = 0
    super(x, y, w, h)
    @dest_scroll_oy = self.oy
    self.layout = layout
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Contents Height
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias maqj_visible_height contents_height
  def contents_height
    @q_contents_height ? [@q_contents_height, maqj_visible_height].max : maqj_visible_height
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Calculate Contents Height
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def calc_contents_height
    @q_contents_height = 0
    @layout.each { |dt| @q_contents_height += data_height(dt) } if @quest
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Data?
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_data?(data_type)
    case data_type
    when :line then true
    when :level then @quest.level > 0 
    when :objectives then !@quest.revealed_objectives.empty?
    when Array then (data_type - [:line]).any? { |dt| draw_data?(dt) }
    else !@quest.send(data_type).empty? # :description, :name, etc...
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Get Data Height
  #    This method calculates the height required for a specified element of
  #   the current quest. This is to calculate the needed space in contents,
  #   as well as advance the @draw_y variable.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def data_height(data_type)
    return 0 unless draw_data?(data_type)
    return line_height if QuestData::BASIC_DATA_TYPES.include?(data_type)
    @maqj_font_data_type = data_type
    reset_font_settings
    return case data_type
    when :line, :level, :name then line_height
    when :banner
      bmp = Cache.picture(@quest.banner)
      hght = bmp.rect.height
      bmp.dispose
      hght
    when :description
      buff = description_x*2
      paragraph = mapf_format_paragraph(@quest.description, contents_width - buff)
      line_num = paragraph.scan(/\n/).size + 1
      line_num += (QuestData::DESCRIPTION_IN_BOX ? 2 : 
        !QuestData::VOCAB[:description].empty? ? 1 : 0)
      line_num*line_height
    when :objectives
      objectives = @quest.revealed_objectives.collect { |obj_id| 
        @quest.objectives[obj_id] } 
      line_num = QuestData::VOCAB[:objectives].empty? ? 0 : 1
      buff = (objective_x*2) + text_size(QuestData::VOCAB[:objective_bullet]).width
      objectives.each { |obj|
        paragraph = mapf_format_paragraph(obj, contents_width - buff)
        line_num += paragraph.scan(/\n/).size + 1 }
        line_num += 1
      line_num*line_height
    when :rewards
      line_num = QuestData::VOCAB[:rewards].empty? ? 0 : 1
      (line_num + @quest.rewards.size)*line_height
    when Array then data_height(data_type.max_by { |dt| data_height(dt) })
    else 0
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Quest
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def quest=(value)
    return if @quest == value
    @quest = value
    @layout = (@quest && @quest.layout) ? @quest.layout : @default_layout
    refresh
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Layout
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def layout=(value)
    return if @default_layout == value && @layout == value
    @default_layout = value
    @layout = value
    refresh
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Refresh
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def refresh
    contents.clear
    calc_contents_height
    create_contents
    return unless @quest && @layout
    self.oy = 0
    @dest_scroll_oy = 0
    #  The basic idea here is that each draw_ method will rely on and advance 
    # the @draw_y variable. Where they are an array, the elements will be 
    # drawn at the same @draw_y.
    @draw_y = 0
    @layout.each {|dt|
      next unless draw_data?(dt)
      dt.is_a?(Array) ? draw_data_array(dt) : draw_data(dt) 
    }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Data
  #    data_type : the data block to draw next
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_data(data_type)
    @maqj_font_data_type = data_type
    reset_font_settings
    send(:"draw_#{data_type}") if self.class.method_defined?(:"draw_#{data_type}")
    @draw_y += data_height(data_type)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Data Array
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_data_array(layout_array)
    y, max_y = @draw_y, @draw_y
    # Draw each data aspect at the same starting @draw_y
    layout_array.each { |dt|
      @draw_y = y
      draw_data(dt)
      max_y = @draw_y if @draw_y > max_y
    }
    @draw_y = max_y
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Line
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_line; draw_horizontal_line(@draw_y + (line_height / 2) - 1, 2); end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Name
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_name
    set_data_font(:name)
    clear_and_draw_text(0, @draw_y, contents_width, line_height, @quest.name, 1)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Level
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_level
    case QuestData::LEVEL_ICON
    when Array then QuestData::LEVEL_ICON.empty? ? draw_level_text : draw_level_array
    when 0 then draw_level_text
    else
      draw_level_stacked
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Stacked Level
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_level_stacked(icon_index = QuestData::LEVEL_ICON)
    align = QuestData::HEADING_ALIGN[:level]
    es = QuestData::LEVEL_ICONS_SPACE*(@quest.level - 1)
    x = align == 2 ? contents_width - 24 : align == 1 ? 
      (contents_width - 24 - (es)) / 2 : es
    @quest.level.times do
      draw_icon(icon_index, x, @draw_y)
      x -= QuestData::LEVEL_ICONS_SPACE
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Array Level
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_level_array(icon_index = QuestData::LEVEL_ICON)
    return if icon_index.empty?
    icon_index = icon_index[@quest.level - 1] ? icon_index[@quest.level - 1] : icon_index[-1]
    align = QuestData::HEADING_ALIGN[:level]
    x = align == 2 ? contents_width - 24 : align == 1 ? (contents_width-24)/2 : 0
    draw_icon(icon_index, x, @draw_y)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Text Level
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_level_text
    reset_font_settings
    level = QuestData::LEVEL_SIGNALS && QuestData::LEVEL_SIGNALS[@quest.level - 1] ? 
      QuestData::LEVEL_SIGNALS[@quest.level - 1] : @quest.level.to_s
    align = QuestData::HEADING_ALIGN[:level]
    tw = text_size(QuestData::VOCAB[:level]).width + 4
    tw2 = text_size(level).width + 2
    space = contents_width - tw - tw2
    x = align == 2 ? space : align == 1 ? space / 2 : 0
    clear_and_draw_text(x, @draw_y, tw, line_height, QuestData::VOCAB[:level])
    set_data_font(:level_signal)
    clear_and_draw_text(x + tw, @draw_y, tw2, line_height, level, 2)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Banner
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_banner
    bmp = Cache.picture(@quest.banner) # Get Picture
    # Shift the hue if requested
    bmp.hue_change(@quest.banner_hue) unless @quest.banner_hue == 0
    x = (contents_width - bmp.rect.width) / 2
    if x < 0 # Stretch horizontally if the banner is too wide
      dest_rect = bmp.rect.dup
      dest_rect.width = contents_width
      contents.stretch_blt(dest_rect, bmp, bmp.rect)
    else
      contents.blt(x, @draw_y, bmp, bmp.rect)
    end
    bmp.dispose
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Description
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_description
    buff = description_x*2
    paragraph = mapf_format_paragraph(@quest.description, contents_width - buff)
    y = @draw_y
    # Draw Rect
    draw_box(paragraph.scan(/\n/).size + 1) if QuestData::DESCRIPTION_IN_BOX
    # Draw Description Label
    draw_heading(:description, y) unless QuestData::VOCAB[:description].empty?
    # Draw Description
    y += line_height if !QuestData::VOCAB[:description].empty? || QuestData::DESCRIPTION_IN_BOX
    draw_text_ex(description_x, y, paragraph)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Objectives
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_objectives
    y = @draw_y
    unless QuestData::VOCAB[:objectives].empty?
      draw_heading(:objectives, y)
      y += line_height
    end
    @quest.revealed_objectives.each { |obj_id| y = draw_objective(obj_id, y) }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Objective
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_objective(obj_id, y)
    bullet = QuestData::VOCAB[:objective_bullet]
    bullet_tw = text_size(bullet).width + 2
    buff = (objective_x*2) + bullet_tw
    paragraph = mapf_format_paragraph(@quest.objectives[obj_id], contents_width - buff)
    line_num = 1 + paragraph.scan(/\n/).size
    # Since draw_text_ex resets the font, set colour here
    @maqj_objective_color = quest_objective_colour(@quest, obj_id)
    change_color(text_color(QuestData::COLOURS[:objective_bullet]))
    draw_text(objective_x, y, bullet_tw, line_height, sprintf(bullet, obj_id + 1))
    draw_text_ex(objective_x + bullet_tw, y, paragraph)
    @maqj_objective_color = false
    y += (line_num*line_height)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Rewards
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_rewards
    y = @draw_y
    unless QuestData::VOCAB[:rewards].empty?
      draw_heading(:rewards, y)
      y += line_height
    end
    for i in 0...@quest.rewards.size do draw_reward(i, y + i*line_height) end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Reward
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_reward(r_id, y)
    reward = @quest.rewards[r_id]
    case reward[0]
    when :item, 0   # Item
      draw_item_reward(y, $data_items[reward[1]], reward[2] ? reward[2] : 1)
    when :weapon, 1 # Weapon
      draw_item_reward(y, $data_weapons[reward[1]], reward[2] ? reward[2] : 1)
    when :armor, 2  # Armor
      draw_item_reward(y, $data_armors[reward[1]], reward[2] ? reward[2] : 1)
    when :gold, 3   # Gold
      draw_basic_data(y, QuestData::ICONS[:reward_gold], 
        QuestData::VOCAB[:reward_gold], (reward[1] ? reward[1] : 0).to_s)
    when :exp, 4    # Exp
      draw_basic_data(y, QuestData::ICONS[:reward_exp], 
        QuestData::VOCAB[:reward_exp], (reward[1] ? reward[1] : 0).to_s)
    when :string, 5 # String
      draw_basic_data(y, reward[1] ? reward[1] : 0, reward[3] ? reward[3].to_s : "", 
        reward[2] ? reward[2].to_s : "")
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Item Reward
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_item_reward(y, item, amount = 1)
    w = contents_width
    w = QuestData::BASIC_DATA_WIDTH if QuestData::BASIC_DATA_WIDTH.between?(1, w)
    x = (contents_width - w) / 2
    draw_item_name(item, x, y, true, w - 40)
    if amount > 1
      change_color(text_color(QuestData::COLOURS[:reward_amount]))
      draw_text(x + w - 40, y, 40, line_height, sprintf(QuestData::VOCAB[:reward_amount], amount), 2)
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Basic Data Methods
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  QuestData::BASIC_DATA_TYPES.each { |data_type|
    define_method(:"draw_#{data_type}") {
      draw_basic_data(@draw_y, QuestData::ICONS[data_type], 
        QuestData::VOCAB[data_type], @quest.send(data_type))
    }
  }
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Basic Data
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_basic_data(y, icon_index, vocab, value)
    w = contents_width
    w = QuestData::BASIC_DATA_WIDTH if QuestData::BASIC_DATA_WIDTH.between?(1, w)
    x = (contents_width - w) / 2
    unless icon_index == 0
      draw_icon(icon_index, x, y)
      x += 24
      w -= 24
    end
    tw = text_size(vocab).width
    change_color(text_color(QuestData::COLOURS[:basic_label]))
    draw_text(x, y, tw, line_height, vocab)
    change_color(text_color(QuestData::COLOURS[:basic_value]))
    draw_text(x + tw, y, w - tw, line_height, value, 2)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Heading
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_heading(data_type, y)
    set_data_font(:heading)
    clear_and_draw_text(40, y, contents_width - 80, line_height, 
      QuestData::VOCAB[data_type], QuestData::HEADING_ALIGN[data_type])
    reset_font_settings
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Clear and Draw Text
  #    Clear the field before drawing the text
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def clear_and_draw_text(*args)
    rect = []
    while !args[0].is_a?(String) do rect.push(args.shift) end
    rect[0].is_a?(Rect) ? rect = rect[0] : rect = Rect.new(*rect)
    align = args[1] ? args[1] : 0
    ts = text_size(args[0])
    ts.width = [ts.width + 4, rect.width].min
    align == 1 ? ts.x = rect.x + ((rect.width - ts.width) / 2) : 
      align == 2 ? ts.x = rect.x + rect.width - ts.width : ts.x = rect.x
    ts.y = rect.y
    contents.clear_rect(ts)
    ts.x += 2
    draw_text(ts, args[0], align)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Description Box
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_box(line_num)
    return if line_num < 1
    x = (line_height / 2) - 1
    y = @draw_y + (line_height / 2) - 1
    w = contents_width - 2*x
    h = (2 + line_num)*line_height
    draw_rect_outline_with_shadow(x, y, w, h) 
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Rect Outline
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_rect_outline(x, y, w, h, colour)
    # Horizontal Lines
    contents.fill_rect(x, y, w, 2, colour)
    contents.fill_rect(x, y + h - 2, w, 2, colour)
    # Vertical Lines
    contents.fill_rect(x, y, 2, h, colour)
    contents.fill_rect(x + w - 2, y, 2, h, colour)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Draw Rect Outline with Shadow
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def draw_rect_outline_with_shadow(x, y, w, h)
    draw_rect_outline(x + 1, y + 1, w, h, text_color(QuestData::COLOURS[:line_shadow]))
    draw_rect_outline(x, y, w, h, text_color(QuestData::COLOURS[:line]))
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Objective/Description X
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def objective_x; line_height / 2; end
  def description_x; QuestData::DESCRIPTION_IN_BOX ? line_height : (line_height/2); end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update(*args, &block)
    super(*args, &block)
    if open? && active && @dest_scroll_oy == self.oy
      scroll_down if Input.press?(:DOWN) || WolfPad.repeat?(:L_DOWN,0) || WolfPad.repeat?(:DOWN,0) || WolfPad.repeat?(:L_DOWN,1) || WolfPad.repeat?(:DOWN,1)
      scroll_up if Input.press?(:UP) || WolfPad.repeat?(:L_UP,0) || WolfPad.repeat?(:UP,0) || WolfPad.repeat?(:L_UP,1) || WolfPad.repeat?(:UP,1)
    end
    if self.oy != @dest_scroll_oy
      mod = (@dest_scroll_oy <=> self.oy)
      self.oy += 3*mod
      self.oy = @dest_scroll_oy if (@dest_scroll_oy <=> self.oy) != mod
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Scroll Down
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def scroll_down(*args, &block)
    max_oy = contents_height - maqj_visible_height
    dest = ((@dest_scroll_oy / line_height) + 1)*line_height
    @dest_scroll_oy = [dest, max_oy].min
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Scroll Up
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def scroll_up(*args, &block)
    dest = ((@dest_scroll_oy / line_height) - 1)*line_height
    @dest_scroll_oy = [dest, 0].max 
  end
end

#==============================================================================
# ** Scene_Quest
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  This class handles processing for the Quest scene
#==============================================================================

class Scene_Quest < Scene_MenuBase
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Start Scene Processing
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def start
    super
    @init_category, @init_quest_index = $game_party.quests.find_location($game_system.last_quest_id, $game_system.last_quest_cat)
    create_maqj_picture unless $game_system.quest_bg_picture.empty?
    create_all_windows
    adjust_window_positions
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Terminate Scene
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def terminate
    $game_system.quest_categories = QuestData::CATEGORIES
    $game_system.quest_scene_label = QuestData::VOCAB[:scene_label]
    $game_system.last_quest_id = @quest_list_window.item ? @quest_list_window.item.id : 0
    $game_system.last_quest_cat = @quest_category_window ? 
      @quest_category_window.item : $game_system.quest_categories[0]
    super
    dispose_maqj_picture
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create Background Picture
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_maqj_picture
    @maqj_picture_sprite = Sprite.new
    @maqj_picture_sprite.bitmap = Cache.picture($game_system.quest_bg_picture)
    @maqj_picture_sprite.opacity = $game_system.quest_bg_opacity
    @maqj_picture_sprite.blend_type = $game_system.quest_bg_blend_type
    #@maqj_picture_sprite.z = @background_sprite.z + 1 if @background_sprite
    @maqj_picture_sprite.z = 53
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create All Windows
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_all_windows
    create_quest_label_window unless $game_system.quest_scene_label.empty?
    create_quest_category_window if $game_system.quest_categories.size > 1
    create_quest_category_label_window if QuestData::SHOW_CATEGORY_LABEL
    create_dummy_category_window if QuestData::CATEGORY_LABEL_IN_SAME_WINDOW &&
      @quest_category_window && @quest_category_label_window
    create_quest_list_window
    create_quest_data_window
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create QuestLabel Window
  #    This window shows the name of the scene
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_quest_label_window
    @quest_label_window = Window_QuestLabel.new(0, 0, $game_system.quest_scene_label)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create QuestCategory Window
  #    This window allows the player to switch categories.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_quest_category_window
    @quest_category_window = Window_QuestCategory.new(0, 0, $game_system.quest_categories)
    @quest_category_window.category = @init_category if @init_category
    @quest_category_window.set_handler(:cancel, method(:on_category_cancel))
    @quest_category_window.set_handler(:ok, method(:on_category_ok)) 
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create QuestCategoryLabel Window
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_quest_category_label_window
    if @quest_category_window
      @quest_category_label_window = Window_QuestCategoryLabel.new(0, @quest_category_window.height)
      @quest_category_window.add_observing_proc(:label) { |category| 
        @quest_category_label_window.category = category }
    else
      @quest_category_label_window = Window_QuestCategoryLabel.new(0, 0)
      @quest_category_label_window.category = $game_system.quest_categories ? $game_system.quest_categories[0] : :all
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create Dummy Category Label Window
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_dummy_category_window
    @quest_category_label_window.y -= 12
    @quest_category_label_window.opacity = 0
    @quest_category_window.opacity = 0
    w = [@quest_category_window.width, @quest_category_label_window.width].max
    h = @quest_category_window.height + @quest_category_label_window.height - 12
    @category_dummy_window = Window_QuestCategoryDummy.new(0, 0, w, h)
    @category_dummy_window.z = [@quest_category_window.z, @quest_category_label_window.z].min - 1
    # Draw Horz Line
    @category_dummy_window.draw_horizontal_line(@quest_category_window.height - @quest_category_window.padding - 7, 2)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create QuestList Window
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_quest_list_window
    if @category_dummy_window
      y = @category_dummy_window.height
    else
      y = @quest_category_window ? @quest_category_window.height : 0
      y += @quest_category_label_window ? @quest_category_label_window.height : 0
      y = @quest_label_window.height if y == 0
    end
    @quest_list_window = Window_QuestList.new(0, y, QuestData::LIST_WINDOW_WIDTH, 
      Graphics.height - y)
    @quest_list_window.set_handler(:ok, method(:on_list_ok))
    @quest_list_window.deactivate if !QuestData::CONCURRENT_ACTIVITY
    if !QuestData::CONCURRENT_ACTIVITY || !@quest_category_window
      @quest_list_window.set_handler(:cancel, method(:on_list_cancel))
    end
    if @quest_category_window
      @quest_category_window.add_observing_proc(:list) { |category| 
        @quest_list_window.category = category }
    else
      @quest_list_window.category = $game_system.quest_categories[0]
    end
    @quest_list_window.index = @init_quest_index if @init_quest_index
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create QuestData Window
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def create_quest_data_window
    x = @quest_list_window.width
    y = (@quest_label_window && (@quest_category_window || 
      @quest_category_label_window)) ? @quest_label_window.height : 0
    @quest_data_window = Window_QuestData.new(x, y, Graphics.width - x, 
      Graphics.height - y)
    @quest_list_window.help_window = @quest_data_window
    @quest_data_window.quest = @quest_list_window.item
    @quest_data_window.set_handler(:ok, method(:on_data_ok))
    @quest_data_window.set_handler(:cancel, method(:on_data_cancel))
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Dispose Background Picture
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def dispose_maqj_picture
    @maqj_picture_sprite.dispose if @maqj_picture_sprite
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Adjust Window Positions
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def adjust_window_positions
    if @quest_label_window && (@quest_category_window || @quest_category_label_window)
      @quest_label_window.x = QuestData::LIST_WINDOW_WIDTH 
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Category OK
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def on_category_ok; end #@quest_list_window.activate; end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Category Cancel
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def on_category_cancel; return_scene; end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * List OK
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def on_list_ok
    @quest_category_window.deactivate if @quest_category_window
    @quest_data_window.activate
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * List Cancel
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def on_list_cancel
    @quest_category_window ? @quest_category_window.activate : return_scene
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Data OK
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def on_data_ok; on_data_cancel; end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Data Cancel
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def on_data_cancel
    @quest_list_window.activate
    @quest_category_window.activate if @quest_category_window && QuestData::CONCURRENT_ACTIVITY
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update All Windows
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update_all_windows(*args, &block)
    # To accomodate for concurrent activity, must deactivate category
    @quest_category_window.deactivate if @quest_category_window &&
      QuestData::CONCURRENT_ACTIVITY && @quest_list_window.active && 
      Input.trigger?(:C) || WolfPad.trigger?(:X,0) || WolfPad.trigger?(:X,1)
    super(*args, &block)
    @quest_category_window.activate if @quest_category_window &&
      QuestData::CONCURRENT_ACTIVITY && @quest_list_window.active
  end
end

#==============================================================================
# ** Scene_Map
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    aliased method - update_scene
#    new methods - update_call_quest_journal; call_quest_journal
#==============================================================================

class Scene_Map
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update Scene
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias maqj_updascne_9kh4 update_scene
  def update_scene(*args, &block)
    maqj_updascne_9kh4(*args, &block)
    update_call_quest_journal if $game_system.quest_map_access && !scene_changing?
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Update Call Quest Journal
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def update_call_quest_journal
    if $game_map.interpreter.running?
      @quest_journal_calling = false
    else
      if Input.trigger?(QuestData::MAP_BUTTON)
        $game_system.quest_access_disabled || $game_party.quests.list.empty? ?
          Sound.play_buzzer : @quest_journal_calling = true
      end
      call_quest_journal if @quest_journal_calling && !$game_player.moving?
    end
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Call Quest Journal
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def call_quest_journal
    @quest_journal_calling = false
    Sound.play_ok
    SceneManager.call(Scene_Quest)
  end
end

# Menu Access
if !$imported[:MA_InsertCommand]
# Initialize the Insertion Hash
MA_COMMAND_INSERTS = {}
MA_InsertableMenuCommand = Struct.new(:name, :index, :enable, :scene, :other)

#==============================================================================
# ** Game_System
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    new public instance variable - maic_menu_commands
#    aliased method - initialize
#==============================================================================

class Game_System
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Inserted Menu Commands
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def maic_inserted_menu_commands
    # Lazy Instantiation so that old save files are not corrupted
    if !@maic_inserted_menu_commands
      @maic_inserted_menu_commands = MA_COMMAND_INSERTS.keys
      # Sort by index
      @maic_inserted_menu_commands.sort! { |a, b| MA_COMMAND_INSERTS[a].index <=> MA_COMMAND_INSERTS[b].index }
    end
    @maic_inserted_menu_commands
  end
end

#==============================================================================
# ** Window_MenuCommand
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    aliased method - make_command_list; maic_insert_command
#==============================================================================

class Window_MenuCommand
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Make Command List
  #``````````````````````````````````````````````````````````````````````````
  #  I alias this method instead of add_original_commands because I need to
  # have all commands created before I can insert at the correct index
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias maic_mkcmmndl_6yd2 make_command_list
  def make_command_list(*args, &block)
    maic_mkcmmndl_6yd2(*args, &block) # Run Original Method
    # Insert new commands
    $game_system.maic_inserted_menu_commands.each { |sym| maic_insert_command(sym) }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Insert Command
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def maic_insert_command(symbol)
    command = MA_COMMAND_INSERTS[symbol]
    # Get the command name
    name = command.name.is_a?(Symbol) ? eval(command.name.to_s) : command.name
    # Check whether enabled
    enabled = case command.enable
    when Integer then command.enable == 0 ? true : $game_switches[command.enable]
    when String then eval(command.enable)
    when Symbol then self.send(command.enable)
    else
      enabled = true
    end
    # Add the command to the list
    add_command(name, symbol, enabled)
    added = @list.pop
    @list.insert([command.index, @list.size].min, added) # Insert at specific index
  end
end

#==============================================================================
# ** Scene_Menu
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Summary of Changes:
#    aliased method - create_command_window; on_personal_ok
#    new methods - maic_set_insert_handler; maic_command_insert
#==============================================================================

class Scene_Menu
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Create Command Window
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias maic_createcndwin_3ey7 create_command_window
  def create_command_window(*args, &block)
    maic_createcndwin_3ey7(*args, &block) # Run Original Method
    # Add handlers for all custom commands
    $game_system.maic_inserted_menu_commands.each { |symbol| maic_set_insert_handler(symbol) }
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Set Inserted Handler
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def maic_set_insert_handler(symbol)
    other = MA_COMMAND_INSERTS[symbol].other
    handler = case other
    when Symbol then method(other)
    when String then lambda { eval(other) }
    when TrueClass then method(:command_personal)
    else
      handler = method(:maic_command_insert)
    end
    @command_window.set_handler(symbol, handler)
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Custom Command
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def maic_command_insert
    SceneManager.call(Kernel.const_get(MA_COMMAND_INSERTS[@command_window.current_symbol].scene))
  end
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # * Personal OK
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  alias maic_onpok_3ek9 on_personal_ok
  def on_personal_ok(*args, &block)
    if $game_system.maic_inserted_menu_commands.include?(@command_window.current_symbol)
      maic_command_insert
    else
      maic_onpok_3ek9(*args, &block) # Run Original Method
    end
  end
end

$imported[:MA_InsertCommand] = true
end

MA_COMMAND_INSERTS[:quest_journal] = 
  MA_InsertableMenuCommand.new(QuestData::VOCAB[:menu_label], QuestData::MENU_INDEX, 
  "!$game_system.quest_access_disabled && !$game_party.quests.list.empty?", 
  :Scene_Quest, false)