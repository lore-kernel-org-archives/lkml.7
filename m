Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8963AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444492084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554981601;
	bh=/lirQ/TDXPNrICOPhobhgw/1//H1WsUfROnm6Y7ytqQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AeztFjqFyZJW50RTbFn3IP5tYl4H/ig9d6YNqmlGjI8bTU/1L895m6gg0Kzcz1y1g
	 3IwD/s7v/S7YvslzojQdXUYvHfy/QSZxhn7SzrQnFDmzbqMoFiUCjD0OP+zyiLryvb
	 QKyLk8QnkjAUh/ObfkQlkNgSo3kLwB6TqyKsDtsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDKLT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:19:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48324 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKLT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5rUsADW007PUA6xUTPh9I7rfzMRRcbYYiUbzIK2plVg=; b=id6psLLDx/Sd
        WEBpmZuCAtVz4C0uqGODwA05h+t2l+I+xFr4R+jNj5vtIYI6nTxg1rAAa20PfB5JWz6gWYMDItsUo
        KmGarl3sIc/KSU7t66snptNMokMRvezvcyIKrthftTlziY+xKU6+IzeLPOn1HVkD5ZKL/GgqgLD/Y
        c9CGo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEXkF-000070-9q; Thu, 11 Apr 2019 11:19:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A6E791126DD6; Thu, 11 Apr 2019 12:19:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Guodong Xu <guodong.xu@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: hi6421: Convert to use simplified DT parsing" to the regulator tree
In-Reply-To: <20190410161427.3394-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190411111949.A6E791126DD6@debutante.sirena.org.uk>
Date:   Thu, 11 Apr 2019 12:19:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: hi6421: Convert to use simplified DT parsing

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

From 29dc269a85ef4e413fd03be295fba52a2eb93d7d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 11 Apr 2019 00:14:27 +0800
Subject: [PATCH] regulator: hi6421: Convert to use simplified DT parsing

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/hi6421-regulator.c | 208 ++++++++++-----------------
 1 file changed, 78 insertions(+), 130 deletions(-)

diff --git a/drivers/regulator/hi6421-regulator.c b/drivers/regulator/hi6421-regulator.c
index 259c3a865ac6..6c7ea4eb4bb0 100644
--- a/drivers/regulator/hi6421-regulator.c
+++ b/drivers/regulator/hi6421-regulator.c
@@ -78,43 +78,6 @@ enum hi6421_regulator_id {
 	HI6421_NUM_REGULATORS,
 };
 
