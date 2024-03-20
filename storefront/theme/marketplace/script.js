/* User Name in the Upper Right & default landing after login is My Home */
CTXS.Extensions.afterDisplayHomeScreen = function(callback) {
	$('.dropdown-menu-top').insertBefore('#userMenuBtn');
	CTXS.ExtensionAPI.changeView("myhome");
};

/* Prevents: Please close your browser to protect your account */
CTXS.allowReloginWithoutBrowserClose = true

/* Store Header  */
$('#customTop').html("Did you know? We have a cool merch store with some nice kit. <a href='https://amazon.com' target='_blank' style='color: #1883C9'>Learn more</a>");

/* Store Footer */
$('#customBottom').html("Made with <font color=ff0f0f><font size=4>&#x2665;</font></font> by the <form action='https://github.com/virtualizebrief' target='_blank'><input type='submit' value='Virtualize Brief' class='butMenuSmall'/></form>");

/* Logon Bottom Footer */
$('.customAuthFooter').html("Made with <font color=ff0f0f><font size=4>&#x2665;</font></font> by the <form action='https://github.com/virtualizebrief' target='_blank'><input type='submit' value='Virtualize Brief' class='butMenuSmall'/></form>");

/* Logon Auth Header */
$('.customAuthHeader').html("<form action='#'><input type='submit' value='Home' class='butMenuSelected'/></form><form action='#'><input type='submit' value='Session Manager' class='butMenu'/></form><form action='#'><input type='submit' value='KnowledgeBase' class='butMenuStore'/></form>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

/* Logon Auth Box Top */
$('.customAuthTop').html("");

/* Store Categories - Disable Infinite Scrolling */
CTXS.UI.repeatAppGroupTiles = false;

/* About - Cusotimize */
(function ($) {
    $.localization.customStringBundle("en", {
        ThirdPartyNotices: "Virtualize Brief",
        ThirdPartyNoticesWeb: "Notices",
        CitrixCopyright:  "\u00a9 2024 github.com/virtualizebrief.",
        AllRightsReserved: "Go to visit virtualizebrief.com",
    });
})(jQuery);

