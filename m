Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15519C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B5D21882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 13:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kG2dqz3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfKINiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 08:38:07 -0500
Received: from m15-113.126.com ([220.181.15.113]:39753 "EHLO m15-113.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfKINiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 08:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=uB1YLWFgB0H4kqFXea
        N2dQC0stXGaM+JHrO+t1N3wP8=; b=kG2dqz3a3VhuwAlq9gJTENHgIO5bV5+l2C
        xl8pAuvwMd/qelTvZhbLXZnzNNMUPqxjG3IIXlMe5HY3tZRMbQvx5W6sS/XHCDzZ
        MS265wltc6FV5pdpBumcfxywNTh3qoJ2aXG0T1ljwXCQH6hHN3hGQIZv0wN1N9k5
        ZDnleGo6I=
Received: from 192.168.137.242 (unknown [112.10.75.191])
        by smtp3 (Coremail) with SMTP id DcmowABn1PX1wMZd7M8zAQ--.33380S3;
        Sat, 09 Nov 2019 21:36:54 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: Fix typo in comment
Date:   Sat,  9 Nov 2019 08:36:54 -0500
Message-Id: <1573306614-21490-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DcmowABn1PX1wMZd7M8zAQ--.33380S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF18Cr1kKFW3Cw17Gry5twb_yoWDZFX_Zr
        1Sqrs7GrnIyr1Sqr4DGr4rZa4SgrW2qrZ2vF4F934akrs8AF4rArZ7W3WUGrW7uFWj9F9x
        Aw47Gryftw1xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnTE_tUUUUU==
X-Originating-IP: [112.10.75.191]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi5hZopFpD9DJGcwAAsW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the typo "cheked" -> "checked" in comment

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 33a6af7..bd5b554 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2331,7 +2331,7 @@ void ieee80211_start_bss(struct ieee80211_device *ieee)
 
 	/* ensure no-one start an associating process (thus setting
 	 * the ieee->state to ieee80211_ASSOCIATING) while we
-	 * have just cheked it and we are going to enable scan.
+	 * have just checked it and we are going to enable scan.
 	 * The ieee80211_new_net function is always called with
 	 * lock held (from both ieee80211_softmac_check_all_nets and
 	 * the rx path), so we cannot be in the middle of such function
-- 
1.8.3.1

