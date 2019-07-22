Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F5C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574BF21900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbfGVV1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:27:07 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:49465 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbfGVV1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:27:07 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d78 with ME
        id fxT32000D4n7eLC03xT3dn; Mon, 22 Jul 2019 23:27:04 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Jul 2019 23:27:04 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bardliao@realtek.com, chiou@realtek.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: rt5665: Fix a typo in the name of a function
Date:   Mon, 22 Jul 2019 23:26:39 +0200
Message-Id: <20190722212639.26954-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All function names start with rt5665_, except 'rt5655_set_verf()'.
It is likely a typo.

Fix it to be consistent.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/rt5665.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index f2ad3a4c3b7f..897e53d4c40a 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -2569,7 +2569,7 @@ static int set_dmic_power(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int rt5655_set_verf(struct snd_soc_dapm_widget *w,
+static int rt5665_set_verf(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
@@ -2689,11 +2689,11 @@ static const struct snd_soc_dapm_widget rt5665_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Mic Det Power", RT5665_PWR_VOL,
 		RT5665_PWR_MIC_DET_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("Vref1", RT5665_PWR_ANLG_1, RT5665_PWR_VREF1_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		rt5665_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("Vref2", RT5665_PWR_ANLG_1, RT5665_PWR_VREF2_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		rt5665_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("Vref3", RT5665_PWR_ANLG_1, RT5665_PWR_VREF3_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		rt5665_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 
 	/* ASRC */
 	SND_SOC_DAPM_SUPPLY_S("I2S1 ASRC", 1, RT5665_ASRC_1,
-- 
2.20.1

