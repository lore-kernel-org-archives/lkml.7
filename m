Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9DCC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A30206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570472027;
	bh=7qTxKpzDfiBZgLFEI3pRCQBh4ABTl6ofZ31Wb0WS2q8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=E/N9vFHim9BQ3uJNZ0TrH4dQQLc9FDMZBUd3MrgDiIgPirfkh/bQ7LhV5xQK3+0HN
	 C5PTIZJm2AntSf+csW98OkVQY/Vr8NzNONDI4bCNUEFRlz7+ht8G8jUKXp1+OGe6JH
	 H9f9EjS80Wk2HGFJBahBVn5bamkpPzTU0dNz919w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfJGSNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:13:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34574 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGSNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dlfa46lGCXB+/J0deOqs/W09rBlwYzs099ZfVzI+9RM=; b=JNe81tPrJrrH
        VkighFnutBYOUCjjUr2NKOzNc0lmT86d6oIAdhojEKNGH6z8dbbOsLJ5mFn9Nm+g3M6VF8sC0etWz
        GcyY17vAMPbIvUUh4iVmR7pRxyvbajIEnv7mSlVWF1oS/owSLzCbazZQoRkWIlXXbtG6sT9r35a/e
        hNl4c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHXVe-0004GE-2f; Mon, 07 Oct 2019 18:13:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7EAD52741D8E; Mon,  7 Oct 2019 19:13:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, navada@ti.com, perex@perex.cz,
        shifu0704@thundersoft.com, tiwai@suse.com
Subject: Applied "ASoc: tas2770: Remove unused defines and variables" to the asoc tree
In-Reply-To: <20191007171157.17813-3-dmurphy@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007181325.7EAD52741D8E@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 19:13:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoc: tas2770: Remove unused defines and variables

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 40f90ef0a77bab65c8f959ba1d264bb674f7234b Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Mon, 7 Oct 2019 12:11:57 -0500
Subject: [PATCH] ASoc: tas2770: Remove unused defines and variables

Remove unused defines and structure variables that are not
referenced by the code.  If these are needed for future
enhancements then they should be added at that time.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: https://lore.kernel.org/r/20191007171157.17813-3-dmurphy@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2770.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index d597a8280707..cbb858369fe6 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -125,40 +125,19 @@
 #define ERROR_UNDER_VOLTAGE 0x0000008
 #define ERROR_BROWNOUT      0x0000010
 #define ERROR_CLASSD_PWR    0x0000020
-#define TAS2770_SLOT_16BIT  16
-#define TAS2770_SLOT_32BIT  32
-#define TAS2770_I2C_RETRY_COUNT      3
-
-struct tas2770_register {
-	int book;
-	int page;
-	int reg;
-};
-
-struct tas2770_dai_cfg {
-	unsigned int dai_fmt;
-	unsigned int tdm_delay;
-};
 
 struct tas2770_priv {
 	struct device *dev;
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
 	struct snd_soc_component *component;
-	struct mutex dev_lock;
-	struct hrtimer mtimer;
 	int power_state;
 	int asi_format;
 	struct gpio_desc *reset_gpio;
 	int sampling_rate;
-	int frame_size;
 	int channel_size;
 	int slot_width;
 	int v_sense_slot;
 	int i_sense_slot;
-	bool runtime_suspend;
-	unsigned int err_code;
-	struct mutex codec_lock;
 };
 
 #endif /* __TAS2770__ */
-- 
2.20.1

