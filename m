Return-Path: <SRS0=iyOS=VR=noisebridge.info=discourse@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MIME_HTML_ONLY,
	SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_PHISH,URIBL_PH_SURBL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4408FC7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 01:32:54 +0000 (UTC)
Received: from discuss.noisebridge.info (unknown [172.93.55.252])
	by mail.kernel.org (Postfix) with ESMTP id C6B1120873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 01:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=noisebridge.info header.i=@noisebridge.info header.b="HglxbYjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B1120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=noisebridge.info
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=discourse@noisebridge.info
Received: from noisebridge.info (unknown [95.174.65.219])
	by discuss.noisebridge.info (Postfix) with ESMTPA id AC774838D9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:19:35 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=noisebridge.info;
	s=201901; t=1563535176;
	bh=S5aSmw9KduXttAINnGmIW4thrNkWoXZkDZ83vGCN66w=;
	h=Reply-To:From:To:Subject:Date:From;
	b=HglxbYjzUSPd6FXYRSU4s35cJ/F7HCjtwAzbz+sBXP80bmGSVCEIPP9/6PXkLebN3
	 LCYmIdoCVOW1Vm8663/mtcFnTukkGTXBDX6SfAJFYd6BWDRYq2DPSVRiCKsdBuN1Xa
	 92EAODyfgN0b/jTN4GOPhmCXhuA6TKew40R9Nm7mYu0Kj+/lX1h4NZXHSuOy/VuY+5
	 uvMf1QT0Y/rrfBSKpEaxr+VV54JrsMnZK2j9EkA8ra5JKDu4ZavClhAWmLEu9hVQ1T
	 43IoDcjGgJlegM2vR1yxoduv99k1kOEQj1Y7YorJt/dH8lQEu2JyBkR8R0iTSrhg+v
	 kI10vpaMeUfWA==
Reply-To: info@archiver.kernel.org
From: Email Server<discourse@noisebridge.info>
To: linux-kernel@archiver.kernel.org
Subject: Security Alert: Account deactivation Request
Date: 19 Jul 2019 04:19:09 -0700
Message-ID: <20190719041909.700E425585A18BD7@noisebridge.info>
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <linux-kernel.vger.kernel.org>

<html>
<head>
	<title></title>
	<meta content=3D"MSHTML 11.00.9600.19375" name=3D"GENERATOR" />
</head>
<body>
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" height=3D"100%" lan=
g=3D"en" style=3D"FONT-SIZE: small; FONT-FAMILY: Arial, Helvetica, sans-ser=
if; MIN-WIDTH: 348px; WORD-BREAK: break-all; COLOR: rgb(34,34,34); LINE-HEI=
GHT: 19px; BACKGROUND-COLOR: rgb(255,255,255); overflow-wrap: break-word; f=
ont-variant-numeric: normal; font-variant-east-asian: normal; font-stretch:=
 normal" width=3D"100%">
	<tbody>
		<tr align=3D"center">
			<td style=3D"FONT-FAMILY: Roboto, RobotoDraft, Helvetica, Arial, sans-se=
rif; WORD-BREAK: break-all; COLOR: rgb(17,17,17); PADDING-BOTTOM: 0px; PADD=
ING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 1.5; PADDING-RIG=
HT: 0px; overflow-wrap: break-word">
			<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" style=3D"MAX-WID=
TH: 516px; MIN-WIDTH: 220px; WORD-BREAK: break-all; PADDING-BOTTOM: 20px; o=
verflow-wrap: break-word">
				<tbody style=3D"WORD-BREAK: break-all; overflow-wrap: break-word">
					<tr style=3D"WORD-BREAK: break-all; overflow-wrap: break-word">
						<td style=3D"WIDTH: 8px; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; =
PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 1.5; PADDING=
-RIGHT: 0px; overflow-wrap: break-word" width=3D"8">&nbsp;</td>
						<td style=3D"WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 1.5; PADDING-RIGHT: 0px;=
 overflow-wrap: break-word">
						<div align=3D"center" style=3D"BORDER-TOP: rgb(218,220,224) thin soli=
d; BORDER-RIGHT: rgb(218,220,224) thin solid; BORDER-BOTTOM: rgb(218,220,22=
4) thin solid; WORD-BREAK: break-all; PADDING-BOTTOM: 36px; PADDING-TOP: 40=
px; PADDING-LEFT: 20px; MARGIN: 0px; BORDER-LEFT: rgb(218,220,224) thin sol=
id; PADDING-RIGHT: 20px; overflow-wrap: break-word; border-radius: 8px">
						<div style=3D"FONT-FAMILY: &quot;Google Sans&quot;, Roboto, RobotoDra=
ft, Helvetica, Arial, sans-serif; BORDER-BOTTOM: rgb(218,220,224) thin soli=
d; WORD-BREAK: break-all; PADDING-BOTTOM: 24px; PADDING-TOP: 0px; PADDING-L=
EFT: 0px; MARGIN: 0px; LINE-HEIGHT: 32px; PADDING-RIGHT: 0px; overflow-wrap=
: break-word">
						<div style=3D"FONT-SIZE: 24px; WORD-BREAK: break-all; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px;=
 overflow-wrap: break-word">Account Shutdown Notification&nbsp;</div>

						<table align=3D"center" style=3D"WORD-BREAK: break-all; MARGIN-TOP: 8=
