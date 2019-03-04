Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAC2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB8020830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658029;
	bh=OIbQp3mweUhBPtoQY5n1DjchA+Rxap+z5gzmzoyotBI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gpOdWE/+4Qh4soCddbTcKX/PU7NzSNIsrOwn9hwBef2El+VmtDk4tmMzO9Xi/6IWy
	 2OpCvhYyvRMDjgP9AaRbhPzyTUoglSe2deF1mq13P3mtqaTyYp55pZ8SyLoQCPy2Sg
	 9w3lhctbZVpz3F0dYj18pTkN6mX1nA73OCycsWj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCDAHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:07:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54622 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCDAG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AORIML7BV+dFIJB/4/oixw7vb47Pri/rGkHx1WKf854=; b=ZQYkk5TNBF1R
        8u0uYA1S5gNYiFi71zW4aA69razAevvsgc/GaKejCkgeXjTBhEYHFvWB7eoDlXalLdHjQBdGJL9Co
        vXQF1H8VKNycymB+0jf5Vt+quFC/7gKCXrA0ba/Pl3kRrtqp7IQ3w23blVBOy5ufVrmGX+jCpo/Qu
        q5dkY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b8B-0007Ql-Hq; Mon, 04 Mar 2019 00:06:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DCBFB440082; Mon,  4 Mar 2019 00:06:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Fix comment for csel_reg and csel_mask" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000654.DCBFB440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Fix comment for csel_reg and csel_mask

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

From 35d838ff98bc57c882eb610393c6b68455d3d9fe Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Feb 2019 21:40:12 +0800
Subject: [PATCH] regulator: Fix comment for csel_reg and csel_mask

The csel_reg and csel_mask fields in struct regulator_desc needs to
be generic for drivers. Not just for TPS65218.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regulator/driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 05efe2b057c1..b9557c9623b5 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -284,8 +284,8 @@ enum regulator_type {
  * @vsel_range_mask: Mask for register bitfield used for range selector
  * @vsel_reg: Register for selector when using regulator_regmap_X_voltage_
  * @vsel_mask: Mask for register bitfield used for selector
- * @csel_reg: Register for TPS65218 LS3 current regulator
- * @csel_mask: Mask for TPS65218 LS3 current regulator
+ * @csel_reg: Register for current limit selector using regmap set_current_limit
+ * @csel_mask: Mask for register bitfield used for current limit selector
  * @apply_reg: Register for initiate voltage change on the output when
  *                using regulator_set_voltage_sel_regmap
  * @apply_bit: Register bitfield used for initiate voltage change on the
-- 
2.20.1

