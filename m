Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15655C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6926214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HD2TeEeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfLKREN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:04:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40944 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfLKREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:04:08 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBH43dG093381;
        Wed, 11 Dec 2019 11:04:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576083843;
        bh=2q7+lDu/00Dro2as6TEZvbW2Mo8FYkswNwEaKXoLaGc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HD2TeEeD8rV95xAm+hnw8E7Um8xDpyYi4Uo/mvWdlZ5u32W/UERVeCGa8j6d7IZQF
         BMVo7W/uMUchDFg2jUIum9How2Slu2oGuxzdiY6FNE0077oHTFjdnNSYrfPegiNt8v
         9maS6mXMdnOd3o13tY7s3Q0BH1zJUbPeFdqIZksU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBH43V7130518;
        Wed, 11 Dec 2019 11:04:03 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 11:04:02 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 11:04:02 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBH3s6h099151;
        Wed, 11 Dec 2019 11:04:00 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 3/3] arm64: dts: k3-am654-base-board: Add IRQ line for GPIO expander
Date:   Wed, 11 Dec 2019 22:34:14 +0530
Message-ID: <20191211170414.7026-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211170414.7026-1-vigneshr@ti.com>
References: <20191211170414.7026-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IRQ line for IO expander present on wkup_i2c bus on  AM654 EVM

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
v2:

New patch

 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 94bec7aa9baf..a634dceaa964 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -85,6 +85,13 @@ AM65X_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* (R3) MCU_OSPI0_D7 */
 			AM65X_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* (R4) MCU_OSPI0_CSn0 */
 		>;
 	};
+
+	wkup_pca554_default: wkup_pca554_default {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x0034, PIN_INPUT, 7) /* (T1) MCU_OSPI1_CLK.WKUP_GPIO0_25 */
+
+		>;
+	};
 };
 
 &main_pmx0 {
@@ -180,6 +187,12 @@ pca9554: gpio@39 {
 		reg = <0x39>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wkup_pca554_default>;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 	};
 };
 
-- 
2.24.0

