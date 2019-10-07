Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35FCC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80282070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453434;
	bh=qyviMD7Ce4azubl4913BSq3eBFa6+QO2U1AZpLD6+gk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qF2/oYNxEbR6FbOgYRmaHxV5bF/q7EcREYNGEaoUV0j0iY5RojSMfcaxrWtOEinhD
	 hYSDOIFI6gZ48oRls0MnJ+5QoAMs69rBSS5quVi4QuOadpFHBcQe552S+0ynBwZeK5
	 7Ddv0r0Yp399OiawOBS0nYjDggeCJSRHEbKk2RaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfJGNDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:03:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50140 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfJGNDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Cfep0rIWMWln/JuLOxx1Em6o0m/piiYjUQUP4jMHOv0=; b=DxajtVCIZ7TS
        LUoA4FeiAcAzoPTrmWvtbEN1KtrYBEv1W9u2aZ7c252BXAw0zAjorz8kqWIqIWS228TtPZyt0OlxW
        ypNHjM2RHffgNnU33MjcMIYZEikgtRvvIWjOYveK0Bd7yLHxEBw4HE4OlNyfCBKHboLT8B1KdT8jZ
        dZuck=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfP-0003Qq-3C; Mon, 07 Oct 2019 13:03:11 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5DBE7274162F; Mon,  7 Oct 2019 14:03:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>
Subject: Applied "ASoC: fsl_mqs: Fix error handling in probe" to the asoc tree
In-Reply-To: <20191004102208.GB823@mwanda>
X-Patchwork-Hint: ignore
Message-Id: <20191007130309.5DBE7274162F@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:09 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_mqs: Fix error handling in probe

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

From a9d273671440c439c4f236123c59dd839c1a0eb7 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 4 Oct 2019 13:22:09 +0300
Subject: [PATCH] ASoC: fsl_mqs: Fix error handling in probe

There are several problems in the error handling in fsl_mqs_probe().

1) "ret" isn't initialized on some paths.  GCC has a feature which
   warns about uninitialized variables but the code initializes "ret"
   to zero at the start of the function so the checking is turned off.
2) "gpr_np" is a pointer so initializing it to zero is confusing and
   generates a Sparse warning.
3) of_parse_phandle() doesn't return error pointers on error, it returns
   NULL.
4) If devm_snd_soc_register_component() fails then the function should
   free the "gpr_np".

Fixes: 9e28f6532c61 ("ASoC: fsl_mqs: Add MQS component driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20191004102208.GB823@mwanda
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_mqs.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index 7b9cab3a62e7..f7fc44e8fb27 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -178,10 +178,10 @@ static const struct regmap_config fsl_mqs_regmap_config = {
 static int fsl_mqs_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *gpr_np = 0;
+	struct device_node *gpr_np = NULL;
 	struct fsl_mqs *mqs_priv;
 	void __iomem *regs;
-	int ret = 0;
+	int ret;
 
 	mqs_priv = devm_kzalloc(&pdev->dev, sizeof(*mqs_priv), GFP_KERNEL);
 	if (!mqs_priv)
@@ -198,17 +198,16 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 
 	if (mqs_priv->use_gpr) {
 		gpr_np = of_parse_phandle(np, "gpr", 0);
-		if (IS_ERR(gpr_np)) {
+		if (!gpr_np) {
 			dev_err(&pdev->dev, "failed to get gpr node by phandle\n");
-			ret = PTR_ERR(gpr_np);
-			goto out;
+			return -EINVAL;
 		}
 
 		mqs_priv->regmap = syscon_node_to_regmap(gpr_np);
 		if (IS_ERR(mqs_priv->regmap)) {
 			dev_err(&pdev->dev, "failed to get gpr regmap\n");
 			ret = PTR_ERR(mqs_priv->regmap);
-			goto out;
+			goto err_free_gpr_np;
 		}
 	} else {
 		regs = devm_platform_ioremap_resource(pdev, 0);
@@ -229,7 +228,7 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 		if (IS_ERR(mqs_priv->ipg)) {
 			dev_err(&pdev->dev, "failed to get the clock: %ld\n",
 				PTR_ERR(mqs_priv->ipg));
-			goto out;
+			return PTR_ERR(mqs_priv->ipg);
 		}
 	}
 
@@ -237,17 +236,21 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 	if (IS_ERR(mqs_priv->mclk)) {
 		dev_err(&pdev->dev, "failed to get the clock: %ld\n",
 			PTR_ERR(mqs_priv->mclk));
-		goto out;
+		ret = PTR_ERR(mqs_priv->mclk);
+		goto err_free_gpr_np;
 	}
 
 	dev_set_drvdata(&pdev->dev, mqs_priv);
 	pm_runtime_enable(&pdev->dev);
 
-	return devm_snd_soc_register_component(&pdev->dev, &soc_codec_fsl_mqs,
+	ret = devm_snd_soc_register_component(&pdev->dev, &soc_codec_fsl_mqs,
 			&fsl_mqs_dai, 1);
-out:
-	if (!IS_ERR(gpr_np))
-		of_node_put(gpr_np);
+	if (ret)
+		goto err_free_gpr_np;
+	return 0;
+
+err_free_gpr_np:
+	of_node_put(gpr_np);
 
 	return ret;
 }
-- 
2.20.1

