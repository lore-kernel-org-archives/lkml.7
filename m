Return-Path: <SRS0=Bkl1=UT=noreply.com=noreply@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,MIME_HTML_ONLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6E2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:16:52 +0000 (UTC)
X-Greylist: delayed 34724 seconds by postgrey-1.34 at mail.kernel.org; Thu, 20 Jun 2019 12:16:51 UTC
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB4B2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=noreply.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=noreply@noreply.com
Received: from host.btflhosting.com (unknown [69.16.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB4B2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:16:51 +0000 (UTC)
Received: from mta-d-189.sentinbox.com ([185.235.15.190]:59609 helo=noreply.com)
	by host.btflhosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.87)
	(envelope-from <noreply@noreply.com>)
	id 1hdmxi-000JG5-4v
	for linux-kernel@archiver.kernel.org; Wed, 19 Jun 2019 22:38:06 -0400
From: archiver.kernel.org  <noreply@noreply.com>
To: linux-kernel@archiver.kernel.org
Subject: Warning!!! Email Update
Date: 19 Jun 2019 19:37:58 -0700
Message-ID: <20190619193758.DFC292987856281C@noreply.com>
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.btflhosting.com
X-AntiAbuse: Original Domain - archiver.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - noreply.com
X-Get-Message-Sender-Via: host.btflhosting.com: authenticated_id: test@btflhosting.com
X-Authenticated-Sender: host.btflhosting.com: test@btflhosting.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
List-Id: <linux-kernel.vger.kernel.org>

<html><head></head><body><div style=3D"color:#000;background-color:#fff;fon=
t-family:Helvetica Neue,Helvetica,Arial,Lucida Grande,sans-serif;font-size:=
13px"><div id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym=
19_1_1555803250049_95266" dir=3D"ltr"><br id=3D"m_2296189881713917254ydp4a1=
92433yiv4067848516yui_3_16_0_ym19_1_1555803250049_97327"/></div><table widt=
h=3D"478" cellspacing=3D"0" cellpadding=3D"0" border=3D"1" style=3D"font-fa=
mily:Arial,Helvetica,sans-serif;font-size:small;color:rgb(33,33,33)" id=3D"=
m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_155580325004=
9_97328"><tbody id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16=
_0_ym19_1_1555803250049_97329"><tr id=3D"m_2296189881713917254ydp4a192433yi=
v4067848516yui_3_16_0_ym19_1_1555803250049_97330"><td style=3D"font-family:=
Roboto,RobotoDraft,Helvetica,Arial,sans-serif;margin:0px;border:medium none=
;padding:11.25pt 7.5pt 11.25pt 15pt" id=3D"m_2296189881713917254ydp4a192433=
yiv4067848516yui_3_16_0_ym19_1_1555803250049_97331"><div style=3D"margin:0i=
n 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif,serif,EmojiFon=
t" id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_155=
5803250049_97332"><span style=3D"font-size:11.5pt" id=3D"m_2296189881713917=
254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_97333"></span></=
div><div style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibr=
i,sans-serif,serif,EmojiFont" id=3D"m_2296189881713917254ydp4a192433yiv4067=
848516yui_3_16_0_ym19_1_1555803250049_97334">Hello=A0<span style=3D"font-fa=
mily:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:small" id=3D"m=
_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049=
_97335">linux-kernel@archiver.kernel.org</span><span style=3D"font-size:11p=
t" id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_155=
5803250049_97336">,</span></div><div style=3D"margin:0in 0in 0.0001pt;font-=
size:11pt;font-family:Calibri,sans-serif,serif,EmojiFont" id=3D"m_229618988=
1713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_97337"><s=
pan style=3D"font-size:11.5pt" id=3D"m_2296189881713917254ydp4a192433yiv406=
7848516yui_3_16_0_ym19_1_1555803250049_97338"></span></div><div style=3D"ma=
rgin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif,serif,E=
mojiFont" id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym1=
9_1_1555803250049_97339"><br id=3D"m_2296189881713917254ydp4a192433yiv40678=
48516yui_3_16_0_ym19_1_1555803250049_97340"/></div><div style=3D"margin:0in=
 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif,serif,EmojiFont=
" id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555=
803250049_97341">You have three messages On Hold due to your mail account l=
imit</div></td><td style=3D"font-family:Roboto,RobotoDraft,Helvetica,Arial,=
sans-serif;margin:0px;border:medium none;padding:11.25pt 15pt 11.25pt 7.5pt=
" id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555=
803250049_97342"><div align=3D"right" style=3D"margin:0in 0in 0.0001pt;font=
-size:11pt;font-family:Calibri,sans-serif,serif,EmojiFont;text-align:right"=
 id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_15558=
03250049_97343"></div><br id=3D"m_2296189881713917254ydp4a192433yiv40678485=
16yui_3_16_0_ym19_1_1555803250049_97344"/></td></tr><tr id=3D"m_22961898817=
13917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_97345"><td =
colspan=3D"2" style=3D"font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-=
serif;margin:0px;border:medium none;padding:0in 15pt 15pt" id=3D"m_22961898=
81713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_97346"><=
table width=3D"438" cellspacing=3D"0" cellpadding=3D"0" border=3D"0" style=
=3D"width:328.5pt;background-image:none" id=3D"m_2296189881713917254ydp4a19=
2433yiv4067848516yui_3_16_0_ym19_1_1555803250049_97347"><tbody id=3D"m_2296=
189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_9734=
8"><tr id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1=
_1555803250049_97349"><td style=3D"margin:0px;padding:15pt 0in 15pt 15pt" i=
d=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803=
250049_97350"><font color=3D"#0000ff" face=3D"Calibri, sans-serif" id=3D"m_=
2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_=
97351"><span style=3D"font-size:16px" id=3D"m_2296189881713917254ydp4a19243=
3yiv4067848516yui_3_16_0_ym19_1_1555803250049_97352">Inbox (3)</span></font=
><br id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1=
555803250049_97353"/><div style=3D"margin:0in 0in 0.0001pt;font-family:Cali=
bri,sans-serif,serif,EmojiFont" id=3D"m_2296189881713917254ydp4a192433yiv40=
67848516yui_3_16_0_ym19_1_1555803250049_97354"><font size=3D"4" id=3D"m_229=
6189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_973=
55"><span style=3D"color:black" id=3D"m_2296189881713917254ydp4a192433yiv40=
67848516yui_3_16_0_ym19_1_1555803250049_97356">Please click on the below bu=
tton to=A0preview messages and Upgrade Limit</span></font></div><div style=
=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif,s=
erif,EmojiFont" id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16=
_0_ym19_1_1555803250049_97357">
</div><table width=3D"393" cellpadding=3D"0" border=3D"0" style=3D"width:29=
4.75pt" id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_=
1_1555803250049_97358"><tbody id=3D"m_2296189881713917254ydp4a192433yiv4067=
848516yui_3_16_0_ym19_1_1555803250049_97359"><tr style=3D"min-height:22.5pt=
" id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555=
803250049_97360"><td nowrap=3D"" width=3D"200" style=3D"margin:0px;width:15=
0pt;border:1pt solid rgb(0,120,215);background-image:none;background-color:=
rgb(0,120,215);padding:0.75pt 15pt;min-height:22.5pt" id=3D"m_2296189881713=
917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_97361"><div a=
lign=3D"center" style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family=
:Calibri,sans-serif,serif,EmojiFont;text-align:center" dir=3D"ltr" id=3D"m_=
2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_=
97362"><span style=3D"font-size:12pt" id=3D"m_2296189881713917254ydp4a19243=
3yiv4067848516yui_3_16_0_ym19_1_1555803250049_97363"><b id=3D"m_22961898817=
13917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_97364"><spa=
n style=3D"font-size:10.5pt;font-family:Tahoma,sans-serif,serif,EmojiFont" =
id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_155580=
3250049_97365"><a href=3D"https://marquiss.co.kr/update/?email=3Dlinux-kern=
el@archiver.kernel.org" style=3D"color:rgb(17,85,204)" id=3D"m_229618988171=
3917254ydp4a192433yiv4067848516yui_3_16_0_ym19_1_1555803250049_97366" rel=
=3D"nofollow" target=3D"_blank" data-saferedirecturl=3D"https://www.google.=
com/url?q=3Dhttp://ktca.com.au/admin/logs/update%25202/index.php?email%3D%5=
B%5B-Email-%5D%5D&amp;source=3Dgmail&amp;ust=3D1559185558494000&amp;usg=3DA=
FQjCNEzG9XcEjaVH3Xg_pQj9Xhu8v28Fg" data-saferedirectreason=3D"2"><font colo=
r=3D"#ffffff" id=3D"m_2296189881713917254ydp4a192433yiv4067848516yui_3_16_0=
_ym19_1_1555803250049_97367">View Here</font></a></span></b></span></div></=
td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table=
></div></body></html>
