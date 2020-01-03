Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A5C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9826206F0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578013552;
	bh=K9PU5OM43+DZjqnKwTii3q2ndbtF5JZDVy8H/vN1DYM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Gh2ZOuI3vXC+IWgi8I04aW3fjWEwhNr1vSbRWRWmXasSKeEZBP9bhMOjW7pRpPxS6
	 qMtxhvgNIGh/gahPu6wJzXDTxivMdGJRvw7A1Ye8RvzH+Np/fKT2D2DvPOFmlmDfHY
	 VqKRG58D/AmJSi5JXT/tblVsPDo6sGtVKmYwUDdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgACBFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:05:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgACBFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZxcMcLfot7xo6EssDktbBsk+589T4RjerrR0FevBARM=; b=GQlW/+466e3E
        InjiITQEs7ZG6mLBpevW5RmSeFSwOlKdg1FxdRtaC+nzYFnE5ayPGYE6vtGerNnS7VCChQuKz401b
        adQZeejUgJOX/2THYWc84nXNPnAGtNm4vZPSo0k9Kw32z87Hy07JQbg7iYOOGcHeprVsC2PqTSZrG
        rOpNY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1inBPP-0003NP-8Y; Fri, 03 Jan 2020 01:05:47 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id AE24ED057C6; Fri,  3 Jan 2020 01:05:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Applied "regulator: bd70528: Remove .set_ramp_delay for bd70528_ldo_ops" to the regulator tree
In-Reply-To: <20200101022406.15176-1-axel.lin@ingics.com>
Message-Id: <applied-20200101022406.15176-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Date:   Fri,  3 Jan 2020 01:05:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd70528: Remove .set_ramp_delay for bd70528_ldo_ops

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

From 6f1ff76154b8b36033efcbf6453a71a3d28f52cd Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 1 Jan 2020 10:24:06 +0800
Subject: [PATCH] regulator: bd70528: Remove .set_ramp_delay for
 bd70528_ldo_ops

The .set_ramp_delay should be for bd70528_buck_ops only.
Setting .set_ramp_delay for for bd70528_ldo_ops causes problem because
BD70528_MASK_BUCK_RAMP (0x10) overlaps with BD70528_MASK_LDO_VOLT (0x1f).
So setting ramp_delay for LDOs may change the voltage output, fix it.

Fixes: 99ea37bd1e7d ("regulator: bd70528: Support ROHM BD70528 regulator block")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Link: https://lore.kernel.org/r/20200101022406.15176-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd70528-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 0248a61f1006..6041839ec38c 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -101,7 +101,6 @@ static const struct regulator_ops bd70528_ldo_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-	.set_ramp_delay = bd70528_set_ramp_delay,
 };
 
 static const struct regulator_ops bd70528_led_ops = {
-- 
2.20.1

