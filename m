Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274BCC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFCB20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555432386;
	bh=hzigErsAKupCh0t6dfp1o/z2vlvI7UTYq5c79l3wGao=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AwEtVN9qDMavLJlOK6wrv9gAKBxE7IU3QPgS2Kp4gWwqxhgQ9pFa9faXnP5XED736
	 vrl90mr+LBCZ1mxmMx+OF1GBbMp33pWUrjFKkuyKuKCwIpDNXrKv9u/idZ+LHN8Hhv
	 ZkBrnk/Df99BkrLzXGC6hjxOW0iO/vcjVsKxCexs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfDPQdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:33:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60972 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPQdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Tp04qHf8O9BOLxeCihX+VVZhS1G8EJ/vQIinK/JsbIQ=; b=E61wyncYJWRR
        i6k1N9fIRNK86HTC3+3Jn+wwmvoZ1cK0m2XFgfNX0/91/zdmht4hxl8jrWc3VR129oOm5L9NnXL2p
        aYAPDc4XtL4gmIcNuDcMU4B+ezGvB1MNXPykHzMStdLYHEpNRI7x7SeNl+4jctoq4lf3XZzU4ePzx
        M6To0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGR10-0007rc-1G; Tue, 16 Apr 2019 16:32:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F3DD7112827A; Tue, 16 Apr 2019 17:32:56 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps80031: Constify regulator_ops and tps80031_dcdc_voltages array" to the regulator tree
In-Reply-To: <20190416101729.26330-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190416163256.F3DD7112827A@debutante.sirena.org.uk>
Date:   Tue, 16 Apr 2019 17:32:56 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps80031: Constify regulator_ops and tps80031_dcdc_voltages array

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

From 4b77a49cb82652488e35ed8d3809f33cedbad6dc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 16 Apr 2019 18:17:28 +0800
Subject: [PATCH] regulator: tps80031: Constify regulator_ops and
 tps80031_dcdc_voltages array

These regulator_ops variables and tps80031_dcdc_voltages array never need
to be modified, make them const so compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps80031-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index d97cd55b6850..8e65a13e2ef5 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -154,7 +154,7 @@ static int tps80031_reg_disable(struct regulator_dev *rdev)
 }
 
 /* DCDC voltages for the selector of 58 to 63 */
-static int tps80031_dcdc_voltages[4][5] = {
+static const int tps80031_dcdc_voltages[4][5] = {
 	{ 1350, 1500, 1800, 1900, 2100},
 	{ 1350, 1500, 1800, 1900, 2100},
 	{ 2084, 2315, 2778, 2932, 3241},
@@ -377,7 +377,7 @@ static int tps80031_vbus_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static struct regulator_ops tps80031_dcdc_ops = {
+static const struct regulator_ops tps80031_dcdc_ops = {
 	.list_voltage		= tps80031_dcdc_list_voltage,
 	.set_voltage_sel	= tps80031_dcdc_set_voltage_sel,
 	.get_voltage_sel	= tps80031_dcdc_get_voltage_sel,
@@ -386,7 +386,7 @@ static struct regulator_ops tps80031_dcdc_ops = {
 	.is_enabled	= tps80031_reg_is_enabled,
 };
 
-static struct regulator_ops tps80031_ldo_ops = {
+static const struct regulator_ops tps80031_ldo_ops = {
 	.list_voltage		= tps80031_ldo_list_voltage,
 	.map_voltage		= tps80031_ldo_map_voltage,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
@@ -396,18 +396,18 @@ static struct regulator_ops tps80031_ldo_ops = {
 	.is_enabled		= tps80031_reg_is_enabled,
 };
 
-static struct regulator_ops tps80031_vbus_sw_ops = {
+static const struct regulator_ops tps80031_vbus_sw_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= tps80031_vbus_enable,
 	.disable	= tps80031_vbus_disable,
 	.is_enabled	= tps80031_vbus_is_enabled,
 };
 
-static struct regulator_ops tps80031_vbus_hw_ops = {
+static const struct regulator_ops tps80031_vbus_hw_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 };
 
-static struct regulator_ops tps80031_ext_reg_ops = {
+static const struct regulator_ops tps80031_ext_reg_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= tps80031_reg_enable,
 	.disable	= tps80031_reg_disable,
-- 
2.20.1

