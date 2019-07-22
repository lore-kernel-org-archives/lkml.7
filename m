Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E4AC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EC621911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfGVLgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:36:36 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfGVLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:36:36 -0400
Received: from orion.localdomain ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDyoU-1hfeiF40Ps-009zPi; Mon, 22 Jul 2019 13:36:29 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net, dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86/pcengines-apuv2: use KEY_RESTART for front button
Date:   Mon, 22 Jul 2019 13:36:19 +0200
Message-Id: <1563795379-7521-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:xv3sdLlicg7odtFSbhiPyDIZ4SM9Cjl3T8XzhC+XWA/0cfZY1Cl
 sFwRqDGry7kIUVRTYAu5Dy33cBbLvV/iajDRT9GaSfhMxA1Tk/Ck5uctL6lsUdmO9gnzTRV
 rNB4f/ByQteTZHuhgCqqp/dKW4YoFZpnVMdnJBs4+iIIMGETOOdzT01mc/dOkaM16BBTPvn
 nYEPeS5q8rZgNxiLUThpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5egK05G+yqo=:ir1F/wdYyU858FWrWL6L40
 lSZ4Wd8kiYnJoVUpHcTvi/PG1FfnEMCFSvVEkOGJP3vk4MY5/w+QliEcsqFVrfk+779/B0p6N
 x8v1WuhEqhsaf3+im5nPhWaxOU+X496chuFgjf5dpRzWzlablLuivmn6kxfzNBanJF9cwFFso
 76BuvgwOxVroONDCpipC5oCwZ7gPaaL+PvCUFnP29Js4mCJ4wbgYUBg93rUgaOgB9DncBnSsE
 HIYBifwvzufn+7k8oHxEw54IVgm66jEA2y/ATwlJV8iSAOTYO/mv3q6Ty37HvmmIjm/1NtbN1
 kvQX/0o/UjkWrYn93uzBZH14tLt5uQ7xHA732nEtK4L1Ab6k78+AuHDR4gAL5CQ6G+ZhjVk57
 NGl3iJBwk7LbqPT4ab28c5EQZFYbJu0dPJUVqimjAURdxG05KKA1QSor6GonnHmzff93TwaBs
 7SIV+FRTAsBHPK5LhIlqNA1TaOZab9J+C5qJTq19TCQfuneeKLBn5n9LTbHeqNtIIuUQT9RXe
 QFObKwqxt8RxdQQ0I78/3NYM9MiH1SB/I2vdHHcs0VI5ZypKrhqDhL2U4MuhHkJC8lO2Nlctn
 x/Pec7zyXYnqBpgDt/SZN2qCWCnRpcIUsZz+AovfLZ/lMoShHH5LcR5AbtyLZZf4Fx12DKKIZ
 beK17y6yLABF2sYs5VlpYvuyGXLbOjx7+trs+WO7MJDmacbxa5oR5H2QMavAxpb3lryeZrVyY
 FhaTXscXDpnQprm3H23Y7EjesiwpdWXTH6lUYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

The keycode KEY_RESTART is more appropriate for the front button,
as most people use it for things like restart or factory reset.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/platform/x86/pcengines-apuv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index b0d3110..4138007c 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -93,7 +93,7 @@
 
 static struct gpio_keys_button apu2_keys_buttons[] = {
 	{
-		.code			= KEY_SETUP,
+		.code			= KEY_RESTART,
 		.active_low		= 1,
 		.desc			= "front button",
 		.type			= EV_KEY,
-- 
1.9.1

