Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A88C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D06E2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553691173;
	bh=EElsyQaDtSeX4WeFy2YCRzN0O25gORAyOT4r2DxN6i0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FrycFCsl7Sn3w1gh26+F7WRW4cTjiPYIDthIRC/6LKPmsCp3xBFsrOVXA17GxRsvT
	 bxLfnWL/JgfV3SvmUxgGwYpC0xPzvm8wekCVlnK8ZTM9DIsPdAPaU1M+WMPL9tZlzQ
	 TmF08qrsX73bbtWNuJLBDQ0t8tlLx7pVtMfbM5Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfC0Mww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:52:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0Mwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xVp3/Bt7FUUYE4y5ndD+RXHou8sHQHV4zptCXcNMx1g=; b=AHWeSVUbQN8z
        Y2+gR5AUqgx1jmrO4iiFNmbEDRTfT+ExfsuIRYlJbPWkGOT832FL4hU/19KYvJelzYZ4QdA1BEqsy
        SSppMNFQWKHmOad7gmufRudpvxqmFr5b61RGhNRWxHAxq6aHVtNSPw2cCQDZswc4zogIUsXZ/mPd2
        +Iupg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h982l-0006Yc-2i; Wed, 27 Mar 2019 12:52:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3357411288FA; Wed, 27 Mar 2019 12:52:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viorel Suman <viorel.suman@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_audmix: Fix kbuild failure" to the asoc tree
In-Reply-To:  <1553678953-31228-1-git-send-email-viorel.suman@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190327125234.3357411288FA@debutante.sirena.org.uk>
Date:   Wed, 27 Mar 2019 12:52:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_audmix: Fix kbuild failure

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

From 5fb94d46c3179cb7afd805a5a9252111316a926f Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Wed, 27 Mar 2019 09:29:38 +0000
Subject: [PATCH] ASoC: fsl_audmix: Fix kbuild failure

The format in dev_dbg function must be a constant.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_audmix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 3356cb617713..dabde0342c95 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -90,7 +90,7 @@ static int fsl_audmix_state_trans(struct snd_soc_component *comp,
 	struct fsl_audmix *priv = snd_soc_component_get_drvdata(comp);
 	/* Enforce all required TDMs are started */
 	if ((priv->tdms & prm.tdms) != prm.tdms) {
-		dev_dbg(comp->dev, prm.msg);
+		dev_dbg(comp->dev, "%s", prm.msg);
 		return -EINVAL;
 	}
 
-- 
2.20.1

