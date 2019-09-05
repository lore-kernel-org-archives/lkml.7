Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DFEC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B0E2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567705140;
	bh=qdUtODjRP0Sn12RGPqJ6n/iCg+SYqJl3zPuVkzF3kXQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FaVc/etqEKHBYsbsZA9IHSqm4VJ4nscE6Lb5gjHKDj1fpLqtyV4Alu8HPpKnBffiJ
	 LYCTNtOr/cHTSRd30Zixi4V5CIxsZzZnXPnVgDDHpwlLHr6dompSrs9qtweg8LO1Kx
	 RsxGIhxXi7Ud0rKj3qLKV+aV4NVyTta8d4wFRDxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391058AbfIERi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:38:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57388 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388532AbfIERi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ljHBBcXn0yOXcfNaI4omwuko81HgbCKJ7rDg1PwuE4s=; b=NGKVfE4OpCaE
        mlV5gsTrUfcF3nHlEYssk2XsLOYfuwYYpRVfQcRRLf8Z2acpxS9njkv7nscC8q9fzvWVnsh0GcKvf
        6W7nl0/iYthZNl0rjnFExMvYgY2rna40BZAmKWrx+0WmBnuy52+wVuwZinqETV89S3x6j1BXiJayX
        zqgvc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5vie-0005Go-SW; Thu, 05 Sep 2019 17:38:52 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3FF342742D07; Thu,  5 Sep 2019 18:38:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-toddr: expose all 8 inputs" to the asoc tree
In-Reply-To: <20190905120120.31752-5-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190905173852.3FF342742D07@ypsilon.sirena.org.uk>
Date:   Thu,  5 Sep 2019 18:38:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-toddr: expose all 8 inputs

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

From 6beced211c22dd8c3e546c956512fddd8e09884f Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 5 Sep 2019 14:01:16 +0200
Subject: [PATCH] ASoC: meson: axg-toddr: expose all 8 inputs

The TODDR component, as it, has a maximum of 8 input. Depending on
the SoC, these may not all be connected or some input components may
not be supported

Instead of decribing only the connected inputs, describe them all
and let ASoC routing do the rest.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190905120120.31752-5-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-toddr.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index 4f63e434fad4..2e9a2e5862ce 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -142,16 +142,11 @@ static struct snd_soc_dai_driver axg_toddr_dai_drv = {
 };
 
 static const char * const axg_toddr_sel_texts[] = {
-	"IN 0", "IN 1", "IN 2", "IN 3", "IN 4", "IN 6"
+	"IN 0", "IN 1", "IN 2", "IN 3", "IN 4", "IN 5", "IN 6", "IN 7"
 };
 
-static const unsigned int axg_toddr_sel_values[] = {
-	0, 1, 2, 3, 4, 6
-};
-
-static SOC_VALUE_ENUM_SINGLE_DECL(axg_toddr_sel_enum, FIFO_CTRL0,
-				  CTRL0_SEL_SHIFT, CTRL0_SEL_MASK,
-				  axg_toddr_sel_texts, axg_toddr_sel_values);
+static SOC_ENUM_SINGLE_DECL(axg_toddr_sel_enum, FIFO_CTRL0, CTRL0_SEL_SHIFT,
+			    axg_toddr_sel_texts);
 
 static const struct snd_kcontrol_new axg_toddr_in_mux =
 	SOC_DAPM_ENUM("Input Source", axg_toddr_sel_enum);
@@ -163,7 +158,9 @@ static const struct snd_soc_dapm_widget axg_toddr_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("IN 2", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("IN 3", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("IN 4", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 5", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("IN 6", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 7", NULL, 0, SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_dapm_route axg_toddr_dapm_routes[] = {
@@ -173,7 +170,9 @@ static const struct snd_soc_dapm_route axg_toddr_dapm_routes[] = {
 	{ "SRC SEL", "IN 2", "IN 2" },
 	{ "SRC SEL", "IN 3", "IN 3" },
 	{ "SRC SEL", "IN 4", "IN 4" },
+	{ "SRC SEL", "IN 5", "IN 5" },
 	{ "SRC SEL", "IN 6", "IN 6" },
+	{ "SRC SEL", "IN 7", "IN 7" },
 };
 
 static const struct snd_soc_component_driver axg_toddr_component_drv = {
-- 
2.20.1

