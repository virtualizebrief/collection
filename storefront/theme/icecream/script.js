/* User Name in the Upper Right & default landing after login is My Home */
CTXS.Extensions.afterDisplayHomeScreen = function(callback) {
	$('.dropdown-menu-top').insertBefore('#userMenuBtn');
	/* CTXS.ExtensionAPI.changeView("myhome"); */
};

/* Prevents: Please close your browser to protect your account */
CTXS.allowReloginWithoutBrowserClose = true

/* Store Header  */
$('#customTop').html("Did you know? We have a merch store with some nice kit. <a href='https://www.toysrus.com' target='_blank' style='color: #1883C9'>Learn more</a>");

/* Store Footer */
$('#customBottom').html("Made with <font color=ff0f0f><font size=4>&#x2665;</font></font> by the <form action='https://github.com/virtualizebrief' target='_blank'><input type='submit' value='Virtualize Brief' class='butMenuSmall'/></form>");


/* Logon Bottom Footer */
$('.customAuthFooter').html("Made with <font color=ff0f0f><font size=4>&#x2665;</font></font> by the <form action='https://github.com/virtualizebrief' target='_blank'><input type='submit' value='Virtualize Brief' class='butMenuSmall'/></form>");

/* Logon Auth Header */
$('.customAuthHeader').html("<form action='#' target='_blank'><input type='submit' value='Remote Support' class='butMenu'/></form><form action='#' target='_blank'><input type='submit' value='Citrix Workspace Download' class='butMenu'/></form><form action='#' target='_blank'><input type='submit' value='Password Requirements' class='butMenuStore'/></form>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

/* Logon Auth Box Top */
$('.customAuthTop').html("");

/* Store Categories - Disable Infinite Scrolling */
CTXS.UI.repeatAppGroupTiles = false;

/* About - Cusotimize */
(function ($) {
    $.localization.customStringBundle("en", {
        ThirdPartyNotices: "Wood Cloud | Marketplace",
        ThirdPartyNoticesWeb: "Notices",
        CitrixCopyright:  "2024 \u00a9 Virtualize Brief",
        AllRightsReserved: "Go to visit github.com/virtualizebrief",
    });
})(jQuery);


