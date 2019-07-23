Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1BCC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CE720665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gL4Zs5fD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbfGWPSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:18:42 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:46532 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726405AbfGWPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:18:40 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7F3D6C0167;
        Tue, 23 Jul 2019 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563895120; bh=vZD2KzrUvdjHlxZiwBv7hf0CczNNnCqpVmAEAVcRqwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gL4Zs5fDoOowlluai/DlIEgMrdJhUzLh4hTCWq5Y/P8btRc98XXjh66ltJlmK+cT+
         E/YxdU9KABzOFZN9DsoYZpwjUYvEVVp78g9nHYxOS1pnU0FCSXmNjtg3ZMNWnLlE6x
         UiD6SEcs9mC7Ig0T0jpVjb2wJ6wxR3DMf94zcLxhp90E2/VcA+DSABdDFugLvHVOM5
         KEqih8h+eUo8FSKSOx1l2FoaQ0xBdX6dawITFCXeDKvWxpM9WvzKk5oJpQxPkPVlrz
         1jldCm+8bdxNpFz+Tstf3asHOXL+g3Zo4WmE60i916pxNdvlOoXnKVSqJ8QS/z7KcL
         hDoHDA7/IPmSQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 20100A005F;
        Tue, 23 Jul 2019 15:18:38 +0000 (UTC)
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com,
        Luis Oliveira <Luis.Oliveira@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [RESEND V2 1/2] dt-bindings: Document the DesignWare IP reset bindings
Date:   Tue, 23 Jul 2019 17:17:27 +0200
Message-Id: <1563895048-30038-2-git-send-email-luis.oliveira@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563895048-30038-1-git-send-email-luis.oliveira@synopsys.com>
References: <1563895048-30038-1-git-send-email-luis.oliveira@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation of device tree bindings for the
DesignWare IP reset controller.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changelog
-no changes

 .../devicetree/bindings/reset/snps,dw-reset.txt    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
new file mode 100644
index 0000000..f94f911
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
@@ -0,0 +1,30 @@
+Synopsys DesignWare Reset controller
+=======================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+
+- compatible: should be one of the following.
+	"snps,dw-high-reset" - for active high configuration
+	"snps,dw-low-reset" - for active low configuration
+
+- reg: physical base address of the controller and length of memory mapped
+	region.
+
+- #reset-cells: must be 1.
+
+example:
+
+	dw_rst_1: reset-controller@0000 {
+		compatible = "snps,dw-high-reset";
+		reg = <0x0000 0x4>;
+		#reset-cells = <1>;
+	};
+
+	dw_rst_2: reset-controller@1000 {i
+		compatible = "snps,dw-low-reset";
+		reg = <0x1000 0x8>;
+		#reset-cells = <1>;
+	};
-- 
2.7.4

