Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E836C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C042189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562243107;
	bh=M8AbFRuaCz7uutOhNGv69ye21d/D/bNqoY3faGgInpA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=hG/D2fWb9H30Gh2Sev+e8ydfr38NdpxKSisdJRX6OHYZ2wMV3vuenWn5hMTPTYMKq
	 QfmWgEroL8qRYTesKl0KkkL1EQCLt80x5a0/tR0g8prIDVaZs+kEtuojKqUti7/6yk
	 Bms1MO9Vl5sMjAr0IwK1FCj0I1/xA71QmCtmM/bI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfGDMZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:25:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35292 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbfGDMZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hfZb/+TAkkRT7t//PaA+oZ9sLytwcv7pG7LhcLvO+as=; b=YBiKN9Ty1Vil
        r6BmVhutzI777WcVvwCD4jijNaOVNW1+W261XwsDcnU7CQmDd3GIYz6Wkj43WRCIdy0H1824KE9nZ
        8gdvWOcHRQUkr8VfV8lcQVJWcJB6HsLFxE8WqQdIbPBnU/JGQUUb076SYsiUJ5QW8IOsynE80luJP
        1P2is=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hj0nG-0000ic-Vf; Thu, 04 Jul 2019 12:24:55 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 725B0274389B; Thu,  4 Jul 2019 13:24:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-tdm-formatter: add reset" to the asoc tree
In-Reply-To: <20190703120749.32341-3-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190704122454.725B0274389B@ypsilon.sirena.org.uk>
Date:   Thu,  4 Jul 2019 13:24:54 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-tdm-formatter: add reset

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

From 751bd5db52604f3f71d54dbad82707ef2475b707 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 3 Jul 2019 14:07:49 +0200
Subject: [PATCH] ASoC: meson: axg-tdm-formatter: add reset

Add the optional reset line handling which is present on the new SoC
families, such as the g12a. Triggering this reset is not critical but
it helps solve a channel shift issue on the g12a.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190703120749.32341-3-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdm-formatter.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 0c6cce5c5773..2e498201139f 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <sound/soc.h>
 
 #include "axg-tdm-formatter.h"
@@ -20,6 +21,7 @@ struct axg_tdm_formatter {
 	struct clk *lrclk;
 	struct clk *sclk_sel;
 	struct clk *lrclk_sel;
+	struct reset_control *reset;
 	bool enabled;
 	struct regmap *map;
 };
@@ -75,6 +77,24 @@ static int axg_tdm_formatter_enable(struct axg_tdm_formatter *formatter)
 	if (formatter->enabled)
 		return 0;
 
+	/*
+	 * On the g12a (and possibly other SoCs), when a stream using
+	 * multiple lanes is restarted, it will sometimes not start
+	 * from the first lane, but randomly from another used one.
+	 * The result is an unexpected and random channel shift.
+	 *
+	 * The hypothesis is that an HW counter is not properly reset
+	 * and the formatter simply starts on the lane it stopped
+	 * before. Unfortunately, there does not seems to be a way to
+	 * reset this through the registers of the block.
+	 *
+	 * However, the g12a has indenpendent reset lines for each audio
+	 * devices. Using this reset before each start solves the issue.
+	 */
+	ret = reset_control_reset(formatter->reset);
+	if (ret)
+		return ret;
+
 	/*
 	 * If sclk is inverted, invert it back and provide the inversion
 	 * required by the formatter
@@ -306,6 +326,15 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Formatter dedicated reset line */
+	formatter->reset = reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(formatter->reset)) {
+		ret = PTR_ERR(formatter->reset);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get reset: %d\n", ret);
+		return ret;
+	}
+
 	return devm_snd_soc_register_component(dev, drv->component_drv,
 					       NULL, 0);
 }
-- 
2.20.1

