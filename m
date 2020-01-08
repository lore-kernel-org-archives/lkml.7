Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16162C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9F52082E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578499134;
	bh=6UVBNLTDsg1T4UjRTZmbZA4mGI2qV4/WxGlzioEsCmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=c1NWUefruncQl+i78EV5dpn2aHl5QdHBfDUcHMsvXnwEx2uybQbYLFB3ymVODjm+L
	 Faf/C6R+4wiK+x3LP5eeRkyG7lwPnHG24PGUnY+EUfkiIIcOjBI1fMbwrcc0LY0gDC
	 8Y/y93Z1SYz0Ylw/8qtC0NHJdCCV0RVvoEopYEYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAHP6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:58:54 -0500
Received: from foss.arm.com ([217.140.110.172]:46582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbgAHP6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:58:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26176328;
        Wed,  8 Jan 2020 07:58:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 828FC3F534;
        Wed,  8 Jan 2020 07:58:51 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:58:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     broonie@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        heiko@sntech.de, icenowy@aosc.io, Jonathan.Cameron@huawei.com,
        laurent.pinchart@ideasonboard.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, mchehab+samsung@kernel.org,
        mripard@kernel.org, robh+dt@kernel.org, sam@ravnborg.org,
        shawnguo@kernel.org, sravanhome@gmail.com
Subject: Applied "MAINTAINERS: Add entry for mpq7920 PMIC driver" to the regulator tree
In-Reply-To: <20200108131234.24128-5-sravanhome@gmail.com>
Message-Id: <applied-20200108131234.24128-5-sravanhome@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   MAINTAINERS: Add entry for mpq7920 PMIC driver

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

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

From c5bae95b4e60a07dd4f06452ccae5805ed16b40d Mon Sep 17 00:00:00 2001
From: Saravanan Sekar <sravanhome@gmail.com>
Date: Wed, 8 Jan 2020 14:12:34 +0100
Subject: [PATCH] MAINTAINERS: Add entry for mpq7920 PMIC driver

Add MAINTAINERS entry for Monolithic Power Systems mpq7920 PMIC driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Link: https://lore.kernel.org/r/20200108131234.24128-5-sravanhome@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..73780dbd60a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11138,6 +11138,13 @@ S:	Maintained
 F:	Documentation/driver-api/serial/moxa-smartio.rst
 F:	drivers/tty/mxser.*
 
+MONOLITHIC POWER SYSTEM PMIC DRIVER
+M:	Saravanan Sekar <sravanhome@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/mpq7920.yaml
+F:	drivers/regulator/mpq7920.c
+F:	drivers/regulator/mpq7920.h
+
 MR800 AVERMEDIA USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
 L:	linux-media@vger.kernel.org
-- 
2.20.1

