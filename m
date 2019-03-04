Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B7520830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658050;
	bh=vcKvZuCbUu/sGtHpG3fSoQAkeDbHrlqG85+54jpome0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Qn85UBy9nUJWRF8IZvFqYt961/kNT2NSktTkYrfePdgbag6ZFHBwoIMjJCaseRHo8
	 BVC9Ks/Jy3HjMOASAX903cpfe1AUF5wB6FCBhi8cRizAzKJA1rpfSwX0otDdSnD7Jd
	 vJx88JMQdQNCsXFYLAnoEXZI2jJljX44UuOkB9QY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfCDAH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:07:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54146 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfCDAGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rMS0hL6MZYLJ3oWXDx1rbyE58KgKS6s7mhOasL1qI24=; b=oY8Gv4BygTHB
        Ow1t/4Wx/66pBMCUsHA0oMjcxD+NsRNPFjSIm1advQ1X6XldJ7vEY+gALapomNIkstJZuo/TDZPQk
        1AdtV8nfsuk7J+QAQtlw/kYdwgo8M94tfabQ6nQp8qnHf0bv07MUXXRH0iyyWRfAixVB7H3TOwUXS
        pOLj0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b7w-0007Q0-A8; Mon, 04 Mar 2019 00:06:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BB581440082; Mon,  4 Mar 2019 00:06:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: pv88060: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000639.BB581440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pv88060: Convert to use regulator_set/get_current_limit_regmap

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 9a5b3e5b2f43e726afe3a628682f866d5cebb25f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Feb 2019 21:40:19 +0800
Subject: [PATCH] regulator: pv88060: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pv88060-regulator.c | 51 ++++-----------------------
 1 file changed, 7 insertions(+), 44 deletions(-)

diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index da6ed723e398..1600f9821891 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -53,10 +53,6 @@ enum {
 
 struct pv88060_regulator {
 	struct regulator_desc desc;
-	/* Current limiting */
-	unsigned	n_current_limits;
-	const int	*current_limits;
-	unsigned int limit_mask;
 	unsigned int conf;		/* buck configuration register */
 };
 
@@ -75,7 +71,7 @@ static const struct regmap_config pv88060_regmap_config = {
  * Entry indexes corresponds to register values.
  */
 
-static const int pv88060_buck1_limits[] = {
+static const unsigned int pv88060_buck1_limits[] = {
 	1496000, 2393000, 3291000, 4189000
 };
 
@@ -128,40 +124,6 @@ static int pv88060_buck_set_mode(struct regulator_dev *rdev,
 					PV88060_BUCK_MODE_MASK, val);
 }
 
-static int pv88060_set_current_limit(struct regulator_dev *rdev, int min,
-				    int max)
-{
-	struct pv88060_regulator *info = rdev_get_drvdata(rdev);
-	int i;
-
-	/* search for closest to maximum */
-	for (i = info->n_current_limits - 1; i >= 0; i--) {
-		if (min <= info->current_limits[i]
-			&& max >= info->current_limits[i]) {
-			return regmap_update_bits(rdev->regmap,
-				info->conf,
-				info->limit_mask,
-				i << PV88060_BUCK_ILIM_SHIFT);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int pv88060_get_current_limit(struct regulator_dev *rdev)
-{
-	struct pv88060_regulator *info = rdev_get_drvdata(rdev);
-	unsigned int data;
-	int ret;
-
-	ret = regmap_read(rdev->regmap, info->conf, &data);
-	if (ret < 0)
-		return ret;
-
-	data = (data & info->limit_mask) >> PV88060_BUCK_ILIM_SHIFT;
-	return info->current_limits[data];
-}
-
 static const struct regulator_ops pv88060_buck_ops = {
 	.get_mode = pv88060_buck_get_mode,
 	.set_mode = pv88060_buck_set_mode,
@@ -171,8 +133,8 @@ static const struct regulator_ops pv88060_buck_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
-	.set_current_limit = pv88060_set_current_limit,
-	.get_current_limit = pv88060_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 static const struct regulator_ops pv88060_ldo_ops = {
@@ -207,10 +169,11 @@ static const struct regulator_ops pv88060_sw_ops = {
 		.enable_mask = PV88060_BUCK_EN, \
 		.vsel_reg = PV88060_REG_##regl_name##_CONF0,\
 		.vsel_mask = PV88060_VBUCK_MASK,\
+		.curr_table = limits_array,\
+		.n_current_limits = ARRAY_SIZE(limits_array),\
+		.csel_reg = PV88060_REG_##regl_name##_CONF1,\
+		.csel_mask = PV88060_BUCK_ILIM_MASK,\
 	},\
-	.current_limits = limits_array,\
-	.n_current_limits = ARRAY_SIZE(limits_array),\
-	.limit_mask = PV88060_BUCK_ILIM_MASK, \
 	.conf = PV88060_REG_##regl_name##_CONF1,\
 }
 
-- 
2.20.1

