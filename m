Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D55ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E07206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570472030;
	bh=I5x8Xalnbu26Om59lzNllqOpqqVCclxULQzJ+QvxKr0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VV/HKgbOExzZqYBD7nQupBvckazqnqQ9hA5umc/6Kax3Ywk8Q9+Lts+twXodwffQK
	 um/zTWVP5k8NYaaCI09EuPgLmnNM8AOrmBqcBKUfl3hN0eqjYP+wmWvov1qCzOhK8e
	 FP3XlDW/+jadoP+yqTcAo/RjtcrSVARLo9IJyluM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfJGSNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:13:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34632 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGSNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=F/519QCZ2cPEiTPBsN/gfjftRPvGaCJLTY4nnrMZONU=; b=xAoCDiDeBOBg
        +yP/gYICl4E0AJFQbECVzr+VI3P783zvguMUugFprIVgZnMp+zQ0wgxOjCeRrJHL5xZLyFJvXmce4
        ovZUxARgZunEn1df47fHhCNwKGpozH+DyUQT69MvI7xYyg4U02b0hNHmJYgnVUNS3ygEGJwJhhOQ1
        69Lxc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHXVe-0004GF-8B; Mon, 07 Oct 2019 18:13:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B7D8E2741EF0; Mon,  7 Oct 2019 19:13:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, navada@ti.com, perex@perex.cz,
        shifu0704@thundersoft.com, tiwai@suse.com
Subject: Applied "ASoC: tas2770: Remove unneeded read of the TDM_CFG3 register" to the asoc tree
In-Reply-To: <20191007171157.17813-2-dmurphy@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007181325.B7D8E2741EF0@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 19:13:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tas2770: Remove unneeded read of the TDM_CFG3 register

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 5911e6729e0886a3fb00b897b73892134d37158a Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Mon, 7 Oct 2019 12:11:56 -0500
Subject: [PATCH] ASoC: tas2770: Remove unneeded read of the TDM_CFG3 register

Remove the unneeded and incorrect read of the TDM_CFG3 register.
The read is done but the value is never used.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: https://lore.kernel.org/r/20191007171157.17813-2-dmurphy@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2770.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 15f6fcc6d87e..f3a665b64fd6 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -374,7 +374,6 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	u8 tdm_rx_start_slot = 0, asi_cfg_1 = 0;
 	int ret;
-	int value = 0;
 	struct snd_soc_component *component = dai->component;
 	struct tas2770_priv *tas2770 =
 			snd_soc_component_get_drvdata(component);
@@ -430,8 +429,6 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret)
 		return ret;
 
-	value = snd_soc_component_read32(component, TAS2770_TDM_CFG_REG3);
-
 	tas2770->asi_format = fmt;
 
 	return 0;
-- 
2.20.1

