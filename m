Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B23C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3A4206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554357877;
	bh=M58E0DaZO3tMg9CvPfpzHNVsqo5lK/IrhCAoz9HQfoc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=b6E6eEOkQOuU1bAgHurcNj/1HCsdw6yT5G1Py9vKmIyXYG+0oJ3U9BQbRZpKgWY5p
	 O3fzw6tAUNHP/MSZEPd4NpsNaShrzSZKoq2iEZX8nUnemF47kdrVA51WquQl/xQ82C
	 fZ+Gzk+xOlYnIm8eXkBd+bQo/SKZGTNO4Yjjn3SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfDDGEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:04:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54350 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=R4SX0A+rcwoCNSDHfLIJHnruiD+HVcPxqIwJeFuqaLU=; b=lceNT1GO7WRv
        wc6oWXX831Y9aL2JgeJQWkQ/dioEvvPNbUH7xvE5deFJqJqXyy1VVslHU/Oany0reiRLssj2B5CXI
        v779i0nYTxj/SWtDkVgR7Evm3T3/rO2gIgM1lda74/z0AECMB7YXQq9oUEU8h/YCTGGzwmkud0Id/
        N2pVk=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBvU8-0004Lp-D3; Thu, 04 Apr 2019 06:04:24 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 68A29441D3C; Thu,  4 Apr 2019 13:04:21 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        baolin.wang@linaro.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, dan.carpenter@oracle.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: sprd: Fix the smatch warning" to the asoc tree
In-Reply-To:  <811e491489b62624942dabd56f277b08784ef0f9.1554276741.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190404060421.68A29441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 13:04:21 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sprd: Fix the smatch warning

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

From adcc9f2b064e60f569979fb1de1f158e8bed8a6d Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 3 Apr 2019 00:47:55 -0700
Subject: [PATCH] ASoC: sprd: Fix the smatch warning

Remove the unnecessary validation of the 'cstream' variable to fix
below smatch warning:

sprd_platform_compr_drain_notify() warn: variable dereferenced
before check 'cstream' (see line 105)

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/sprd-pcm-compress.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index dc84257cffc2..424e9834d093 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -107,8 +107,7 @@ static void sprd_platform_compr_drain_notify(void *arg)
 
 	memset(stream->info_area, 0, sizeof(struct sprd_compr_playinfo));
 
-	if (cstream)
-		snd_compr_drain_notify(cstream);
+	snd_compr_drain_notify(cstream);
 }
 
 static void sprd_platform_compr_dma_complete(void *data)
-- 
2.20.1

