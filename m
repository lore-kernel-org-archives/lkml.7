Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C11C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59279253C3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559584955;
	bh=G8eYNbtU8N+3Z5oxkIr7VnDtXStm0u2Uqu6Xk+AXLec=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=uWLpl2L4CrXmdlsjl0H73IpMIPsN9ToP/p87rMEbi70AtY3BkiiPVbKGalKYXD4GK
	 8RaggbfRfvsaLKDFeDqXnr2Qz4I70pL3cFt/Q42M31I8xljSN9eNYvZ/9IXjS9uBnV
	 eUmlDp9jrOJ1lBhIE7BzEElewHDWjdvnpHnblmBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFCSCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:02:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56006 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCSCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=otpltEqbxE1wG10DlJ6Z/RYoNO63SjV1X4IyXsWQwhE=; b=Y9sfrIpFqsVC
        1OlomFRVLJTOPI7AuJwoUopr8UyAvQ37S1jCySeES2n7VBFgLRI2+juQwfKdHFvK0KkEbYPMUP7EO
        KxSSJfQQyaWKsL0Dy5RNgehRAOnibQw+muTMllmVnwPbpZ8zQlVXWQip2i5eX2eNfqckxCb3Zv6vn
        mGfx4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXrHx-0003aX-6K; Mon, 03 Jun 2019 18:02:29 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 99362440049; Mon,  3 Jun 2019 19:02:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Applied "regulator: bd70528: Drop unused include" to the regulator tree
In-Reply-To: <20190531230608.7361-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190603180228.99362440049@finisterre.sirena.org.uk>
Date:   Mon,  3 Jun 2019 19:02:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd70528: Drop unused include

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

From 532e9334eb38de50d75b6a0e94832ee9d9975743 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 1 Jun 2019 01:06:08 +0200
Subject: [PATCH] regulator: bd70528: Drop unused include

This driver does not use any symbols from <linux/gpio.h>
so just drop the include.

Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd70528-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 30e3ed430a8a..0248a61f1006 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -4,7 +4,6 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd70528.h>
-- 
2.20.1

