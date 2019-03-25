Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA770C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A097920880
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfCYEPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:15:36 -0400
Received: from mx.socionext.com ([202.248.49.38]:53579 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCYEPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:15:36 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Mar 2019 13:15:34 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 96D06180085;
        Mon, 25 Mar 2019 13:15:34 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 25 Mar 2019 13:15:34 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 191F81A15B7;
        Mon, 25 Mar 2019 13:15:34 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 0319F120487;
        Mon, 25 Mar 2019 13:15:34 +0900 (JST)
From:   Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kanematsu.shinji@socionext.com, jaswinder.singh@linaro.org,
        masami.hiramatsu@linaro.org, linux-kernel@vger.kernel.org,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Subject: [PATCH 1/2] dt-bindings: dmaengine: Add Milbeaut AXI DMA controller bindings
Date:   Mon, 25 Mar 2019 13:15:13 +0900
Message-Id: <1553487314-9185-2-git-send-email-kasai.kazuhiro@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553487314-9185-1-git-send-email-kasai.kazuhiro@socionext.com>
References: <1553487314-9185-1-git-send-email-kasai.kazuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Milbeaut AXI DMA controller bindings. This DMA controller has
only capable of memory to memory transfer.

Signed-off-by: Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
---
 .../devicetree/bindings/dma/xdmac-milbeaut.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xdmac-milbeaut.txt

diff --git a/Documentation/devicetree/bindings/dma/xdmac-milbeaut.txt b/Documentation/devicetree/bindings/dma/xdmac-milbeaut.txt
new file mode 100644
index 0000000..3a77fb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xdmac-milbeaut.txt
@@ -0,0 +1,24 @@
+* Milbeaut AXI DMA Controller
+
+Milbeaut AXI DMA controller has only memory to memory transfer capability.
+
+* DMA controller
+
+Required property:
+- compatible: 		Should be  "socionext,milbeaut-m10v-xdmac"
+- reg:			Should contain DMA registers location and length.
+- interrupts: 		Should contain all of the per-channel DMA interrupts.
+- #dma-cells: 		Should be 1.
+- dma-channels: 	Number of DMA channels supported by the controller.
+
+Example:
+	xdmac0: dma-controller@1c250000 {
+		compatible = "socionext,milbeaut-m10v-xdmac";
+		reg = <0x1c250000 0x1000>;
+		interrupts = <0 17 0x4>,
+			     <0 18 0x4>,
+			     <0 19 0x4>,
+			     <0 20 0x4>;
+		#dma-cells = <1>;
+		dma-channels = <4>;
+	};
-- 
1.9.1

