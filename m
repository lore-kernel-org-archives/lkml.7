Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E25C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E55213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108832;
	bh=l+fWRGYJX/ZLTa+HOgrf4WeCWOA8/Rcw3mR0ZhbhYtY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=D5yFNq8X/UKNuKn8GKJ4uxzjRED+df2yE7V4TQ4CV+2ralFNGWIfUHFvOqHEm0dQL
	 +778Uy+33M78FDpWyP+remVILX2orMnWE6QJTm7+VazfUhbfY52ovV9dBHc1/7qbwP
	 +dQ0/zxlFtRwpUqqwK6LFw0Y8tSWLp+ZbueAq5HA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfDAIxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:53:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60340 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfDAIxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RYjIQ8RhdmaHWX2SIkP6u3dDNkQ+3UQs+rAvd3XlygM=; b=YjRmdJ8KGF9K
        k/ASbXx/JXC9t+N2StO4IeOT4SPtKkBMI1jd+0LKwWzOm9oWsqeFi4EtLJjXMFa5bR8TYIwLTHIXQ
        5jjgLJRJtu2T9OTUqi6JA/cFLbCN1hlmho24+H7Sq44HGFqQy0TCAe2dvmjFVtu5TW4M8bZeG/0Xu
        87Pm4=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAsh3-0008OB-U4; Mon, 01 Apr 2019 08:53:26 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4C290440083; Mon,  1 Apr 2019 09:53:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: cs42l51: add multi endpoint support" to the asoc tree
In-Reply-To:  <1553873857-7423-1-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190401085323.4C290440083@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:53:23 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l51: add multi endpoint support

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

From ad6bb3067c4d7c684488eb9f8f8a32f623b12af3 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Fri, 29 Mar 2019 16:37:37 +0100
Subject: [PATCH] ASoC: cs42l51: add multi endpoint support

Support multiple endpoints on cs42L51 codec port
when used in of_graph context.

This patch allows to share the codec port between two CPU DAIs.

Example:

STM32MP157C-DK2 board uses CS42L51 audio codec.
This codec is connected to two serial audio interfaces,
which are configured either as rx or tx.

From AsoC point of view the topolgy is the following:
// 2 CPU DAIs (SAI2A/B), 1 Codec (CS42L51)
Playback: CPU-A-DAI(slave) -> (master)CODEC-DAI/port0
Record:   CPU-B-DAI(slave) <- (master)CODEC-DAI/port0

In the DT two endpoints have to be associated to the codec port:
cs42l51_port: port {
	cs42l51_tx_endpoint: endpoint@0 {
		remote-endpoint = <&sai2a_endpoint>;
	};
	cs42l51_rx_endpoint: endpoint@1 {
		remote-endpoint = <&sai2b_endpoint>;
	};
};

However, when the audio graph card parses the codec nodes, it expects
to find DAI interface indexes matching the endpoints indexes.

The current patch forces the use of DAI id 0 for both endpoints,
which allows to share the codec DAI between the two CPU DAIs
for playback and capture streams respectively.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index fd2bd74024c1..80da3cd73e04 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -464,6 +464,13 @@ static int cs42l51_dai_mute(struct snd_soc_dai *dai, int mute)
 	return snd_soc_component_write(component, CS42L51_DAC_OUT_CTL, reg);
 }
 
+static int cs42l51_of_xlate_dai_id(struct snd_soc_component *component,
+				   struct device_node *endpoint)
+{
+	/* return dai id 0, whatever the endpoint index */
+	return 0;
+}
+
 static const struct snd_soc_dai_ops cs42l51_dai_ops = {
 	.hw_params      = cs42l51_hw_params,
 	.set_sysclk     = cs42l51_set_dai_sysclk,
@@ -526,6 +533,7 @@ static const struct snd_soc_component_driver soc_component_device_cs42l51 = {
 	.num_dapm_widgets	= ARRAY_SIZE(cs42l51_dapm_widgets),
 	.dapm_routes		= cs42l51_routes,
 	.num_dapm_routes	= ARRAY_SIZE(cs42l51_routes),
+	.of_xlate_dai_id	= cs42l51_of_xlate_dai_id,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-- 
2.20.1

