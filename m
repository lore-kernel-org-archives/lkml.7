Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA95CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C59F20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VD0ECpbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbfJ1Jhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:37:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41490 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733224AbfJ1Jhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:37:46 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9S9bhGQ098567;
        Mon, 28 Oct 2019 04:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572255463;
        bh=s0Ju9MGTwhkdP/osJmJnHaang4k/pcUHy4/CGtiLVgY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VD0ECpbch/kmp674QDI9sBS6i/jrIfZJ7bVnhMhnXF6GLkXtggfzZQTmUi/yQetgc
         E1HNl8mTeE2yzzpfF4AYtbiSKCptMi+C1buIprjtYKyH/vo/n0DhGcpwfgBwY2v8P1
         MJVeq6AlTT38ktByE+FmqR4xbCGTM8DKVUqJFpIo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9S9bhme005966
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Oct 2019 04:37:43 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 04:37:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 04:37:26 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9S9bW4i027237;
        Mon, 28 Oct 2019 04:37:36 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j721e-common-proc-board: Add USB ports
Date:   Mon, 28 Oct 2019 11:37:30 +0200
Message-ID: <20191028093730.23094-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028093730.23094-1-rogerq@ti.com>
References: <20191028093730.23094-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB0 as otg port and USB1 as host port.

Although USB0 can be used at super-speed, limit the
speed to high-speed for now till SERDES PHY support
is added.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 57df79a815f0..2a3cd6174504 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -55,6 +55,18 @@
 			J721E_IOPAD(0x25c, PIN_INPUT, 0) /* (R28) MMC1_SDWP */
 		>;
 	};
+
+	main_usbss0_pins_default: main_usbss0_pins_default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
+		>;
+	};
+
+	main_usbss1_pins_default: main_usbss1_pins_default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -244,3 +256,26 @@
 	/* Unused */
 	status = "disabled";
 };
+
+&usbss0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usbss0_pins_default>;
+	ti,usb2-only;
+	ti,vbus-divider;
+};
+
+&usb0 {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+};
+
+&usbss1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usbss1_pins_default>;
+	ti,usb2-only;
+};
+
+&usb1 {
+	dr_mode = "host";
+	maximum-speed = "high-speed";
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

