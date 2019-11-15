Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69149C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380632075E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573820776;
	bh=2kT458QwiUoJ1anrPh85zSPZ+t9Tlaax6hx/8GssUrU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Kil+3po8PQzc/FmNmmo/SvlqzsIrios5Yfax2s+tL8sSFK9780N5dgk3arvTek5MI
	 a9H8gNML+cxno2uludirY4WGyCD45MkRwjY4ga5P3H784Gg9G6WKG77O70udL7g6VW
	 +TTn0odM23x3fAJaUcEiVpc5AMWj5vomjSOx3LF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfKOM0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:26:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32956 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfKOMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NoJQ/BiAhwJPJINl8oVLkVKiRSpmH92kSU++XZetC4w=; b=AX7xCxNoUWqj
        vtQ7yCrfzLG7qoCLrx8SeqModvFHZhqGcXsHGU8f0pPjbTnSPNs7C88qKQ0OIVB6RRQ5noDvHyVNl
        GyEVps9wjMmmyFD5WIQVNuKrmAr+kwtGtINtOUJYg+FFDbJVWyb9gFAYhb/W4Bttk+Y9/ceHShYaO
        lsDOM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaex-0000Km-W9; Fri, 15 Nov 2019 12:25:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7C3AF2741609; Fri, 15 Nov 2019 12:25:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Fritz <chf.fritz@googlemail.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Christian Hemp <c.hemp@phytec.de>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: da9062: add of_map_mode support for bucks" to the regulator tree
In-Reply-To: <1573652416-9848-3-git-send-email-chf.fritz@googlemail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191115122507.7C3AF2741609@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:25:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9062: add of_map_mode support for bucks

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From 844e7492ee3da1a8714bf3cc1dd54d777a5257c2 Mon Sep 17 00:00:00 2001
From: Christoph Fritz <chf.fritz@googlemail.com>
Date: Wed, 13 Nov 2019 14:40:14 +0100
Subject: [PATCH] regulator: da9062: add of_map_mode support for bucks

This patch adds of_map_mode support for bucks to set regulator modes
from within regulator framework.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Signed-off-by: Christian Hemp <c.hemp@phytec.de>
Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Link: https://lore.kernel.org/r/1573652416-9848-3-git-send-email-chf.fritz@googlemail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 601002e3e012..29f4a60398a3 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -98,6 +98,20 @@ static const unsigned int da9062_buck_b_limits[] = {
 	2300000, 2400000, 2500000, 2600000, 2700000, 2800000, 2900000, 3000000
 };
 
+static unsigned int da9062_map_buck_mode(unsigned int mode)
+{
+	switch (mode) {
+	case DA9063_BUCK_MODE_SLEEP:
+		return REGULATOR_MODE_STANDBY;
+	case DA9063_BUCK_MODE_SYNC:
+		return REGULATOR_MODE_FAST;
+	case DA9063_BUCK_MODE_AUTO:
+		return REGULATOR_MODE_NORMAL;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int da9062_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
@@ -360,6 +374,7 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK1_A,
 		.desc.vsel_mask = DA9062AA_VBUCK1_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_buck_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK1_A,
 			__builtin_ffs((int)DA9062AA_BUCK1_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -396,6 +411,7 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK3_A,
 		.desc.vsel_mask = DA9062AA_VBUCK3_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_buck_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK3_A,
 			__builtin_ffs((int)DA9062AA_BUCK3_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -432,6 +448,7 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK4_A,
 		.desc.vsel_mask = DA9062AA_VBUCK4_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_buck_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK4_A,
 			__builtin_ffs((int)DA9062AA_BUCK4_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -604,6 +621,7 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK1_A,
 		.desc.vsel_mask = DA9062AA_VBUCK1_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_buck_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK1_A,
 			__builtin_ffs((int)DA9062AA_BUCK1_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -640,6 +658,7 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK2_A,
 		.desc.vsel_mask = DA9062AA_VBUCK2_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_buck_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK2_A,
 			__builtin_ffs((int)DA9062AA_BUCK2_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -676,6 +695,7 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK3_A,
 		.desc.vsel_mask = DA9062AA_VBUCK3_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_buck_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK3_A,
 			__builtin_ffs((int)DA9062AA_BUCK3_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -712,6 +732,7 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK4_A,
 		.desc.vsel_mask = DA9062AA_VBUCK4_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_buck_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK4_A,
 			__builtin_ffs((int)DA9062AA_BUCK4_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-- 
2.20.1

