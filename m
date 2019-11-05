Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E11C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD960204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572980129;
	bh=9D3y5IVc0Cdhd0Dgs00PzxIFl0KZgCCUWC6wNfyvr1k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fgOPN8tBIo+DxZO8d+zfSYI7S1wadhdJ421bqtK1mPl8kfqD8Is6o6XZiMPRciyeJ
	 3XvxgF4btfXWdGeA/VhQ853zR2f8CBwzTVy5bBp/wL62im76mlbIN0nnuQrHaE1JHL
	 9ZRxFtvJ94ahQ1fn1LLisuHEcpaj3SUHBMD0xDHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390836AbfKESz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:55:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36482 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390651AbfKESz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dcXKl/0UqJ+dCjeE5w/EDI2rZhDXMA0VO2ph2g/2lKo=; b=YkXoDtn0mNp3
        jFthqMO+OvdjD02O8vSt6QOaYPW6A2o/HfrkS1KnXTTHqzmAJmr6M16eewkN96qkeu3oNTOX3O1ed
        hqBjH5+GIdql2zgffYYMjNS78o0IXbse7cvkL9co0/585HrS3ftkHrcJIsy1nelXT1wmAcZh3rnxx
        zf7Xw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iS3z0-0007Pi-Ja; Tue, 05 Nov 2019 18:55:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 91F312743284; Tue,  5 Nov 2019 18:55:12 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: sai: add restriction on mmap support" to the asoc tree
In-Reply-To: <20191104133654.28750-1-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20191105185512.91F312743284@ypsilon.sirena.org.uk>
Date:   Tue,  5 Nov 2019 18:55:12 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: add restriction on mmap support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From eaf072e512d54c95b0977eda06cbca3151ace1e5 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 4 Nov 2019 14:36:54 +0100
Subject: [PATCH] ASoC: stm32: sai: add restriction on mmap support

Do not support mmap in S/PDIF mode. In S/PDIF mode
the buffer has to be copied, to allow the channel status
bits insertion.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20191104133654.28750-1-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index a4060813bc74..48e629ac2d88 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1218,6 +1218,16 @@ static int stm32_sai_pcm_process_spdif(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+/* No support of mmap in S/PDIF mode */
+static const struct snd_pcm_hardware stm32_sai_pcm_hw_spdif = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED,
+	.buffer_bytes_max = 8 * PAGE_SIZE,
+	.period_bytes_min = 1024,
+	.period_bytes_max = PAGE_SIZE,
+	.periods_min = 2,
+	.periods_max = 8,
+};
+
 static const struct snd_pcm_hardware stm32_sai_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP,
 	.buffer_bytes_max = 8 * PAGE_SIZE,
@@ -1270,7 +1280,7 @@ static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config = {
 };
 
 static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config_spdif = {
-	.pcm_hardware = &stm32_sai_pcm_hw,
+	.pcm_hardware = &stm32_sai_pcm_hw_spdif,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
 	.process = stm32_sai_pcm_process_spdif,
 };
-- 
2.20.1

