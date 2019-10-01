Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE5C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC092133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930132;
	bh=25AX+cJR0HQYq0g9dSgkDCxIvceoLatWiK6omL76a0w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qowDcJTZKS5APmLVmxkvDJPjRt6ObA8j+4NBpNRMrL2Z3VxwpriqLAVr+OKDz+QBV
	 H/jRNjC3HGE9pXAzG4P+QlFDAzVAmV9thOBhi/iW68/vpdRDOnixRjPVQfLkOj3wJ0
	 d5jXX3VIswzRwspr1dIFqYQ31YiYZor0kPqIMs7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbfJALmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:42:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40880 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbfJALlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zIkM8oZgmIv/BhPJfyepEtaPqf94VD1HkTKQ5Bkf03o=; b=rjUhPgbp9msm
        QGDlarWKfelOcSp6yjhEK8t8BnIjzJmTyhAFw2dvt5H80DDeuC8eLpmdJNxArzrz2FReKT2ijFJXk
        66I/MRGRzds+unjB8nUn8FG6uv9cYvEoK424b1jbBuNfA5uJuKHeEcsBvk2ADsIbEvm6C/JzRBD3I
        iVNbQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWT-0004Vn-7m; Tue, 01 Oct 2019 11:40:53 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A265527429C0; Tue,  1 Oct 2019 12:40:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, nicoleotsuka@gmail.com,
        Nicolin Chen <nicoleotsuka@gmail.com>, perex@perex.cz,
        robh+dt@kernel.org, timur@kernel.org, tiwai@suse.com,
        Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_mqs: add DT binding documentation" to the asoc tree
In-Reply-To: <65e1f035aea2951aacda54aa3a751bc244f72f6a.1568367274.git.shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114052.A265527429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_mqs: add DT binding documentation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 75234212c446cef3272a025b588b2e418158ed30 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Fri, 13 Sep 2019 17:42:13 +0800
Subject: [PATCH] ASoC: fsl_mqs: add DT binding documentation

Add the DT binding documentation for NXP MQS driver

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/65e1f035aea2951aacda54aa3a751bc244f72f6a.1568367274.git.shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/fsl,mqs.txt     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,mqs.txt b/Documentation/devicetree/bindings/sound/fsl,mqs.txt
new file mode 100644
index 000000000000..40353fc30255
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,mqs.txt
@@ -0,0 +1,36 @@
+fsl,mqs audio CODEC
+
+Required properties:
+  - compatible : Must contain one of "fsl,imx6sx-mqs", "fsl,codec-mqs"
+		"fsl,imx8qm-mqs", "fsl,imx8qxp-mqs".
+  - clocks : A list of phandles + clock-specifiers, one for each entry in
+	     clock-names
+  - clock-names : "mclk" - must required.
+		  "core" - required if compatible is "fsl,imx8qm-mqs", it
+		           is for register access.
+  - gpr : A phandle of General Purpose Registers in IOMUX Controller.
+	  Required if compatible is "fsl,imx6sx-mqs".
+
+Required if compatible is "fsl,imx8qm-mqs":
+  - power-domains: A phandle of PM domain provider node.
+  - reg: Offset and length of the register set for the device.
+
+Example:
+
+mqs: mqs {
+	compatible = "fsl,imx6sx-mqs";
+	gpr = <&gpr>;
+	clocks = <&clks IMX6SX_CLK_SAI1>;
+	clock-names = "mclk";
+	status = "disabled";
+};
+
+mqs: mqs@59850000 {
+	compatible = "fsl,imx8qm-mqs";
+	reg = <0x59850000 0x10000>;
+	clocks = <&clk IMX8QM_AUD_MQS_IPG>,
+		 <&clk IMX8QM_AUD_MQS_HMCLK>;
+	clock-names = "core", "mclk";
+	power-domains = <&pd_mqs0>;
+	status = "disabled";
+};
-- 
2.20.1

