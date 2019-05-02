Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3395CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030F221479
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763562;
	bh=czJ2gGl1dfjH/l57awPvh4sM5OwFICV7oNoavQNVK2Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mjrHE9ALc6ObtkduurnozbM3dDdxunxMSyZesfoJRULpn3vm51iX9uDMQfMvLXoTV
	 eq1GtvENNoDtLj9I3Bq5I5S78mohlQ9qUe1lMmVnMSE854i7bneznO9Sxo+gE85XwR
	 Z4fWa529ffPzHH3afe/+PjHgUz7b9CO3hEC2VfdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEBCTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:19:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfEBCTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UHEfdzY2SRblr5bwZcw14SwkQj4L3ql7iy+ou6Q9jpY=; b=RRkiWZznDnkq
        9i1BJ9BDacg3nhd5+AAC2FWqBYdHF0aOqh+HPw+42Kz5ePNCW35qSAWdrWOKRiPGQaatodjC9RWxf
        2s09OxcrRo5I/lxpff9XGc64maZTWk4ByZSDzlu/VUOjftvzNCzhieVUtYOetI+ev9D90owDQk804
        z8VnM=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1J3-0005sr-SV; Thu, 02 May 2019 02:18:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BE8A2441D3B; Thu,  2 May 2019 03:18:38 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        colin.king@canonical.com, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, maruthi.bayyavarapu@amd.com,
        perex@perex.cz, tiwai@suse.com, Vijendar.Mukunda@amd.com
Subject: Applied "ASoC: amd: acp3x: Make acp3x_dai_i2s_ops static" to the asoc tree
In-Reply-To:  <20190416145251.16800-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021838.BE8A2441D3B@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:38 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: acp3x: Make acp3x_dai_i2s_ops static

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

From a1a86e1bd4a87fd09171fd8555fe7490917e4e94 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 16 Apr 2019 22:52:51 +0800
Subject: [PATCH] ASoC: amd: acp3x: Make acp3x_dai_i2s_ops static

Fix sparse warning:

sound/soc/amd/raven/acp3x-pcm-dma.c:561:24: warning:
 symbol 'acp3x_dai_i2s_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 1a2e15ff1456..9775bda2a4ca 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -558,7 +558,7 @@ static int acp3x_dai_i2s_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
+static struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
 	.hw_params = acp3x_dai_i2s_hwparams,
 	.trigger   = acp3x_dai_i2s_trigger,
 	.set_fmt = acp3x_dai_i2s_set_fmt,
-- 
2.20.1

