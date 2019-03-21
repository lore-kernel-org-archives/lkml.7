Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D255C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1835218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553180869;
	bh=mS16fVJ/nehW4xcpn3UwSENIDMDR0+sYeeHnTyBQ3Pc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=um3aDRHhW7A78UZ7svO33qAwg38wj22NesFh2RGGzSqwtkHGesurmj+or/wGxNQw3
	 WP/PgSXtgykGzrh4wqUVSoZYQBOOi6DBdD1FgFsJTNDomg/K1LmH35GIbYo/jKZzLo
	 b/UAZTNhhu/219X70SapAYPWksbBZ173PBL8s9sI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfCUPHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:07:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48520 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfCUPHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ibOJY8C3En9zuMvunG0fjuaB8DvNrqc9sbjoShd2I9g=; b=OVyid4obSYi1
        7jqJnHO6rKPBNTEgb0T4c1jvSbO+P8y/+Nf1K+ly5PNcMgVpLacwtJJZf4bCyPE4RSUi8oL+F/G88
        W+aVKXEBTLdAQYD+LSn48Rvi5E95cGMJuuZhfQPYW+3VWAIAtf8nkccn+rf5ZMmePVYm/5Lf0seCr
        VzDm4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6zI9-0005dt-5Y; Thu, 21 Mar 2019 15:07:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 910B511288EC; Thu, 21 Mar 2019 15:07:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: export tracepoint symbols to modules" to the spi tree
In-Reply-To:  <20190321124240.901884-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190321150736.910B511288EC@debutante.sirena.org.uk>
Date:   Thu, 21 Mar 2019 15:07:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: export tracepoint symbols to modules

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From ca1438dcb34c7fcad63b6ce14ea63a870b92a69b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 21 Mar 2019 13:42:25 +0100
Subject: [PATCH] spi: export tracepoint symbols to modules

The newly added tracepoints in the spi-mxs driver cause a link
error when the driver is a loadable module:

ERROR: "__tracepoint_spi_transfer_stop" [drivers/spi/spi-mxs.ko] undefined!
ERROR: "__tracepoint_spi_transfer_start" [drivers/spi/spi-mxs.ko] undefined!

I'm not quite sure where to put the export statements, but
directly after the inclusion of the header seems as good as
any other place.

Fixes: f3fdea3af405 ("spi: mxs: add tracing to custom .transfer_one_message callback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2be394d3bc59..bd2a424672df 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -36,6 +36,8 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
+EXPORT_TRACEPOINT_SYMBOL(spi_transfer_start);
+EXPORT_TRACEPOINT_SYMBOL(spi_transfer_stop);
 
 #include "internals.h"
 
-- 
2.20.1

