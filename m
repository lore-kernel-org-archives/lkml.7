Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D255C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9CD2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfGUK0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 06:26:21 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:24704 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfGUK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:26:20 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d33 with ME
        id fNSH2000A4n7eLC03NSHfn; Sun, 21 Jul 2019 12:26:18 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 12:26:18 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     perex@perex.cz, tiwai@suse.com, tglx@linutronix.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ALSA: line6: Fix a typo
Date:   Sun, 21 Jul 2019 12:25:58 +0200
Message-Id: <20190721102558.16640-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Vairax/Variax/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/usb/line6/variax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index 0d24c72c155f..ed158f04de80 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -244,5 +244,5 @@ static struct usb_driver variax_driver = {
 
 module_usb_driver(variax_driver);
 
-MODULE_DESCRIPTION("Vairax Workbench USB driver");
+MODULE_DESCRIPTION("Variax Workbench USB driver");
 MODULE_LICENSE("GPL");
-- 
2.20.1

