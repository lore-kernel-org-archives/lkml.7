Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21908C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011082178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406800AbfIGU51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 16:57:27 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:24603 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406391AbfIGU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:57:26 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6hlq-0006Md-Bf; Sat, 07 Sep 2019 22:57:22 +0200
Received: from 145-126.cable.senselan.ch ([83.222.145.126] helo=volery)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6hlq-000HWv-7v; Sat, 07 Sep 2019 22:57:22 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Date:   Sat, 7 Sep 2019 22:57:20 +0200
From:   Sandro Volery <sandro@volery.com>
To:     gregkh@linuxfoundation.org, osdevtc@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: wlan-ng: parenthesis at end of line fix
Message-ID: <20190907205720.GA25377@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed open parenthesis at the end of the line on line 327.

Signed-off-by: Sandro Volery <sandro@volery.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index eee1998c4b18..0a4c7415f773 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -324,7 +324,8 @@ static int prism2_scan(struct wiphy *wiphy,
 		(i < request->n_channels) && i < ARRAY_SIZE(prism2_channels);
 		i++)
 		msg1.channellist.data.data[i] =
-			ieee80211_frequency_to_channel(
+			ieee80211_frequency_to_channel
+			(
 				request->channels[i]->center_freq);
 	msg1.channellist.data.len = request->n_channels;
 
-- 
2.23.0

