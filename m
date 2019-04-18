Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD58C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193CC214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555583207;
	bh=G1RK4PmhvqS8Q85ubVZmKD8MWBiQ+ew21zhTkhVn0oo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=x8cB1rGyoyelxnxX9yM7SulNVl7yT4WlbxZ/khaYzObXoxc8jCuSKtrQ1y8ifKUI7
	 JKbswVAs4oo9D38JQ8Md8yZkggHsHBxJupQTNIh7aGRsZ7zti9fguGdNUBeIUgqsTo
	 xLfu8Y7O6eAKZ8F+BJxCjY1nea0V5Y2lL7f6Bvek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbfDRK0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:26:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44730 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbfDRK0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4i1wz0+hDHyXvG9MYVIMKr5rG0BDsWVAErtStvBHo6w=; b=hzHHJ6x7y2Fn
        sIrF/o4QTODvjsoTroKnq6iOJTaWEMnZLU2fOJQqkKX4J7bCqVgzqENfiewMIDKT30yJmf1v7SXws
        wSbf8ty9+QUnaDjVAtl56kk6Vs1dhMPgHZakJxr96vjtpjN3g6qFamAf7aHN9mQKY0jjaeLiCBAtl
        T2Euk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hH4F5-0001TF-He; Thu, 18 Apr 2019 10:26:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AE0181126DA9; Thu, 18 Apr 2019 11:26:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     alsa-devel@alsa-project.org, baolin.wang@linaro.org,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        orsonzhai@gmail.com, perex@perex.cz, tiwai@suse.com,
        zhang.lyra@gmail.com
Subject: Applied "ASoC: sprd: Add reserved DMA memory support" to the asoc tree
In-Reply-To: <ee4a22c3491628abf94c8d356dccd67984604811.1555049554.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190418102606.AE0181126DA9@debutante.sirena.org.uk>
Date:   Thu, 18 Apr 2019 11:26:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sprd: Add reserved DMA memory support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From 25a073bb9ceda91b8bf731b20ac01b68cc8877a9 Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 12 Apr 2019 14:40:17 +0800
Subject: [PATCH] ASoC: sprd: Add reserved DMA memory support

For Spreadtrum audio platform driver, it need allocate a larger DMA buffer
dynamically to copy audio data between userspace and kernel space, but that
will increase the risk of memory allocation failure especially the system
is under heavy load situation.

To make sure the audio can work in this scenario, we usually reserve one
region of memory to be used as a shared pool of DMA buffers for the
platform component. So add of_reserved_mem_device_init_by_idx() function
to initialize the shared pool of DMA buffers to be used by the platform
component.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/sprd-pcm-dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index 9be6d4b2bf74..d38ebbbbf169 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -6,6 +6,7 @@
 #include <linux/dma/sprd-dma.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -530,8 +531,14 @@ static const struct snd_soc_component_driver sprd_soc_component = {
 
 static int sprd_soc_platform_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
+	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	if (ret)
+		dev_warn(&pdev->dev,
+			 "no reserved DMA memory for audio platform device\n");
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &sprd_soc_component,
 					      NULL, 0);
 	if (ret)
-- 
2.20.1

