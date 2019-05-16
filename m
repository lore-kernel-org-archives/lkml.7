Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12818C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BB4206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558005248;
	bh=TqhZHdwfkO5ivrC/6wBTb10vpkHbNtbC4ec8hlXtbPY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UI9aaiuFVDQ1oxUJJfb1TIxRvx6SaRSnsMdkDDSJplOuV7RSPBgv2wpcP7tPr4QDY
	 zVYVn796Umjm39mcu0QGXwcg56hAEszMkNcFInmaapXcAAPnTLiNTPOE/8U4KvKa3t
	 QHJgB6cn/H3x9oyq1z8UFXFOv+AbmMtPJad7RUMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfEPLOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:14:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35300 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfEPLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gGP3DkbIF/cxsu+/ZUcpP5J0dMsctvEJY2qZqUFf/OY=; b=PmfERiVv7OwM
        c1fg/+1vfnyuXyd+aMEu2YjFO7cgsleOlYqvvqesOOx0xen7NfxfCWZP6yJHr9UHuE6JDi5/3QAu7
        nthGwooDQbvuMi/ZsWIMcp8tYY417GM4RUssJqIzFSYGxV4dGT8WrtrA3avuY7gT7dUNOXbDh5a+/
        XkSrE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hREKj-00066i-FY; Thu, 16 May 2019 11:13:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 07B201126D46; Thu, 16 May 2019 12:13:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Applied "ASoC: meson: axg-card: add basic codec-to-codec link support" to the asoc tree
In-Reply-To: <20190515131858.32130-5-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190516111354.07B201126D46@debutante.sirena.org.uk>
Date:   Thu, 16 May 2019 12:13:54 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-card: add basic codec-to-codec link support

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

From 0a8f1117a6803398d361e7bd76fef59c636f143b Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 15 May 2019 15:18:57 +0200
Subject: [PATCH] ASoC: meson: axg-card: add basic codec-to-codec link support

Add basic support for codec-to-codec link in the axg sound card.
The cpu side of these links is expected to properly set the hw_params
and format of the link.

ATM, only the tohdmitx glue is supported but others (like the
internal DAC glue) should follow.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-card.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 5c8deee8d512..db0a7fc18928 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -29,6 +29,18 @@ struct axg_dai_link_tdm_data {
 	struct axg_dai_link_tdm_mask *codec_masks;
 };
 
+/*
+ * Base params for the codec to codec links
+ * Those will be over-written by the CPU side of the link
+ */
+static const struct snd_soc_pcm_stream codec_params = {
+	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.rate_min = 5525,
+	.rate_max = 192000,
+	.channels_min = 1,
+	.channels_max = 8,
+};
+
 #define PREFIX "amlogic,"
 
 static int axg_card_reallocate_links(struct axg_card *priv,
@@ -517,6 +529,11 @@ static int axg_card_cpu_is_tdm_iface(struct device_node *np)
 	return of_device_is_compatible(np, PREFIX "axg-tdm-iface");
 }
 
+static int axg_card_cpu_is_codec(struct device_node *np)
+{
+	return of_device_is_compatible(np, PREFIX "g12a-tohdmitx");
+}
+
 static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 			     int *index)
 {
@@ -540,6 +557,8 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 
 	if (axg_card_cpu_is_tdm_iface(dai_link->cpu_of_node))
 		ret = axg_card_parse_tdm(card, np, index);
+	else if (axg_card_cpu_is_codec(dai_link->cpu_of_node))
+		dai_link->params = &codec_params;
 
 	return ret;
 }
-- 
2.20.1

