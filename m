Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F9EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F9720870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708646;
	bh=4M5EGwCPrt7E9EtK6NeVtmMxlNoR7PxH2gEq2cp9Jg0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wLLrnL4iKbaTT33jnYCTNgAcMnzEhAUaRRyYuG8AMVXmO1pGRwR46gNUjgwAZ6o8/
	 9aEVmayRHyIoE2RrASNCkA6dd9rBRUDQpyqEYPSYWQoRH8payRLwsTyk67oKM5mn9d
	 k53uxZ1cY/8W2LKKYeGb21uI7YbQwySnoobPlfw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDHHao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:30:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41438 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHHao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aV/7tX/DmZrazI7qKGVZyvFjmHbgVorKqbmO4OzxlSc=; b=nMC8quD/mXY1
        GvBDHVXsmg4cEJVd3eiPyu9peo/DS2UfR3E1hTA39k+us4P0UFYKqogL/3OEWMUy7LEloX3HPk8EK
        jDCYHml9JHOzYV93GEYRDI9g3KyVVvmJXI2p3TL0EscoiVAOXVxTftVrqEnJuHhlGIaFwz5DfaALk
        hvgdU=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOjO-0003ug-M4; Mon, 08 Apr 2019 07:30:15 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F0485441D3C; Mon,  8 Apr 2019 14:29:59 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>, Liam@sirena.org.uk,
        Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi@sirena.org.uk, Iwai <tiwai@suse.com>,
        arnaud.pouliquen@st.com, Olivier Moysan <olivier.moysan@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: fix sai driver name initialisation" to the asoc tree
In-Reply-To:  <1554455951-2755-1-git-send-email-arnaud.pouliquen@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072959.F0485441D3C@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:29:59 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: fix sai driver name initialisation

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

From 17d3069ccf06970e2db3f7cbf4335f207524279e Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Fri, 5 Apr 2019 11:19:11 +0200
Subject: [PATCH] ASoC: stm32: fix sai driver name initialisation

This patch fixes the sai driver structure overwriting which results in
a cpu dai name equal NULL.

Fixes: 3e086ed ("ASoC: stm32: add SAI driver")

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 55d802f51c15..83d8a7ac56f4 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1419,7 +1419,6 @@ static int stm32_sai_sub_dais_init(struct platform_device *pdev,
 	if (!sai->cpu_dai_drv)
 		return -ENOMEM;
 
-	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
 	if (STM_SAI_IS_PLAYBACK(sai)) {
 		memcpy(sai->cpu_dai_drv, &stm32_sai_playback_dai,
 		       sizeof(stm32_sai_playback_dai));
@@ -1429,6 +1428,7 @@ static int stm32_sai_sub_dais_init(struct platform_device *pdev,
 		       sizeof(stm32_sai_capture_dai));
 		sai->cpu_dai_drv->capture.stream_name = sai->cpu_dai_drv->name;
 	}
+	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
 
 	return 0;
 }
-- 
2.20.1

