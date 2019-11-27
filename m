Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0286CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BC520665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfK0Ixu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:53:50 -0500
Received: from mail.sysgo.com ([176.9.12.79]:54360 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK0Ixt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:53:49 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Nov 2019 03:53:49 EST
From:   David Engraf <david.engraf@sysgo.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] watchdog: max77620_wdt: fix potential build errors
Date:   Wed, 27 Nov 2019 09:46:17 +0100
Message-Id: <20191127084617.16937-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max77620_wdt uses watchdog core functions. Enable CONFIG_WATCHDOG_CORE
to fix potential build errors.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 58e7c100b6ad..c9cc34f4e541 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -687,6 +687,7 @@ config MAX63XX_WATCHDOG
 config MAX77620_WATCHDOG
 	tristate "Maxim Max77620 Watchdog Timer"
 	depends on MFD_MAX77620 || COMPILE_TEST
+	select WATCHDOG_CORE
 	help
 	 This is the driver for the Max77620 watchdog timer.
 	 Say 'Y' here to enable the watchdog timer support for
-- 
2.17.1

