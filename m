Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0991C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA90214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554386335;
	bh=zkFqvPtOmbeGU97xqUbQ8LEKDyVCL2579KmZY/R0X5o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=y0SFWd6YOFmTUIXjR1r2MSRaHXUBS3Zbu1RqN6vKd9NoGQbbLmb53jnqxjbAaiFmv
	 AR+KoqdoL9jJy7+jkn+TDE68dZExw5J1ZuhMcrsuugTWvvDUndsrwmokV998ktEgER
	 dyS5Ys5BWSSwkWWwEaa1+z6cC2cSP0BWtLuo0GSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfDDN6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:58:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60134 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfDDN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=o9qc8BULGi8SzKzz3FPvxxn43t/KoOJY1dafcoG2Yo8=; b=l4VWODum7BOp
        QyyiIPpR0MD0ZyjYzVDUJo0CNw4AbcoRK45+BE3n8fkOc1qEP3qLXRfLHQuCwgn0vVF3umbbsvn4V
        MRlL81OrmWJXvwnr+4lfszgRcFwXFYMjJ9pA2NMmWQoOSqA8Z3XiY/KTNiuyWZvwqBQFHRvflzB3E
        3zZqs=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hC2su-0006d1-VW; Thu, 04 Apr 2019 13:58:29 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 22337441D3C; Thu,  4 Apr 2019 20:58:26 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        apatard@mandriva.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: cs42l51: add reset management" to the asoc tree
In-Reply-To:  <1554297817-14154-4-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404135826.22337441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 20:58:26 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l51: add reset management

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 11b9cd748e3107df5c5e040a4daa986a3c6d8b75 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:33 +0200
Subject: [PATCH] ASoC: cs42l51: add reset management

Manage cs42l51 audio codec reset pin.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index f43eb51d2d8d..9b3ffa16b204 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -30,6 +30,7 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/pcm.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -54,6 +55,7 @@ struct cs42l51_private {
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(cs42l51_supply_names)];
+	struct gpio_desc *reset_gpio;
 };
 
 #define CS42L51_FORMATS ( \
@@ -595,6 +597,17 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 		return ret;
 	}
 
+	cs42l51->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(cs42l51->reset_gpio))
+		return PTR_ERR(cs42l51->reset_gpio);
+
+	if (cs42l51->reset_gpio) {
+		dev_dbg(dev, "Release reset gpio\n");
+		gpiod_set_value_cansleep(cs42l51->reset_gpio, 0);
+		mdelay(2);
+	}
+
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
@@ -629,6 +642,8 @@ int cs42l51_remove(struct device *dev)
 {
 	struct cs42l51_private *cs42l51 = dev_get_drvdata(dev);
 
+	gpiod_set_value_cansleep(cs42l51->reset_gpio, 1);
+
 	return regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
 				      cs42l51->supplies);
 }
-- 
2.20.1

