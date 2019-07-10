Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001D0C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B7A20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562772907;
	bh=jDsbKFRnFT1lWRJd+v83zUMAM9b5s8HZlAZFo1H67aQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=rVxxpKwhAPYuenRz5sdiZ4NXwmQlYPC6O6wiAdg8Oc0u6G1pD5wiQwzzD/q3ZULnH
	 8GSbbm+9G4h9Hwu1Oa1pymIKkhk9MG4DbtaZdi+4X5W/3Iz5EW1ULE60E8z7bqVFPA
	 RF7cf3Jz4gdghiHGx+cJHBLNUHkPK9R93nC3LWKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfGJPfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:35:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45900 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGJPe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XwWqA/NOfRgx4XNg5ONW4QqeN4QoWIVSGnqy3C9aBgo=; b=kC0/z8lP3pY0
        qROInMGLjDfgylZMHdNshu+ied001x4cFRdb/T25+4+pHKvGopXv1l6RDf89vRm2uS+XyOL2C6fxp
        OYhScgLTWBprjbh+ySoUZrs5asYrnFz0zlejsLWMejYw7ewCpzn7VeYmh/TUOACRSiSh5cy7vra7k
        XuqbM=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hlEcL-00083E-LR; Wed, 10 Jul 2019 15:34:49 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 52CE3D02DA0; Wed, 10 Jul 2019 16:34:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: Relocate my e-mail to .com domain zone" to the asoc tree
In-Reply-To: <20190710055135.21377-1-kmarinushkin@birdec.com>
X-Patchwork-Hint: ignore
Message-Id: <20190710153449.52CE3D02DA0@fitzroy.sirena.org.uk>
Date:   Wed, 10 Jul 2019 16:34:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Relocate my e-mail to .com domain zone

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 9e944c9be2456159fb8c36b0ba3170b2f01c3887 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.com>
Date: Wed, 10 Jul 2019 07:51:35 +0200
Subject: [PATCH] ASoC: Relocate my e-mail to .com domain zone

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.com>
Link: https://lore.kernel.org/r/20190710055135.21377-1-kmarinushkin@birdec.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS                    | 2 +-
 sound/soc/codecs/pcm3060-i2c.c | 4 ++--
 sound/soc/codecs/pcm3060-spi.c | 4 ++--
 sound/soc/codecs/pcm3060.c     | 4 ++--
 sound/soc/codecs/pcm3060.h     | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e75361f9b3b..11db05b56744 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15795,7 +15795,7 @@ S:	Maintained
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
2.20.1

