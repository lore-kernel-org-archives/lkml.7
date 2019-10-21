Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F73CA9EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AED020B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571680857;
	bh=XQ27IYNq1NCsCJ5Hnu9hMQycT9ViXaKYc1wjA9/rZZA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XgTH1zADLuB6lEjuRH/DJhWkl0u+EB/OyzFbm8HmyT7+E159GrmdZBsseVinq3+Pj
	 JG4GTnogYHy9ZE2L8ojtq2M5yhAKvnrMWqY002aKu5JR/uFlG7dLheq1aVdVKHOULK
	 ClEFbpTivvA0qMBjKiIwUZdHMrmiOUjX9f+MWSlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfJUSA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:00:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39018 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbfJUSAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NBKg7z/RWZPm9A3Z0ZyyZEqHwnPNJzRElLBLEbH7hrs=; b=ppfGIhq/ufNJ
        R2esk6NDpi5I8o/Z//GhcbYeNbpsuz4J6SzMaUwcPS9CX7DCG6nxq+8RXLXiKDG7gQFgvA75714Zz
        gCfs3HlRbDUP7EojhMazCdZZe+yx08O5qH/c3Sk4HgR2CgtTqGyO0TAFq3uODGQiLGhFi70Zy3xzm
        J7Q1Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMbz5-0004bq-HG; Mon, 21 Oct 2019 18:00:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E69772741DD1; Mon, 21 Oct 2019 19:00:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: msm8916-wcd-analog: Fix RX1 selection in RDAC2 MUX" to the asoc tree
In-Reply-To: <20191020153007.206070-1-stephan@gerhold.net>
X-Patchwork-Hint: ignore
Message-Id: <20191021180046.E69772741DD1@ypsilon.sirena.org.uk>
Date:   Mon, 21 Oct 2019 19:00:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: msm8916-wcd-analog: Fix RX1 selection in RDAC2 MUX

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

From 9110d1b0e229cebb1ffce0c04db2b22beffd513d Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan@gerhold.net>
Date: Sun, 20 Oct 2019 17:30:06 +0200
Subject: [PATCH] ASoC: msm8916-wcd-analog: Fix RX1 selection in RDAC2 MUX

According to the PM8916 Hardware Register Description,
CDC_D_CDC_CONN_HPHR_DAC_CTL has only a single bit (RX_SEL)
to switch between RX1 (0) and RX2 (1). It is not possible to
disable it entirely to achieve the "ZERO" state.

However, at the moment the "RDAC2 MUX" mixer defines three possible
values ("ZERO", "RX2" and "RX1"). Setting the mixer to "ZERO"
actually configures it to RX1. Setting the mixer to "RX1" has
(seemingly) no effect.

Remove "ZERO" and replace it with "RX1" to fix this.

Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20191020153007.206070-1-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 667e9f73aba3..e3d311fb510e 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -306,7 +306,7 @@ struct pm8916_wcd_analog_priv {
 };
 
 static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
-static const char *const rdac2_mux_text[] = { "ZERO", "RX2", "RX1" };
+static const char *const rdac2_mux_text[] = { "RX1", "RX2" };
 static const char *const hph_text[] = { "ZERO", "Switch", };
 
 static const struct soc_enum hph_enum = SOC_ENUM_SINGLE_VIRT(
@@ -321,7 +321,7 @@ static const struct soc_enum adc2_enum = SOC_ENUM_SINGLE_VIRT(
 
 /* RDAC2 MUX */
 static const struct soc_enum rdac2_mux_enum = SOC_ENUM_SINGLE(
-			CDC_D_CDC_CONN_HPHR_DAC_CTL, 0, 3, rdac2_mux_text);
+			CDC_D_CDC_CONN_HPHR_DAC_CTL, 0, 2, rdac2_mux_text);
 
 static const struct snd_kcontrol_new spkr_switch[] = {
 	SOC_DAPM_SINGLE("Switch", CDC_A_SPKR_DAC_CTL, 7, 1, 0)
-- 
2.20.1

