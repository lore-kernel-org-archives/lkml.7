Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF9C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579A9208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562072713;
	bh=tccxaV4NKvFoM/IOK/V+VkCHSJMd0PgS6CBM5zxuLVQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2U3JWbs/RKnAVlBLAMLNYOTLzXXO5QpgBUCOHMvWE+qGKOArUFITG0Guhp6BgUihY
	 0jA9x6lvYwgfB4/9zLkU60RVmIcAqsXumiL3Z1PkgDqtlQhA51jNDiA+V3qzCW8JwB
	 uCy9LYcka5zPT2d8GnpntB59dXtNZkfjdoTh9mk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGBNFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:05:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40458 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfGBNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JZq94gVIt9OPiVxwVhfvMyRq1d3OQdO0lv56n1fIsjc=; b=EMBcbEPBSq8o
        hdUjNnoxW33yRHf9zmJfoX3ct4oTDoxdyITuD0Clwqjf8jaRnpJZ3BJHETs9KXk/fW8HR+Q54S8AI
        r8azab9HKgiC08jnSKKRLFvI4MV9QB4RJJ0NnZPRBDNRthSQ6SQJ2IGtJKuwl58ybyGlPklM/bY2a
        iy0G8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiISm-0002O1-Ii; Tue, 02 Jul 2019 13:04:48 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 1B37D440046; Tue,  2 Jul 2019 14:04:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     alexandre.torgue@st.com, broonie@kernel.org,
        devicetree@vger.kernel.org, fabrice.gasnier@st.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        robh+dt@kernel.org
Subject: Applied "dt-bindings: regulator: add support for the stm32-booster" to the regulator tree
In-Reply-To: <1561968865-22037-2-git-send-email-fabrice.gasnier@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190702130448.1B37D440046@finisterre.sirena.org.uk>
Date:   Tue,  2 Jul 2019 14:04:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: add support for the stm32-booster

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

From d6d02bc6e80453ca004e101eae28d741bde54426 Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Date: Mon, 1 Jul 2019 10:14:22 +0200
Subject: [PATCH] dt-bindings: regulator: add support for the stm32-booster

Document the 3.3V booster regulator embedded in stm32h7 and stm32mp1
devices, that can be used to supply ADC analog input switches.
It's controlled by using system configuration registers (SYSCFG).
Introduce two compatibles as the booster regulator is controlled by:
- a unique register/bit in STM32H7
- a set/clear register pair in STM32MP1

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/st,stm32-booster.txt    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.txt

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt b/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
new file mode 100644
index 000000000000..479ad4c8758e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
@@ -0,0 +1,18 @@
+STM32 BOOSTER - Booster for ADC analog input switches
+
+Some STM32 devices embed a 3.3V booster supplied by Vdda, that can be used
+to supply ADC analog input switches.
+
+Required properties:
+- compatible: Should be one of:
+  "st,stm32h7-booster"
+  "st,stm32mp1-booster"
+- st,syscfg: Phandle to system configuration controller.
+- vdda-supply: Phandle to the vdda input analog voltage.
+
+Example:
+	booster: regulator-booster {
+		compatible = "st,stm32mp1-booster";
+		st,syscfg = <&syscfg>;
+		vdda-supply = <&vdda>;
+	};
-- 
2.20.1

