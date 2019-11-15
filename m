Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D00C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C206207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573820718;
	bh=hCV/FGxoHknjJu4UEFxg/QAqMjxyOF6Pyv9qpgelyRQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ZEB7x/VE5VF84JPLr468Gcr3nn/BuyJQkz5ogAYEUOW5h604JfFrhiVoFUffAVtBc
	 x2+9dDnLT52aVwNKMOrNf3tpJLbmf5m22d/MqOc6dKocr8pDJCSMDpyG8vMDRCe/jP
	 +/tOLpgiFPMqGKP/iS21FPL0+dcbHjNuyjnUb8gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfKOMZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:25:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32884 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfKOMZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4AGPkKPSVyOTs5n0W0mJVA5CUUCsjeEv/AClqhuZzv4=; b=qzFKtRmxYbbx
        bGe9vsc580IghowflZsvWJTvC4y/mPeSs+UAZrMoT0TpI0kL1zEYB+R3i2fIbx1d5k1c+1sve/Pnn
        DMdcbZjd6l8oxtpDgVH3StavMUHRPNTEkuePI7ANTtBJjLR9y2uFYAyEiteMXaTQsWF6yDDDdoeUV
        153rk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaex-0000Kk-OA; Fri, 15 Nov 2019 12:25:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3CFBC27415A7; Fri, 15 Nov 2019 12:25:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Fritz <chf.fritz@googlemail.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "dt-bindings: mfd: da9062: describe buck modes" to the regulator tree
In-Reply-To: <1573652416-9848-4-git-send-email-chf.fritz@googlemail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191115122507.3CFBC27415A7@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:25:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: mfd: da9062: describe buck modes

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From a4bb429811bd4a5be94873ae218062c83c476ed9 Mon Sep 17 00:00:00 2001
From: Christoph Fritz <chf.fritz@googlemail.com>
Date: Wed, 13 Nov 2019 14:40:15 +0100
Subject: [PATCH] dt-bindings: mfd: da9062: describe buck modes

This patch adds DT description of da9062 buck regulator modes.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Link: https://lore.kernel.org/r/1573652416-9848-4-git-send-email-chf.fritz@googlemail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/mfd/da9062.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index edca653a5777..bc4b59de6a55 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -66,6 +66,9 @@ Sub-nodes:
   details of individual regulator device can be found in:
   Documentation/devicetree/bindings/regulator/regulator.txt
 
+  regulator-initial-mode may be specified for buck regulators using mode values
+  from include/dt-bindings/regulator/dlg,da9063-regulator.h.
+
 - rtc : This node defines settings required for the Real-Time Clock associated
   with the DA9062. There are currently no entries in this binding, however
   compatible = "dlg,da9062-rtc" should be added if a node is created.
@@ -96,6 +99,7 @@ Example:
 				regulator-max-microvolt = <1570000>;
 				regulator-min-microamp = <500000>;
 				regulator-max-microamp = <2000000>;
+				regulator-initial-mode = <DA9063_BUCK_MODE_SYNC>;
 				regulator-boot-on;
 			};
 			DA9062_LDO1: ldo1 {
-- 
2.20.1

