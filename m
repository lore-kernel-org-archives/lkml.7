Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C09CC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E542F20644
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563881378;
	bh=sU4oGUG2lyh9uiIu/jvXRl26Q8S14NWExxm2BjTV2eM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=p4znQ3cSS8P6lHol4tX2QF6H0OyPmzjsvooNTjqCTXKK1BfoeMpLsIsg2GmTHckIa
	 fqpb8zqKICNOvBJQX192533IgXkun2F7EcQegHUFMrA1rIRKyhX2ZCRkdXTO5DXEw0
	 IfdAURI4KYPbybnEOM3dadxkHmgOZ9b2KLRG5U/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbfGWL32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:29:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46442 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387541AbfGWL30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uW8mLkBNzzRIUGgBhcROR5IPwDhjQ5ZLJDLiCjkF0r0=; b=o+GutVd3z7jP
        8thUV9hTXmaYYo0frBFgoO9tBy26F516R0a6nN42ioBP4lyEw1BlhYJpsyurMAFQE6pBngx6pboxK
        Mb6RjEszP6AWe39zPawJLb/oRuXA5AHMvKgZTW1GoNnc15uDrGZnHjl+C31Zvvv5wbSZx6U1e8pLo
        52R0c=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpsyq-0003KX-3p; Tue, 23 Jul 2019 11:29:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 71C2D2742B60; Tue, 23 Jul 2019 12:29:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        peter.ujfalusi@ti.com, tglx@linutronix.de, tiwai@suse.com,
        wang@mentor.com
Subject: Applied "ASoC: pcm3168a: Fix a typo in the name of a constant" to the asoc tree
In-Reply-To: <20190722211528.26600-1-christophe.jaillet@wanadoo.fr>
X-Patchwork-Hint: ignore
Message-Id: <20190723112915.71C2D2742B60@ypsilon.sirena.org.uk>
Date:   Tue, 23 Jul 2019 12:29:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pcm3168a: Fix a typo in the name of a constant

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

From f8f85216f8d309daadb37aba8a4b0826783d8747 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 22 Jul 2019 23:15:28 +0200
Subject: [PATCH] ASoC: pcm3168a: Fix a typo in the name of a constant

There is a typo in PCM1368A_MAX_SYSCLK, it should be PCM3168A_MAX_SYSCLK
(1 and 3 switched in 3168)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20190722211528.26600-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index f1104d7d6426..5d59ce254821 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -263,7 +263,7 @@ static unsigned int pcm3168a_scki_ratios[] = {
 #define PCM3168A_NUM_SCKI_RATIOS_DAC	ARRAY_SIZE(pcm3168a_scki_ratios)
 #define PCM3168A_NUM_SCKI_RATIOS_ADC	(ARRAY_SIZE(pcm3168a_scki_ratios) - 2)
 
-#define PCM1368A_MAX_SYSCLK		36864000
+#define PCM3168A_MAX_SYSCLK		36864000
 
 static int pcm3168a_reset(struct pcm3168a_priv *pcm3168a)
 {
@@ -296,7 +296,7 @@ static int pcm3168a_set_dai_sysclk(struct snd_soc_dai *dai,
 	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(dai->component);
 	int ret;
 
-	if (freq > PCM1368A_MAX_SYSCLK)
+	if (freq > PCM3168A_MAX_SYSCLK)
 		return -EINVAL;
 
 	ret = clk_set_rate(pcm3168a->scki, freq);
-- 
2.20.1

