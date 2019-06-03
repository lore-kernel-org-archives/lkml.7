Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BB9C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D08621900
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559584963;
	bh=Fme9iwxnMfuHajbWkaFwEutmc986rRPwZuRudH7litw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2UBbzVMumImro4m69COrRIEb2sSfw2E4Ain7KX9nawUkDc/rzXGPqEjjcxHAKfIhv
	 MZIiQn6VwFll2blAwu3P6ZGphsSwnW0jy+tmdeFQs5VT74KHO7a6qPciSsCcJF8bqR
	 OD+/p33QBEAnE93q6kxTNPMOjfwIBiwXCZWOHBRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfFCSCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:02:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56142 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfFCSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VXZFoIxhi+ru17r3G4lihTvQcDcxm5W+K1yLNf/64JA=; b=H87zknG8AaTd
        qKMCwg9cVI5tr+9dXFMVIEKrHkLy9oGbx8CTGl1kIQv8j5vBF+gKKtZSBEDuV/Qs8iamJhxZ/ci0g
        1WOK5Of6+1P0ZcWX+j2f0q+bPNbbkWU7qLpVTfO3mn+nbyH9930O7FQDB7kNgNXRNMfkasZzLFYl1
        ahx4I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXrHx-0003ac-S5; Mon, 03 Jun 2019 18:02:29 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 325BA440046; Mon,  3 Jun 2019 19:02:29 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: arizona-micsupp: Delete unused include" to the regulator tree
In-Reply-To: <20190531230252.6541-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190603180229.325BA440046@finisterre.sirena.org.uk>
Date:   Mon,  3 Jun 2019 19:02:29 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona-micsupp: Delete unused include

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

From 60b909e413dab4d131a6629dce1fb2177d3cc918 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 1 Jun 2019 01:02:52 +0200
Subject: [PATCH] regulator: arizona-micsupp: Delete unused include

This driver uses no symbols from <linux/gpio.h> so just drop
this include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-micsupp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index de6802b85e9f..ae1a5de3e57d 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -16,7 +16,6 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <sound/soc.h>
-- 
2.20.1

