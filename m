Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B98C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 12:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08A52084C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 12:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfGUM4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 08:56:11 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:45440 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfGUM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 08:56:11 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d34 with ME
        id fQw8200044n7eLC03Qw8SE; Sun, 21 Jul 2019 14:56:09 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 14:56:09 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] watchdog: ath79_wdt: fix a typo in the name of a function
Date:   Sun, 21 Jul 2019 14:55:47 +0200
Message-Id: <20190721125547.13473-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is likely that 'ath97_wdt_shutdown()' should be 'ath79_wdt_shutdown()'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/watchdog/ath79_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 02234c254b10..436cdb4f0392 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -306,7 +306,7 @@ static int ath79_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void ath97_wdt_shutdown(struct platform_device *pdev)
+static void ath79_wdt_shutdown(struct platform_device *pdev)
 {
 	ath79_wdt_disable();
 }
@@ -322,7 +322,7 @@ MODULE_DEVICE_TABLE(of, ath79_wdt_match);
 static struct platform_driver ath79_wdt_driver = {
 	.probe		= ath79_wdt_probe,
 	.remove		= ath79_wdt_remove,
-	.shutdown	= ath97_wdt_shutdown,
+	.shutdown	= ath79_wdt_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = of_match_ptr(ath79_wdt_match),
-- 
2.20.1

