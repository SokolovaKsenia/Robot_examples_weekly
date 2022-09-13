*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description


*** Variables ***
${BC EOBUWIE URL}  https://flyingbisons.com/case-studies/eobuwie-mobile
${KIKFIT TEST URL}  https://kikfit.pl
${BROWSER}  Chrome
${COOKIES}  xpath=//button[@id="acceptBtn"]
${MYPROFIL}  xpath=//*[@class="c-profile"]
${ZALOGUJ}  xpath=//*[@id="logInContainer"]/section/div/div/form/div[4]/button
${SIGNINBUTTON}  xpath=//*[@data-testid='button']
${EMAILINPUT}  xpath=//*[@id='username']
${PASSWORDINPUT}  xpath=//*[@type='password']
${HOMEPAGELOGO}   xpath=//*[@class="c-profile"]
${DASHBOARDLOGO}  xpath=//*[@id="user"]/div/div/div/aside/div/div[1]/h2
${FBLOGO}   xpath=//*[@class='c-logo']
${POSTDESCRIPTION}   xpath=//p[@class='t-text -f12 -cWhite -uppercase']
${LANGUAGE}  xpath=//*[@role='button']
${DROPDOWNPOLSKI}  xpath=//li[@data-value='pl']
${DROPDOWNENGLISH}  xpath=//li[@data-value='en']
${SIGNOUTBUTTON}  xpath=(//ul[contains(@class, 'MuiList-root')])[2]/div[2]/div/span
${BOXTITLE}  xpath=//*[contains(@class, 'MuiTypography-root MuiTypography-h5')]
${INVALIDLOGINMESSAGE}  xpath=//*[@id="logInContainer"]/section/div/div/form/div[1]/span
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
${WORDEOBUWIE}   xpath=//p[contains(text(),'buwie')]
${COOKIESFB}   xpath=//*[@id="iubenda-cs-banner"]/div/div/div/div[3]/div[2]/button[2]


*** Test Cases ***
Login to My profil
    Open kikfit page
    Close Cookies popup
    Click on my profil
    Type in email
    Type in password
    Click on the Sign in button
    Assert Dashboard
    [Teardown]  Close Browser

Leave login empty
    Open kikfit page
    Close Cookies popup
    Click on my profil
    Leave login field empty
    Type in password
    Click on the Sign in button
    Assert Login page
    Assert empty login message
    [Teardown]  Close Browser

Check spelling eobuwie
    Open Big Case eobuwie page
    Assert spelling eobuwie
    [Teardown]  Close Browser

Assert post description for Mr Wcislo
    Open Big Case eobuwie page
    Close Cookies popup FB
    Check post description for Mr Wcislo
    [Teardown]  Close Browser



*** Keywords ***
Open Big Case eobuwie page
    Open Browser  ${BC EOBUWIE URL}  ${BROWSER}
    Title Should Be     eObuwie mobile
Open kikfit page
    Open Browser  ${KIKFIT TEST URL}  ${BROWSER}
    Wait Until Element Is Visible     ${HOMEPAGELOGO}
    Title Should Be   Twój spersonalizowany catering dietetyczny | kikfit
Close Cookies popup
    Wait Until Element Is Visible     ${COOKIES}
    Scroll Element Into View    ${COOKIES}
    Click Element     ${COOKIES}
Click on my profil
    Click Element    ${MYPROFIL}
Type in email
    Input Text    ${EMAILINPUT}     kseniia.sokolova@flyingbisons.com
Type in password
    Input Text    ${PASSWORDINPUT}    1qaz2wsx
Click on the Sign in button
     Scroll Element Into View    ${ZALOGUJ}
     Wait Until Element Is Visible     ${ZALOGUJ}
     Click Element     ${ZALOGUJ}
Assert Dashboard
    Wait Until Element Is Visible     ${DASHBOARDLOGO}
    Title Should Be     Profil użytkownika | kikfit
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Click on the language button
    Click Element    ${LANGUAGE}
Select "Polski"
    Click Element    ${DROPDOWNPOLSKI}
Assert spelling eobuwie
    Wait Until Element Is Visible    ${FBLOGO}
    Element Text Should Be    ${WORDEOBUWIE}    eobuwie
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Leave login field empty
    Input Text      ${EMAILINPUT}   ${EMPTY}
Assert empty login message
    Wait Until Element Is Visible     ${INVALIDLOGINMESSAGE}
    Element Text Should Be    ${INVALIDLOGINMESSAGE}    To pole nie powinno być puste
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Type invalid password
    Input Text    ${PASSWORDINPUT}    Test-1111
Assert invalid password message
    Wait Until Element Is Visible    ${INVALIDLOGINMESSAGE}
    Element Text Should Be    ${INVALIDLOGINMESSAGE}    Identifier or password invalid.
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Check post description for Mr Wcislo
    Run Keyword And Ignore Error  Scroll Element Into View   ${POSTDESCRIPTION}
    Wait Until Element Is Visible    ${POSTDESCRIPTION}
    Element Text Should Be    ${POSTDESCRIPTION}   HEAD OF ECOMMERCE EXPERIENCE DESIGN, EOBUWIE
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Click on Add Player button
    Click Element   ${ADDPLAYERBUTTON}
    Wait Until Element Is Visible    ${ADDPLAYERLOGO}
Type in player's name
    Input Text    ${PLAYERNAMEFIELD}
Type in player's surname
    Input Text    ${PLAYERSURNAMEFIELD}
Type in player's date of birth
    Input Text    ${PLAYERDATEOFBIRTH}
Type in player's main position
    Input Text    ${PLAYERMAINPOSITION}
Select player's right leg
    Click Element    ${PLAYERLEGDROPDOWN}
    Click Element    ${RIGHTLEG}
Click on the Submit button
    Click Element    ${SUBMITBUTTON}
Assert added player in menu
    Wait Until Element Is Visible    ${PLAYERNAMEADDEDINMENU}
    Element Text Should Be    ${PLAYERNAMEADDEDINMENU}
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Click on the Sign out button
    Click Element    ${SIGNOUTBUTTON}
Assert Login page
    Wait Until Element Is Visible     ${HOMEPAGELOGO}
    Title Should Be   Twój spersonalizowany catering dietetyczny | kikfit
    Capture Page Screenshot     screenshot_${TEST NAME}.png
Close Cookies popup FB
    Wait Until Element Is Visible     ${COOKIESFB}
    Scroll Element Into View    ${COOKIESFB}
    Click Element     ${COOKIESFB}







    #Type in invalid password kikfit
#    Open kikfit page
#    Click on my profil
#    Type in email
#    Type invalid password
#    Click on the Sign in button
#    Assert Login page
#    Assert invalid password message
#    [Teardown]      Close Browser

#Log out of the site
#    Open Login page
#    Type in email
#    Type in password
#    Click on the Sign in button
#    Assert Dashboard
#    Click on the Sign out button
#    Assert Login page
#    [Teardown]      Close Browser