px; overflow-wrap: break-word">
							<tbody style=3D"WORD-BREAK: break-all; overflow-wrap: break-word">
								<tr style=3D"WORD-BREAK: break-all; LINE-HEIGHT: normal; overflow-w=
rap: break-word">
									<td align=3D"right" style=3D"FONT-FAMILY: Roboto, RobotoDraft, Hel=
vetica, Arial, sans-serif; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADD=
ING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 1.5; PADDING-RIG=
HT: 8px; overflow-wrap: break-word">For:&nbsp;<b style=3D"WORD-BREAK: break=
-all; overflow-wrap: break-word"><a href=3D"mailto:namkw61@hanmail.net" rel=
=3D"noopener noreferrer" style=3D"WORD-BREAK: break-all; overflow-wrap: bre=
ak-word; text-decoration-line: none" target=3D"_blank">linux-kernel@archive=
r.kernel.org</a></b></td>
									<td style=3D"FONT-FAMILY: Roboto, RobotoDraft, Helvetica, Arial, s=
ans-serif; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PA=
DDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 1.5; PADDING-RIGHT: 0px; overflo=
w-wrap: break-word">&nbsp;</td>
								</tr>
							</tbody>
						</table>
						</div>

						<div style=3D"FONT-SIZE: 14px; FONT-FAMILY: Roboto-Regular, Helvetica=
, Arial, sans-serif; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TO=
P: 20px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 20px; PADDING-RIGHT: =
0px; overflow-wrap: break-word">This is to notify you that you that we rece=
ived a command from your email settings instructing us to shutdown your acc=
ount.</div>

						<div style=3D"FONT-SIZE: 14px; FONT-FAMILY: Roboto-Regular, Helvetica=
, Arial, sans-serif; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TO=
P: 20px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 20px; PADDING-RIGHT: =
0px; overflow-wrap: break-word">Are you aware of this? Or was the command g=
iven by mistake?</div>

						<div style=3D"FONT-SIZE: 14px; FONT-FAMILY: Roboto-Regular, Helvetica=
, Arial, sans-serif; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TO=
P: 20px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 20px; PADDING-RIGHT: =
0px; overflow-wrap: break-word">If you clicked the button by accident, then=
 we strongly advice that you cancel this command now else your email will b=
e shutdown.
						<div style=3D"WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP=
: 32px; PADDING-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; overflow-wrap: =
break-word"><a data-saferedirecturl=3D"https://www.google.com/url?q=3Dhttps=
://egtattoostudio.com/123/deactivation/source/index.php?email%3Dnamkw61@han=
mail.net&amp;source=3Dgmail&amp;ust=3D1556664523363000&amp;usg=3DAFQjCNGxZp=
-GRTokS4gp8XpiBG0w7-jVrQ" href=3D"https://anthemwebservices.com/fanc/update=
/index.php?email=3Dlinux-kernel@archiver.kernel.org" rel=3D"noopener norefe=
rrer" style=3D"FONT-FAMILY: &quot;Google Sans&quot;, Roboto, RobotoDraft, H=
elvetica, Arial, sans-serif; MIN-WIDTH: 90px; WORD-BREAK: break-all; COLOR:=
 rgb(255,255,255); PADDING-BOTTOM: 10px; PADDING-TOP: 10px; PADDING-LEFT: 2=
4px; DISPLAY: inline-block; LINE-HEIGHT: 16px; PADDING-RIGHT: 24px; BACKGRO=
UND-COLOR: rgb(65,132,243); overflow-wrap: break-word; text-decoration-line=
: none; border-radius: 5px" target=3D"_blank">Click here to keep your accou=
nt safe!</a></div>
						&nbsp;

						<div style=3D"FONT-SIZE: 12px; WORD-BREAK: break-all; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; LETTER-SPACING: 0px=
; LINE-HEIGHT: 16px; PADDING-RIGHT: 0px; overflow-wrap: break-word"><b styl=
e=3D"WORD-BREAK: break-all; overflow-wrap: break-word">If you fail to verif=
y your account within 72hrs, your email will be shutdown</b></div>
						</div>
						</div>

						<div style=3D"WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP=
: 0px; PADDING-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; overflow-wrap: b=
reak-word">
						<div style=3D"FONT-SIZE: 11px; FONT-FAMILY: Roboto-Regular, Helvetica=
, Arial, sans-serif; WORD-BREAK: break-all; PADDING-BOTTOM: 0px; TEXT-ALIGN=
: center; PADDING-TOP: 12px; PADDING-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 1=
8px; PADDING-RIGHT: 0px; overflow-wrap: break-word">
						<div style=3D"WORD-BREAK: break-all; PADDING-BOTTOM: 0px; PADDING-TOP=
: 0px; PADDING-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; overflow-wrap: b=
reak-word">You received this email to let you know about important changes =
to your Account and services.</div>

						<div style=3D"WORD-BREAK: break-all; PADDING-BOTTOM: 0px; DIRECTION: =
ltr; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; =
overflow-wrap: break-word">&copy; 2019&nbsp;</div>
						</div>
						</div>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
	</tbody>
</table>
</body>
</html>

