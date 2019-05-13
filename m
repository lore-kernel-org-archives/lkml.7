Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54474C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249DA20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="adOzDD/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfEMPlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:41:35 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:41268 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728513AbfEMPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:41:34 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2CBC0C01E6;
        Mon, 13 May 2019 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557762098; bh=WCBNYFY1ChFojjxZC8JG7x5O1lCoq1Zfiew6HInYASk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=adOzDD/S6wc0Q3IlQ3jHOnd/ViuLE178tE+nHGbZCLvOuXubf85vGX+0g3TE7fLr+
         Y9Lpk7FWciHyLkVb/Dp2jZJKMTGy00tzR/4csxN30Y8LV0nDqLl/exNjdTVpLIaISX
         eKnBksqt48xBdZoTN86d3NwyfW+aqWT4v5H8dDb4zCYwDdGo2qVNK4FlG6txKQU+/8
         1PcxsmDs4+Cw8tLRioePY9w3ob9K0RmDOb33cXhQ4E5kc1tBn/UoYnCLpkRLtVsaQD
         h+DHlCs+eU8k8IeRXiPdlxescC6NYauxic+ckbTPt5iBd3qetrHTzorXT9J5Q7cJov
         nyWBHMirDPtaw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id CD54CA00A3;
        Mon, 13 May 2019 15:41:32 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 044ED3F928;
        Mon, 13 May 2019 17:41:32 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH 2/2] dt-bindings: Document the DesignWare IP reset bindings
Date:   Mon, 13 May 2019 17:41:28 +0200
Message-Id: <57b3e24f85b0838fc7fafe35abab00e19993d458.1557759340.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1557759340.git.gustavo.pimentel@synopsys.com>
References: <cover.1557759340.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1557759340.git.gustavo.pimentel@synopsys.com>
References: <cover.1557759340.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation of device tree bindings for the
DesignWare IP reset controller.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
---
 .../devicetree/bindings/reset/snps,dw-reset.txt    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
new file mode 100644
index 0000000..5316212
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
+	dw_rst: reset-controller@0000 {
+		compatible = "dw,dw-high-reset";
+		reg = <0x0000 0x4>;
+		#reset-cells = <1>;
+	};
+
+	dw_rst: reset-controller@1000 {
+		compatible = "dw,dw-low-reset";
+		reg = <0x1000 0x4>;
+		#reset-cells = <1>;
+	};
-- 
2.7.4

