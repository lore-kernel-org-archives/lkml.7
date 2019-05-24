Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D8FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB18921773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558699976;
	bh=oU70x9WD0KRbUXZgWqmKrC7f3GP2Mzsg67maRVKYUBo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0HdRQrmkoZrNsA3u9+Nnak0tJxY7GQClUClT5dbYoo2t6UlmLyWTR5eGRl1x9Wbux
	 dMAhVw25DM08eGmQ2iG/YWQ8yEwo1iU0xJzoHQQBrkfp0mvWQHQuuk9lSn76HS66AT
	 uEsEs1Eo0hB4ZSDxy8NTsJdfqFraQqbhO+Qkm6WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391528AbfEXMMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:12:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43384 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391465AbfEXMMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ic6SaIUprOJ9l44L07M1AKULLelAxLdceTmb7ck22Uw=; b=X3yU+3QEpVC4
        j5toY3+4z5P40Fkm2ukgqzX4aT0PM5B9or8M1HUE0O9r5aXDwyTOCTxLqByiiWBnZIMUcSE8nlNAX
        hjCcKhnIRdBdY/vlo3BWtxa5Tb+FPne7rOajAcNnyBebn1L2MPGaHmWxqPNnTSSYN8GJp0ejcxPj/
        eqVMI=;
Received: from [176.12.107.140] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hU943-0003DX-TR; Fri, 24 May 2019 12:12:48 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id E219E440049; Fri, 24 May 2019 13:12:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Eric Jeong <eric.jeong.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: slg51000: Constify slg51000_regl_ops and slg51000_switch_ops" to the regulator tree
In-Reply-To: <20190524100247.7267-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190524121246.E219E440049@finisterre.sirena.org.uk>
Date:   Fri, 24 May 2019 13:12:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: slg51000: Constify slg51000_regl_ops and slg51000_switch_ops

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

From 0a33d4feea748399c9341ff054c5f29c98393d35 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 24 May 2019 18:02:46 +0800
Subject: [PATCH] regulator: slg51000: Constify slg51000_regl_ops and
 slg51000_switch_ops

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/slg51000-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 12e21d43030b..a06a18f220e0 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -183,7 +183,7 @@ static const struct regmap_config slg51000_regmap_config = {
 	.volatile_table = &slg51000_volatile_table,
 };
 
-static struct regulator_ops slg51000_regl_ops = {
+static const struct regulator_ops slg51000_regl_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -193,7 +193,7 @@ static struct regulator_ops slg51000_regl_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 };
 
-static struct regulator_ops slg51000_switch_ops = {
+static const struct regulator_ops slg51000_switch_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-- 
2.20.1

