Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478D6C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1666020862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558005242;
	bh=2xxMeU8NZ2/1j+KQYb+H12BiVBey0fD58KuUVodw8uU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=pkuJIZ0C36xqazGx/MRfsz3LuKceWdvO7D12B5zo7oJP3Vg+Qnk2rSHwm/rvXs6Fi
	 6Ajf1jy0gk08dRNwRf4+PG9j6QTzaoJ7JocpBNfCOF8gwQ/IGfgDMqWwKB2nvfTnCK
	 sc9errT4+h2mugfsi6iDOrjNSVLe/g3EbB66PmOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEPLOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:14:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35214 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfEPLOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fDitb6ASC9cZfIrOe4+L3fFCNtBGCfZGypMXHpNdCzE=; b=jHZ10UfMvV9D
        l7T1r16wVwTmS3N9XXlWof2CHJ9ublT6cSvnRTLqOpVyBXAXZS1AFbSIQP3I0crbhX5SP6zptG23X
        fKFjCst1afk49xhNNXDr2wI9XoduNBu2k3ufVeJyLoYpUzwiX73EQfonXOYAR2WRCajQVx9siW4+N
        GfkP4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hREKh-00066Y-2s; Thu, 16 May 2019 11:13:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9ECA01126D49; Thu, 16 May 2019 12:13:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Applied "ASoC: meson: axg-card: set link name based on link node name" to the asoc tree
In-Reply-To: <20190515131858.32130-2-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190516111354.9ECA01126D49@debutante.sirena.org.uk>
Date:   Thu, 16 May 2019 12:13:54 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-card: set link name based on link node name

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

From 1b74211011eb064914b8155a77a8aaae61cd27eb Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 15 May 2019 15:18:54 +0200
Subject: [PATCH] ASoC: meson: axg-card: set link name based on link node name

So far the link names of the axg sound card was derived from the cpu name
of the link. Since the dai link must be unique, it works as long as a
device does not provide more than one cpu dai. However, the 'tohdmitx'
does provide 2 dais used as cpu on codec-to-codec links

Instead of cpu name, use the node name of the dai link. DT already enforce
the uniqueness of this name

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-card.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index aa54d2c612c9..5c8deee8d512 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -80,10 +80,11 @@ static int axg_card_parse_dai(struct snd_soc_card *card,
 
 static int axg_card_set_link_name(struct snd_soc_card *card,
 				  struct snd_soc_dai_link *link,
+				  struct device_node *node,
 				  const char *prefix)
 {
 	char *name = devm_kasprintf(card->dev, GFP_KERNEL, "%s.%s",
-				    prefix, link->cpu_of_node->full_name);
+				    prefix, node->full_name);
 	if (!name)
 		return -ENOMEM;
 
@@ -474,7 +475,7 @@ static int axg_card_set_be_link(struct snd_soc_card *card,
 		codec++;
 	}
 
-	ret = axg_card_set_link_name(card, link, "be");
+	ret = axg_card_set_link_name(card, link, node, "be");
 	if (ret)
 		dev_err(card->dev, "error setting %pOFn link name\n", np);
 
@@ -483,6 +484,7 @@ static int axg_card_set_be_link(struct snd_soc_card *card,
 
 static int axg_card_set_fe_link(struct snd_soc_card *card,
 				struct snd_soc_dai_link *link,
+				struct device_node *node,
 				bool is_playback)
 {
 	link->dynamic = 1;
@@ -497,7 +499,7 @@ static int axg_card_set_fe_link(struct snd_soc_card *card,
 	else
 		link->dpcm_capture = 1;
 
-	return axg_card_set_link_name(card, link, "fe");
+	return axg_card_set_link_name(card, link, node, "fe");
 }
 
 static int axg_card_cpu_is_capture_fe(struct device_node *np)
@@ -527,9 +529,9 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 		return ret;
 
 	if (axg_card_cpu_is_playback_fe(dai_link->cpu_of_node))
-		ret = axg_card_set_fe_link(card, dai_link, true);
+		ret = axg_card_set_fe_link(card, dai_link, np, true);
 	else if (axg_card_cpu_is_capture_fe(dai_link->cpu_of_node))
-		ret = axg_card_set_fe_link(card, dai_link, false);
+		ret = axg_card_set_fe_link(card, dai_link, np, false);
 	else
 		ret = axg_card_set_be_link(card, dai_link, np);
 
-- 
2.20.1

