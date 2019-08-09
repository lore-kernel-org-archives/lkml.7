Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4064CC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FD4208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565353938;
	bh=F3gH/2U5N508N96Fa0WPfRL9AkWww6dcYeAo+KlnLJ0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2TxYZoXmRyfJN2lwZEIdbRJF1C8zV/jpIne8NaLEslCpkKUxMFtZRGH+eonEQuX9H
	 xz1G39N/9BlJRcI8zEpHcAANNr6rQWMjIrGqH4BbDjQz6U4xP5pQhCF310cdbjN22U
	 VfJsNPiwqs+obyetFgmjNJfjrmVG3ymUdPTOsGIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436466AbfHIMcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:32:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59406 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406996AbfHIMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KkMWdWdaZPGt8q4/51AC+gNMwtToOnoRdH8VMCOgM9g=; b=O18c1zr3Vr1e
        BraQLZz7D3x4DwmSGP0bu0tuanXkRWnksVm1bAyMpDE4gydDcGA77mL1l0v+UbBgCrTfMatTh0H7j
        d86REthYs9NGJrb/ZSN3hhlvcZXMIoJcpx44MJo3CL/uTXNlaKWsndN9aF56690R6YSnZJi7Y24xV
        vua5Q=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hw43l-00061B-Ag; Fri, 09 Aug 2019 12:31:53 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AA2A0274303D; Fri,  9 Aug 2019 13:31:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        tiwai@suse.com
Subject: Applied "ASoC: mt6351: remove unused variable 'mt_lineout_control'" to the asoc tree
In-Reply-To: <20190809080234.23332-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190809123152.AA2A0274303D@ypsilon.sirena.org.uk>
Date:   Fri,  9 Aug 2019 13:31:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mt6351: remove unused variable 'mt_lineout_control'

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

From bc8d9f737fc01cce913f1cc215b7e66f01697e52 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 9 Aug 2019 16:02:34 +0800
Subject: [PATCH] ASoC: mt6351: remove unused variable 'mt_lineout_control'

sound/soc/codecs/mt6351.c:1070:38: warning:
 mt_lineout_control defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190809080234.23332-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mt6351.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index 4b3ce01c5a93..5c0536eb1044 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1066,11 +1066,6 @@ static int mt_mic_bias_2_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-/* DAPM Kcontrols */
-static const struct snd_kcontrol_new mt_lineout_control =
-	SOC_DAPM_SINGLE("Switch", MT6351_AUDDEC_ANA_CON3,
-			RG_AUDLOLPWRUP_VAUDP32_BIT, 1, 0);
-
 /* DAPM Widgets */
 static const struct snd_soc_dapm_widget mt6351_dapm_widgets[] = {
 	/* Digital Clock */
-- 
2.20.1

