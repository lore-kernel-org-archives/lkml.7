Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5394C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A642B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551657989;
	bh=/8cKmXlUjiXWYk0+GKu/57XN7kzHGcicbtBXymZP5SE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PGLbMbgGm/EbMqkWJ3Q+PxjHDbqSq6X6At5uF6qVmLN3N3Q2GCC2SYpbs8Ek9TnaM
	 UwlnXc1np4ggEFUex8JZ2JQ+5Lqazo5OR9epa/fjsM+Kmsfc+SdT2Y9oeSZJHMUxzD
	 UB3MKiWGmeVdUOWqZmT6hhLOLsQomsc/kzhgoag4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfCDAGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53508 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDAGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GWqqA8xw92m6MgwvODIDMHRfxSfdZxbytWMFV6QbuRg=; b=nLuDI/AWWYFC
        Nz3R2xRhFDVECLMW5XbLUSeOSrUgv9V80RxdsCKAXQvRYZTU+dTQKsO/2uOnbw6fKbUoQSK1lTi33
        wGzyx9DtSpwno5Qb/WcXGZOzx1bszjHzSR7pKQoWPaHwRnutN330LjJ13b/DMPDObJ2Q8BE80Cbo+
        Jmn9Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b7L-0007OF-3S; Mon, 04 Mar 2019 00:06:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 66378440082; Mon,  4 Mar 2019 00:06:02 +0000 (GMT)
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
Subject: Applied "ASoC: stm32: sai: fix exposed capabilities in spdif mode" to the asoc tree
In-Reply-To:  <1551359965-25228-3-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190304000602.66378440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:02 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: fix exposed capabilities in spdif mode

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

From b8468192971807c43a80d6e2c41f83141cb7b211 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 28 Feb 2019 14:19:22 +0100
Subject: [PATCH] ASoC: stm32: sai: fix exposed capabilities in spdif mode

Change capabilities exposed in SAI S/PDIF mode, to match
actually supported formats.
In S/PDIF mode only 32 bits stereo is supported.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 506360b7bc01..e418f446e03b 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -682,6 +682,14 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 
 	sai->substream = substream;
 
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		snd_pcm_hw_constraint_mask64(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_FORMAT,
+					     SNDRV_PCM_FMTBIT_S32_LE);
+		snd_pcm_hw_constraint_single(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+	}
+
 	ret = clk_prepare_enable(sai->sai_ck);
 	if (ret < 0) {
 		dev_err(cpu_dai->dev, "Failed to enable clock: %d\n", ret);
-- 
2.20.1

