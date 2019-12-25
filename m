Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E4BC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5131206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577232555;
	bh=m+VLykQJEzjVW7QKF0+eUcbL8TFEbKEAqBJY4iEmHec=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=smnzCAjGdN5K8X8t4TqtGtM+fYDYZKendN1nKMM5pW9IkVJw4pcA3MS9qSNsE1SpP
	 qXk/tBoHZI5BKY7oLlpEcE3kxaOIv9dNswganTHUp5/dpp5TMrKrOUzaDSHiDE2Yc1
	 nBLuk7AX7zBwQlH68ZiwXgl5pm2ky4jVRIHZZOtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfLYAJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:09:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33402 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfLYAJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mvceb9SyiTUP4LHcW1D/15nGZh8U8azDo/ToabGUuI0=; b=YlNAef+dA9GF
        /WDH90F83142fJnUkxKWS+Uz0ehvTPS6PU7UmWA479jIlMSHP3Y3JQFugFn04gzr79rgV9BRiX1Kq
        Olkz3tKJUstNGQmsqi23x56Ys1vqug9DSjjL5fHA+ufLXPwbOaUBSoLyVQhT+xgMI2z8m6ftjamiB
        sk+50=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ijuET-0007KZ-Sp; Wed, 25 Dec 2019 00:08:57 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 6D527D01A1C; Wed, 25 Dec 2019 00:08:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, bleung@chromium.org,
        broonie@kernel.org, cezary.rojewski@intel.com,
        Hulk Robot <hulkci@huawei.com>,
        kuninori.morimoto.gx@renesas.com, liam.r.girdwood@linux.intel.com,
        linux-kernel@vger.kernel.org, mac.chiang@intel.com,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        yang.jie@linux.intel.com, yuehaibing@huawei.com
Subject: Applied "ASoC: Intel: kbl_da7219_max98357a: remove unused variable 'constraints_16000' and 'ch_mono'" to the asoc tree
In-Reply-To: <20191224140237.36732-1-yuehaibing@huawei.com>
Message-Id: <applied-20191224140237.36732-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 00:08:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: kbl_da7219_max98357a: remove unused variable 'constraints_16000' and 'ch_mono'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From c5614fb8e3d13be7bba79f71b798468a3a6224f7 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 24 Dec 2019 22:02:37 +0800
Subject: [PATCH] ASoC: Intel: kbl_da7219_max98357a: remove unused variable
 'constraints_16000' and 'ch_mono'

sound/soc/intel/boards/kbl_da7219_max98357a.c:343:48:
 warning: constraints_16000 defined but not used [-Wunused-const-variable=]
sound/soc/intel/boards/kbl_da7219_max98357a.c:348:27:
 warning: ch_mono defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20191224140237.36732-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 537a88932bb6..0d55319a0773 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -336,19 +336,6 @@ static struct snd_soc_ops kabylake_dmic_ops = {
 	.startup = kabylake_dmic_startup,
 };
 
-static const unsigned int rates_16000[] = {
-	16000,
-};
-
-static const struct snd_pcm_hw_constraint_list constraints_16000 = {
-	.count = ARRAY_SIZE(rates_16000),
-	.list  = rates_16000,
-};
-
-static const unsigned int ch_mono[] = {
-	1,
-};
-
 SND_SOC_DAILINK_DEF(dummy,
 	DAILINK_COMP_ARRAY(COMP_DUMMY()));
 
-- 
2.20.1

