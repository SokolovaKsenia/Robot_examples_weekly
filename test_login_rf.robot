*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description

*** Variables ***
${LOGIN URL}  https://scouts-test.futbolkolektyw.pl/en
${BROWSER}  Chrome
${SIGNINBUTTON}  xpath=//*[text()= 'Sign in']
${EMAILINPUT}  xpath=//*[@id='login']
${PASSWORDINPUT}  xpath=//*[@id='password']
${DASHBOARDLOGO}  xpath=//*[@id="__next"]/div[1]/header/div/h6
${LOGINLOGO}   xpath=//*[contains(@class, 'MuiTypography-root MuiTypography-h5')]
${LANGUAGE}  xpath=//*[@role='button']
${DROPDOWNPOLSKI}  xpath=//li[@data-value='pl']
${DROPDOWNENGLISH}  xpath=//li[@data-value='en']
${SIGNOUTBUTTON}  xpath=(//ul[contains(@class, 'MuiList-root')])[2]/div[2]/div/span
${BOXTITLE}  xpath=//*[contains(@class, 'MuiTypography-root MuiTypography-h5')]
${INVALIDLOGINMESSAGE}  xpath=//span[contains(@class, 'MuiTypography-root')]
${BACKTOSIGNINLINK}  xpath=//a[contains(@class, 'MuiTypography-root')]
${ADDPLAYERLOGO}   xpath=//span[contains(@class, 'MuiTypography-h5')]
${ADDPLAYERBUTTON}  xpath=//*[text()='Add player']
${PLAYERNAMEFIELD}  xpath=//input[@name='name']
${PLAYERSURNAMEFIELD}  xpath=//input[@name='surname']
${PLAYERDATEOFBIRTH}  xpath=//input[@name='age']
${PLAYERLEGDROPDOWN}  xpath=//*[@id='mui-component-select-leg']
${LEFTLEG}  xpath=//li[@data-value='left']
${RIGHTLEG}  xpath=//li[@data-value='right']
${PLAYERMAINPOSITION}  xpath=//input[@name='mainPosition']
${SUBMITBUTTON}  xpath=//button[@type='submit']/span[1]
${PLAYERNAMEADDEDINMENU}     xpath=//ul[2]/div[1]/div/span[contains(text(),'Lionel Messi')]
${PAGEINPOLISH}   xpath=//*[text()='Zaloguj']


*** Test Cases ***

Login to the system
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert dashboard
    [Teardown]  Close Browser

Select polish language
    Open login page
    Click on the language button
    Select "Polski"
    Assert login page in polish
    [Teardown]  Close Browser

Leave Login empty
    Open login page
    Leave login field empty
    Type in password
    Click on the Sign in button
    Assert login page
    Assert empty login message
    [Teardown]      Close Browser

Type in Invalid Password
    Open login page
    Type in email
    Type invalid password
    Click on the Sign in button
    Assert login page
    Assert invalid password message
    [Teardown]      Close Browser

Add New Player
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert Dashboard
    Click on Add Player button
    Type in name
    Type in surname
    Type in date of birth
    Type in main position
    Select right leg
    Click on the Submit button
    Assert added player in menu
    [Teardown]      Close Browser

Login out of the site
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Assert Dashboard
    Click on Sign out button
    Assert Login page
    [Teardown]      Close Browser

Assert text of the Sign in box title
    Open login page
    Check text of the box title by xpath
    [Teardown]  Close Browser



*** Keywords ***
Open login page
    Open Browser  ${LOGIN URL}  ${BROWSER}
    Title Should Be    Scouts panel - sign in
Type in email
    Input Text    ${EMAILINPUT}  user10@getnada.com
Type in password
    Input Text    ${PASSWORDINPUT}    Test-1234
Click on the Sign in button
    Click Element     ${SIGNINBUTTON}
Assert dashboard
    wait until element is visible    ${DASHBOARDLOGO}
    title should be    Scouts panel
    Capture Page Screenshot  alert_signed_in.png
Assert Login page
    wait until element is visible   ${LOGINLOGO}
    title Should be   Scouts panel - sign in
    capture page screenshot     alert_login_page.png
Leave login field empty
    Input Text      ${EMAILINPUT}   ${EMPTY}
Assert empty login message
    wait until element is visible     ${INVALIDLOGINMESSAGE}
    element text should be     ${INVALIDLOGINMESSAGE}    Please provide your username or your e-mail.
    capture page screenshot     alert_empty_login.png
Type invalid password
    Input Text      ${PASSWORDINPUT}    Test-1111
Assert invalid password message
    wait until element is visible   ${INVALIDLOGINMESSAGE}
    element text should be    ${INVALIDLOGINMESSAGE}     Identifier or password invalid.
    capture page screenshot     alert_invalid_password.png
Click on Sign out button
    Click Element   ${SIGNOUTBUTTON}
Click on the language button
    Click Element    ${LANGUAGE}
Select "Polski"
    Click Element    ${DROPDOWNPOLSKI}
Assert login page in polish
    wait until element is visible    ${LOGINLOGO}
    title should be    Scouts panel - zaloguj
    element text should be    ${PAGEINPOLISH}  ZALOGUJ
    Capture Page Screenshot  alert_polish.png
Click on Add Player button
    Click Element   ${ADDPLAYERBUTTON}
    wait until element is visible   ${ADDPLAYERLOGO}
Type in name
    Input Text   ${PLAYERNAMEFIELD}   Lionel
Type in surname
    Input Text    ${PLAYERSURNAMEFIELD}   Messi
Type in date of birth
    Input Text    ${PLAYERDATEOFBIRTH}    24/06/1987
Type in main position
    Input Text    ${PLAYERMAINPOSITION}   forward
Select right leg
    Click Element   ${PLAYERLEGDROPDOWN}
    Click Element   ${RIGHTLEG}
Click on the Submit button
    Click Element   ${SUBMITBUTTON}
Assert added player in menu
    wait until element is visible   ${PLAYERNAMEADDEDINMENU}
    element text should be    ${PLAYERNAMEADDEDINMENU}   Lionel Messi
    capture page screenshot     alert_new_player.png
Check text of the box title by xpath
    element text should be   ${BOXTITLE}    Scouts Panel
    capture page screenshot     alert_check_element_text.png