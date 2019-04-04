Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F276C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CFA2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554386340;
	bh=OL3UsMRx2ft4924hE6G/TazY0Rwe/hh0SKS0nFU2ETk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=WxsPb0k4kPjnrhSXmQPBKUd1MtVOPRKpBBjwVp8Z8dAugDwloZ4zGM4Sm62R3W8zQ
	 tW59pkYG3+WllUk9VHWOhzgj25fnToz+LQpZD8l0a2aAX8o84aNdfOpU1borVUeaqX
	 XM36bbs4u5i4Jvku6hMy7MwXN8fnLXLxIGV7g82Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfDDN66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:58:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60620 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfDDN64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=oWDoha4VVfxGFviUMKrKt8Ehle+H0bKg97aqkOx4Tc4=; b=rxuiCQpcLwIs
        lmXmCsVAAA3LDPooj2GVdS2hrb3b0CxfhlUQPTlWCToRd1RIjVCGX901pfjdXvhivdOe57EYyygh4
        ePnHUDafdbbu62ddSypaUcCYDwb8t+lPzXlUatrtCHYZi+5bbp5BgrdHqtnHRKChWxDBAInaLLk8q
        LWRUo=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hC2sx-0006d6-Pi; Thu, 04 Apr 2019 13:58:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1A94A441D3B; Thu,  4 Apr 2019 20:58:29 +0700 (+07)
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
Subject: Applied "ASoC: cs42l51: add regulator management" to the asoc tree
In-Reply-To:  <1554297817-14154-3-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404135829.1A94A441D3B@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 20:58:29 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l51: add regulator management

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

From f77b6ea70f3a672092e2d7eca2e67be09c0b8c54 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:32 +0200
Subject: [PATCH] ASoC: cs42l51: add regulator management

Add cs42l51 audio codec power supply management
through regulator framework.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51-i2c.c |  6 +++++
 sound/soc/codecs/cs42l51.c     | 44 +++++++++++++++++++++++++++++++++-
 sound/soc/codecs/cs42l51.h     |  1 +
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 4b5731a41876..8333dbf18ea2 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -35,12 +35,18 @@ static int cs42l51_i2c_probe(struct i2c_client *i2c,
 	return cs42l51_probe(&i2c->dev, devm_regmap_init_i2c(i2c, &config));
 }
 
+static int cs42l51_i2c_remove(struct i2c_client *i2c)
+{
+	return cs42l51_remove(&i2c->dev);
+}
+
 static struct i2c_driver cs42l51_i2c_driver = {
 	.driver = {
 		.name = "cs42l51",
 		.of_match_table = cs42l51_of_match,
 	},
 	.probe = cs42l51_i2c_probe,
+	.remove = cs42l51_i2c_remove,
 	.id_table = cs42l51_i2c_id,
 };
 
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 80da3cd73e04..f43eb51d2d8d 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -31,6 +31,7 @@
 #include <sound/pcm_params.h>
 #include <sound/pcm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include "cs42l51.h"
 
@@ -40,11 +41,19 @@ enum master_slave_mode {
 	MODE_MASTER,
 };
 
+static const char * const cs42l51_supply_names[] = {
+	"VL",
+	"VD",
+	"VA",
+	"VAHP",
+};
+
 struct cs42l51_private {
 	unsigned int mclk;
 	struct clk *mclk_handle;
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(cs42l51_supply_names)];
 };
 
 #define CS42L51_FORMATS ( \
@@ -550,7 +559,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 {
 	struct cs42l51_private *cs42l51;
 	unsigned int val;
-	int ret;
+	int ret, i;
 
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -569,6 +578,23 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 		cs42l51->mclk_handle = NULL;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(cs42l51->supplies); i++)
+		cs42l51->supplies[i].supply = cs42l51_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(cs42l51->supplies),
+				      cs42l51->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l51->supplies),
+				    cs42l51->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
@@ -587,11 +613,27 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	ret = devm_snd_soc_register_component(dev,
 			&soc_component_device_cs42l51, &cs42l51_dai, 1);
+	if (ret < 0)
+		goto error;
+
+	return 0;
+
 error:
+	regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
+			       cs42l51->supplies);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cs42l51_probe);
 
+int cs42l51_remove(struct device *dev)
+{
+	struct cs42l51_private *cs42l51 = dev_get_drvdata(dev);
+
+	return regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
+				      cs42l51->supplies);
+}
+EXPORT_SYMBOL_GPL(cs42l51_remove);
+
 const struct of_device_id cs42l51_of_match[] = {
 	{ .compatible = "cirrus,cs42l51", },
 	{ }
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 0ca805492ac4..aef0ede82c7b 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -22,6 +22,7 @@ struct device;
 
 extern const struct regmap_config cs42l51_regmap;
 int cs42l51_probe(struct device *dev, struct regmap *regmap);
+int cs42l51_remove(struct device *dev);
 extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
-- 
2.20.1

