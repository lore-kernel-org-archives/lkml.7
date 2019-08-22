Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D402BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FAF2341B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566498794;
	bh=KLmgALeIZCH6nr8+B7z5mZ7wd2JXmQ36CsYSdoqjStM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Zy+pP51K3KktY2/3MAOBeAjLNPdVzuWsgC335X+GqHdkp3Gn12yunvptDQN0Oq4Je
	 tEf7PgxpF/JWmSvIfXmJKwKKV1gteXqF80dC6kQaH6tqNrvsSd8URI7B3xSIMeZH/k
	 Ra9x/b9GqxWvzVTE2HaTu5N48U8K5eXnlTiMzODM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390564AbfHVSdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:33:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37742 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbfHVSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=B5B+lya+oQSpgnTe/m6tpXC18rHyNfPImgjKFa/i45Y=; b=A5sTZZMF199U
        Ee1ooWMNXyW2yKFHY4NisoCeExx8VpEiUqvS9I3xUgEFIpbQmqWTHHaKwqEqlHZT/2GkUFO8FIAK2
        rnqSheA06SmXrh9dd0WNhYG/LLvXIuGe+GTutMXwZzpiubfFqO4P48WokWQN4xSw8OUCAGLOMQfAX
        PGuP0=;
Received: from 92.40.26.78.threembb.co.uk ([92.40.26.78] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i0rtS-0007fs-FP; Thu, 22 Aug 2019 18:33:06 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 89AC8D02CEA; Thu, 22 Aug 2019 19:32:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        nicoleotsuka@gmail.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        robh+dt@kernel.org, Rob Herring <robh@kernel.org>,
        shengjiu.wang@nxp.com, tiwai@suse.de, viorel.suman@nxp.com,
        Xiubo.Lee@gmail.com
Subject: Applied "dt-bindings: dsp: fsl: Add DSP core binding support" to the asoc tree
In-Reply-To: <20190821164730.7385-2-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190822183257.89AC8D02CEA@fitzroy.sirena.org.uk>
Date:   Thu, 22 Aug 2019 19:32:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: dsp: fsl: Add DSP core binding support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 7db2f2dfc701f9f903283e830653b02fb6ce823c Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 21 Aug 2019 11:47:28 -0500
Subject: [PATCH] dt-bindings: dsp: fsl: Add DSP core binding support

This describes the DSP device tree node.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190821164730.7385-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
new file mode 100644
index 000000000000..3248595dc93c
--- /dev/null
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dsp/fsl,dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8 DSP core
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+description: |
+  Some boards from i.MX8 family contain a DSP core used for
+  advanced pre- and post- audio processing.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-dsp
+
+  reg:
+    description: Should contain register location and length
+
+  clocks:
+    items:
+      - description: ipg clock
+      - description: ocram clock
+      - description: core clock
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ocram
+      - const: core
+
+  power-domains:
+    description:
+      List of phandle and PM domain specifier as documented in
+      Documentation/devicetree/bindings/power/power_domain.txt
+    maxItems: 4
+
+  mboxes:
+    description:
+      List of <&phandle type channel> - 2 channels for TXDB, 2 channels for RXDB
+      (see mailbox/fsl,mu.txt)
+    maxItems: 4
+
+  mbox-names:
+    items:
+      - const: txdb0
+      - const: txdb1
+      - const: rxdb0
+      - const: rxdb1
+
+  memory-region:
+    description:
+       phandle to a node describing reserved memory (System RAM memory)
+       used by DSP (see bindings/reserved-memory/reserved-memory.txt)
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - mboxes
+  - mbox-names
+  - memory-region
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/clock/imx8-clock.h>
+    dsp@596e8000 {
+        compatible = "fsl,imx8qxp-dsp";
+        reg = <0x596e8000 0x88000>;
+        clocks = <&adma_lpcg IMX_ADMA_LPCG_DSP_IPG_CLK>,
+                 <&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
+                 <&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
+        clock-names = "ipg", "ocram", "core";
+        power-domains = <&pd IMX_SC_R_MU_13A>,
+                        <&pd IMX_SC_R_MU_13B>,
+                        <&pd IMX_SC_R_DSP>,
+                        <&pd IMX_SC_R_DSP_RAM>;
+        mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
+        mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
+    };
-- 
2.20.1

