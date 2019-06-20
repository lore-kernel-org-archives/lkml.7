Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0924BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA66D2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561037574;
	bh=tHdq2LQhtct4xrEueAHSAhjPBMcpTZgMnYHg86UwUko=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HET4HTmHXVx1lE7xZNfosM5+jAKcnPB+tY0ZcMSSVlSCKcVsbzeUAxmlSb94WvSNy
	 a6i8WUBuJm8n6YYvXVPllUjf+xq5mwos/p7S+SX30GKpadMVnFDLVlTk1RWA2y/7vb
	 hNzKo6LWjP3AdGj5kqtI5kI9aolSmHHE0tSXxJWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfFTNcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:32:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59210 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfFTNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=r8KK7n36Dnj9zcCMDV0/kiaK1i2LxyhynFtnjeHXVMc=; b=OoPaU9TzmuPW
        S2Dfbjoqzp/Ycg4csVUe40pRUfrpU9ow207Zx4k73ahVCUaB/Z2bw1wiSMboGSNwP0cD6//8gP5bG
        u91rm/dv5Dq+TZFmGDnaSRPNZXxKFQ8U9JqJboBGXjXRas+VKlcwnVuxhFOa23CKFITCKAqnpWck5
        2X3Ws=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdxB1-0000kH-VC; Thu, 20 Jun 2019 13:32:32 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 7E667440049; Thu, 20 Jun 2019 14:32:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Felix Riemann <felix.riemann@sma.de>
Cc:     Felix Riemann <Felix.Riemann@sma.de>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: da9061/62: Adjust LDO voltage selection minimum value" to the regulator tree
In-Reply-To: <20190620074042.E1E803FB4A@swsrvapps-01.diasemi.com>
X-Patchwork-Hint: ignore
Message-Id: <20190620133231.7E667440049@finisterre.sirena.org.uk>
Date:   Thu, 20 Jun 2019 14:32:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9061/62: Adjust LDO voltage selection minimum value

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From fd5d10059d5ead12dd12f05ae6d96e70d1fac3df Mon Sep 17 00:00:00 2001
From: Felix Riemann <felix.riemann@sma.de>
Date: Thu, 20 Jun 2019 08:45:00 +0100
Subject: [PATCH] regulator: da9061/62: Adjust LDO voltage selection minimum
 value

According to the DA9061 and DA9062 datasheets the LDO voltage selection
registers have a lower value of 0x02. This applies to voltage registers
VLDO1_A, VLDO2_A, VLDO3_A and VLDO4_A. This linear offset of 0x02 was
previously not observed by the driver, causing the LDO output voltage to
be systematically lower by two steps (= 0.1V).

This patch fixes the minimum linear selector offset by setting it to a
value of 2 and increases the n_voltages by the same amount allowing
voltages in the range 0x02 -> 0.9V to 0x38 -> 3.6V to be correctly
selected. Also fixes an incorrect calculaton for the n_voltages value in
the regulator LDO2.

These fixes effect all LDO regulators for DA9061 and DA9062.

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Felix Riemann <felix.riemann@sma.de>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 40 +++++++++++++++++-----------
 include/linux/mfd/da9062/registers.h |  3 +++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index a02e0488410f..2ffc64622451 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -493,12 +493,13 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO1_CONT,
 		.desc.enable_mask = DA9062AA_LDO1_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO1_A,
 		.desc.vsel_mask = DA9062AA_VLDO1_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO1_A,
 			__builtin_ffs((int)DA9062AA_LDO1_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -525,12 +526,13 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (600))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO2_CONT,
 		.desc.enable_mask = DA9062AA_LDO2_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO2_A,
 		.desc.vsel_mask = DA9062AA_VLDO2_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO2_A,
 			__builtin_ffs((int)DA9062AA_LDO2_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -557,12 +559,13 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO3_CONT,
 		.desc.enable_mask = DA9062AA_LDO3_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO3_A,
 		.desc.vsel_mask = DA9062AA_VLDO3_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO3_A,
 			__builtin_ffs((int)DA9062AA_LDO3_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -589,12 +592,13 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO4_CONT,
 		.desc.enable_mask = DA9062AA_LDO4_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO4_A,
 		.desc.vsel_mask = DA9062AA_VLDO4_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO4_A,
 			__builtin_ffs((int)DA9062AA_LDO4_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -769,12 +773,13 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO1_CONT,
 		.desc.enable_mask = DA9062AA_LDO1_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO1_A,
 		.desc.vsel_mask = DA9062AA_VLDO1_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO1_A,
 			__builtin_ffs((int)DA9062AA_LDO1_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -801,12 +806,13 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (600))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO2_CONT,
 		.desc.enable_mask = DA9062AA_LDO2_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO2_A,
 		.desc.vsel_mask = DA9062AA_VLDO2_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO2_A,
 			__builtin_ffs((int)DA9062AA_LDO2_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -833,12 +839,13 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO3_CONT,
 		.desc.enable_mask = DA9062AA_LDO3_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO3_A,
 		.desc.vsel_mask = DA9062AA_VLDO3_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO3_A,
 			__builtin_ffs((int)DA9062AA_LDO3_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -865,12 +872,13 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.ops = &da9062_ldo_ops,
 		.desc.min_uV = (900) * 1000,
 		.desc.uV_step = (50) * 1000,
-		.desc.n_voltages = ((3600) - (900))/(50) + 1,
+		.desc.n_voltages = ((3600) - (900))/(50) + 1
+				+ DA9062AA_VLDO_A_MIN_SEL,
 		.desc.enable_reg = DA9062AA_LDO4_CONT,
 		.desc.enable_mask = DA9062AA_LDO4_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VLDO4_A,
 		.desc.vsel_mask = DA9062AA_VLDO4_A_MASK,
-		.desc.linear_min_sel = 0,
+		.desc.linear_min_sel = DA9062AA_VLDO_A_MIN_SEL,
 		.sleep = REG_FIELD(DA9062AA_VLDO4_A,
 			__builtin_ffs((int)DA9062AA_LDO4_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
diff --git a/include/linux/mfd/da9062/registers.h b/include/linux/mfd/da9062/registers.h
index fe04b708742b..2906bf6160fb 100644
--- a/include/linux/mfd/da9062/registers.h
+++ b/include/linux/mfd/da9062/registers.h
@@ -797,6 +797,9 @@
 #define DA9062AA_BUCK3_SL_A_SHIFT	7
 #define DA9062AA_BUCK3_SL_A_MASK	BIT(7)
 
+/* DA9062AA_VLDO[1-4]_A common */
+#define DA9062AA_VLDO_A_MIN_SEL	2
+
 /* DA9062AA_VLDO1_A = 0x0A9 */
 #define DA9062AA_VLDO1_A_SHIFT		0
 #define DA9062AA_VLDO1_A_MASK		0x3f
-- 
2.20.1

