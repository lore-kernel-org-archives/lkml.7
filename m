Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85333C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EAE21721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567165535;
	bh=bDvL4oj/qiplFE/Ojz554Nt8tf/M53LMearfTBYdXHs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JbGOoC51vKidvhGl7KCn4TiQqnLhX6g8BgGld6loLNE4fJO7yXJG6dSUsxg+ZgDtt
	 hh5ANwd1tKrtDIs3C3t80OhTRQZzD1an2u4EW1BKXPv5p88aAvu8R4sGM8vL8Y1V6m
	 nARLpIBNlvDhMAyHqvefoO1vJSbZv3afow7Qs4Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfH3Lpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:45:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42686 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfH3Lpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QjPKEdDB9sCJJLsmrlg6e6hB1mOM3Pkslxq2I1phBfw=; b=Jlx4pGUUKv/H
        7TLy34v8F8kpMKglTqTATjOIIYARUIpwZuU5MNu+f4CaCohs4TSZa3SanmORostsdtFwOww1DzNQx
        YIhwuZpJ3ZHSNlF1KRQxNR6XP+oSI7ZA5rx8xuGb3ZbboPBfIvTY1GLrY8HEQTJHbGysSf8Xoz6ag
        pqUf4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3fLE-0006Iq-4M; Fri, 30 Aug 2019 11:45:20 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8C9522742CDC; Fri, 30 Aug 2019 12:45:19 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        festevam@gmail.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com,
        perex@perex.cz, timur@kernel.org, tiwai@suse.com,
        Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_ssi: Fix clock control issue in master mode" to the asoc tree
In-Reply-To: <1567012817-12625-1-git-send-email-shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190830114519.8C9522742CDC@ypsilon.sirena.org.uk>
Date:   Fri, 30 Aug 2019 12:45:19 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_ssi: Fix clock control issue in master mode

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

From 696d05225cebffd172008d212657be90e823eac0 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Wed, 28 Aug 2019 13:20:17 -0400
Subject: [PATCH] ASoC: fsl_ssi: Fix clock control issue in master mode

The test case is
arecord -Dhw:0 -d 10 -f S16_LE -r 48000 -c 2 temp.wav &
aplay -Dhw:0 -d 30 -f S16_LE -r 48000 -c 2 test.wav

There will be error after end of arecord:
aplay: pcm_write:2051: write error: Input/output error

Capture and Playback work in parallel in master mode, one
substream stops, the other substream is impacted, the
reason is that clock is disabled wrongly.

The clock's reference count is not increased when second
substream starts, the hw_param() function returns in the
beginning because first substream is enabled, then in end
of first substream, the hw_free() disables the clock.

This patch is to move the clock enablement to the place
before checking of the device enablement in hw_param().

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1567012817-12625-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fa862af25c1a..085855f9b08d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -799,15 +799,6 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	u32 wl = SSI_SxCCR_WL(sample_size);
 	int ret;
 
-	/*
-	 * SSI is properly configured if it is enabled and running in
-	 * the synchronous mode; Note that AC97 mode is an exception
-	 * that should set separate configurations for STCCR and SRCCR
-	 * despite running in the synchronous mode.
-	 */
-	if (ssi->streams && ssi->synchronous)
-		return 0;
-
 	if (fsl_ssi_is_i2s_master(ssi)) {
 		ret = fsl_ssi_set_bclk(substream, dai, hw_params);
 		if (ret)
@@ -823,6 +814,15 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
+	/*
+	 * SSI is properly configured if it is enabled and running in
+	 * the synchronous mode; Note that AC97 mode is an exception
+	 * that should set separate configurations for STCCR and SRCCR
+	 * despite running in the synchronous mode.
+	 */
+	if (ssi->streams && ssi->synchronous)
+		return 0;
+
 	if (!fsl_ssi_is_ac97(ssi)) {
 		/*
 		 * Keep the ssi->i2s_net intact while having a local variable
-- 
2.20.1

