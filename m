Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B18C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4CC2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552325023;
	bh=0b4pNyZIqmDE/F3FFm4cthw1hqt5748t6sBW2sOl0zU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cBBwkHkOr8TgnT+WwhjX55qJDiwIrh5SJe3cQuacJ3rsg6dVi9REFvWzpxsEI6WSl
	 AJ/PudrRMS8F3qI+VQjrum7QNNSMRbOrcp/JpLX2o5CntSGQKDbwMAnfnwuIdsU/3s
	 GcJE5H77si6Wn+YiVuxlym+R8UjHK+2jwSWABrPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfCKRXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:23:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfCKRXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4PYsjOHcsmuOtq4dlytNCFy2tEUNoxDVKAMNIWp/UV4=; b=tZ5rRIbxUzF/
        w50nOzPP5IerzBzASF8HU5YBHfuf7sfWl3bVLWtrZPyAs/SjSRLw9gvBPZkWxgBKuDV6Tr+bf5HZZ
        gncD7rTiH+xxlz/L8qZfV4bsr8UCEGotibSyOjLMDC76f64wdXq04fzhKOCqNDKNzqJy7z1djBWBN
        o1awI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h3Oe5-0005L3-8t; Mon, 11 Mar 2019 17:23:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D3A4A1128897; Mon, 11 Mar 2019 17:23:24 +0000 (GMT)
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
Subject: Applied "ASoC: stm32: i2s: fix registers declaration in regmap" to the asoc tree
In-Reply-To:  <1552318768-25404-1-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190311172324.D3A4A1128897@debutante.sirena.org.uk>
Date:   Mon, 11 Mar 2019 17:23:24 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: i2s: fix registers declaration in regmap

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

From a39fe6e2061615496c12825d6d249fedf1974f8a Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 11 Mar 2019 16:39:28 +0100
Subject: [PATCH] ASoC: stm32: i2s: fix registers declaration in regmap

- Declare SR as volatile, as it is changed by hardware.
- Remove TXDR from readable and volatile register list,
as it is intended for write accesses only.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 47c334de6b09..8968458eec62 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -281,7 +281,6 @@ static bool stm32_i2s_readable_reg(struct device *dev, unsigned int reg)
 	case STM32_I2S_CFG2_REG:
 	case STM32_I2S_IER_REG:
 	case STM32_I2S_SR_REG:
-	case STM32_I2S_TXDR_REG:
 	case STM32_I2S_RXDR_REG:
 	case STM32_I2S_CGFR_REG:
 		return true;
@@ -293,7 +292,7 @@ static bool stm32_i2s_readable_reg(struct device *dev, unsigned int reg)
 static bool stm32_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case STM32_I2S_TXDR_REG:
+	case STM32_I2S_SR_REG:
 	case STM32_I2S_RXDR_REG:
 		return true;
 	default:
-- 
2.20.1

