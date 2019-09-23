Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2867DC4320D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DEF21D81
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569273796;
	bh=Rr2lUw9XH4p70UBkVGjF6FPB4B0PbprMbE4a7pSh48E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=s+bunV+1R6VaiN2fnxeIWl0sTjsUSVuwVa9TA+B+Qg3kTOsyFCSboG9Tyg7RgIsCi
	 b2GW7D8Cu1e7DZYQ2lzUb0ci3G77QsQvdzlIk9hIoIcyj5Tf+848pKA+9w9WliP9r/
	 TYe57YTbf2uosW4l4SNriyueyLfA5LC1nFVe17OM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503024AbfIWVXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:23:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35034 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389861AbfIWVXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0W6Qss75JNSOVCDtpelJs8sNwm9PR0wQy/PHrfq2BB8=; b=f2BlPFEW3FOg
        J6wrKBXwV+5yJDULuS29IspGVBhWAGPBbGgysLskcrLpPHGtg7ECwIF405SPv2HFyGkk3IzcVSHVo
        SCVr9TrIclnABX/XWLNvFiA27c8W/JHWoRMCwjpfQJQgCfygw8A6dhQ7sLcXIUi/z7vrOwfeNHNTu
        q0XD4=;
Received: from [12.157.10.114] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iCVnW-0005Wn-EU; Mon, 23 Sep 2019 21:23:06 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9E3C9D02FCA; Mon, 23 Sep 2019 22:23:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        robh+dt@kernel.org, stwiss.opensource@diasemi.com,
        support.opensource@diasemi.com
Subject: Applied "regulator: da9062: fix suspend_enable/disable preparation" to the regulator tree
In-Reply-To: <20190917124246.11732-2-m.felsch@pengutronix.de>
X-Patchwork-Hint: ignore
Message-Id: <20190923212304.9E3C9D02FCA@fitzroy.sirena.org.uk>
Date:   Mon, 23 Sep 2019 22:23:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9062: fix suspend_enable/disable preparation

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

From a72865f057820ea9f57597915da4b651d65eb92f Mon Sep 17 00:00:00 2001
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Tue, 17 Sep 2019 14:42:42 +0200
Subject: [PATCH] regulator: da9062: fix suspend_enable/disable preparation

Currently the suspend reg_field maps to the pmic voltage selection bits
and is used during suspend_enabe/disable() and during get_mode(). This
seems to be wrong for both use cases.

Use case one (suspend_enabe/disable):
Those callbacks are used to mark a regulator device as enabled/disabled
during suspend. Marking the regulator enabled during suspend is done by
the LDOx_CONF/BUCKx_CONF bit within the LDOx_CONT/BUCKx_CONT registers.
Setting this bit tells the DA9062 PMIC state machine to keep the
regulator on in POWERDOWN mode and switch to suspend voltage.

Use case two (get_mode):
The get_mode callback is used to retrieve the active mode state. Since
the regulator-setting-A is used for the active state and
regulator-setting-B for the suspend state there is no need to check
which regulator setting is active.

Fixes: 4068e5182ada ("regulator: da9062: DA9062 regulator driver")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Link: https://lore.kernel.org/r/20190917124246.11732-2-m.felsch@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 118 +++++++++++----------------
 1 file changed, 47 insertions(+), 71 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 56f3f72d7707..710e67081d53 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -136,7 +136,6 @@ static int da9062_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	struct regmap_field *field;
 	unsigned int val, mode = 0;
 	int ret;
 
@@ -158,18 +157,7 @@ static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 		return REGULATOR_MODE_NORMAL;
 	}
 
-	/* Detect current regulator state */
-	ret = regmap_field_read(regl->suspend, &val);
-	if (ret < 0)
-		return 0;
-
-	/* Read regulator mode from proper register, depending on state */
-	if (val)
-		field = regl->suspend_sleep;
-	else
-		field = regl->sleep;
-
-	ret = regmap_field_read(field, &val);
+	ret = regmap_field_read(regl->sleep, &val);
 	if (ret < 0)
 		return 0;
 
@@ -208,21 +196,9 @@ static int da9062_ldo_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9062_ldo_get_mode(struct regulator_dev *rdev)
 {
 	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	struct regmap_field *field;
 	int ret, val;
 
-	/* Detect current regulator state */
-	ret = regmap_field_read(regl->suspend, &val);
-	if (ret < 0)
-		return 0;
-
-	/* Read regulator mode from proper register, depending on state */
-	if (val)
-		field = regl->suspend_sleep;
-	else
-		field = regl->sleep;
-
-	ret = regmap_field_read(field, &val);
+	ret = regmap_field_read(regl->sleep, &val);
 	if (ret < 0)
 		return 0;
 
@@ -408,10 +384,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK1_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_BUCK2,
@@ -444,10 +420,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK3_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_BUCK3,
@@ -480,10 +456,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK4_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_LDO1,
@@ -509,10 +485,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO1_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO1_CONT,
+			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -542,10 +518,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO2_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO2_CONT,
+			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -575,10 +551,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO3_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO3_CONT,
+			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -608,10 +584,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO4_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO4_CONT,
+			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -652,10 +628,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK1_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK2,
@@ -688,10 +664,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK2_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK2_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK2_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK2_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK2_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK2_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK2_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK3,
@@ -724,10 +700,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK3_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK4,
@@ -760,10 +736,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK4_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_LDO1,
@@ -789,10 +765,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO1_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO1_CONT,
+			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -822,10 +798,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO2_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO2_CONT,
+			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -855,10 +831,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO3_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO3_CONT,
+			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -888,10 +864,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO4_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO4_CONT,
+			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-- 
2.20.1

