Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9349FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F42B217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108811;
	bh=9oDeEmGNdt7Rin+oU5YY/vfowK0dcqtgrFScr7klsMA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VxX4MnrIOOAxlT5vrFOGDaWAwieZbOrl9p/txeF2vv3697iYmpxc4G745MsWm8QJu
	 vHKptqoDk4Hq5Br7srjX5VTRYq7jSGokVW1dyG+ZKl5TCLEDvfdLcqdVCKl5USc43a
	 M/IlvRfYSL+GSa9L0FGGOYPx0f2ra9iXQUz0pBJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDAIxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:53:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59692 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfDAIx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=t+lRs5pjKJsRfFn3KKh0+7500TT4TVYHBCkpK4BQglA=; b=vFrklQZQof7s
        NwECopsPvhoVn1SZIxABHa8yivhuh1WAESqjJhtZq6pxYwCUiDLv5/z+kZ3ss/OFZ50S1rM2gaoAn
        SgcD0FalkgNpGRC2wyrOcaqDdLiYS6ftNWazkgui94YcwNyuDKoDbEXZhnd82Y+b5y0akqeZfYqmN
        VeZuI=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAsgo-0008NI-K2; Mon, 01 Apr 2019 08:53:11 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A2D25440082; Mon,  1 Apr 2019 09:53:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Mark Brown <broonie@kernel.org>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl: fix spelling mistake: "missign" -> "missing"" to the asoc tree
In-Reply-To:  <20190328092816.12883-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190401085307.A2D25440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:53:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl: fix spelling mistake: "missign" -> "missing"

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

From de70b2a581125a8a627db6fdc1d7f9c05536fe84 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 28 Mar 2019 09:28:16 +0000
Subject: [PATCH] ASoC: fsl: fix spelling mistake: "missign" -> "missing"

There is a spelling mistake in a dev_err message. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Acked-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-audmix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 72e37ca6cfbb..7983bd339c01 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -161,7 +161,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	}
 
 	if (!audmix_np) {
-		dev_err(&pdev->dev, "Missign DT node for parent device.\n");
+		dev_err(&pdev->dev, "Missing DT node for parent device.\n");
 		return -EINVAL;
 	}
 
-- 
2.20.1

