Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FCEC33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321FE207FA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573820788;
	bh=ShLByoMib5GDWRmGpfAXmcxKahyzswH+OvSeSQ7l7oM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BOdQZgdWxG+PVox2ik8lui7sUMm+CA12/HnMOYzaTW0l4t020OVI8xCd+aoazuJVw
	 n/IjQdmfCTsMqB6/nzhxCyCLs4a8/F+ErxhMya+hAqmml23LRWEO1jxEWQv1A83k95
	 zbcne9AAJcr1VU3iy/7cE3RMkPwiADs/FPmwxxdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfKOMZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:25:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32828 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfKOMZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fz8jcrh/IFmNSf19R75zpgiaL6oK1a5JOhUgpBqW6fc=; b=HjTNCn/EvDkn
        RhKF2VsqyIx3Q2q0f/KdcCi9w5udwexkzZ/i1+AwwbhOJu3oquvRWaL7eKb0kwVLXmj0V9a3d0HC/
        OW8v5b5HVBZjZqLQvVOjwmb0/JsvjRPNA3HvNx7yQb/NsvCX7DgWUOpz16q1WwH1D1AV8WXHUotP1
        FyB1M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaey-0000Kt-GT; Fri, 15 Nov 2019 12:25:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 02ABF27415A7; Fri, 15 Nov 2019 12:25:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal Paillet <p.paillet@st.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        pascal paillet <p.paillet@st.com>, p.paillet@st.com
Subject: Applied "regulator: stpmic1: Set a default ramp delay value" to the regulator tree
In-Reply-To: <20191113161529.27739-1-p.paillet@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20191115122508.02ABF27415A7@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:25:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stpmic1: Set a default ramp delay value

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

From 9ebde17c5d0387a5e1f71e687ac35d36e01208cc Mon Sep 17 00:00:00 2001
From: Pascal Paillet <p.paillet@st.com>
Date: Wed, 13 Nov 2019 17:15:29 +0100
Subject: [PATCH] regulator: stpmic1: Set a default ramp delay value

Set a default ramp delay value to the regulators with the worst
case value.

Signed-off-by: pascal paillet <p.paillet@st.com>
Link: https://lore.kernel.org/r/20191113161529.27739-1-p.paillet@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stpmic1_regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index f09061473613..f3d7d007ecbb 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -54,6 +54,8 @@ enum {
 
 /* Enable time worst case is 5000mV/(2250uV/uS) */
 #define PMIC_ENABLE_TIME_US 2200
+/* Ramp delay worst case is (2250uV/uS) */
+#define PMIC_RAMP_DELAY 2200
 
 static const struct regulator_linear_range buck1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(725000, 0, 4, 0),
@@ -208,6 +210,7 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
+	.ramp_delay = PMIC_RAMP_DELAY, \
 	.supply_name = #base, \
 }
 
@@ -227,6 +230,7 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
+	.ramp_delay = PMIC_RAMP_DELAY, \
 	.bypass_reg = LDO3_ACTIVE_CR, \
 	.bypass_mask = LDO_BYPASS_MASK, \
 	.bypass_val_on = LDO_BYPASS_MASK, \
@@ -248,6 +252,7 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
+	.ramp_delay = PMIC_RAMP_DELAY, \
 	.supply_name = #base, \
 }
 
@@ -267,6 +272,7 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
+	.ramp_delay = PMIC_RAMP_DELAY, \
 	.of_map_mode = stpmic1_map_mode, \
 	.pull_down_reg = ids##_PULL_DOWN_REG, \
 	.pull_down_mask = ids##_PULL_DOWN_MASK, \
-- 
2.20.1

