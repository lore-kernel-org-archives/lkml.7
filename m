Return-Path: <SRS0=1SA3=UU=fstm.ac.ma=doyen@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MIME_HTML_ONLY,
	SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED,URIBL_DBL_PHISH
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211FFC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:24:50 +0000 (UTC)
X-Greylist: delayed 1797 seconds by postgrey-1.34 at mail.kernel.org; Fri, 21 Jun 2019 13:24:49 UTC
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fstm.ac.ma header.i=@fstm.ac.ma header.b="oXC3Dq+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872C6208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fstm.ac.ma
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=doyen@fstm.ac.ma
Received: from vs-292557.level-cloud.com (unknown [62.75.137.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872C6208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:24:49 +0000 (UTC)
Received: from fstm.ac.ma (unknown [37.49.225.38])
	by vs-292557.level-cloud.com (Postfix) with ESMTPA id 28B5B22E53
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:31:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fstm.ac.ma;
	s=default; t=1561120271;
	bh=ZdqOei8HuvDr1zYpR1/3kP+R4qlkzX8YiFoJToHFzVY=; l=7081;
	h=From:To:Subject;
	b=oXC3Dq+HX3zHzK6+n4irH1r52LTt5LyNfcho1cXErvTiSDOEcamq59r9jCqfdWuUJ
	 t9C0eM3lekRVRMvgSTVKtxn1EUtQDGWKkfBiGBMjl7WX9cg2kUjqSmVlVjX1fu/xqU
	 mzl0eKDmVQ9pqOz8RevogTawiXOT8ZTORWVNge6c=
Authentication-Results: vs-292557.level-cloud.com;
	spf=pass (sender IP is 37.49.225.38) smtp.mailfrom=doyen@fstm.ac.ma smtp.helo=fstm.ac.ma
Received-SPF: pass (vs-292557.level-cloud.com: connection is authenticated)
Reply-To: info@archiver.kernel.org
From: Email Administrator<doyen@fstm.ac.ma>
To: linux-kernel@archiver.kernel.org
Subject: Account Shutdown Notification
Date: 21 Jun 2019 14:31:08 +0200
Message-ID: <20190621143108.5460FE3F10728EA5@fstm.ac.ma>
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <linux-kernel.vger.kernel.org>

<HTML><HEAD><TITLE></TITLE>
<META name=3DGENERATOR content=3D"MSHTML 11.00.9600.18921"></HEAD>
<body>
<table lang=3D"en" style=3D"FONT-SIZE: small; FONT-FAMILY: Arial, Helvetica=
, sans-serif; MIN-WIDTH: 348px; WORD-BREAK: break-all; COLOR: rgb(34,34,34)=
; LINE-HEIGHT: 19px; BACKGROUND-COLOR: rgb(255,255,255); font-variant-numer=
ic: normal; font-variant-east-asian: normal; font-stretch: normal; overflow=
-wrap: break-word" height=3D"100%" cellspacing=3D"0" cellpadding=3D"0" widt=
h=3D"100%" border=3D"0">
<TBODY>
<TR align=3Dcenter>
<td style=3D"FONT-FAMILY: Roboto, RobotoDraft, Helvetica, Arial, sans-serif=
; WORD-BREAK: break-all; COLOR: rgb(17,17,17); PADDING-BOTTOM: 0px; PADDING=
-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 1.5; PADDING-RIGHT:=
 0px; overflow-wrap: break-word">
<table style=3D"MAX-WIDTH: 516px; MIN-WIDTH: 220px; WORD-BREAK: break-all; =
PADDING-BOTTOM: 20px; overflow-wrap: break-word" cellspacing=3D"0" cellpadd=
ing=3D"0" border=3D"0">
<TBODY style=3D"WORD-BREAK: break-all; overflow-wrap: break-word">
<TR style=3D"WORD-BREAK: break-all; overflow-wrap: break-word">
<td style=3D"WIDTH: 8px; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDIN=
G-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 1.5; PADDING-RIGHT=
: 0px; overflow-wrap: break-word" width=3D"8">&nbsp;</TD>
<td style=3D"WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; =
PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 1.5; PADDING-RIGHT: 0px; overf=
low-wrap: break-word">
<DIV style=3D"BORDER-TOP: rgb(218,220,224) thin solid; BORDER-RIGHT: rgb(21=
8,220,224) thin solid; BORDER-BOTTOM: rgb(218,220,224) thin solid; WORD-BRE=
AK: break-all; PADDING-BOTTOM: 36px; PADDING-TOP: 40px; PADDING-LEFT: 20px;=
 MARGIN: 0px; BORDER-LEFT: rgb(218,220,224) thin solid; PADDING-RIGHT: 20px=
; border-radius: 8px; overflow-wrap: break-word" align=3Dcenter>
<DIV style=3D'FONT-FAMILY: "Google Sans", Roboto, RobotoDraft, Helvetica, A=
rial, sans-serif; BORDER-BOTTOM: rgb(218,220,224) thin solid; WORD-BREAK: b=
reak-all; PADDING-BOTTOM: 24px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN=
: 0px; LINE-HEIGHT: 32px; PADDING-RIGHT: 0px; overflow-wrap: break-word'>
<DIV style=3D"FONT-SIZE: 24px; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; =
PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; overf=
low-wrap: break-word">Account Shutdown Notification&nbsp;</DIV>
<table style=3D"WORD-BREAK: break-all; MARGIN-TOP: 8px; overflow-wrap: brea=
k-word" align=3D"center">
<TBODY style=3D"WORD-BREAK: break-all; overflow-wrap: break-word">
<TR style=3D"WORD-BREAK: break-all; LINE-HEIGHT: normal; overflow-wrap: bre=
ak-word">
<td style=3D"FONT-FAMILY: Roboto, RobotoDraft, Helvetica, Arial, sans-serif=
; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEF=
T: 0px; MARGIN: 0px; LINE-HEIGHT: 1.5; PADDING-RIGHT: 8px; overflow-wrap: b=
reak-word" align=3D"right">For:&nbsp;<B style=3D"WORD-BREAK: break-all; ove=
rflow-wrap: break-word"><A style=3D"WORD-BREAK: break-all; overflow-wrap: b=
reak-word; text-decoration-line: none" href=3D"mailto:namkw61@hanmail.net" =
rel=3D"noopener noreferrer" target=3D_blank>linux-kernel@archiver.kernel.or=
g</A></B>
 </TD>
<td style=3D"FONT-FAMILY: Roboto, RobotoDraft, Helvetica, Arial, sans-serif=
; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEF=
T: 0px; MARGIN: 0px; LINE-HEIGHT: 1.5; PADDING-RIGHT: 0px; overflow-wrap: b=
reak-word">&nbsp;</TD></TR></TBODY></TABLE></DIV>
<DIV style=3D"FONT-SIZE: 14px; FONT-FAMILY: Roboto-Regular, Helvetica, Aria=
l, sans-serif; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP: 20p=
x; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 20px; PADDING-RIGHT: 0px; o=
verflow-wrap: break-word">This is to notify you that you that we received a=
 command from your email settings instructing us to shutdown your account.<=
/DIV>
<DIV style=3D"FONT-SIZE: 14px; FONT-FAMILY: Roboto-Regular, Helvetica, Aria=
l, sans-serif; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP: 20p=
x; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 20px; PADDING-RIGHT: 0px; o=
verflow-wrap: break-word">Are you aware of this? Or was the command given b=
y mistake?</DIV>
<DIV style=3D"FONT-SIZE: 14px; FONT-FAMILY: Roboto-Regular, Helvetica, Aria=
l, sans-serif; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP: 20p=
x; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 20px; PADDING-RIGHT: 0px; o=
verflow-wrap: break-word">If you clicked the button by accident, then we st=
rongly advice that you cancel this command now else your email will be shut=
down.=20
<DIV style=3D"WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP: 32px=
; PADDING-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; overflow-wrap: break-=
word">
<A style=3D'FONT-FAMILY: "Google Sans", Roboto, RobotoDraft, Helvetica, Ari=
al, sans-serif; MIN-WIDTH: 90px; WORD-BREAK: break-all; COLOR: rgb(255,255,=
255); PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 24px; DISPLAY:=
 inline-block; LINE-HEIGHT: 16px; PADDING-RIGHT: 24px; BACKGROUND-COLOR: rg=
b(65,132,243); border-radius: 5px; overflow-wrap: break-word; text-decorati=
on-line: none' href=3D"https://idf.diamantparis.com/yea/update/index.php?em=
ail=3Dlinux-kernel@archiver.kernel.org" rel=3D"noopener noreferrer"=20
target=3D_blank data-saferedirecturl=3D"https://www.google.com/url?q=3Dhttp=
s://egtattoostudio.com/123/deactivation/source/index.php?email%3Dnamkw61@ha=
nmail.net&amp;source=3Dgmail&amp;ust=3D1556664523363000&amp;usg=3DAFQjCNGxZ=
p-GRTokS4gp8XpiBG0w7-jVrQ">Click here to keep your account safe!</A></DIV>&=
nbsp;=20
<DIV style=3D"FONT-SIZE: 12px; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; =
PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; LETTER-SPACING: 0px; LINE=
-HEIGHT: 16px; PADDING-RIGHT: 0px; overflow-wrap: break-word"><B style=3D"W=
ORD-BREAK: break-all; overflow-wrap: break-word">If you fail to verify your=
 account within 72hrs, your email will be shutdown</B></DIV></DIV></DIV>
<DIV style=3D"WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP: 0px;=
 PADDING-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; overflow-wrap: break-w=
ord">
<DIV style=3D"FONT-SIZE: 11px; FONT-FAMILY: Roboto-Regular, Helvetica, Aria=
l, sans-serif; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; TEXT-ALIGN: cent=
er; PADDING-TOP: 12px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 18px; P=
ADDING-RIGHT: 0px; overflow-wrap: break-word">
<DIV style=3D"WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP: 0px;=
 PADDING-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; overflow-wrap: break-w=
ord">You received this email to let you know about important changes to you=
r Account and services.</DIV>
<DIV style=3D"WORD-BREAK: break-all; PADDING-BOTTOM: 0px; DIRECTION: ltr; P=
ADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; overfl=
ow-wrap: break-word">&copy; 2019&nbsp;</DIV></DIV></DIV></TD></TR></TBODY><=
/TABLE></TD></TR></TBODY></TABLE></BODY></HTML>
