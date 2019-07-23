Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE8FC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552C720644
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563881371;
	bh=Y3AXI0crJJO5PJiXGzotsv0F7VGKZPHiU/9R+K7HquI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ZD7zgcwXRFSxhUwm+VPRiEkPOvqvjMJ8a72v5JtAXBc6prUmG+buf6l2Th3whX2xh
	 9rBp2y09C6ZPvnxfTJZEtuf3Vuw+qRhsYf3CMnlz+J/mhWvQR13wLKB9RuL+UnnvQn
	 sj/JstiVzOz5WHf3W2gbq7SoqfXPmEjrfspgBcnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbfGWL3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:29:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46410 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfGWL30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Gc5GLXyF8cKvljRTkgH1UFhNedj29JjDLTkvJDEc7W0=; b=xuXgz1dXWP4t
        ClDwPye7sG3zp5ovMYhmDPi/WooqCY3oP/c0ZrHG+LsPnZMNABCTAMxvuqWcJwEhzYNBhjfaAk8Ti
        FvypW+1YDmqFjWDRhtxv0IgACyLnZ0YcWYPyCTEGGVMJgnkPaYTSvKNY6Z/fLOri18vFBEhyc97fO
        tpNuE=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpsyw-0003Lw-3U; Tue, 23 Jul 2019 11:29:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 859742742B59; Tue, 23 Jul 2019 12:29:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: stm32-booster: Remove .min_uV and .list_voltage for fixed regulator" to the regulator tree
In-Reply-To: <20190723014102.25103-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190723112921.859742742B59@ypsilon.sirena.org.uk>
Date:   Tue, 23 Jul 2019 12:29:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stm32-booster: Remove .min_uV and .list_voltage for fixed regulator

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From 03b77f0b8587a9a0f9d2f1503da3d120aa6fe730 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 23 Jul 2019 09:41:02 +0800
Subject: [PATCH] regulator: stm32-booster: Remove .min_uV and .list_voltage
 for fixed regulator

Setting .n_voltages = 1 and .fixed_uV is enough for fixed regulator,
remove the redundant .min_uV and .list_voltage settings.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Link: https://lore.kernel.org/r/20190723014102.25103-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stm32-booster.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/stm32-booster.c b/drivers/regulator/stm32-booster.c
index 2a897666c650..03f162ffd144 100644
--- a/drivers/regulator/stm32-booster.c
+++ b/drivers/regulator/stm32-booster.c
@@ -20,7 +20,6 @@
 #define STM32MP1_SYSCFG_EN_BOOSTER_MASK	BIT(8)
 
 static const struct regulator_ops stm32h7_booster_ops = {
-	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= regulator_enable_regmap,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
@@ -31,7 +30,6 @@ static const struct regulator_desc stm32h7_booster_desc = {
 	.supply_name = "vdda",
 	.n_voltages = 1,
 	.type = REGULATOR_VOLTAGE,
-	.min_uV = 3300000,
 	.fixed_uV = 3300000,
 	.ramp_delay = 66000, /* up to 50us to stabilize */
 	.ops = &stm32h7_booster_ops,
@@ -53,7 +51,6 @@ static int stm32mp1_booster_disable(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops stm32mp1_booster_ops = {
-	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= stm32mp1_booster_enable,
 	.disable	= stm32mp1_booster_disable,
 	.is_enabled	= regulator_is_enabled_regmap,
@@ -64,7 +61,6 @@ static const struct regulator_desc stm32mp1_booster_desc = {
 	.supply_name = "vdda",
 	.n_voltages = 1,
 	.type = REGULATOR_VOLTAGE,
-	.min_uV = 3300000,
 	.fixed_uV = 3300000,
 	.ramp_delay = 66000,
 	.ops = &stm32mp1_booster_ops,
-- 
2.20.1

