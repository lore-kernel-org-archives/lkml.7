Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74F4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732E82147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491550;
	bh=uoyvcnHzjWrNWVVTPHX21c3p638QO8DLdQx7OyScl7c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=z5GobhI/BKqGjvdMuJi912zuUkisLTJILAg7xr4Wc/VZFs8/6dHdZ5uZhYwsUMoWk
	 kd4G643jUAU+OyZKw3DRn5LGZc0mVE45E/fHaPL45vZuIm4Ef23vomy1iFDs4uJiEb
	 mpMNMxKZoUW5nmQBB4AwFSKXEA14r3hfpeft8GhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfCMPjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49538 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfCMPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BMelY5BHaMGtrKjDHAbn5iQmGhdPaeBVqHghbF2/TMU=; b=thYx6liZHxMK
        kGDMp1RSAC6CypBvPxYEhwHnlYxLw0JAEBEzt6ueGMJVC+cSkpEMT4e864IE9yMzzvOkg5I0eqReF
        HpVuc6BT8Ffj77btdysQ+7ULj9qcJQ5GRLApaVEJKbRVOmaVcXNVRbEni4dGbkuF/qWqfNie+Vgai
        OnGW4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45xu-0003Qf-RN; Wed, 13 Mar 2019 15:38:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 61BD01128B98; Wed, 13 Mar 2019 15:38:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: i2s: use default dai name" to the asoc tree
In-Reply-To:  <1552317990-24219-4-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190313153846.61BD01128B98@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:38:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: i2s: use default dai name

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

From fef050c88ce1cbec1ab9a0d981b5331a5ba40f15 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 11 Mar 2019 16:26:30 +0100
Subject: [PATCH] ASoC: stm32: i2s: use default dai name

Use default DAI name based on dev_name function.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 06bbbef74b3a..c18e068c1a0d 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -179,7 +179,6 @@ enum i2s_datlen {
 	I2S_I2SMOD_DATLEN_32,
 };
 
-#define STM32_I2S_DAI_NAME_SIZE		20
 #define STM32_I2S_FIFO_SIZE		16
 
 #define STM32_I2S_IS_MASTER(x)		((x)->ms_flg == I2S_MS_MASTER)
@@ -202,7 +201,6 @@ enum i2s_datlen {
  * @phys_addr: I2S registers physical base address
  * @lock_fd: lock to manage race conditions in full duplex mode
  * @irq_lock: prevent race condition with IRQ
- * @dais_name: DAI name
  * @mclk_rate: master clock frequency (Hz)
  * @fmt: DAI protocol
  * @refcount: keep count of opened streams on I2S
@@ -224,7 +222,6 @@ struct stm32_i2s_data {
 	dma_addr_t phys_addr;
 	spinlock_t lock_fd; /* Manage race conditions for full duplex */
 	spinlock_t irq_lock; /* used to prevent race condition with IRQ */
-	char dais_name[STM32_I2S_DAI_NAME_SIZE];
 	unsigned int mclk_rate;
 	unsigned int fmt;
 	int refcount;
@@ -771,12 +768,8 @@ static int stm32_i2s_dais_init(struct platform_device *pdev,
 	if (!dai_ptr)
 		return -ENOMEM;
 
-	snprintf(i2s->dais_name, STM32_I2S_DAI_NAME_SIZE,
-		 "%s", dev_name(&pdev->dev));
-
 	dai_ptr->probe = stm32_i2s_dai_probe;
 	dai_ptr->ops = &stm32_i2s_pcm_dai_ops;
-	dai_ptr->name = i2s->dais_name;
 	dai_ptr->id = 1;
 	stm32_i2s_dai_init(&dai_ptr->playback, "playback");
 	stm32_i2s_dai_init(&dai_ptr->capture, "capture");
-- 
2.20.1

