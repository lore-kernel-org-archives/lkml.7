Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C3DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7229F21872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365810;
	bh=N8gR5y8ZDXgzTyUmfPvp6SFd1rUgDmqMj8uduFXyoDM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=N1J/O6LzaporJGYJJbWGbbPD6kq0lVeh9uYSJGDnnGXDB8YUArlSTIrez8zF89Akl
	 9n3y5mlZXAxo72IQ4PC62hLR1fQILz7QSHQMW8Bwr+mLGDic55wgAmCF2Fl0q36YH5
	 vrLVOzUCxHl3IG2TRa0pBREUy+oVSR+uxWyS+Pig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfDDIQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:16:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50302 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfDDIQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0xj/pwOyFRetV4GBOH5TjvihbzLExIKTBnSUoPsgNhA=; b=EEuq88ZIvKdE
        Tb9BUhXwD6asFOq0KNdFyncYU1iD79fVS7fnkQ8YjhbOFkCi8vnqJ4xf76nawlyLS6s3FlccGvkHX
        EYklkTKlUCGYn3akA1Z/f00IA+94qpTnC2ETQ3CIqR08m+uX4oUBOIOw0ehPL+ESUhaSHU0igXl2S
        wsUjc=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxXy-00051E-MI; Thu, 04 Apr 2019 08:16:31 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D053A441D3C; Thu,  4 Apr 2019 15:16:27 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: sprd: Fix spelling mistake "faied" -> "failed"" to the asoc tree
In-Reply-To:  <20190404075603.11680-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081627.D053A441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:27 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sprd: Fix spelling mistake "faied" -> "failed"

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

From 47fa5773f11c7cc9117d74ea5a18a22502d8f0f3 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 4 Apr 2019 08:56:03 +0100
Subject: [PATCH] ASoC: sprd: Fix spelling mistake "faied" -> "failed"

There are two identical spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/sprd-pcm-compress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index 424e9834d093..6cddf551bc11 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -281,13 +281,13 @@ static int sprd_platform_compr_set_params(struct snd_compr_stream *cstream,
 	 */
 	ret = sprd_platform_compr_dma_config(cstream, params, 1);
 	if (ret) {
-		dev_err(dev, "faied to config stage 1 DMA: %d\n", ret);
+		dev_err(dev, "failed to config stage 1 DMA: %d\n", ret);
 		return ret;
 	}
 
 	ret = sprd_platform_compr_dma_config(cstream, params, 0);
 	if (ret) {
-		dev_err(dev, "faied to config stage 0 DMA: %d\n", ret);
+		dev_err(dev, "failed to config stage 0 DMA: %d\n", ret);
 		goto config_err;
 	}
 
-- 
2.20.1

