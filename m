Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9982CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E66A20645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561741018;
	bh=wq35QUkea7rPx2h5PfSjEOqIZxHN1vv09znnt6mS54U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=d81P1LjHXr2+6VAn/NfGu4IpbjdcJZZZ11Dd1WahHyfcQP+yNsWW96KOU0GwczqtX
	 m5eUyi8zaRcAYCzJczuk0WeT+vOM9QGaAinJ88cOhfUe+NelycXjsUvhYPNvQMP1Jw
	 UH74fjJgwnki9ecmxWHdfgVTcJL6waL8hXL7sbkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfF1Q45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:56:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42650 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfF1Q4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=P65+glkc/PafbadJ7HPJk1X/+KIWe+VK7GZfBS57f4k=; b=AGwNTeurJVuE
        X5p/rQrkE+wZYFa/67PlyMpxDTBiBtRlRtsbrU/UH0rIQ6KgKl/Znm3hXgxoTslBvQPACExUJN40f
        kYdI5Jq0ueGNkMCsG2F/rqvnhMyvWoCrKBDGOjbNrQ+tYxBfgQ3SkILy+KdmvclsbdzXq4GsJoHCI
        snJZM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hguAm-0007Bl-Rp; Fri, 28 Jun 2019 16:56:28 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5898244004A; Fri, 28 Jun 2019 17:56:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: codecs: ad193x: Reset used registers at probe" to the asoc tree
In-Reply-To: <20190627120208.4661-2-codrin.ciubotariu@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190628165628.5898244004A@finisterre.sirena.org.uk>
Date:   Fri, 28 Jun 2019 17:56:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: ad193x: Reset used registers at probe

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

From 8af6b2291e054773e2e58b2e5dbc06e981d14296 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Thu, 27 Jun 2019 15:02:08 +0300
Subject: [PATCH] ASoC: codecs: ad193x: Reset used registers at probe

Since the ad193x codecs have no software reset, we have to reinitialize the
registers after a hardware reset to assure no previous values are kept.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index f3bab8fe3579..9615e786d049 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -427,12 +427,22 @@ static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
 		{  1, 0x04 },	/* PLL_CLK_CTRL1: no on-chip Vref */
 		{  2, 0x40 },	/* DAC_CTRL0: TDM mode */
+		{  3, 0x00 },	/* DAC_CTRL1: reset */
 		{  4, 0x1A },	/* DAC_CTRL2: 48kHz de-emphasis, unmute dac */
 		{  5, 0x00 },	/* DAC_CHNL_MUTE: unmute DAC channels */
+		{  6, 0x00 },	/* DAC_L1_VOL: no attenuation */
+		{  7, 0x00 },	/* DAC_R1_VOL: no attenuation */
+		{  8, 0x00 },	/* DAC_L2_VOL: no attenuation */
+		{  9, 0x00 },	/* DAC_R2_VOL: no attenuation */
+		{ 10, 0x00 },	/* DAC_L3_VOL: no attenuation */
+		{ 11, 0x00 },	/* DAC_R3_VOL: no attenuation */
+		{ 12, 0x00 },	/* DAC_L4_VOL: no attenuation */
+		{ 13, 0x00 },	/* DAC_R4_VOL: no attenuation */
 	};
 	const struct ad193x_reg_default reg_adc_init[] = {
 		{ 14, 0x03 },	/* ADC_CTRL0: high-pass filter enable */
 		{ 15, 0x43 },	/* ADC_CTRL1: sata delay=1, adc aux mode */
+		{ 16, 0x00 },	/* ADC_CTRL2: reset */
 	};
 	int i;
 
-- 
2.20.1

