Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23CAC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93409208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271656;
	bh=HwmCpbZ+UmNqFC7OrmrNL0W5b1KrkSJNxy1iF3mWvqk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=RqmyNqlIKPtKks5DQmFac3Ah56OEI31ZJEJOxjCHgDuYtb0cxbeWV5zDM2RRfK8Dy
	 sNycfDZZyRhmfX4f9M0gHCpQHtVa0Vj83ld3HV8OiaJm8QyRzFN8o0S4ajFbwCQCG1
	 lxnmYFl+PjzBVobYjTtZr/KDkvVHp4cfziZrdBWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfDZJkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:40:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46418 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfDZJkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RSjnE2qLZo7Q1TAMcgIM3WoPBmF5lDdPJvqF61tp1BY=; b=ZgAarCnIh66Y
        rPvluNSgmPXJzhDEanKJyXhqrjXfX8RgNLpnkzNMtGL5CYm+3tFF/zdLeFUOhcjNoN/3hfti+JW70
        dTa0G49/OKlLVB8KVrv4/VNpvybWo3NuDSKQEEvYA/pYrtOIzj2MovIl06k2o9BknA6jRvDlLepwP
        UaCxM=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxLd-0003KK-Dh; Fri, 26 Apr 2019 09:40:49 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 043B7441D3B; Fri, 26 Apr 2019 10:40:47 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pascal Paillet <p.paillet@st.com>
Subject: Applied "dt-bindings: regulator: Add stm32mp1 pwr regulators" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094048.043B7441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:47 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: Add stm32mp1 pwr regulators

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

From c29687c354c58cd56fb2529fb89266c280206cf9 Mon Sep 17 00:00:00 2001
From: Pascal PAILLET-LME <p.paillet@st.com>
Date: Mon, 15 Apr 2019 09:17:37 +0000
Subject: [PATCH] dt-bindings: regulator: Add stm32mp1 pwr regulators

Document devicetree bindings for stm32mp1 pwr regulators.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../regulator/st,stm32mp1-pwr-reg.txt         | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
new file mode 100644
index 000000000000..e372dd3f0c8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
@@ -0,0 +1,43 @@
+STM32MP1 PWR Regulators
+-----------------------
+
+Available Regulators in STM32MP1 PWR block are:
+  - reg11 for regulator 1V1
+  - reg18 for regulator 1V8
+  - usb33 for the swtich USB3V3
+
+Required properties:
+- compatible: Must be "st,stm32mp1,pwr-reg"
+- list of child nodes that specify the regulator reg11, reg18 or usb33
+  initialization data for defined regulators. The definition for each of
+  these nodes is defined using the standard binding for regulators found at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+- vdd-supply: phandle to the parent supply/regulator node for vdd input
+- vdd_3v3_usbfs-supply: phandle to the parent supply/regulator node for usb33
+
+Example:
+
+pwr_regulators: pwr@50001000 {
+	compatible = "st,stm32mp1,pwr-reg";
+	reg = <0x50001000 0x10>;
+	vdd-supply = <&vdd>;
+	vdd_3v3_usbfs-supply = <&vdd_usb>;
+
+	reg11: reg11 {
+		regulator-name = "reg11";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+	};
+
+	reg18: reg18 {
+		regulator-name = "reg18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	usb33: usb33 {
+		regulator-name = "usb33";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
-- 
2.20.1

