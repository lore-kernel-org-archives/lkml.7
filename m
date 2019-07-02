Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237CCC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E01208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562072720;
	bh=xeUCCAuI8XFlgnMuuNWMEjcZqnk87LzbxBcEjd+qNSU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wdDxkj89985zzaMGQ8Vo6+WGx2qpUwR/T9E63AfZDYLXy+gQLgoGPPVgPmG4oPNJW
	 fQ9IyEoMiv5E33Ex/Gr+5f1JKa1qjktNz86a2B7cYvDKGKnLYJLHjPxSpWxl/3CTCq
	 T3JD7GT/sLSsAWf189j0RZ8paCESD3dIJGu86KrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGBNFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:05:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40304 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfGBNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=J6di5hKSvm2U7x0iTDHc1tDKkTElop7GVRgvSTGDsGY=; b=X0Dz1xWmCu7M
        icmPZahvfRBHoQss9hogkiOZ51LLsy/GGpcOfkGTHDIiBWOl0lmSZx96E8XUAKiUfNVhAwE0ZkVhN
        Vh9bHqIoB0jtNmUoQ6WxouzbOBThgV7KcdzormDc8LEV6EPjqD952mmmry3TmNkAvC5FSjXQVwi14
        M2w4o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiISm-0002O3-Si; Tue, 02 Jul 2019 13:04:48 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 51BF944004A; Tue,  2 Jul 2019 14:04:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>
Subject: Applied "regulator: s2mps11: Adjust supported buck voltages to real values" to the regulator tree
In-Reply-To: <20190629114446.11381-2-krzk@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190702130448.51BF944004A@finisterre.sirena.org.uk>
Date:   Tue,  2 Jul 2019 14:04:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s2mps11: Adjust supported buck voltages to real values

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

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

From 9d83dcb3e4553f34ee1c4f09d65173159f9eb7a7 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 29 Jun 2019 13:44:46 +0200
Subject: [PATCH] regulator: s2mps11: Adjust supported buck voltages to real
 values

The driver was registering buck regulators with unsupported range of
voltages for S2MPS11 devices.  Basically it assumed that all 256 values
are possible for a single 8-bit I2C register controlling buck's voltage.
This is not true, as datasheet describes subset of these which can be
used.

