Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9E3C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EDB20856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfGYTGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:06:12 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:51939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:06:11 -0400
Received: from orion.localdomain ([77.9.64.13]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MFKCV-1hazTw0Drl-00FjDC; Thu, 25 Jul 2019 21:06:05 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net, dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2] platform/x86/pcengines-apuv2: use KEY_RESTART for front button
Date:   Thu, 25 Jul 2019 21:06:03 +0200
Message-Id: <1564081563-28322-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:adNwRs05/JGrziC0a2T4c+nfOAroExubb17H0iLxlQ33ip+kwz/
 7V7O6xwh96hqW3M4GD0lI+ijvGJF89qoi8v2j5Gsx9RbKeoJy5e0uEy5NTw86BA4UE2kVeZ
 L987vPidVJkjN0zJ8WhBzZzI8yTP0y2C0x7MGK/tQUrtJFtYZq5wwMgi2qLC/0DJGSlYRgO
 ZBbSdIWeB533Y8W4SXoBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+SzGQ0XlC70=:ipwKXEW6l7cdJNKjcwxcGe
 IeDZ9PF+8QLJpOLOCrbykmTRStnIXdLVSnn8XRmwDXKZQM+Oa0ynY9hULzXtj8zuVe34CzrrJ
 wGUt9ebVvn0NgeoQ78oUDK0bE3A4LpwdGHUK96YLh1r3lFFFhuErwoOdsBP6A/9wJSbKpBJ1V
 Stiy800JhX16UX5ozolpPtOcgzzyICF4LnT+6v/daxSjIwk2uxgRdixu95JoxFwaRspWVKbWo
 sNEj/C58LSuARV5HSTebjBlTJ9FUCe5B7t0aw92X3l7Ce6wu2YFWWIb590BPLacb8ANA5OggE
 A2S7JKSxqxgT/Ptx2e5OpUKJYBWpOqE6GUmDMMn/qHH6bGQApCmi27wpCdcMLeYVfildqwL2G
 YzmnFnE5ffEhMNF1YKoe45FrZEWvkBXhuH523amSpkhIE8Hb/kxjKs0ipGB5+1J8l5aLQ9G/u
 6udYxlgqOQotJsgOklke8sqJ/+xX09L90wEIo5WhfrKGg4Ven1NYLjJKhRVs5Hvu6ECEohzUP
 523xZk9UGAYal2f+z4nxE38EmQEJR+oT99PgGYE/2VpgYaDbzar2thSo7PEXNR7hlFev0Wgkt
 j3BupkqbRUuDx6AX+3yabA6Ttj+z8YXBT1yAOf54W1TXHqNcSOzgG+BRMzQ21ztPkdr21tEmd
 iP974+lCw16gsk0Q+vvLNBvMlMgHJ2CZLuqSs9+/Bh8kCInVPsKXaVFJnahtsukKNTYK5xP1S
 ecOvy145/vTT4XiJx+DZjinpjmK0BA0TRBoWKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

The keycode KEY_RESTART is more appropriate for the front button,
as most people use it for things like restart or factory reset.

Signed-off-by: Enrico Weigelt <info@metux.net>
Fixes: f8eb0235f65989fc5521c40c78d1261e7f25cdbe ("x86: pcengines apuv2 gpio/leds/keys platform driver")
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

