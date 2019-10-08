Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928BCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1E020673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570531995;
	bh=Xb2L8ZNSHXHbIvM6x77IpqB5ZmknculTANIovynndz4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XShlcXGW6opyhIZXCCyBJb8HzkjELNwmHK0p/205eG03zh5ubOJ6mjHjXjYSEaxFM
	 zsfHHA1W0jJKbddlBsGfmR17Wr5ab/ouBwnp9+QvVD5l6NQvMdzlCdKSKdmLXoZ9yQ
	 kcl7A2Ih1cHqLAlMbohFGxOh+I7IW+MNkJzsRux4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfJHKxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:53:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47622 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbfJHKwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ngt3gSvS1KH6rVDgxpsnLeZZYKwMM9UIKM2G9/QBotk=; b=TGm54aoVA/Ji
        rdLAkOiG3y3eitoFt72K7QEtPTG6ziFkQFm5uLm91+ThVyYiZuG62oXG0hFkyqf0voncw6Ke8qAL9
        ULe1c9WexgjAB/aLW6msUm8HCjNJVezQrUjNoiWwI9b+LEYvxlJZGMPOb69m05fbctklNcIh+WqVF
        QMuY8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHn6n-00083Y-B6; Tue, 08 Oct 2019 10:52:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CDB5D274299F; Tue,  8 Oct 2019 11:52:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Tony Xie <tony.xie@rock-chips.com>
Subject: Applied "regulator: rk808: Constify rk817 regulator_ops" to the regulator tree
In-Reply-To: <20191008010628.8513-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20191008105248.CDB5D274299F@ypsilon.sirena.org.uk>
Date:   Tue,  8 Oct 2019 11:52:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rk808: Constify rk817 regulator_ops

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

From 2e67f32296e3f1841793e36ce796f1497614c687 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 8 Oct 2019 09:06:26 +0800
Subject: [PATCH] regulator: rk808: Constify rk817 regulator_ops

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20191008010628.8513-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 61bd5ef0806c..eda056fce65f 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -686,7 +686,7 @@ static const struct regulator_linear_range rk805_buck_1_2_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(2300000, 63, 63, 0),
 };
 
-static struct regulator_ops rk809_buck5_ops_range = {
+static const struct regulator_ops rk809_buck5_ops_range = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -700,7 +700,7 @@ static struct regulator_ops rk809_buck5_ops_range = {
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
 
-static struct regulator_ops rk817_reg_ops = {
+static const struct regulator_ops rk817_reg_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -713,7 +713,7 @@ static struct regulator_ops rk817_reg_ops = {
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
 
-static struct regulator_ops rk817_boost_ops = {
+static const struct regulator_ops rk817_boost_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -725,7 +725,7 @@ static struct regulator_ops rk817_boost_ops = {
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
 
-static struct regulator_ops rk817_buck_ops_range = {
+static const struct regulator_ops rk817_buck_ops_range = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -743,7 +743,7 @@ static struct regulator_ops rk817_buck_ops_range = {
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
 
-static struct regulator_ops rk817_switch_ops = {
+static const struct regulator_ops rk817_switch_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= rk8xx_is_enabled_wmsk_regmap,
-- 
2.20.1

