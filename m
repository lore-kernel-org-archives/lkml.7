Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D1CC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA9F206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577232567;
	bh=dYy2H33zREIWzAdKTtdSY8Nv7OIsH0akMM5AhkCB2sY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fzOIOl6Umt+bTCgYGI+g9fvzIjrtgj9jDmqE4YnIuIkPNBbBqZQKyThTORqxqcHEy
	 l5wqOOYPHGlT70Ghk+2sVSwTVqb7s0WrKz2nFETYqzzxAPzR80oiks2lAjWi0iFgKd
	 8q4/KJaLOZOhJNRGshA3UamIzRWVQU0wjZDBN2D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfLYAJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:09:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33446 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfLYAJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2GeG6xR/J7VM2a/ObwQ0fm8SxgMna4I+z6ph1YDl5Rs=; b=LfGTMjJEKuyE
        ea2zyxLVkyi/yF1/sjsO/UviCdqxEIx6SmUAf7MFxvGMd6I8DPh1SDStqKKqQXjLH489wNc3RxTX3
        XIJvnfZFcRRD6MmFMjE8SqAl826vjxoKHWJbEacnMcrwy4WqFPWWimrMW2kz7gYxPh4hzAfikFEGO
        oNTC4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ijuEd-0007M2-Vr; Wed, 25 Dec 2019 00:09:08 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 7D617D01957; Wed, 25 Dec 2019 00:09:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: spdifrx: fix inconsistent lock state" to the asoc tree
In-Reply-To:  <20191204154333.7152-2-olivier.moysan@st.com>
Message-Id:  <applied-20191204154333.7152-2-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 00:09:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: spdifrx: fix inconsistent lock state

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

From 2859b1784031b5709446af8f6039c467f136e67d Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 4 Dec 2019 16:43:31 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: fix inconsistent lock state

In current spdifrx driver locks may be requested as follows:
- request lock on iec capture control, when starting synchronization.
- request lock in interrupt context, when spdifrx stop is called
from IRQ handler.

Take lock with IRQs disabled, to avoid the possible deadlock.

Lockdep report:
[   74.278059] ================================
[   74.282306] WARNING: inconsistent lock state
[   74.290120] --------------------------------
...
[   74.314373]        CPU0
[   74.314377]        ----
[   74.314381]   lock(&(&spdifrx->lock)->rlock);
[   74.314396]   <Interrupt>
[   74.314400]     lock(&(&spdifrx->lock)->rlock);

Fixes: 03e4d5d56fa5 ("ASoC: stm32: Add SPDIFRX support")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20191204154333.7152-2-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 3fd28ee01675..9c6beb610c17 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -320,6 +320,7 @@ static void stm32_spdifrx_dma_ctrl_stop(struct stm32_spdifrx_data *spdifrx)
 static int stm32_spdifrx_start_sync(struct stm32_spdifrx_data *spdifrx)
 {
 	int cr, cr_mask, imr, ret;
+	unsigned long flags;
 
 	/* Enable IRQs */
 	imr = SPDIFRX_IMR_IFEIE | SPDIFRX_IMR_SYNCDIE | SPDIFRX_IMR_PERRIE;
@@ -327,7 +328,7 @@ static int stm32_spdifrx_start_sync(struct stm32_spdifrx_data *spdifrx)
 	if (ret)
 		return ret;
 
-	spin_lock(&spdifrx->lock);
+	spin_lock_irqsave(&spdifrx->lock, flags);
 
 	spdifrx->refcount++;
 
@@ -362,7 +363,7 @@ static int stm32_spdifrx_start_sync(struct stm32_spdifrx_data *spdifrx)
 				"Failed to start synchronization\n");
 	}
 
-	spin_unlock(&spdifrx->lock);
+	spin_unlock_irqrestore(&spdifrx->lock, flags);
 
 	return ret;
 }
@@ -370,11 +371,12 @@ static int stm32_spdifrx_start_sync(struct stm32_spdifrx_data *spdifrx)
 static void stm32_spdifrx_stop(struct stm32_spdifrx_data *spdifrx)
 {
 	int cr, cr_mask, reg;
+	unsigned long flags;
 
-	spin_lock(&spdifrx->lock);
+	spin_lock_irqsave(&spdifrx->lock, flags);
 
 	if (--spdifrx->refcount) {
-		spin_unlock(&spdifrx->lock);
+		spin_unlock_irqrestore(&spdifrx->lock, flags);
 		return;
 	}
 
@@ -393,7 +395,7 @@ static void stm32_spdifrx_stop(struct stm32_spdifrx_data *spdifrx)
 	regmap_read(spdifrx->regmap, STM32_SPDIFRX_DR, &reg);
 	regmap_read(spdifrx->regmap, STM32_SPDIFRX_CSR, &reg);
 
-	spin_unlock(&spdifrx->lock);
+	spin_unlock_irqrestore(&spdifrx->lock, flags);
 }
 
 static int stm32_spdifrx_dma_ctrl_register(struct device *dev,
-- 
2.20.1

