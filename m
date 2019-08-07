Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C96C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED39122293
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565184661;
	bh=oka3HDsAJEEogVFQ0ezYZaYf29efLi0Cax4LdGeKtOI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kyrM6h421H9t999l40Zm3j6xZPLR3uMbGoXnW+Vld0A9Qig+twkA4RoHTzwyymB7e
	 t5FUQGsuBGTs80yBwCPqWdWkp5sTnN54wZiMTEqr5zdKfxiVH1nCpsxhEUeRbrPnRF
	 gCd/o/0Sh2qodxnssiUOSOYluNPVW5lZdGNoY8fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfHGNa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:30:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35268 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388280AbfHGNa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=He/eybvHtH7EREDmS2gRlNbZs/2VuGXdKsYyhsRo5CI=; b=ulvMPfRkp/vl
        nC0jVgfLmy8RX5gHqdNvqPW6v1038lwYUw9qmmzpKC8sui4ioYix40HLP1UO6er/Mgn6sLQcoed0J
        MK14UGQPfCLAomVhvrcuFdQycEpvloPMCUUm/5vZx3xzU0oiWRWRKTmPWIddrD9UwKxg5LWQjX8yT
        K4SpQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvM1e-0007f6-TM; Wed, 07 Aug 2019 13:30:46 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 605AB2742B9E; Wed,  7 Aug 2019 14:30:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, angus@akkea.ca, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, l.stach@pengutronix.de,
        Mark Brown <broonie@kernel.org>, mihai.serban@gmail.com,
        nicoleotsuka@gmail.com, Nicolin Chen <nicoleotsuka@gmail.com>,
        robh@kernel.org, shengjiu.wang@nxp.com, timur@kernel.org,
        tiwai@suse.com
Subject: Applied "ASoC: fsl_sai: Add support for imx7ulp/imx8mq" to the asoc tree
In-Reply-To: <20190806151214.6783-5-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190807133046.605AB2742B9E@ypsilon.sirena.org.uk>
Date:   Wed,  7 Aug 2019 14:30:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_sai: Add support for imx7ulp/imx8mq

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

From a860fac420971c5a90d4f78959b44ead793aee4f Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 6 Aug 2019 18:12:13 +0300
Subject: [PATCH] ASoC: fsl_sai: Add support for imx7ulp/imx8mq

SAI module on imx7ulp/imx8m features 2 new registers (VERID and PARAM)
at the beginning of register address space.

On imx7ulp FIFOs can held up to 16 x 32 bit samples.
On imx8mq FIFOs can held up to 128 x 32 bit samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/20190806151214.6783-5-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 0c5452927c04..4a346fcb5630 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1019,10 +1019,24 @@ static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.reg_offset = 0,
 };
 
+static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 16,
+	.reg_offset = 8,
+};
+
+static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 128,
+	.reg_offset = 8,
+};
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
 	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
 	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
+	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
+	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
-- 
2.20.1

