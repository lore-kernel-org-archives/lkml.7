Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1299C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10E92147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dTHFmOa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCLJEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:04:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52068 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfCLJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:04:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2C94TUG082137;
        Tue, 12 Mar 2019 04:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552381470;
        bh=bsWvIBnAG9ndj75Mz58Sr12fO0SUQ8YBixeuLbEaHCg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dTHFmOa4MYNX7HOZu5qGF6r2GnLrWcvLB5eWN0DGnxcMySqr10jJ9Ae3OOd4PJFsy
         7zlG8+QiUkQ/Uaoj+7pBRi/HIE+HToyqsVTB7ULmOayHY2N1jaZFkem8UEKDcWLi9Y
         dj5pD+w65Sa3MOUzawgwVSbZGyNU+/3jA9rqRV+0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2C94Tlj004583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 04:04:29 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 04:04:29 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 04:04:29 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2C94Lfr016945;
        Tue, 12 Mar 2019 04:04:26 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] dt-bindings: clock: Add binding documentation for TI syscon gate clock
Date:   Tue, 12 Mar 2019 14:35:17 +0530
Message-ID: <20190312090518.28666-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312090518.28666-1-vigneshr@ti.com>
References: <20190312090518.28666-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for TI syscon gate clock.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../bindings/clock/ti,syscon-gate-clock.txt   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt b/Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt
new file mode 100644
index 000000000000..f2bc4281ddba
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt
@@ -0,0 +1,35 @@
+TI syscon gate clock
+
+The gate clock node must be provided inside a system controller node.
+
+Required:
+- comaptible: Must be "ti,syscon-gate-clock"
+- reg: Offset of register that controls the clock within syscon regmap
+- ti,clock-bit-idx: bit index that control gate/ungating of clock
+- clocks: phandle to the clock parent
+- #clock-cells: must be <0>
+
+Example:
+	ctrlmmr_epwm_ctrl: syscon@104140{
+		compatible = "syscon", "simple-bus";
+		reg = <0x0 0x104140 0x0 0x18>;
+		ranges = <0x0 0x0 0x104140>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ehrpwm0_tbclk: clk@0 {
+			compatible = "ti,syscon-gate-clock";
+			reg = <0x0>;
+			#clock-cells = <0>;
+			clocks = <&k3_clks 40 0>;
+			ti,clock-bit-idx = <0>;
+		};
+
+		ehrpwm1_tbclk: clk@4 {
+			compatible = "ti,syscon-gate-clock";
+			reg = <0x4>;
+			#clock-cells = <0>;
+			clocks = <&k3_clks 41 0>;
+			ti,clock-bit-idx = <0>;
+		};
+	};
-- 
2.21.0