For example for buck[12346] the minimum voltage is 650 mV which
corresponds to register value of 0x8.  The driver was however
registering regulator starting at 600 mV, so for a step of 6.25 mV this
gave the same result.  However this allowed to try to configure
regulators to unsupported values.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s2mps11.c         | 27 +++++++++++++++++----------
 include/linux/mfd/samsung/core.h    |  1 +
 include/linux/mfd/samsung/s2mps11.h |  4 +++-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 7a89030187a4..5b7ba7c6c4f6 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -269,9 +269,10 @@ static const struct regulator_ops s2mps11_buck_ops = {
 	.ops		= &s2mps11_buck_ops,			\
 	.type		= REGULATOR_VOLTAGE,			\
 	.owner		= THIS_MODULE,				\
-	.min_uV		= MIN_600_MV,				\
+	.min_uV		= MIN_650_MV,				\
 	.uV_step	= STEP_6_25_MV,				\
-	.n_voltages	= S2MPS11_BUCK_N_VOLTAGES,		\
+	.linear_min_sel	= 8,					\
+	.n_voltages	= S2MPS11_BUCK12346_N_VOLTAGES,		\
 	.ramp_delay	= S2MPS11_RAMP_DELAY,			\
 	.vsel_reg	= S2MPS11_REG_B1CTRL2 + (num - 1) * 2,	\
 	.vsel_mask	= S2MPS11_BUCK_VSEL_MASK,		\
@@ -285,9 +286,10 @@ static const struct regulator_ops s2mps11_buck_ops = {
 	.ops		= &s2mps11_buck_ops,			\
 	.type		= REGULATOR_VOLTAGE,			\
 	.owner		= THIS_MODULE,				\
-	.min_uV		= MIN_600_MV,				\
+	.min_uV		= MIN_650_MV,				\
 	.uV_step	= STEP_6_25_MV,				\
-	.n_voltages	= S2MPS11_BUCK_N_VOLTAGES,		\
+	.linear_min_sel	= 8,					\
+	.n_voltages	= S2MPS11_BUCK5_N_VOLTAGES,		\
 	.ramp_delay	= S2MPS11_RAMP_DELAY,			\
 	.vsel_reg	= S2MPS11_REG_B5CTRL2,			\
 	.vsel_mask	= S2MPS11_BUCK_VSEL_MASK,		\
@@ -295,7 +297,7 @@ static const struct regulator_ops s2mps11_buck_ops = {
 	.enable_mask	= S2MPS11_ENABLE_MASK			\
 }
 
-#define regulator_desc_s2mps11_buck67810(num, min, step) {	\
+#define regulator_desc_s2mps11_buck67810(num, min, step, min_sel, voltages) {	\
 	.name		= "BUCK"#num,				\
 	.id		= S2MPS11_BUCK##num,			\
 	.ops		= &s2mps11_buck_ops,			\
@@ -303,7 +305,8 @@ static const struct regulator_ops s2mps11_buck_ops = {
 	.owner		= THIS_MODULE,				\
 	.min_uV		= min,					\
 	.uV_step	= step,					\
-	.n_voltages	= S2MPS11_BUCK_N_VOLTAGES,		\
+	.linear_min_sel	= min_sel,				\
+	.n_voltages	= voltages,				\
 	.ramp_delay	= S2MPS11_RAMP_DELAY,			\
 	.vsel_reg	= S2MPS11_REG_B6CTRL2 + (num - 6) * 2,	\
 	.vsel_mask	= S2MPS11_BUCK_VSEL_MASK,		\
@@ -371,11 +374,15 @@ static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_buck1_4(3),
 	regulator_desc_s2mps11_buck1_4(4),
 	regulator_desc_s2mps11_buck5,
-	regulator_desc_s2mps11_buck67810(6, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck67810(7, MIN_750_MV, STEP_12_5_MV),
-	regulator_desc_s2mps11_buck67810(8, MIN_750_MV, STEP_12_5_MV),
+	regulator_desc_s2mps11_buck67810(6, MIN_650_MV, STEP_6_25_MV, 8,
+					 S2MPS11_BUCK12346_N_VOLTAGES),
+	regulator_desc_s2mps11_buck67810(7, MIN_750_MV, STEP_12_5_MV, 0,
+					 S2MPS11_BUCK7810_N_VOLTAGES),
+	regulator_desc_s2mps11_buck67810(8, MIN_750_MV, STEP_12_5_MV, 0,
+					 S2MPS11_BUCK7810_N_VOLTAGES),
 	regulator_desc_s2mps11_buck9,
-	regulator_desc_s2mps11_buck67810(10, MIN_750_MV, STEP_12_5_MV),
+	regulator_desc_s2mps11_buck67810(10, MIN_750_MV, STEP_12_5_MV, 0,
+					 S2MPS11_BUCK7810_N_VOLTAGES),
 };
 
 static const struct regulator_ops s2mps14_reg_ops;
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index 3ca17eb89aa2..f1631a39acfc 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -20,6 +20,7 @@
 #define MIN_850_MV		850000
 #define MIN_800_MV		800000
 #define MIN_750_MV		750000
+#define MIN_650_MV		650000
 #define MIN_600_MV		600000
 #define MIN_500_MV		500000
 
diff --git a/include/linux/mfd/samsung/s2mps11.h b/include/linux/mfd/samsung/s2mps11.h
index 6e7668a389a1..fc67c9e75bba 100644
--- a/include/linux/mfd/samsung/s2mps11.h
+++ b/include/linux/mfd/samsung/s2mps11.h
@@ -170,7 +170,9 @@ enum s2mps11_regulators {
 #define S2MPS11_ENABLE_MASK	(0x03 << S2MPS11_ENABLE_SHIFT)
 #define S2MPS11_ENABLE_SHIFT	0x06
 #define S2MPS11_LDO_N_VOLTAGES	(S2MPS11_LDO_VSEL_MASK + 1)
-#define S2MPS11_BUCK_N_VOLTAGES (S2MPS11_BUCK_VSEL_MASK + 1)
+#define S2MPS11_BUCK12346_N_VOLTAGES	153
+#define S2MPS11_BUCK5_N_VOLTAGES	216
+#define S2MPS11_BUCK7810_N_VOLTAGES	225
 #define S2MPS11_BUCK9_N_VOLTAGES (S2MPS11_BUCK9_VSEL_MASK + 1)
 #define S2MPS11_RAMP_DELAY	25000		/* uV/us */
 
-- 
2.20.1

