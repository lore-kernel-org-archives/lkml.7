Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166D9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00DB24AB7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559660374;
	bh=JAkTNWpl6Vnw9XnoJVZ89x7XsOw0H/wj2o7r+Fmj5Tk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=RJzEmcETywbtTqkcL9S9uEDIl6GKm0V0RFXMZ13LpvcwtstNFtxfI/sb5Kvcqd1Hn
	 4f9x2pxK+H4LRxB8JdfQheFVIvLrT2XQdzuaVTfztaIk7ZhKFiZTc8I4AJXOZlbDSS
	 5mjSPfMoU6+bke1HPnBK5BWp/a/273kF0KHpIwbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfFDO7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:59:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48736 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfFDO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RbstzphZvlrTV6oS0dsnCRyk4ToW/lQ4snN4C+vyhtE=; b=RWsKsz7nmfQ/
        u7wQuxhxavNRgyeEccQTmkwSX4SAJTO5a+2SrtQyDtYC0/eK014eSfNOSMmb7qWCTW654mOAKw5A6
        LCtvxpJ+8wOaUR2Dufse2OTcMUhxkV0zpzkmObfsfCyTP8ROhskEa2vhqRf6G9xk5eZXug0u7EA2c
        wJU9c=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYAtx-0006Eo-EN; Tue, 04 Jun 2019 14:59:01 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id E9721440049; Tue,  4 Jun 2019 15:59:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: cx2072x: remove set but not used variable 'is_right_j '" to the asoc tree
In-Reply-To: <20190525123204.16148-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190604145900.E9721440049@finisterre.sirena.org.uk>
Date:   Tue,  4 Jun 2019 15:59:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cx2072x: remove set but not used variable 'is_right_j '

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 190d9e0332ab43b28cbb1856fc73ed7fafbfad7c Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 25 May 2019 20:32:04 +0800
Subject: [PATCH] ASoC: cx2072x: remove set but not used variable 'is_right_j '

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/codecs/cx2072x.c: In function cx2072x_config_i2spcm:
sound/soc/codecs/cx2072x.c:679:6: warning: variable is_right_j set but not used [-Wunused-but-set-variable]

It's never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx2072x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 8b0830854bb3..f2cb35a50726 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -676,7 +676,6 @@ static int cx2072x_config_i2spcm(struct cx2072x_priv *cx2072x)
 	unsigned int bclk_rate = 0;
 	int is_i2s = 0;
 	int has_one_bit_delay = 0;
-	int is_right_j = 0;
 	int is_frame_inv = 0;
 	int is_bclk_inv = 0;
 	int pulse_len;
@@ -740,7 +739,6 @@ static int cx2072x_config_i2spcm(struct cx2072x_priv *cx2072x)
 
 	case SND_SOC_DAIFMT_RIGHT_J:
 		is_i2s = 1;
-		is_right_j = 1;
 		pulse_len = frame_len / 2;
 		break;
 
-- 
2.20.1

