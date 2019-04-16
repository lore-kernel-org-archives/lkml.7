Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2116C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CC520821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555432404;
	bh=zmnxKo+PXBuq3tt/zHFmlv1hG90QECVMflPMSZiafb4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=APwVyRut7qtxoPkx1aFXjHmo+xn94GhZly1SVhamAUyrcxgKI5qOW9JGur5kEDkIY
	 ZSq4dM0mwVkl6WROnXfcuINujzdbmy/o6LWoEGnwQwLpS0QUxJTPZH5c+LC+kJisJ5
	 CYbjI4Qz5WlkXUwVf23ZFElhC3M7sSSq+rT4qfxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfDPQdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:33:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33280 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbfDPQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0Q5rjXF9vuYwcWpx/AeS+oJDcKPcWIw6C5G87zEHQR4=; b=Qi9h7gX/z/Af
        Np36WmzBH1xrqX59hEpBOuo55v48VmfW5aYcwYiXa+qFKYbHw78Hb1Rlot9UbQ4RxNyK71NR5Fy+q
        XUX8+W2/TbYMYGENZwKUzGj0abPFLpPsZ8/U20akXDyuc0w6kTLvdjcqvjl3PVaJVnj8OAs5/9Smo
        f0IJA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGR14-0007rX-CA; Tue, 16 Apr 2019 16:33:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 39C7A1127D45; Tue, 16 Apr 2019 17:32:56 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        colin.king@canonical.com, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, maruthi.bayyavarapu@amd.com,
        perex@perex.cz, tiwai@suse.com, Vijendar.Mukunda@amd.com
Subject: Applied "ASoC: amd: acp3x: Make acp3x_dai_i2s_ops static" to the asoc tree
In-Reply-To: <20190416145251.16800-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190416163256.39C7A1127D45@debutante.sirena.org.uk>
Date:   Tue, 16 Apr 2019 17:32:56 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: acp3x: Make acp3x_dai_i2s_ops static

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

From dc11607e151bd85b17c8e03d1bf823febd5e3c40 Mon Sep 17 00:00:00 2001
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

