Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09A7C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFA226B4B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559584959;
	bh=Y8GwcBFlxQtDqR/g5UMTqq5QCjuTQuTWKI94XEt5wP4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ewJ1u3LKGR/IZDZGk2WMjNz/kVkk4B0xEg2eNkxsOpHgd4GEe4f7yD+zkRUpMNpLU
	 tWs5ktyB/my1a99RkqNNZxzs6h+EMGZIm+av2CgYeHNCT155ywwUR0uOQGhQ0H56rR
	 nUnEXuL/mkiCKFjQYoOG70l7fqy5kXBWRDWbK1w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFCSCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:02:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56082 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NLQI+tGOyr+RskvUQuRtxdHYuF/GDgmGTjO7Ul5MBBs=; b=XXRu82FJE1JE
        5gB2EjnOVArBgUCqJKA+K52M8jqzy8Sr6dfhUyG852GXWG32LBft1ihCqOGqggxzT8rmUXnEzgI6a
        +bXeT6QJp1dRcdkn5VWYe8cT8///4Hq5QP/cjcZpihtOBdHDPclehQNip2jmJzMv6jyM7x8pM/Zh0
        rR1mE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXrHw-0003aW-MD; Mon, 03 Jun 2019 18:02:28 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 12077440046; Mon,  3 Jun 2019 19:02:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Applied "regulator: bd718x7: Drop unused include" to the regulator tree
In-Reply-To: <20190531230851.8084-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190603180228.12077440046@finisterre.sirena.org.uk>
Date:   Mon,  3 Jun 2019 19:02:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd718x7: Drop unused include

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

From 5cbb1515e75c0b8d328ddce0f5e4ff636334373c Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 1 Jun 2019 01:08:51 +0200
Subject: [PATCH] regulator: bd718x7: Drop unused include

This driver does not use any symbols from <linux/gpio.h>
so just drop the include.

Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd718x7-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index fde4264da6ff..8c22cfb76173 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -4,7 +4,6 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd718x7.h>
-- 
2.20.1

