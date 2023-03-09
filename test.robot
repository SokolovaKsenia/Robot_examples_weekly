*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description


*** Variables ***
${BROWSER}  Chrome
${BC EOBUWIE URL}  https://flyingbisons.com/case-studies/eobuwie-mobile
${WORDEOBUWIE}   xpath=//p[contains(text(),'buwie')]
${KIKFIT TEST URL}  https://kikfit.pl
${COOKIES}  xpath=//button[@id="acceptBtn"]
${MYPROFIL}  xpath=//*[@class="c-profile"]
${ZALOGUJ}  xpath=//*[@id="logInContainer"]/section/div/div/form/div[4]/button
${SIGNINBUTTON}  xpath=//*[@data-testid='button']
${EMAILINPUT}  xpath=//*[@id='username']
${PASSWORDINPUT}  xpath=//*[@type='password']
${HOMEPAGELOGO}   xpath=//*[@class="c-profile"]
${DASHBOARDLOGO}  xpath=//*[@id="user"]/div/div/div/aside/div/div[1]/h2
${COOKIESFB}   xpath=//*[@id="iubenda-cs-banner"]/div/div/div/div[3]/div[2]/button[2]
${FBLOGO}   xpath=//*[@class='c-logo']
${POSTDESCRIPTION}   xpath=//p[@class='t-text -f12 -cWhite -uppercase']
${INVALIDLOGINMESSAGE}  xpath=//*[@id="logInContainer"]/section/div/div/form/div[1]/span




*** Test Cases ***
Login to My profil on kikfit.pl
    Open kikfit page
    Close Cookies popup
    Click on my profil
    Type in email
    Type in password
    Click on the Sign in button
    Assert Dashboard
    [Teardown]  Close Browser

Leave login empty kikfit
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
Assert spelling eobuwie
    Wait Until Element Is Visible    ${FBLOGO}
    Element Text Should Be    ${WORDEOBUWIE}    eobuwie
    Capture Page Screenshot    screenshot_${TEST NAME}.png
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
Leave login field empty
    Input Text      ${EMAILINPUT}   ${EMPTY}
Type in password
    Input Text    ${PASSWORDINPUT}    1234
Assert empty login message
    Wait Until Element Is Visible     ${INVALIDLOGINMESSAGE}
    Element Text Should Be    ${INVALIDLOGINMESSAGE}    To pole nie powinno być puste
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Check post description for Mr Wcislo
    Run Keyword And Ignore Error  Scroll Element Into View   ${POSTDESCRIPTION}
    Wait Until Element Is Visible    ${POSTDESCRIPTION}
    Element Text Should Be    ${POSTDESCRIPTION}   HEAD OF ECOMMERCE EXPERIENCE DESIGN, EOBUWIE
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Type in email
    Input Text    ${EMAILINPUT}     kseniia.sokolova@flyingbisons.com
Click on the Sign in button
     Scroll Element Into View    ${ZALOGUJ}
     Wait Until Element Is Visible     ${ZALOGUJ}
     Click Element     ${ZALOGUJ}
Assert Dashboard
    Wait Until Element Is Visible     ${DASHBOARDLOGO}
    Title Should Be     Profil użytkownika | kikfit
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Type invalid password
    Input Text    ${PASSWORDINPUT}    Test-1111
Assert invalid password message
    Wait Until Element Is Visible    ${INVALIDLOGINMESSAGE}
    Element Text Should Be    ${INVALIDLOGINMESSAGE}    Identifier or password invalid.
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


