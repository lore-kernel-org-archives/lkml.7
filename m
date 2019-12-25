Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A995C2D0D0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728B7206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577232560;
	bh=nlWXELyvwIGu8mJicfsHO4HQFZGza3VqbVeaSGizge8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=u9X69Tq/QU97n4uT+QgcuQ0NJFvl7qQmQCLYsm4vjffsKt9SgJxETG/BNf8ozApSC
	 LBlsIQow5fxTI0JbqrGO6TRb12Jq069ia7egbD4n242/dm/Zv7bV3pWZWLyP2vvzJ3
	 GwdfWutc8ISIT4LaOs/i2S+/m7p5heOM6W5YAbIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLYAJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:09:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33412 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfLYAJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZAC+d2JhJHnHloKpHt3+Xps6PellG/fLmAlbtuVbLVU=; b=bRt/n1MCrO/u
        xCRVANLJ6/mrTO6xb79b49qi0iI5agKkGFWVD0uD8ka0JAabDUX8Mziun4Vnwg6rZFc+ifcZjTNc1
        IkaLM+fqNt3PcvicCGJMYiNLA/6xcu1cUvsd6VPvRIVriCjEq92WZb1NqBMnmZEWKS0rP78ZSs33I
        Ik8ak=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ijuEa-0007Ld-4Y; Wed, 25 Dec 2019 00:09:04 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9713CD01957; Wed, 25 Dec 2019 00:09:03 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: spdifrx: fix input pin state management" to the asoc tree
In-Reply-To:  <20191204154333.7152-4-olivier.moysan@st.com>
Message-Id:  <applied-20191204154333.7152-4-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 00:09:03 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: spdifrx: fix input pin state management

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

From 3b7658679d88b5628939f9bdc8e613f79cd821f9 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 4 Dec 2019 16:43:33 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: fix input pin state management

Changing input state in iec capture control is not safe,
as the pin state may be changed concurrently by ASoC
framework.
Remove pin state handling in iec capture control.

Note: This introduces a restriction on capture control,
when pin sleep state is defined in device tree. In this case
channel status can be captured only when an audio stream
capture is active.

Fixes: f68c2a682d44 ("ASoC: stm32: spdifrx: add power management")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20191204154333.7152-4-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 3cb8e6db3eeb..3769d9ce5dbe 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -12,7 +12,6 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -484,8 +483,6 @@ static int stm32_spdifrx_get_ctrl_data(struct stm32_spdifrx_data *spdifrx)
 	memset(spdifrx->cs, 0, SPDIFRX_CS_BYTES_NB);
 	memset(spdifrx->ub, 0, SPDIFRX_UB_BYTES_NB);
 
-	pinctrl_pm_select_default_state(&spdifrx->pdev->dev);
-
 	ret = stm32_spdifrx_dma_ctrl_start(spdifrx);
 	if (ret < 0)
 		return ret;
@@ -517,7 +514,6 @@ static int stm32_spdifrx_get_ctrl_data(struct stm32_spdifrx_data *spdifrx)
 
 end:
 	clk_disable_unprepare(spdifrx->kclk);
-	pinctrl_pm_select_sleep_state(&spdifrx->pdev->dev);
 
 	return ret;
 }
-- 
2.20.1

