Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF104C31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0BD20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560188092;
	bh=jWkAWQunZXXWSf+rGiHXL9t60c8lnlyNwKwze0ZWG/c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HOM4BM6M5bbmzO9X1undS3mVswpGns49vDfkG6WecHx74icGB26TkNeEendgJnvzK
	 Y2mpMgWWuoLpeBuxX525XGXfNKlxGvfP4TL0kn7Cwt/aOrceAvuaNHGBrqHCkPE/m/
	 aR6xYDeMhbmWrPFq4FI3Iky5yKLa+gvo/StkiMjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbfFJRev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:34:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53022 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388170AbfFJRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jpIsnQKToLnfohGME7GlwGk9uxrjkhAPVWzXiTiDiLc=; b=wrdkbQAWqIyR
        6HwbjH6zBnFBJ9bwyB/T71DJmGBVMBAuSfEcL8xQCREYWl1HoCkRxGO+bqQZEC9fIJ9uJ6pEhtp/w
        z0tFevrdlr4v36b7vVug1wD8PvXA/ACah9KORB210WHjNdjs5h1PR0kBG4C8RgVzMloMWoUAyYyk9
        0nMfI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1haOBy-0006G0-Jh; Mon, 10 Jun 2019 17:34:46 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 29048440046; Mon, 10 Jun 2019 18:34:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max77802: Drop unused includes" to the regulator tree
In-Reply-To: <20190609110513.29220-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190610173446.29048440046@finisterre.sirena.org.uk>
Date:   Mon, 10 Jun 2019 18:34:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77802: Drop unused includes

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

From d17adf7d3f5be74bdfda89ceed7bff3910ffb6d4 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 9 Jun 2019 13:05:13 +0200
Subject: [PATCH] regulator: max77802: Drop unused includes

This driver does not use any symbols from <linux/gpio.h>
no <linux/gpio/consumer.h> so just drop the includes.

Cc: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77802-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index ea7b50397300..7b8ec8c0bd15 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -14,9 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
-#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
-- 
2.20.1

