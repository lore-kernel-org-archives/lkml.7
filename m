Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A962CA9EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6223821906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571856977;
	bh=qku/IeDiKmYSe8V7I/U9iuWDuHuGMlCSTQSWtE1Lu6Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=u2iCvg/JgoiLvPZmtecs7SSCKT2HIT4Iph7j4PTm4nq7tqPwTbingZ7i44iKO4G0w
	 8sIVU6Ulya5CzIp33GScDAQPHWVEEiFFoipZim6j4sNXGqC99d8qBZpfdSvb4XU+5d
	 n3+EhVUYzqlkfSNjdYobQ8IPK0zN5sSTPWOfJWEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404461AbfJWS4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:56:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59378 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJWS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TnhcvqGIFKnz9lf8OV8nCnZizb4cr6gyBDUnaKlbK5Q=; b=ESz8SQfkF8mz
        KtoZjP4wE9f5fRgQzfqfwvP24AykigX9cveHf/ii+UqsSfFoKc492pmwwO2XmvNldmKRnyTgNYeYx
        O5Yz3X+W87Er3qp4vd3UArwD7xW6PT32o43NgFSNQHASxlbcNgrmBUR6ErvsPp5c4Z/wVZLYLckox
        0Eky4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNLno-0001CK-Pa; Wed, 23 Oct 2019 18:56:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 377F72743021; Wed, 23 Oct 2019 19:56:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Subject: Applied "regulator: bd70528: Add MODULE_ALIAS to allow module auto loading" to the regulator tree
In-Reply-To: <20191023121452.GA1812@localhost.localdomain>
X-Patchwork-Hint: ignore
Message-Id: <20191023185612.377F72743021@ypsilon.sirena.org.uk>
Date:   Wed, 23 Oct 2019 19:56:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd70528: Add MODULE_ALIAS to allow module auto loading

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

From 55d5f62c3fa005a6a8010363d7d1855909ceefbc Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Wed, 23 Oct 2019 15:14:52 +0300
Subject: [PATCH] regulator: bd70528: Add MODULE_ALIAS to allow module auto
 loading

The bd70528 regulator driver is probed by MFD driver. Add MODULE_ALIAS
in order to allow udev to load the module when MFD sub-device cell for
regulators is added.

Fixes: 99ea37bd1e7d7 ("regulator: bd70528: Support ROHM BD70528 regulator block")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Link: https://lore.kernel.org/r/20191023121452.GA1812@localhost.localdomain
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd70528-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 0248a61f1006..ec764022621f 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -286,3 +286,4 @@ module_platform_driver(bd70528_regulator);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD70528 voltage regulator driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bd70528-pmic");
-- 
2.20.1

