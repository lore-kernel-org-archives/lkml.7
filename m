Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A9C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D2321D81
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930162;
	bh=JX7sfxbar9hp7jtBRElG8a55KKamXmsuITr+ItlnKUI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wC/sBJuvzCFPvdwoofjTXLhkP/dxfNgcNZuta07JP90IPOHT/KYXo+0QRJDdxwfKd
	 VwRMPTOk/g1YVPoBrGHic7yURmVOhYaXMxIxqOu2tWL9Sg+Yg4qLI4z9GDl9AASj3+
	 iNOLxX+xoskZzXBkyWZWm9yVjVHQ8m0RTcLTBA/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbfJALml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:42:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40606 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387495AbfJALk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EZwXH2/aboNMmkJHaxOZm8Q5obeSzSnzi54A3erjNLY=; b=a0FYSRLwPqIy
        7f9N2YC5sUglieOL4Sk813LoHqYbsXCQB1TKMJ9g0HIyUbbZmTdr72dI9gwQbzDSEjc81igak3EqX
        ySK9pcDJYCNs2yAnz8Shb9Nc21UNcSDFt33CpSD9Owhknmd7fWV/LZSaOr0pnYXXQdzhH/rg1M3Jh
        VhZgA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWM-0004SZ-FF; Tue, 01 Oct 2019 11:40:46 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E1B2827429C0; Tue,  1 Oct 2019 12:40:45 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, lars@metafoo.de,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, nicoleotsuka@gmail.com,
        Nicolin Chen <nicoleotsuka@gmail.com>, perex@perex.cz,
        robh+dt@kernel.org, timur@kernel.org, tiwai@suse.com,
        Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_asrc: update supported sample format" to the asoc tree
In-Reply-To: <45a7c383f43cc1dd9d0934846447aee653278c03.1569493933.git.shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114045.E1B2827429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:45 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_asrc: update supported sample format

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

From 109539c986cee525e5ff9ae98793f23c2b29e54d Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Fri, 27 Sep 2019 09:46:10 +0800
Subject: [PATCH] ASoC: fsl_asrc: update supported sample format

The ASRC support 24bit/16bit/8bit input width, which is
data width, not slot width.

For the S20_3LE format, the data with is 20bit, slot width
is 24bit, if we set ASRMCR1n.IWD to be 24bits, the result
is the volume is lower than expected, it likes 24bit data
right shift 4 bits

So replace S20_3LE with S24_3LE in supported list and add S8
format in TX supported list

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/45a7c383f43cc1dd9d0934846447aee653278c03.1569493933.git.shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 4d3804a1ea55..584badf956d2 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -624,7 +624,7 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
 
 #define FSL_ASRC_FORMATS	(SNDRV_PCM_FMTBIT_S24_LE | \
 				 SNDRV_PCM_FMTBIT_S16_LE | \
-				 SNDRV_PCM_FMTBIT_S20_3LE)
+				 SNDRV_PCM_FMTBIT_S24_3LE)
 
 static struct snd_soc_dai_driver fsl_asrc_dai = {
 	.probe = fsl_asrc_dai_probe,
@@ -635,7 +635,8 @@ static struct snd_soc_dai_driver fsl_asrc_dai = {
 		.rate_min = 5512,
 		.rate_max = 192000,
 		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_ASRC_FORMATS,
+		.formats = FSL_ASRC_FORMATS |
+			   SNDRV_PCM_FMTBIT_S8,
 	},
 	.capture = {
 		.stream_name = "ASRC-Capture",
-- 
2.20.1

