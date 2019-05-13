Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA782C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF7D20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557750659;
	bh=WLnTwRjQLDy7cMJ4fO/Qi4I29n5zEE0jp8MQ1WQKZO4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nmcsjhN+BZViCkQo8lRb9bKtlwXmQJQoYEXKzl/NjmUXxSB4fSqHB9hyw7PmvkdDz
	 GUvI+Tngm3/xw3CbdOXY5ib2MH6FNGZSyVa0Z7EjI3FqUDn4yMkXiQX4hLmlPVat4t
	 SPjQUSixWaPRhaevb0PIu9g6Sav1Bosw7FLpFCyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfEMMa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:30:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57194 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfEMMa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fn3jzof4sQG3BHsIXJo+a5pXSTAy5nFc+jR4ZasQfdE=; b=UJB8V32POPml
        aQjJPn+T0+YQJXIov/1JZs7EgQdBXDSZZUFVG1cTm+oqHFvmfLzzxsyS/3pjGr/+2VTe2Zi3r+03m
        NBQF9qtprC+zqUD5aTH6aoRyVUTu0R+1vRz3H+1M5u5ZwtY6T/6bTVaFzmQy54eX1ll/hp6JeawT+
        mwlxA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQA6X-0006a4-Uj; Mon, 13 May 2019 12:30:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2A29F1129232; Mon, 13 May 2019 13:30:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Eric Jeong <eric.jeong.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: slg51000 updates to the Dialog Semiconductor search terms" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190513123053.2A29F1129232@debutante.sirena.org.uk>
Date:   Mon, 13 May 2019 13:30:53 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   MAINTAINERS: slg51000 updates to the Dialog Semiconductor search terms

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 249825cc48ebe7d036a1200f6e5ad3d4dc1d2e25 Mon Sep 17 00:00:00 2001
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
index 2c2fce72e694..32c86779a900 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4605,6 +4605,7 @@ F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
+F:	Documentation/devicetree/bindings/regulator/slg51000.txt
 F:	Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
 F:	drivers/gpio/gpio-da90??.c
@@ -4620,6 +4621,7 @@ F:	drivers/power/supply/da9052-battery.c
 F:	drivers/power/supply/da91??-*.c
 F:	drivers/regulator/da903x.c
 F:	drivers/regulator/da9???-regulator.[ch]
+F:	drivers/regulator/slg51000-regulator.[ch]
 F:	drivers/thermal/da90??-thermal.c
 F:	drivers/rtc/rtc-da90??.c
 F:	drivers/video/backlight/da90??_bl.c
-- 
2.20.1

