Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B512CC2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 21:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A723206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 21:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577914937;
	bh=HEukejX4OvNOVnS8a6Olekp+Ofu1GNOBQnlpMpfkObA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JJHMb4zSY1F3oTW4C0/Cqp1p7QVnVahZnW4kQoPIoqw7lYGUNUpA+PSF+s9OQ+gPn
	 3qA3/GQn03bPjuQCoq9VB/ORu3LKa1fEmb/dpPf6G423r+vX+S75Zb55ObyP7HiAqX
	 M4QaHpVk9beMQi4H7MbBc/2SGfZVqcj9D/SpaDqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgAAVmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 16:42:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56738 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAAVmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 16:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=79XWKkj31wGwumBYjA54s8OnuOHN68P66X/FOnDTTeE=; b=SbM53CQGUUHc
        UcUyqxGU/+zizlzxTKG5tvwBu8JOObPRQ445sBf7exavks/y+ZT8NVBRtPDWuCiaJAw7elEC3dxMz
        Czs41xLyR7ozgeZ7uLoBDKxXQqRZegGECxEzjnQT0QEV+lvS7tuTA/PZZqyzeoWWFcnR6aC5dZnDF
        hXbjE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1imlkc-0002aM-4S; Wed, 01 Jan 2020 21:41:58 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8030DD057C6; Wed,  1 Jan 2020 21:41:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: SOF: imx8: use resource_size" to the asoc tree
In-Reply-To: <1577900990-8588-7-git-send-email-Julia.Lawall@inria.fr>
Message-Id: <applied-1577900990-8588-7-git-send-email-Julia.Lawall@inria.fr>
X-Patchwork-Hint: ignore
Date:   Wed,  1 Jan 2020 21:41:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: imx8: use resource_size

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 49f261e273078a5dc0272296a833dc72571efd92 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@inria.fr>
Date: Wed, 1 Jan 2020 18:49:46 +0100
Subject: [PATCH] ASoC: SOF: imx8: use resource_size

Use resource_size rather than a verbose computation on
the end and start fields.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@ struct resource ptr; @@
- (ptr.end - ptr.start + 1)
+ resource_size(&ptr)
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Link: https://lore.kernel.org/r/1577900990-8588-7-git-send-email-Julia.Lawall@inria.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/imx/imx8.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index aef6ca167b9c..b2556f5e2871 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -294,8 +294,7 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 	}
 
 	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap_wc(sdev->dev, res.start,
-							  res.end - res.start +
-							  1);
+							  resource_size(&res));
 	if (!sdev->bar[SOF_FW_BLK_TYPE_SRAM]) {
 		dev_err(sdev->dev, "failed to ioremap mem 0x%x size 0x%x\n",
 			base, size);
-- 
2.20.1

