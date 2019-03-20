Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5CFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C397321841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553102990;
	bh=Lk7k+IPd2BHNIJS6GJnLGGAJXFtxX8lBe/H3HH8ESw8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UAn9XR9XaFZoPqt5GxOKldE3C3HIOuNsCN0mgcMSBYSfkS9YJTOruupQg5S+l/l5n
	 isNtoOHSH3HsUrv+WLN+VPoX2chNIVlbiSYTLZ95Y3zm3kiw7dCMzHjiay8zsjNKL3
	 VjGEvCaLCfk5qFyxfiruycgYI5TyltCA22Td9074=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCTR3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:29:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCTR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SfWvnPoYE5gMVl54x9lFERPTjgu2ExqSsU/pSBLeKHA=; b=oC6dnffBZ45S
        tbMo/5BQPxvG86hUko95RFbI6G8I9AVOq29L5Gs2d2Gf6REtrbTe5zUsdc6dqL8IDLGrRZBb6Ez9M
        yc2CWUrWR/5OW49lInQtezwfKp+09rBiH9Osp4Q+iqGUTCvhjYogWDoutW8t1AVb0RffuJ1VgCpUC
        6wPWs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f1j-00017z-UN; Wed, 20 Mar 2019 17:29:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3D7731126E4C; Wed, 20 Mar 2019 17:29:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: dfsdm: add mmap support" to the asoc tree
In-Reply-To:  <1551711165-28684-4-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190320172919.3D7731126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:29:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: dfsdm: add mmap support

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

From d151cf89a47666622425ff093ee97e15587acd9a Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 4 Mar 2019 15:52:45 +0100
Subject: [PATCH] ASoC: stm32: dfsdm: add mmap support

Enable direct access (mmap) support.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 47901983a6ff..1f20ff1ccb57 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -41,7 +41,7 @@ struct stm32_adfsdm_priv {
 
 static const struct snd_pcm_hardware stm32_adfsdm_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-	    SNDRV_PCM_INFO_PAUSE,
+		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_PAUSE,
 	.formats = SNDRV_PCM_FMTBIT_S32_LE,
 
 	.rate_min = 8000,
-- 
2.20.1

