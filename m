Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFCC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E3E218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798151;
	bh=Vn99tqsuUqCrR9KMDkXnfx6rT0Xazq+4lGxL4AT/0DI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aoz+GVjqvLu9qsgvXk0PrPdVULf4/tOoiTsvIx3fxA1joPys1z6WmCCyl4rSblAu1
	 9OTDr00l7ec4z8jDkeXiFV7qWME+5DbPHWcpIQdUCTYpmiY7BzGNjGjv1sDD8dJkJS
	 mKwoLfIZDd6Ry7nNxJAa5FR6Nsc1ffAa/8BD+HGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfGVMWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:22:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58690 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfGVMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7M7lfxWMFFVq8j0P/G4KjJPLxGJ0Xmx4Exm43dS/2gQ=; b=mzGDl9CLEFH+
        xj8Kc54ODYAuIM97N1LZlwA7PAiqB1VWeNZoD2+/R8MufkpBoEF7KV0A0G+GTff6Kg90+FLXank9D
        LkLhQVzhIzlDSfG+nKTXhqlmVF2EAQMbowy8IjBINdHFl+ZwvvqAiiUGh9+HDk9VMKod3WpffgWX5
        BpzqA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKR-0007cO-G3; Mon, 22 Jul 2019 12:22:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EEFF22742C38; Mon, 22 Jul 2019 13:22:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     fengchunguo <chunguo.feng@amlogic.com>
Cc:     alsa-devel@alsa-project.org, bleung@chromium.org,
        broonie@kernel.org, chunguo.feng@amlogic.com,
        grundler@chromium.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        RyanS.Lee@maximintegrated.com, tiwai@suse.com
Subject: Applied "ASoC: max98383: fix i2c probe failure" to the asoc tree
In-Reply-To: <20190715095556.1614-1-chunguo.feng@amlogic.com>
X-Patchwork-Hint: ignore
Message-Id: <20190722122206.EEFF22742C38@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98383: fix i2c probe failure

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 1eac7bb88ae5a4c45283de1dc1f93e9da9278a7f Mon Sep 17 00:00:00 2001
From: fengchunguo <chunguo.feng@amlogic.com>
Date: Mon, 15 Jul 2019 17:55:56 +0800
Subject: [PATCH] ASoC: max98383: fix i2c probe failure

Added reset_gpio configuration for i2c probe successfully.
If not,i2c address can't be found rightly.

Error information:
max98373 3-0031: Failed to read: 0x21FF

Fixed:
[3.761299@3] max98373 3-0031: MAX98373 revisionID: 0x43
[3.828911@3] asoc-aml-card auge_sound: max98373-aif1 <-> TDM-B mapping ok

Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
Link: https://lore.kernel.org/r/20190715095556.1614-1-chunguo.feng@amlogic.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 34 ++++++++++++++++++++++++++++++----
 sound/soc/codecs/max98373.h |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 528695cd6a1c..9a1eb7222357 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -12,6 +12,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98373.h"
@@ -895,6 +896,17 @@ static void max98373_slot_config(struct i2c_client *i2c,
 	else
 		max98373->i_slot = 1;
 
+	max98373->reset_gpio = of_get_named_gpio(dev->of_node,
+						"maxim,reset-gpio", 0);
+	if (!gpio_is_valid(max98373->reset_gpio)) {
+		dev_err(dev, "Looking up %s property in node %s failed %d\n",
+			"maxim,reset-gpio", dev->of_node->full_name,
+			max98373->reset_gpio);
+	} else {
+		dev_dbg(dev, "maxim,reset-gpio=%d",
+			max98373->reset_gpio);
+	}
+
 	if (!device_property_read_u32(dev, "maxim,spkfb-slot-no", &value))
 		max98373->spkfb_slot = value & 0xF;
 	else
@@ -923,7 +935,6 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 	else
 		max98373->interleave_mode = false;
 
-
 	/* regmap initialization */
 	max98373->regmap
 		= devm_regmap_init_i2c(i2c, &max98373_regmap);
@@ -934,6 +945,24 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/* voltage/current slot & gpio configuration */
+	max98373_slot_config(i2c, max98373);
+
+	/* Power on device */
+	if (gpio_is_valid(max98373->reset_gpio)) {
+		ret = gpio_request(max98373->reset_gpio, "MAX98373_RESET");
+		if (ret) {
+			dev_err(&i2c->dev, "%s: Failed to request gpio %d\n",
+				__func__, max98373->reset_gpio);
+			gpio_free(max98373->reset_gpio);
+			return -EINVAL;
+		}
+		gpio_direction_output(max98373->reset_gpio, 0);
+		msleep(50);
+		gpio_direction_output(max98373->reset_gpio, 1);
+		msleep(20);
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98373->regmap,
 		MAX98373_R21FF_REV_ID, &reg);
@@ -944,9 +973,6 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 	}
 	dev_info(&i2c->dev, "MAX98373 revisionID: 0x%02X\n", reg);
 
-	/* voltage/current slot configuration */
-	max98373_slot_config(i2c, max98373);
-
 	/* codec registeration */
 	ret = devm_snd_soc_register_component(&i2c->dev, &soc_codec_dev_max98373,
 		max98373_dai, ARRAY_SIZE(max98373_dai));
diff --git a/sound/soc/codecs/max98373.h b/sound/soc/codecs/max98373.h
index f6a37aa02f26..533d2053f608 100644
--- a/sound/soc/codecs/max98373.h
+++ b/sound/soc/codecs/max98373.h
@@ -203,6 +203,7 @@
 
 struct max98373_priv {
 	struct regmap *regmap;
+	int reset_gpio;
 	unsigned int v_slot;
 	unsigned int i_slot;
 	unsigned int spkfb_slot;
-- 
2.20.1

