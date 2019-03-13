Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C5FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D072171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491588;
	bh=7RpSNMUg9sbmjCpAWm4+1FRRVQvJHm49ZXykN6ZICTw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ahpN+eQmmoRm4xULTxcOLCGS+NRk6+Stzc45iebxLg9hui5Gkgxo1tTK3wJ1+7KRq
	 Qdlnxb7E3Fz+fhU7pnoKWwGVZD70qAI1Zde2fhWgyOLJDGedmDNM8yppTsCXyqNqqh
	 Od/lz8j/OrxTCUdyfajuEtXAzNYrRm406vnBx25k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfCMPjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51028 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCMPjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bMg03Gd6bcAgOPO6FwSfg80y+qjJq5SYCbOEe0aTwSY=; b=ZcoouyEIc565
        aAAek+RbkAq+07Ts81fZTEUrdm4y6u9TX17Y5qaVC8z6bB49Ht4IuvM0jm3Z4laZFwsWfaWQeBHi+
        HZnlOMZ50dZhhP10bQ9cXgUpLCafRf4t9GtjnN9bVp1bHmGBEZrfHUuboEwQSSP5z2A37BeLE7W5V
        bmaYU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45yn-0003UJ-6B; Wed, 13 Mar 2019 15:39:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ADF971128B97; Wed, 13 Mar 2019 15:39:40 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm8400: Fix trivial typo" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190313153940.ADF971128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:39:40 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm8400: Fix trivial typo

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

From 178d08ea81b1538ea0b2c432a3ddda53b7fec296 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 27 Feb 2019 13:54:21 +0800
Subject: [PATCH] regulator: wm8400: Fix trivial typo

Use WM8400_DC2_ENA_MASK for DCDC2 enable_mask.
The define is the same as WM8400_DC1_ENA_MASK, just a cleanup.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm8400-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index 40c4e6628471..5ce86b92851b 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -194,7 +194,7 @@ static struct regulator_desc regulators[] = {
 		.id = WM8400_DCDC2,
 		.ops = &wm8400_dcdc_ops,
 		.enable_reg = WM8400_DCDC2_CONTROL_1,
-		.enable_mask = WM8400_DC1_ENA_MASK,
+		.enable_mask = WM8400_DC2_ENA_MASK,
 		.n_voltages = WM8400_DC2_VSEL_MASK + 1,
 		.vsel_reg = WM8400_DCDC2_CONTROL_1,
 		.vsel_mask = WM8400_DC2_VSEL_MASK,
-- 
2.20.1

