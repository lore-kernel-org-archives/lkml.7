Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109EFC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5D22190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfGYSkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:40:02 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:29362 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGYSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:40:02 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d13 with ME
        id h6fu2000Y4n7eLC036fwcM; Thu, 25 Jul 2019 20:40:00 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 Jul 2019 20:40:00 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, nishadkamdar@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Staging: fbtft: Fix some typo. pdc8544 --> pcd8544
Date:   Thu, 25 Jul 2019 20:38:56 +0200
Message-Id: <20190725183856.17616-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is related to 'pcd8544'.
However, 2 strings are about pdc8544 (c and d switched)
Fix it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is only theorical. It is based on the fact that a part of the
filename (i.e. pcd8544) looks misspelled in the file itself.
I don't know the implication of FBTFT_REGISTER_DRIVER and MODULE_ALIAS and
if additional adjustments are needed.
---
 drivers/staging/fbtft/fb_pcd8544.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_pcd8544.c b/drivers/staging/fbtft/fb_pcd8544.c
index ad49973ad594..08f8a4bb8772 100644
--- a/drivers/staging/fbtft/fb_pcd8544.c
+++ b/drivers/staging/fbtft/fb_pcd8544.c
@@ -157,10 +157,10 @@ static struct fbtft_display display = {
 	.backlight = 1,
 };
 
-FBTFT_REGISTER_DRIVER(DRVNAME, "philips,pdc8544", &display);
+FBTFT_REGISTER_DRIVER(DRVNAME, "philips,pcd8544", &display);
 
 MODULE_ALIAS("spi:" DRVNAME);
-MODULE_ALIAS("spi:pdc8544");
+MODULE_ALIAS("spi:pcd8544");
 
 MODULE_DESCRIPTION("FB driver for the PCD8544 LCD Controller");
 MODULE_AUTHOR("Noralf Tronnes");
-- 
2.20.1

