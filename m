Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD4C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C97D20883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561456454;
	bh=Iwt8ojU2pHbv9Ii6uQ5m3ER29DNjLneqS6Hx4N7ESQg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cZ7ntdcRKLqoLpugUIVxsuidPYJjGx/o4gutsUUN5LJcXebNSdMMUX3OhiBp0ddcA
	 LNHdfrKVzs/V3FRjmXZAUZzrZ00/KlJQt7Dw5Kk5zKTdENCUT66VpMlkScWQfzkChM
	 YILFqBzvynRpkcCO9zEd83B8FY5SKd6QBB1xjC48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbfFYJyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:54:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37282 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfFYJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Is1+qLfsClVYiQcPS895LnMxgYzGgmXn4MHHKf2bb7I=; b=cNk4HE2OKVSE
        St+k+AGRo3ZxuiSrky92SzPbqf4UFvfwEaI6n+IVKYrX9I8a/UrMrdqwLrHVHcLBYEwcUia2INzV6
        tYSzPa1lYqmLmz7LtxB7iiKinuPW52wKKTsZclliiDmWBvgkqOwMCSTdFIX/jZQuPsucp2HRopelY
        9mwNw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hfi9G-0004mc-GD; Tue, 25 Jun 2019 09:53:58 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 6A2A0440066; Mon, 24 Jun 2019 17:32:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, notify@kernel.org,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Applied "regulator: s2mps11: Reduce number of rdev_get_id() calls" to the regulator tree
In-Reply-To: <20190620183530.5386-2-krzk@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190624163221.6A2A0440066@finisterre.sirena.org.uk>
Date:   Mon, 24 Jun 2019 17:32:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s2mps11: Reduce number of rdev_get_id() calls

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

From df33799c5c3262a69acd29b7a4eb9e7cbd1b007c Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 20 Jun 2019 20:35:26 +0200
Subject: [PATCH] regulator: s2mps11: Reduce number of rdev_get_id() calls

Store the regulator ID instead of calling rdev_get_id() every time.
This makes code slightly easier to read as shorter 'rdev_id' variable is
used instead of full call.  This can also speed things up by reducing
number of calls, although effect was not measured.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s2mps11.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 134c62db36c5..93570712eb56 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -70,10 +70,11 @@ static int s2mps11_regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 				   unsigned int new_selector)
 {
 	struct s2mps11_info *s2mps11 = rdev_get_drvdata(rdev);
+	int rdev_id = rdev_get_id(rdev);
 	unsigned int ramp_delay = 0;
 	int old_volt, new_volt;
 
-	switch (rdev_get_id(rdev)) {
+	switch (rdev_id) {
 	case S2MPS11_BUCK2:
 		ramp_delay = s2mps11->ramp_delay2;
 		break;
@@ -111,9 +112,10 @@ static int s2mps11_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 	struct s2mps11_info *s2mps11 = rdev_get_drvdata(rdev);
 	unsigned int ramp_val, ramp_shift, ramp_reg = S2MPS11_REG_RAMP_BUCK;
 	unsigned int ramp_enable = 1, enable_shift = 0;
+	int rdev_id = rdev_get_id(rdev);
 	int ret;
 
-	switch (rdev_get_id(rdev)) {
+	switch (rdev_id) {
 	case S2MPS11_BUCK1:
 		if (ramp_delay > s2mps11->ramp_delay16)
 			s2mps11->ramp_delay16 = ramp_delay;
@@ -203,9 +205,8 @@ static int s2mps11_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 		goto ramp_disable;
 
 	/* Ramp delay can be enabled/disabled only for buck[2346] */
-	if ((rdev_get_id(rdev) >= S2MPS11_BUCK2 &&
-			rdev_get_id(rdev) <= S2MPS11_BUCK4) ||
-			rdev_get_id(rdev) == S2MPS11_BUCK6)  {
+	if ((rdev_id >= S2MPS11_BUCK2 && rdev_id <= S2MPS11_BUCK4) ||
+	    rdev_id == S2MPS11_BUCK6)  {
 		ret = regmap_update_bits(rdev->regmap, S2MPS11_REG_RAMP,
 					 1 << enable_shift, 1 << enable_shift);
 		if (ret) {
@@ -503,20 +504,21 @@ static const struct regulator_desc s2mps13_regulators[] = {
 static int s2mps14_regulator_enable(struct regulator_dev *rdev)
 {
 	struct s2mps11_info *s2mps11 = rdev_get_drvdata(rdev);
+	int rdev_id = rdev_get_id(rdev);
 	unsigned int val;
 
 	switch (s2mps11->dev_type) {
 	case S2MPS13X:
 	case S2MPS14X:
-		if (test_bit(rdev_get_id(rdev), s2mps11->suspend_state))
+		if (test_bit(rdev_id, s2mps11->suspend_state))
 			val = S2MPS14_ENABLE_SUSPEND;
-		else if (s2mps11->ext_control_gpiod[rdev_get_id(rdev)])
+		else if (s2mps11->ext_control_gpiod[rdev_id])
 			val = S2MPS14_ENABLE_EXT_CONTROL;
 		else
 			val = rdev->desc->enable_mask;
 		break;
 	case S2MPU02:
-		if (test_bit(rdev_get_id(rdev), s2mps11->suspend_state))
+		if (test_bit(rdev_id, s2mps11->suspend_state))
 			val = S2MPU02_ENABLE_SUSPEND;
 		else
 			val = rdev->desc->enable_mask;
@@ -570,7 +572,7 @@ static int s2mps14_regulator_set_suspend_disable(struct regulator_dev *rdev)
 	if (ret < 0)
 		return ret;
 
-	set_bit(rdev_get_id(rdev), s2mps11->suspend_state);
+	set_bit(rdev_id, s2mps11->suspend_state);
 	/*
 	 * Don't enable suspend mode if regulator is already disabled because
 	 * this would effectively for a short time turn on the regulator after
@@ -856,8 +858,9 @@ static int s2mps11_pmic_dt_parse(struct platform_device *pdev,
 static int s2mpu02_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 {
 	unsigned int ramp_val, ramp_shift, ramp_reg;
+	int rdev_id = rdev_get_id(rdev);
 
-	switch (rdev_get_id(rdev)) {
+	switch (rdev_id) {
 	case S2MPU02_BUCK1:
 		ramp_shift = S2MPU02_BUCK1_RAMP_SHIFT;
 		break;
-- 
2.20.1

