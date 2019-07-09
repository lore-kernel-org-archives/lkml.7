Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCC5C606D8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8C721707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="D/24DhkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfGIHex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:34:53 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:61848 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfGIHep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1562656768; x=1565248768;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s1zdktaUgi8FD5Dd3rpCZWrmcQvNrrlNSk3dVdiF9OQ=;
        b=D/24DhkEnr9C73VWm6s2YtHz16ECsSV4296exQp5BNqcqEn5bRRuOc0CMTzISToI
        H6/F7fSOqiCPxWmM+6CUjXKcz28cbnsjC3+g5syJHFKHdHFksv2ZiycU/XaLZcfL
        YITLqWo2+pisknbZHnRF9HCMeRWuluUKtezWE8Rpzmw=;
X-AuditID: c39127d2-193ff70000001aee-04-5d244000701c
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id DA.B0.06894.000442D5; Tue,  9 Jul 2019 09:19:28 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019070909192851-309708 ;
          Tue, 9 Jul 2019 09:19:28 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, martyn.welch@collabora.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH 05/10] ARM: dts: imx6ul: segin: Make FEC and ethphy configurable in dts
Date:   Tue, 9 Jul 2019 09:19:22 +0200
Message-Id: <1562656767-273566-6-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:28,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:28,
        Serialize complete at 09.07.2019 09:19:28
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWyRoCBS5fBQSXWYOEyS4v5R86xWjy86m+x
        aupOFotNj6+xWnT9WslscXnXHDaLpdcvMlk8uNjFYtG69wi7xd/tm1gsXmwRd+D2WDNvDaPH
        jrtLGD12zrrL7rFpVSebx+Yl9R4b3+1g8uj/a+DxeZNcAEcUl01Kak5mWWqRvl0CV8bCLU/Y
        CmaJVMyZ/5axgXGnQBcjJ4eEgInEibYJjF2MXBxCAjsYJea/2skE4VxglFj0r5MFpIpNwEhi
        wbRGJhBbRCBS4t323+wgRcwCexglpl2/zgiSEBYIl1j2YwVYA4uAisS5jZvYQGxeAQ+J1ZO3
        s0Gsk5O4ea6TGcTmFPCUOHrxF5gtBFRzecE0FpChEgKNTBKLH51mhGgQkji9+CzzBEa+BYwM
        qxiFcjOTs1OLMrP1CjIqS1KT9VJSNzECQ/XwRPVLOxj75ngcYmTiYDzEKMHBrCTCu89dOVaI
        NyWxsiq1KD++qDQntfgQozQHi5I47wbekjAhgfTEktTs1NSC1CKYLBMHp1QDo+ndVZ+vvC9f
        lnZrwvsdpYc/Mya0rwnVKwvepHylxqLl+w7GtbFSLovmPI/xmKzy4vrWw1qfKzIbjt09GpLS
        NLfinZuJTIeXKt/xosuXPT4fEV6iz+b/mydn+nvjNVOuLz3vcGbh96V7+D7nHOv+URd4z0Y8
        qP92I5N2ieHyiXEJxScvJs95t1CJpTgj0VCLuag4EQABBJ4NQwIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To disable Ethernet interfaces in case they are not populated
make the FEC and Ethernet PHY status configurable in the dts files.

Also change the Ethernet PHYs labels to make them correspond to
the MDIO address.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi      |  7 ++++---
 arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts | 12 ++++++++++++
 arch/arm/boot/dts/imx6ul-phytec-segin.dtsi            |  5 +++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
index 73266b4a889b..fee7a7e938ee 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -42,20 +42,21 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
 	phy-mode = "rmii";
-	phy-handle = <&ethphy0>;
-	status = "okay";
+	phy-handle = <&ethphy1>;
+	status = "disabled";
 
 	mdio: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		ethphy0: ethernet-phy@1 {
+		ethphy1: ethernet-phy@1 {
 			reg = <1>;
 			interrupt-parent = <&gpio1>;
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			micrel,led-mode = <1>;
 			clocks = <&clks IMX6UL_CLK_ENET_REF>;
 			clock-names = "rmii-ref";
+			status = "disabled";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
index dc06029c5701..81a82dd65019 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
@@ -34,6 +34,18 @@
 	status = "okay";
 };
 
+&ethphy1 {
+	status = "okay";
+};
+
+&ethphy2 {
+	status = "okay";
+};
+
+&fec1 {
+	status = "okay";
+};
+
 &fec2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
index 28ba3a4c4c74..7cd24ec40c36 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
@@ -107,7 +107,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet2>;
 	phy-mode = "rmii";
-	phy-handle = <&ethphy1>;
+	phy-handle = <&ethphy2>;
 	status = "disabled";
 };
 
@@ -160,11 +160,12 @@
 };
 
 &mdio {
-	ethphy1: ethernet-phy@2 {
+	ethphy2: ethernet-phy@2 {
 		reg = <2>;
 		micrel,led-mode = <1>;
 		clocks = <&clks IMX6UL_CLK_ENET2_REF>;
 		clock-names = "rmii-ref";
+		status = "disabled";
 	};
 };
 
-- 
2.7.4

