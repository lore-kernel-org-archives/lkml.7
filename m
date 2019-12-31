Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C42C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFE3206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577752249;
	bh=blw4x22xrbNI+tZkdMxAL/mwV97EzQUolmSdLgpbZy4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XxHti+tUHxrmrBKqbupPrf1Z5YGlRLBdY8MZEvZx09cAftPgMcG30AD4Io/1/3R+M
	 FbMVGM3XNINSJgLEyZwNAr/rpm+aZ8P9IOXlaTEKf1q1T/2lp6rUS5TesZwLrCJzHz
	 gQbDa3jrbls8P3LIrkNxAg9wuHSTLdFqLvdJ9wXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfLaAat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:30:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46334 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfLaAap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=x+tq/P7MFfoTpVq1wYknSSh2xy/H5XU8JlazuogWVHk=; b=CoYuxl0dN7iT
        P40XlnMV5r4YAQ9ds2ivLwaOQY47y5JejlvuhA8Ow4Cjbb1UWUZAS5P8xBezQkcT31EKXVEtBZSrs
        3IKLbnNXxZCorckVPXXOgXKZzK6xd5GXF1HPOqJestGlrAClerK5oszgce+LXrj6nyGRdJvIMIcEY
        a/N+M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1im5Qf-0002nS-Mm; Tue, 31 Dec 2019 00:30:33 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 41A01D01A22; Tue, 31 Dec 2019 00:30:33 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, "Cc:"@sirena.org.uk, "Cc:"@sirena.org.uk,
        Colin Ian King <colin.king@canonical.com>,
        djkurtz@google.com, Gustavo@sirena.org.uk,
        Jaroslav Kysela <perex@perex.cz>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam@sirena.org.uk, Mark Brown <broonie@kernel.org>,
        moderated@sirena.org.uk, "list:SOUND"@sirena.org.uk,
        -@sirena.org.uk, SOC@sirena.org.uk, LAYER@sirena.org.uk,
        /@sirena.org.uk, DYNAMIC@sirena.org.uk, AUDIO@sirena.org.uk,
        open list <linux-kernel@vger.kernel.org>,
        Takashi@sirena.org.uk, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Applied "ASoC: amd MMAP_INTERLEAVED Support" to the asoc tree
In-Reply-To: <1577540460-21438-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Message-Id: <applied-1577540460-21438-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Patchwork-Hint: ignore
Date:   Tue, 31 Dec 2019 00:30:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd MMAP_INTERLEAVED Support

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

From 3d8cbeda38f1cc51733715f0a02b338b4f75fad0 Mon Sep 17 00:00:00 2001
From: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Date: Sat, 28 Dec 2019 19:11:00 +0530
Subject: [PATCH] ASoC: amd MMAP_INTERLEAVED Support

ACP-I2S device support MMAP_INTERLEAVED.
Added support for the same.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Link: https://lore.kernel.org/r/1577540460-21438-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 151daa996343..5c3ec3c58e3b 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -21,6 +21,7 @@ static const struct snd_pcm_hardware acp3x_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_BATCH |
+		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
 		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE |
@@ -41,7 +42,8 @@ static const struct snd_pcm_hardware acp3x_pcm_hardware_capture = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_BATCH |
-	    SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
+		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
 		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE |
 		   SNDRV_PCM_FMTBIT_S32_LE,
-- 
2.20.1

