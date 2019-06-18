Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B44EC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E6B21479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560882813;
	bh=csgia0MkVKGLXkqg5Vjp2rHm94NEMVYU40gdwal/WuQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HOMXrhpzJmyiXwcC1OWlMGE0SfsSUhehIjxZ5Puyy/av7LoAur8B39ZOlBmPbPDiP
	 hRWQmIvDwgBjNL9UXeLJ1dkAFL8FRSjjBPp+/08bfTVE1thIxPH2LsTftPxFRYhvhC
	 urFqUVSE+C/3ddiVgK2v7Hr0Yr092E7DUSpPH4RU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfFRSdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:33:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47486 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfFRSdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WOqAY43dXbjtdsHhQB8RefLmjQ7YgryuXjWLr32JmRc=; b=kwRPGFvSNm4L
        RAeB6RUTuVtEF3I6zRxl8t3dt7o60xi1RfWD2CCXqq9VmUwSPxyjRkyKuX9Rgz3zetO5M05tlAOCr
        volvZGhznCmy4FD+vZ8LyKGg0zUxxEcB9vfngeQvj5c35mt6um5Eydr2iPbnoIZSCUdgNwCCpQwz4
        0aw78=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdIv2-0005Kl-1B; Tue, 18 Jun 2019 18:33:20 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 8A72B440049; Tue, 18 Jun 2019 19:33:19 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: Applied "dt-bindings: qcom_spmi: Document pms405 support" to the regulator tree
In-Reply-To: <20190617183815.13659-1-jeffrey.l.hugo@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190618183319.8A72B440049@finisterre.sirena.org.uk>
Date:   Tue, 18 Jun 2019 19:33:19 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: qcom_spmi: Document pms405 support

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

From bbd7992e6a32a3a52f3c26c86eba81037651c5c6 Mon Sep 17 00:00:00 2001
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Date: Mon, 17 Jun 2019 11:38:15 -0700
Subject: [PATCH] dt-bindings: qcom_spmi: Document pms405 support

The PMS405 supports 5 SMPS and 13 LDO regulators.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/qcom,spmi-regulator.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
index ba94bc2d407a..430b8622bda1 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
@@ -10,6 +10,7 @@ Qualcomm SPMI Regulators
 			"qcom,pm8941-regulators"
 			"qcom,pm8994-regulators"
 			"qcom,pmi8994-regulators"
+			"qcom,pms405-regulators"
 
 - interrupts:
 	Usage: optional
@@ -111,6 +112,23 @@ Qualcomm SPMI Regulators
 	Definition: Reference to regulator supplying the input pin, as
 		    described in the data sheet.
 
+- vdd_l1_l2-supply:
+- vdd_l3_l8-supply:
+- vdd_l4-supply:
+- vdd_l5_l6-supply:
+- vdd_l10_l11_l12_l13-supply:
+- vdd_l7-supply:
+- vdd_l9-supply:
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
+- vdd_s4-supply:
+- vdd_s5-supply
+	Usage: optional (pms405 only)
+	Value type: <phandle>
+	Definition: Reference to regulator supplying the input pin, as
+		    described in the data sheet.
+
 - qcom,saw-reg:
 	Usage: optional
 	Value type: <phandle>
-- 
2.20.1

