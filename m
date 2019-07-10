Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF589C73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839FC2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.com header.i=@birdec.com header.b="WEi8z93d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfGJGkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 02:40:08 -0400
Received: from host.euro-space.net ([87.117.239.2]:56336 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfGJGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:40:07 -0400
X-Greylist: delayed 2969 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 02:40:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.com;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VdUiBxCjMnnmnjRuqrh2wCzPM35P1D7GGN/3U9qGim4=; b=WEi8z93dlEvDji1OYcR9r4X+7l
        x8qMDa/++VDfFFL3krpXjXvEmDLcDD2axsSVHU77qip5WiZmVe7mqUXQYDzRGI6zwpDvOQxdikdlE
        uFmqY4KfKtUj6v5gLULr6CdWY4Hue0C5hKbjAv3g1s92MwZG56l/KJGQbplFLBniNRXV9vM80FwB9
        FcvBt+GppAYBL7IOgvdN9AU8tiy7GEQs3oi3dZBJBISYA09CgHSh4Gt6Gm42gdoiXNaZK6kBbZS0g
        li0FE2LqF1ZWT1klTvnJ2tiF6grxK+24OgvYbzvdsGxOIP09tMKWCFaNqZDcSYTGppL7msKeS8vg8
        gktyp/IQ==;
Received: from x4dbf9360.dyn.telefonica.de ([77.191.147.96]:58102 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <kmarinushkin@birdec.com>)
        id 1hl5Uw-0002Cb-DB; Wed, 10 Jul 2019 06:50:34 +0100
From:   Kirill Marinushkin <kmarinushkin@birdec.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.com>
Subject: [PATCH] ASoC: Relocate my e-mail to .com domain zone
Date:   Wed, 10 Jul 2019 07:51:35 +0200
Message-Id: <20190710055135.21377-1-kmarinushkin@birdec.com>
X-Mailer: git-send-email 2.13.6
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.com
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.com
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.com>
---
 MAINTAINERS                    | 2 +-
 sound/soc/codecs/pcm3060-i2c.c | 4 ++--
 sound/soc/codecs/pcm3060-spi.c | 4 ++--
 sound/soc/codecs/pcm3060.c     | 4 ++--
 sound/soc/codecs/pcm3060.h     | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 558acf24ea1e..9cdc10e80d78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15829,7 +15829,7 @@ S:	Maintained
 F:	drivers/net/ethernet/ti/netcp*
 
 TI PCM3060 ASoC CODEC DRIVER
-M:	Kirill Marinushkin <kmarinushkin@birdec.tech>
+M:	Kirill Marinushkin <kmarinushkin@birdec.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/pcm3060.txt
diff --git a/sound/soc/codecs/pcm3060-i2c.c b/sound/soc/codecs/pcm3060-i2c.c
index cdc8314882bc..abcdeb922201 100644
--- a/sound/soc/codecs/pcm3060-i2c.c
+++ b/sound/soc/codecs/pcm3060-i2c.c
@@ -2,7 +2,7 @@
 //
 // PCM3060 I2C driver
 //
-// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
 
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -56,5 +56,5 @@ static struct i2c_driver pcm3060_i2c_driver = {
 module_i2c_driver(pcm3060_i2c_driver);
 
 MODULE_DESCRIPTION("PCM3060 I2C driver");
-MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.tech>");
+MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060-spi.c b/sound/soc/codecs/pcm3060-spi.c
index f6f19fa80932..3b79734b832b 100644
--- a/sound/soc/codecs/pcm3060-spi.c
+++ b/sound/soc/codecs/pcm3060-spi.c
@@ -2,7 +2,7 @@
 //
 // PCM3060 SPI driver
 //
-// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
 
 #include <linux/module.h>
 #include <linux/spi/spi.h>
@@ -55,5 +55,5 @@ static struct spi_driver pcm3060_spi_driver = {
 module_spi_driver(pcm3060_spi_driver);
 
 MODULE_DESCRIPTION("PCM3060 SPI driver");
-MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.tech>");
+MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 32b26f1c2282..b2358069cf9b 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -2,7 +2,7 @@
 //
 // PCM3060 codec driver
 //
-// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
 
 #include <linux/module.h>
 #include <sound/pcm_params.h>
@@ -342,5 +342,5 @@ int pcm3060_probe(struct device *dev)
 EXPORT_SYMBOL(pcm3060_probe);
 
 MODULE_DESCRIPTION("PCM3060 codec driver");
-MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.tech>");
+MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index 75931c9a9d85..18d51e5dac2c 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -2,7 +2,7 @@
 /*
  * PCM3060 codec driver
  *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+ * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
  */
 
 #ifndef _SND_SOC_PCM3060_H
-- 
2.13.6

