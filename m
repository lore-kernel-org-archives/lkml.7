Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5A821881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567533634;
	bh=gcXMn/pCPI78qMPyPJeVr6flkKkG+eyehXBXJdCQAGY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=00nMouH7l4RtndL5vVRbf0DAzHrR6mVAuIehRT5z1NoBtdvOrOr9kkmj2hODoT9aT
	 4hyaiFkVMpEsWqcP9lyIwJFVi8IDghTQnPnnRiw7m5u3Btbo0GVXsBZCHYQ0v6ARDI
	 ywJCnGyfJhFfvqQjKNlKxtw9NZylPhgEnYKjWNS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfICSAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:00:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40922 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfICSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CYvNu2cKcY4lT8gMAf5xfJU7mlv/HVixnNOL6VgZw80=; b=mKZb8ShhW/Wa
        XlRY0/tZDWa+xfy9DsdTnvQJOnOxBeIji1CC93FzPJLs8bx7Rivo/4/d3SpWyw5pASUVu3Zhmknbb
        Mh1llsTWcIKxdc6pvXuxJ5t6sSm+qjsCmpmovy+xM/HgK082gO6x9gO6+Ao/jwWQpMNHPy3NkZOGP
        P4irE=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5D6J-0000zW-0C; Tue, 03 Sep 2019 18:00:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6118D2740A97; Tue,  3 Sep 2019 19:00:18 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     alsa-devel@alsa-project.org, Daniel Drake <drake@endlessm.com>,
        David Yang <yangxiaohua@everest-semi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8316: add clock control of MCLK" to the asoc tree
In-Reply-To: <20190903165322.20791-2-katsuhiro@katsuster.net>
X-Patchwork-Hint: ignore
Message-Id: <20190903180018.6118D2740A97@ypsilon.sirena.org.uk>
Date:   Tue,  3 Sep 2019 19:00:18 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es8316: add clock control of MCLK

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

From 6dd567dc964878c04269a44114ef13693712edf1 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Wed, 4 Sep 2019 01:53:20 +0900
Subject: [PATCH] ASoC: es8316: add clock control of MCLK

This patch introduce clock property for MCLK master freq control.
Driver will set rate of MCLK master if set_sysclk is called and
changing sysclk by board driver.

[Modified slightly to apply without an earlier patch in the series due
to context diffs -- broonie]

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Link: https://lore.kernel.org/r/20190903165322.20791-2-katsuhiro@katsuster.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8316.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 6db002cc2058..6248b01ca049 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -33,6 +34,7 @@ static const unsigned int supported_mclk_lrck_ratios[] = {
 
 struct es8316_priv {
 	struct mutex lock;
+	struct clk *mclk;
 	struct regmap *regmap;
 	struct snd_soc_component *component;
 	struct snd_soc_jack *jack;
@@ -360,7 +362,7 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_component *component = codec_dai->component;
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
-	int i;
+	int i, ret;
 	int count = 0;
 
 	es8316->sysclk = freq;
@@ -368,6 +370,12 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	if (freq == 0)
 		return 0;
 
+	if (es8316->mclk) {
+		ret = clk_set_rate(es8316->mclk, freq);
+		if (ret)
+			return ret;
+	}
+
 	/* Limit supported sample rates to ones that can be autodetected
 	 * by the codec running in slave mode.
 	 */
@@ -697,9 +705,26 @@ static int es8316_set_jack(struct snd_soc_component *component,
 static int es8316_probe(struct snd_soc_component *component)
 {
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	es8316->component = component;
 
+	es8316->mclk = devm_clk_get(component->dev, "mclk");
+	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (IS_ERR(es8316->mclk)) {
+		dev_err(component->dev, "clock is invalid, ignored\n");
+		es8316->mclk = NULL;
+	}
+
+	if (es8316->mclk) {
+		ret = clk_prepare_enable(es8316->mclk);
+		if (ret) {
+			dev_err(component->dev, "unable to enable clock\n");
+			return ret;
+		}
+	}
+
 	/* Reset codec and enable current state machine */
 	snd_soc_component_write(component, ES8316_RESET, 0x3f);
 	usleep_range(5000, 5500);
@@ -722,8 +747,17 @@ static int es8316_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static void es8316_remove(struct snd_soc_component *component)
+{
+	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+
+	if (es8316->mclk)
+		clk_disable_unprepare(es8316->mclk);
+}
+
 static const struct snd_soc_component_driver soc_component_dev_es8316 = {
 	.probe			= es8316_probe,
+	.remove			= es8316_remove,
 	.set_jack		= es8316_set_jack,
 	.controls		= es8316_snd_controls,
 	.num_controls		= ARRAY_SIZE(es8316_snd_controls),
-- 
2.20.1

