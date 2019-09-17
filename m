Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C19C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4DC214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568736186;
	bh=oQSrtoLmw01GmX3BOo+GBZyXvvwlUSsEoH+UH44Ii9w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=d0B2+AVC15oMf74HKDL+5FaY+FqZIw2DMmHu9qaK0N2W0Pu638it2+FxaaTz/ql37
	 DytevL0YOU4Je2OtiMFW6AgfGbLdJf4hQ5IXt3QBHwi7jHB/irJ1JBnZ3lE1/7ZB83
	 936SF4wZAW0AkngkUdDvWdsvrF2UTABXwg0DYr3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfIQQDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:03:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56572 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfIQQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jzQqPDNCshg/Zd6d4MvwNBT3FLgvcGKr/NrC8JhQeu8=; b=EMw2sNoDuuHl
        etl71c1SQ3OovCvc96/B6L9twH7JmY+ZS+WPFuwAtNvLfK6AT9hNweDWEGdaaL+mqX7ORROtLz+EX
        bKWylEomx+zK+ixsKNUyAHY/evlEQPlJe+WvFIRleL5kBpAZoPPc/gpkxWCZGmdtVTdNK7emaT0Fe
        5eSM4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAFwN-0008OQ-VA; Tue, 17 Sep 2019 16:02:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 76DB027428FE; Tue, 17 Sep 2019 17:02:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     broonie@kernel.org, ckeepax@opensource.cirrus.com,
        dianders@chromium.org, kernel@pengutronix.de, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        zhang.chunyan@linaro.org
Subject: Applied "regulator: of: fix suspend-min/max-voltage parsing" to the regulator tree
In-Reply-To: <20190917154021.14693-3-m.felsch@pengutronix.de>
X-Patchwork-Hint: ignore
Message-Id: <20190917160255.76DB027428FE@ypsilon.sirena.org.uk>
Date:   Tue, 17 Sep 2019 17:02:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: of: fix suspend-min/max-voltage parsing

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From 131cb1210d4b58acb0695707dad2eb90dcb50a2a Mon Sep 17 00:00:00 2001
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Tue, 17 Sep 2019 17:40:20 +0200
Subject: [PATCH] regulator: of: fix suspend-min/max-voltage parsing

Currently the regulator-suspend-min/max-microvolt must be within the
root regulator node but the dt-bindings specifies it as subnode
properties for the regulator-state-[mem/disk/standby] node. The only DT
using this bindings currently is the at91-sama5d2_xplained.dts and this
DT uses it correctly. I don't know if it isn't tested but it can't work
without this fix.

Fixes: f7efad10b5c4 ("regulator: add PM suspend and resume hooks")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Link: https://lore.kernel.org/r/20190917154021.14693-3-m.felsch@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/of_regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 9112faa6a9a0..38dd06fbab38 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -231,12 +231,12 @@ static int of_get_regulation_constraints(struct device *dev,
 					"regulator-off-in-suspend"))
 			suspend_state->enabled = DISABLE_IN_SUSPEND;
 
-		if (!of_property_read_u32(np, "regulator-suspend-min-microvolt",
-					  &pval))
+		if (!of_property_read_u32(suspend_np,
+				"regulator-suspend-min-microvolt", &pval))
 			suspend_state->min_uV = pval;
 
-		if (!of_property_read_u32(np, "regulator-suspend-max-microvolt",
-					  &pval))
+		if (!of_property_read_u32(suspend_np,
+				"regulator-suspend-max-microvolt", &pval))
 			suspend_state->max_uV = pval;
 
 		if (!of_property_read_u32(suspend_np,
-- 
2.20.1

