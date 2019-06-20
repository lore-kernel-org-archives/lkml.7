Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86665C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499032085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFTHkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:40:49 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:44082 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbfFTHks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:40:48 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id 0A/D2-08182-D783B0D5; Thu, 20 Jun 2019 07:40:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRWlGSWpSXmKPExsVy8IPnUd0aC+5
  Yg7kfTS2mPnzCZvFz0jQWi/tfjzJafLvSwWRxedccNgdWj52z7rJ7bFrVyeZx59oeNo9ntxex
  eHzeJBfAGsWamZeUX5HAmnFo1h3WggnWFZ/PVzcwTjDqYuTkEBJYzyixckExhF0h0Tl1LiuIz
  SZgKDHvzXtGEJtFQFXi2aOzbCC2sECoxIzzG4DiXBwiApMZJea9mguWYBaIlTg/bykLiM0r4C
  Cxsfk6O4QtKHFy5hMWiBoJiYMvXjB3MXIALdOSWH4sEiQsIWAvMf39VbCwhIC+ROOxWIiwocT
  3Wd9YIGxziXerVrNNYOSfhWToLCRDFzAyrWK0TCrKTM8oyU3MzNE1NDDQNTQ01jXWNTI00Uus
  0k3USy3VTU7NKylKBMrqJZYX6xVX5ibnpOjlpZZsYgQGdkoh87UdjI+OvNY7xCjJwaQkyntAn
  ztWiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSvqTlQTrAoNT21Ii0zBxhlMGkJDh4lEd47ZkBp3u
  KCxNzizHSI1ClGXY6125csYhZiycvPS5US590AUiQAUpRRmgc3AhbxlxhlpYR5GRkYGIR4ClK
  LcjNLUOVfMYpzMCoJ8/KAXMKTmVcCt+kV0BFMQEcsmM0FckRJIkJKqoHJQJ033tBuh+Xdf1cS
  u8Pm8MkrN02ct/je+d5p/IYTTmrZBZ7TeKX1I/xy/paAv3lrl7i+aV/gOmFnam3IHyffGX9T/
  /lkz/9Up7Pm2sK/53YWZ/GeviT6QOpXcrKpzeQbDAfOi7Tc1Te4832mYOakAM9brfGeRxOVEy
  6+5T+uu0mD/9iLp3F9AvYN8g7/nr2e4bWg7Fxs/6kPqoJsZ0z7lu5OX7/32dH3244u9BMtr+H
  evaV9T4fgWcHE1X9NYjz01H9PnHT+ywGDyBX8p3icGyY/W27Pnci+vtYs+7Dd78zPd+8s6sqV
  vzMtUl9krbTejNClzVd07WaqPfLs+PC4Km1pseKFbW/ybKdzxPX6KbEUZyQaajEXFScCAPDJT
  xRzAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-16.tower-229.messagelabs.com!1561016444!213810!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16502 invoked from network); 20 Jun 2019 07:40:44 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-16.tower-229.messagelabs.com with AES128-SHA256 encrypted SMTP; 20 Jun 2019 07:40:44 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Jun 2019 08:40:43 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 E1E803FB4A; Thu, 20 Jun 2019 08:40:42 +0100 (BST)
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Thu, 20 Jun 2019 08:45:00 +0100
Subject: [PATCH V4] regulator: da9061/62: Adjust LDO voltage selection minimum
 value
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        Felix Riemann <Felix.Riemann@sma.de>
CC:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <20190620074042.E1E803FB4A@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 20/06/2019 02:38:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Riemann <felix.riemann@sma.de>

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
---

Patch history

v2 - Fix whitespace problems, slight refactor and correct n_voltages calc
v3 - Addition of missing signed-off-by tag from sender
v4 - Correct order for Signed-off-by tags in commit message

Regards,
Steve

 drivers/regulator/da9062-regulator.c | 40 +++++++++++++++++++++---------------
 include/linux/mfd/da9062/registers.h |  3 +++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index a02e048..1cadaae 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -493,12 +493,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
@@ -525,12 +526,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
@@ -557,12 +559,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
@@ -589,12 +592,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
@@ -769,12 +773,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
@@ -801,12 +806,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
@@ -833,12 +839,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
@@ -865,12 +872,13 @@ static int da9062_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
index fe04b70..090213a 100644
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
1.9.3

