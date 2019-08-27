Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89078C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEA520674
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566935914;
	bh=b0pwUSD/iZ7AXOldVxbrbirIBwpEgsb6m1G8URnuss0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=tgNFELYVl340uujJo7kASmuFSUMxegUnFJYI79g0oUhSUJxQuRzejl1lurCYMCm7e
	 T9Kid7j+V2Jf677cBMpzQtadziSL3fEIqcwMLrSLinoefE4SMVnBHsjG3ESfPBPFI4
	 lEMwuYqrpKMr3rFj6Z7RNELZ+ea/3/WF8nNpGNzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbfH0T6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:58:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48620 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731359AbfH0T6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mLwhdc61f1fsTUMVyTfwingh4QR4ollQQm6O+N5/vGA=; b=vpg+xa0BPq5J
        iUlAqSGQ2EZIXLO0NI2f0EOA7ejYzzsbW5ZQ2xC9nrSEAElRAfrqJS5TleLvriYDYXZiRomc3lvvR
        B+1tBbnr4/qx99Y4T3B5sxbytLm3Aaka2wL10WZ9u055PN2rQz9RmEdtRGh5JLUYG4WHNC+mSfhgx
        39zGA=;
Received: from 188.28.18.107.threembb.co.uk ([188.28.18.107] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2hbb-0001Cr-QO; Tue, 27 Aug 2019 19:58:15 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8D170D02CE8; Tue, 27 Aug 2019 20:58:14 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        festevam@gmail.com, kernel@pengutronix.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com,
        perex@perex.cz, s.hauer@pengutronix.de, shawnguo@kernel.org,
        timur@kernel.org, tiwai@suse.com, viorel.suman@nxp.com,
        Viorel Suman <viorel.suman@nxp.com>, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: imx-audmix: register the card on a proper dev" to the asoc tree
In-Reply-To: <1566921315-23402-1-git-send-email-shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190827195814.8D170D02CE8@fitzroy.sirena.org.uk>
Date:   Tue, 27 Aug 2019 20:58:14 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: imx-audmix: register the card on a proper dev

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

From 9573820eb1951e0cb0f329886abcb4153f2ea798 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Tue, 27 Aug 2019 11:55:15 -0400
Subject: [PATCH] ASoC: imx-audmix: register the card on a proper dev

This platform device is registered from "fsl_audmix", which is
its parent device. If use pdev->dev.parent for the priv->card.dev,
the value set by dev_set_drvdata in parent device will be covered
by the value in child device.

Fixes: b86ef5367761 ("ASoC: fsl: Add Audio Mixer machine driver")
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/1566921315-23402-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-audmix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 9e1cb18859ce..71590ca6394b 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -325,14 +325,14 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	priv->card.num_configs = priv->num_dai_conf;
 	priv->card.dapm_routes = priv->dapm_routes;
 	priv->card.num_dapm_routes = priv->num_dapm_routes;
-	priv->card.dev = pdev->dev.parent;
+	priv->card.dev = &pdev->dev;
 	priv->card.owner = THIS_MODULE;
 	priv->card.name = "imx-audmix";
 
 	platform_set_drvdata(pdev, &priv->card);
 	snd_soc_card_set_drvdata(&priv->card, priv);
 
-	ret = devm_snd_soc_register_card(pdev->dev.parent, &priv->card);
+	ret = devm_snd_soc_register_card(&pdev->dev, &priv->card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed\n");
 		return ret;
-- 
2.20.1

