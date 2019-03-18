Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D74C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8431620850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920698;
	bh=7ynF7jzb9iFZ0oboi20i4GrFxMFu3CxYd9MkPk8oR9Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=RjwDxB/aS6qkA/+qwGyNeqtgWdnVcw6hnNyXb2VuLijhyy3DnPi47nJyOykI80OT/
	 8d8FrPKYu1vkeSgMPBYR2ve0j/W4W5kh6ZLUHIz95Jj6O15yf59ewZLqbx0PuVVpEC
	 SKMBONO/g4vsiHmZGysDHXirnZ9IFOWZWkqvk3dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfCROvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:51:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55012 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfCROvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DuYYtJIN4Sd2eie0QZdMS4TGjrWIz8RGkJN+kGigMPA=; b=o0RgzThXc2kp
        EquiX+jocSIdRiJ4Shg6uJg/dz3IVv4oRu3bu7zQEiDUbsUQ9uSov7KjEkXosjMYW9KXKtaZOp4mQ
        pK4zksVdrFlhuypprTdK0xfoLkC4V7JSe0M6stUDK7/FrQZQu8PEIaRZglGO4KuFp+rg50df18V1d
        ykkLA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tbg-0005nI-Gx; Mon, 18 Mar 2019 14:51:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 138FE1128874; Mon, 18 Mar 2019 14:51:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: spdifrx: add power management" to the asoc tree
In-Reply-To:  <1551890888-24622-1-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190318145116.138FE1128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: spdifrx: add power management

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

From f68c2a682d444296403d1aa6e73b3de0681fdcea Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 6 Mar 2019 17:48:08 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: add power management

Add suspend and resume sleep callbacks to STM32 SPDIFRX driver,
to support system low power modes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 42 ++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 373df4f24be1..b4c3d983e195 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -471,6 +472,8 @@ static int stm32_spdifrx_get_ctrl_data(struct stm32_spdifrx_data *spdifrx)
 	memset(spdifrx->cs, 0, SPDIFRX_CS_BYTES_NB);
 	memset(spdifrx->ub, 0, SPDIFRX_UB_BYTES_NB);
 
+	pinctrl_pm_select_default_state(&spdifrx->pdev->dev);
+
 	ret = stm32_spdifrx_dma_ctrl_start(spdifrx);
 	if (ret < 0)
 		return ret;
@@ -502,6 +505,7 @@ static int stm32_spdifrx_get_ctrl_data(struct stm32_spdifrx_data *spdifrx)
 
 end:
 	clk_disable_unprepare(spdifrx->kclk);
+	pinctrl_pm_select_sleep_state(&spdifrx->pdev->dev);
 
 	return ret;
 }
@@ -611,10 +615,15 @@ static bool stm32_spdifrx_readable_reg(struct device *dev, unsigned int reg)
 
 static bool stm32_spdifrx_volatile_reg(struct device *dev, unsigned int reg)
 {
-	if (reg == STM32_SPDIFRX_DR)
+	switch (reg) {
+	case STM32_SPDIFRX_DR:
+	case STM32_SPDIFRX_CSR:
+	case STM32_SPDIFRX_SR:
+	case STM32_SPDIFRX_DIR:
 		return true;
-
-	return false;
+	default:
+		return false;
+	}
 }
 
 static bool stm32_spdifrx_writeable_reg(struct device *dev, unsigned int reg)
@@ -638,6 +647,7 @@ static const struct regmap_config stm32_h7_spdifrx_regmap_conf = {
 	.volatile_reg = stm32_spdifrx_volatile_reg,
 	.writeable_reg = stm32_spdifrx_writeable_reg,
 	.fast_io = true,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static irqreturn_t stm32_spdifrx_isr(int irq, void *devid)
@@ -983,10 +993,36 @@ static int stm32_spdifrx_remove(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, stm32_spdifrx_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_spdifrx_suspend(struct device *dev)
+{
+	struct stm32_spdifrx_data *spdifrx = dev_get_drvdata(dev);
+
+	regcache_cache_only(spdifrx->regmap, true);
+	regcache_mark_dirty(spdifrx->regmap);
+
+	return 0;
+}
+
+static int stm32_spdifrx_resume(struct device *dev)
+{
+	struct stm32_spdifrx_data *spdifrx = dev_get_drvdata(dev);
+
+	regcache_cache_only(spdifrx->regmap, false);
+
+	return regcache_sync(spdifrx->regmap);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops stm32_spdifrx_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_spdifrx_suspend, stm32_spdifrx_resume)
+};
+
 static struct platform_driver stm32_spdifrx_driver = {
 	.driver = {
 		.name = "st,stm32-spdifrx",
 		.of_match_table = stm32_spdifrx_ids,
+		.pm = &stm32_spdifrx_pm_ops,
 	},
 	.probe = stm32_spdifrx_probe,
 	.remove = stm32_spdifrx_remove,
-- 
2.20.1