-#define HI6421_REGULATOR_OF_MATCH(_name, id)				\
-{									\
-	.name = #_name,							\
-	.driver_data = (void *) HI6421_##id,				\
-}
-
-static struct of_regulator_match hi6421_regulator_match[] = {
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout0, LDO0),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout1, LDO1),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout2, LDO2),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout3, LDO3),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout4, LDO4),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout5, LDO5),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout6, LDO6),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout7, LDO7),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout8, LDO8),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout9, LDO9),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout10, LDO10),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout11, LDO11),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout12, LDO12),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout13, LDO13),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout14, LDO14),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout15, LDO15),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout16, LDO16),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout17, LDO17),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout18, LDO18),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout19, LDO19),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout20, LDO20),
-	HI6421_REGULATOR_OF_MATCH(hi6421_vout_audio, LDOAUDIO),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck0, BUCK0),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck1, BUCK1),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck2, BUCK2),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck3, BUCK3),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck4, BUCK4),
-	HI6421_REGULATOR_OF_MATCH(hi6421_buck5, BUCK5),
-};
-
 /* LDO 0, 4~7, 9~14, 16~20 have same voltage table. */
 static const unsigned int ldo_0_voltages[] = {
 	1500000, 1800000, 2400000, 2500000,
@@ -157,6 +120,7 @@ static const struct regulator_ops hi6421_buck345_ops;
 #define HI6421_LDO_ENABLE_TIME (350)
 /*
  * _id - LDO id name string
+ * _match - of match name string
  * v_table - voltage table
  * vreg - voltage select register
  * vmask - voltage select mask
@@ -166,11 +130,13 @@ static const struct regulator_ops hi6421_buck345_ops;
  * ecomask - eco mode mask
  * ecoamp - eco mode load uppler limit in uA
  */
-#define HI6421_LDO(_id, v_table, vreg, vmask, ereg, emask,		\
+#define HI6421_LDO(_id, _match, v_table, vreg, vmask, ereg, emask,	\
 		   odelay, ecomask, ecoamp)				\
 	[HI6421_##_id] = {						\
 		.desc = {						\
 			.name		= #_id,				\
+			.of_match        = of_match_ptr(#_match),	\
+			.regulators_node = of_match_ptr("regulators"),	\
 			.ops		= &hi6421_ldo_ops,		\
 			.type		= REGULATOR_VOLTAGE,		\
 			.id		= HI6421_##_id,			\
@@ -191,6 +157,7 @@ static const struct regulator_ops hi6421_buck345_ops;
 /* HI6421 LDO1~3 are linear voltage regulators at fixed uV_step
  *
  * _id - LDO id name string
+ * _match - of match name string
  * _min_uV - minimum voltage supported in uV
  * n_volt - number of votages available
  * vstep - voltage increase in each linear step in uV
@@ -202,11 +169,13 @@ static const struct regulator_ops hi6421_buck345_ops;
  * ecomask - eco mode mask
  * ecoamp - eco mode load uppler limit in uA
  */
-#define HI6421_LDO_LINEAR(_id, _min_uV, n_volt, vstep, vreg, vmask,	\
+#define HI6421_LDO_LINEAR(_id, _match, _min_uV, n_volt, vstep, vreg, vmask,\
 			  ereg, emask, odelay, ecomask, ecoamp)		\
 	[HI6421_##_id] = {						\
 		.desc = {						\
 			.name		= #_id,				\
+			.of_match        = of_match_ptr(#_match),	\
+			.regulators_node = of_match_ptr("regulators"),	\
 			.ops		= &hi6421_ldo_linear_ops,	\
 			.type		= REGULATOR_VOLTAGE,		\
 			.id		= HI6421_##_id,			\
@@ -228,6 +197,7 @@ static const struct regulator_ops hi6421_buck345_ops;
 /* HI6421 LDOAUDIO is a linear voltage regulator with two 4-step ranges
  *
  * _id - LDO id name string
+ * _match - of match name string
  * n_volt - number of votages available
  * volt_ranges - array of regulator_linear_range
  * vstep - voltage increase in each linear step in uV
@@ -239,11 +209,13 @@ static const struct regulator_ops hi6421_buck345_ops;
  * ecomask - eco mode mask
  * ecoamp - eco mode load uppler limit in uA
  */
-#define HI6421_LDO_LINEAR_RANGE(_id, n_volt, volt_ranges, vreg, vmask,	\
+#define HI6421_LDO_LINEAR_RANGE(_id, _match, n_volt, volt_ranges, vreg, vmask,\
 				ereg, emask, odelay, ecomask, ecoamp)	\
 	[HI6421_##_id] = {						\
 		.desc = {						\
 			.name		= #_id,				\
+			.of_match        = of_match_ptr(#_match),	\
+			.regulators_node = of_match_ptr("regulators"),	\
 			.ops		= &hi6421_ldo_linear_range_ops,	\
 			.type		= REGULATOR_VOLTAGE,		\
 			.id		= HI6421_##_id,			\
@@ -265,6 +237,7 @@ static const struct regulator_ops hi6421_buck345_ops;
 /* HI6421 BUCK0/1/2 are linear voltage regulators at fixed uV_step
  *
  * _id - BUCK0/1/2 id name string
+ * _match - of match name string
  * vreg - voltage select register
  * vmask - voltage select mask
  * ereg - enable register
@@ -273,11 +246,13 @@ static const struct regulator_ops hi6421_buck345_ops;
  * etime - enable time
  * odelay - off/on delay time in uS
  */
-#define HI6421_BUCK012(_id, vreg, vmask, ereg, emask, sleepmask,	\
+#define HI6421_BUCK012(_id, _match, vreg, vmask, ereg, emask, sleepmask,\
 			etime, odelay)					\
 	[HI6421_##_id] = {						\
 		.desc = {						\
 			.name		= #_id,				\
+			.of_match        = of_match_ptr(#_match),	\
+			.regulators_node = of_match_ptr("regulators"),	\
 			.ops		= &hi6421_buck012_ops,		\
 			.type		= REGULATOR_VOLTAGE,		\
 			.id		= HI6421_##_id,			\
@@ -299,6 +274,7 @@ static const struct regulator_ops hi6421_buck345_ops;
  *  that it supports SLEEP mode, so has different .ops.
  *
  * _id - LDO id name string
+ * _match - of match name string
  * v_table - voltage table
  * vreg - voltage select register
  * vmask - voltage select mask
@@ -307,11 +283,13 @@ static const struct regulator_ops hi6421_buck345_ops;
  * odelay - off/on delay time in uS
  * sleepmask - mask of sleep mode
  */
-#define HI6421_BUCK345(_id, v_table, vreg, vmask, ereg, emask,		\
+#define HI6421_BUCK345(_id, _match, v_table, vreg, vmask, ereg, emask,	\
 			odelay, sleepmask)				\
 	[HI6421_##_id] = {						\
 		.desc = {						\
 			.name		= #_id,				\
+			.of_match        = of_match_ptr(#_match),	\
+			.regulators_node = of_match_ptr("regulators"),	\
 			.ops		= &hi6421_buck345_ops,		\
 			.type		= REGULATOR_VOLTAGE,		\
 			.id		= HI6421_##_id,			\
@@ -331,59 +309,63 @@ static const struct regulator_ops hi6421_buck345_ops;
 /* HI6421 regulator information */
 static struct hi6421_regulator_info
 		hi6421_regulator_info[HI6421_NUM_REGULATORS] = {
-	HI6421_LDO(LDO0, ldo_0_voltages, 0x20, 0x07, 0x20, 0x10,
+	HI6421_LDO(LDO0, hi6421_vout0, ldo_0_voltages, 0x20, 0x07, 0x20, 0x10,
 		   10000, 0x20, 8000),
-	HI6421_LDO_LINEAR(LDO1, 1700000, 4, 100000, 0x21, 0x03, 0x21, 0x10,
-			  10000, 0x20, 5000),
-	HI6421_LDO_LINEAR(LDO2, 1050000, 8, 50000, 0x22, 0x07, 0x22, 0x10,
-			  20000, 0x20, 8000),
-	HI6421_LDO_LINEAR(LDO3, 1050000, 8, 50000, 0x23, 0x07, 0x23, 0x10,
-			  20000, 0x20, 8000),
-	HI6421_LDO(LDO4, ldo_0_voltages, 0x24, 0x07, 0x24, 0x10,
+	HI6421_LDO_LINEAR(LDO1, hi6421_vout1, 1700000, 4, 100000, 0x21, 0x03,
+			  0x21, 0x10, 10000, 0x20, 5000),
+	HI6421_LDO_LINEAR(LDO2, hi6421_vout2, 1050000, 8, 50000, 0x22, 0x07,
+			  0x22, 0x10, 20000, 0x20, 8000),
+	HI6421_LDO_LINEAR(LDO3, hi6421_vout3, 1050000, 8, 50000, 0x23, 0x07,
+			  0x23, 0x10, 20000, 0x20, 8000),
+	HI6421_LDO(LDO4, hi6421_vout4, ldo_0_voltages, 0x24, 0x07, 0x24, 0x10,
 		   20000, 0x20, 8000),
-	HI6421_LDO(LDO5, ldo_0_voltages, 0x25, 0x07, 0x25, 0x10,
+	HI6421_LDO(LDO5, hi6421_vout5, ldo_0_voltages, 0x25, 0x07, 0x25, 0x10,
 		   20000, 0x20, 8000),
-	HI6421_LDO(LDO6, ldo_0_voltages, 0x26, 0x07, 0x26, 0x10,
+	HI6421_LDO(LDO6, hi6421_vout6, ldo_0_voltages, 0x26, 0x07, 0x26, 0x10,
 		   20000, 0x20, 8000),
-	HI6421_LDO(LDO7, ldo_0_voltages, 0x27, 0x07, 0x27, 0x10,
+	HI6421_LDO(LDO7, hi6421_vout7, ldo_0_voltages, 0x27, 0x07, 0x27, 0x10,
 		   20000, 0x20, 5000),
-	HI6421_LDO(LDO8, ldo_8_voltages, 0x28, 0x07, 0x28, 0x10,
+	HI6421_LDO(LDO8, hi6421_vout8, ldo_8_voltages, 0x28, 0x07, 0x28, 0x10,
 		   20000, 0x20, 8000),
-	HI6421_LDO(LDO9, ldo_0_voltages, 0x29, 0x07, 0x29, 0x10,
+	HI6421_LDO(LDO9, hi6421_vout9, ldo_0_voltages, 0x29, 0x07, 0x29, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO10, ldo_0_voltages, 0x2a, 0x07, 0x2a, 0x10,
+	HI6421_LDO(LDO10, hi6421_vout10, ldo_0_voltages, 0x2a, 0x07, 0x2a, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO11, ldo_0_voltages, 0x2b, 0x07, 0x2b, 0x10,
+	HI6421_LDO(LDO11, hi6421_vout11, ldo_0_voltages, 0x2b, 0x07, 0x2b, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO12, ldo_0_voltages, 0x2c, 0x07, 0x2c, 0x10,
+	HI6421_LDO(LDO12, hi6421_vout12, ldo_0_voltages, 0x2c, 0x07, 0x2c, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO13, ldo_0_voltages, 0x2d, 0x07, 0x2d, 0x10,
+	HI6421_LDO(LDO13, hi6421_vout13, ldo_0_voltages, 0x2d, 0x07, 0x2d, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO14, ldo_0_voltages, 0x2e, 0x07, 0x2e, 0x10,
+	HI6421_LDO(LDO14, hi6421_vout14, ldo_0_voltages, 0x2e, 0x07, 0x2e, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO15, ldo_8_voltages, 0x2f, 0x07, 0x2f, 0x10,
+	HI6421_LDO(LDO15, hi6421_vout15, ldo_8_voltages, 0x2f, 0x07, 0x2f, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO16, ldo_0_voltages, 0x30, 0x07, 0x30, 0x10,
+	HI6421_LDO(LDO16, hi6421_vout16, ldo_0_voltages, 0x30, 0x07, 0x30, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO17, ldo_0_voltages, 0x31, 0x07, 0x31, 0x10,
+	HI6421_LDO(LDO17, hi6421_vout17, ldo_0_voltages, 0x31, 0x07, 0x31, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO18, ldo_0_voltages, 0x32, 0x07, 0x32, 0x10,
+	HI6421_LDO(LDO18, hi6421_vout18, ldo_0_voltages, 0x32, 0x07, 0x32, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO19, ldo_0_voltages, 0x33, 0x07, 0x33, 0x10,
+	HI6421_LDO(LDO19, hi6421_vout19, ldo_0_voltages, 0x33, 0x07, 0x33, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO(LDO20, ldo_0_voltages, 0x34, 0x07, 0x34, 0x10,
+	HI6421_LDO(LDO20, hi6421_vout20, ldo_0_voltages, 0x34, 0x07, 0x34, 0x10,
 		   40000, 0x20, 8000),
-	HI6421_LDO_LINEAR_RANGE(LDOAUDIO, 8, ldo_audio_volt_range, 0x36,
-				0x70, 0x36, 0x01, 40000, 0x02, 5000),
-	HI6421_BUCK012(BUCK0, 0x0d, 0x7f, 0x0c, 0x01, 0x10, 400, 20000),
-	HI6421_BUCK012(BUCK1, 0x0f, 0x7f, 0x0e, 0x01, 0x10, 400, 20000),
-	HI6421_BUCK012(BUCK2, 0x11, 0x7f, 0x10, 0x01, 0x10, 350, 100),
-	HI6421_BUCK345(BUCK3, buck_3_voltages, 0x13, 0x07, 0x12, 0x01,
-		       20000, 0x10),
-	HI6421_BUCK345(BUCK4, buck_4_voltages, 0x15, 0x07, 0x14, 0x01,
-		       20000, 0x10),
-	HI6421_BUCK345(BUCK5, buck_5_voltages, 0x17, 0x07, 0x16, 0x01,
-		       20000, 0x10),
+	HI6421_LDO_LINEAR_RANGE(LDOAUDIO, hi6421_vout_audio, 8,
+				ldo_audio_volt_range, 0x36, 0x70, 0x36, 0x01,
+				40000, 0x02, 5000),
+	HI6421_BUCK012(BUCK0, hi6421_buck0, 0x0d, 0x7f, 0x0c, 0x01, 0x10, 400,
+		       20000),
+	HI6421_BUCK012(BUCK1, hi6421_buck1, 0x0f, 0x7f, 0x0e, 0x01, 0x10, 400,
+		       20000),
+	HI6421_BUCK012(BUCK2, hi6421_buck2, 0x11, 0x7f, 0x10, 0x01, 0x10, 350,
+		       100),
+	HI6421_BUCK345(BUCK3, hi6421_buck3, buck_3_voltages, 0x13, 0x07, 0x12,
+		       0x01, 20000, 0x10),
+	HI6421_BUCK345(BUCK4, hi6421_buck4, buck_4_voltages, 0x15, 0x07, 0x14,
+		       0x01, 20000, 0x10),
+	HI6421_BUCK345(BUCK5, hi6421_buck5, buck_5_voltages, 0x17, 0x07, 0x16,
+		       0x01, 20000, 0x10),
 };
 
 static int hi6421_regulator_enable(struct regulator_dev *rdev)
@@ -552,42 +534,14 @@ static const struct regulator_ops hi6421_buck345_ops = {
 	.set_mode = hi6421_regulator_buck_set_mode,
 };
 
-static int hi6421_regulator_register(struct platform_device *pdev,
-				     struct regmap *rmap,
-				     struct regulator_init_data *init_data,
-				     int id, struct device_node *np)
-{
-	struct hi6421_regulator_info *info = NULL;
-	struct regulator_config config = { };
-	struct regulator_dev *rdev;
-
-	/* assign per-regulator data */
-	info = &hi6421_regulator_info[id];
-
-	config.dev = &pdev->dev;
-	config.init_data = init_data;
-	config.driver_data = info;
-	config.regmap = rmap;
-	config.of_node = np;
-
-	/* register regulator with framework */
-	rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
-	if (IS_ERR(rdev)) {
-		dev_err(&pdev->dev, "failed to register regulator %s\n",
-			info->desc.name);
-		return PTR_ERR(rdev);
-	}
-
-	return 0;
-}
-
 static int hi6421_regulator_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct device_node *np;
-	struct hi6421_pmic *pmic;
+	struct hi6421_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
 	struct hi6421_regulator_pdata *pdata;
-	int i, ret = 0;
+	struct hi6421_regulator_info *info;
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	int i;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -595,27 +549,21 @@ static int hi6421_regulator_probe(struct platform_device *pdev)
 	mutex_init(&pdata->lock);
 	platform_set_drvdata(pdev, pdata);
 
-	np = of_get_child_by_name(dev->parent->of_node, "regulators");
-	if (!np)
-		return -ENODEV;
-
-	ret = of_regulator_match(dev, np,
-				 hi6421_regulator_match,
-				 ARRAY_SIZE(hi6421_regulator_match));
-	of_node_put(np);
-	if (ret < 0) {
-		dev_err(dev, "Error parsing regulator init data: %d\n", ret);
-		return ret;
-	}
-
-	pmic = dev_get_drvdata(dev->parent);
-
 	for (i = 0; i < ARRAY_SIZE(hi6421_regulator_info); i++) {
-		ret = hi6421_regulator_register(pdev, pmic->regmap,
-			hi6421_regulator_match[i].init_data, i,
-			hi6421_regulator_match[i].of_node);
-		if (ret)
-			return ret;
+		/* assign per-regulator data */
+		info = &hi6421_regulator_info[i];
+
+		config.dev = pdev->dev.parent;
+		config.driver_data = info;
+		config.regmap = pmic->regmap;
+
+		rdev = devm_regulator_register(&pdev->dev, &info->desc,
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register regulator %s\n",
+				info->desc.name);
+			return PTR_ERR(rdev);
+		}
 	}
 
 	return 0;
-- 
2.20.1

