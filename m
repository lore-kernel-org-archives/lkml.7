Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF4FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC69D2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555583173;
	bh=UucU2yGB9d6UI9VYDJQ7wgL1nXJU8BGPlu+buCBO6Co=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vxmegJpFG8bBsuPirZcVENRqdWyRRg/GnFF5Y61vi2UQELBRn3bDnTBbTbMax+Lan
	 u7J7/wkskG9w5EAlQ5LF8kLrXgETzCTG/2LLulqKtq67jk4PhnPXDl0hoeKKzARAVy
	 DmisMosvNZpbsvrrohi8yzEYZVbtJBLgCd5uJI54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbfDRK0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:26:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43756 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbfDRK0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LWMBaE526Ee2BEbbLn7FCCxX0jBn4QnUNAwfaOECkRE=; b=cejE5au4cDwn
        5/giUUP7CWSoIXBCIh7hvkEbg0zDdOAldLSbDK6akjb+lZnTXF0pTHgHgiXQX8TMifV7oFvcz9ln6
        aj74cYlDEKjDmFMgFCbd6Ek6Z9QdaL01yj9OsTodCJwncoKtQ3HyNHfp71cD2ONB0GnondLV4LuW4
        nGJM4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hH4F6-0001TI-4R; Thu, 18 Apr 2019 10:26:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5AFC811279BB; Thu, 18 Apr 2019 11:26:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Eric Jeong <eric.jeong.opensource@diasemi.com>
Cc:     DEVICETREE <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "MAINTAINERS: slg51000 updates to the Dialog Semiconductor search terms" to the regulator tree
In-Reply-To: <878724615d6edf4d1d8960fd4aa9058aaedab026.1555567784.git.eric.jeong.opensource@diasemi.com>
X-Patchwork-Hint: ignore
Message-Id: <20190418102607.5AFC811279BB@debutante.sirena.org.uk>
Date:   Thu, 18 Apr 2019 11:26:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   MAINTAINERS: slg51000 updates to the Dialog Semiconductor search terms

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

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

From 4b01c5afc1817a966065d7da0fb962cc591c6fad Mon Sep 17 00:00:00 2001
From: Eric Jeong <eric.jeong.opensource@diasemi.com>
Date: Thu, 18 Apr 2019 15:09:43 +0900
Subject: [PATCH] MAINTAINERS: slg51000 updates to the Dialog Semiconductor
 search terms

This patch adds the slg51000 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Eric Jeong <eric.jeong.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..656c1cc6431e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4603,6 +4603,7 @@ F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
+F:	Documentation/devicetree/bindings/regulator/slg51000.txt
 F:	Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
 F:	drivers/gpio/gpio-da90??.c
@@ -4618,6 +4619,7 @@ F:	drivers/power/supply/da9052-battery.c
 F:	drivers/power/supply/da91??-*.c
 F:	drivers/regulator/da903x.c
 F:	drivers/regulator/da9???-regulator.[ch]
+F:	drivers/regulator/slg51000-regulator.[ch]
 F:	drivers/thermal/da90??-thermal.c
 F:	drivers/rtc/rtc-da90??.c
 F:	drivers/video/backlight/da90??_bl.c
-- 
2.20.1

