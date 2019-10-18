Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B15CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A9E222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="B/zOlGKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442327AbfJRJje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:39:34 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16369 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442311AbfJRJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:39:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da988560000>; Fri, 18 Oct 2019 02:39:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 18 Oct 2019 02:39:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 18 Oct 2019 02:39:29 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 09:39:29 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 18 Oct 2019 09:39:29 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.66.147]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da9884e0004>; Fri, 18 Oct 2019 02:39:29 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V11 05/11] dt-bindings: usb: Add NVIDIA Tegra XUSB device mode controller binding
Date:   Fri, 18 Oct 2019 15:08:10 +0530
Message-ID: <1571391496-20834-6-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571391496-20834-1-git-send-email-nkristam@nvidia.com>
References: <1571391496-20834-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571391574; bh=tqspIJXyEKe8rhhtfMtZneWvho9mAfhBPIvgA46vtOo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=B/zOlGKDWWXnZF2PaikJv05QgL7DXCEkT1XD8nE8PdYhKd1q0n3mw/LR8UldMwTt/
         ReYs01kDBfx43wCoQDzL4pND84RTAgNOitTe429VT5Q5QPCPERL5kDDNasMrLuGuPq
         yxy0n5vJZXbCViQEi4FFftNlfandG6DH9tW6ByttAMlfZzAyod3Or9cJ+FJkRy/RH4
         VPd4VojkYU0b0cDGmqk10X8UxIulugFGiCEgb19xsJDpdD8e8lqbvYn4c6z4YRlgio
         Df+XwToNUv+rrM6bpcCew2BPAcI9sLhCOax/Lhx0nsHCe9oc8fIS4JqjU5pdCxZikm
         7EGatL3v/pg2A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation for the XUSB device mode controller
present on Tegra210 SoC. This controller supports the USB 3.0
specification.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Reviewed-by: JC Kuo <jckuo@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/usb/nvidia,tegra-xudc.txt  | 112 +++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.txt

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.txt
new file mode 100644
index 0000000..b497491
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.txt
@@ -0,0 +1,112 @@
+Device tree binding for NVIDIA Tegra XUSB device mode controller (XUDC)
+=======================================================================
+
+The Tegra XUDC controller supports both USB 2.0 HighSpeed/FullSpeed and
+USB 3.0 SuperSpeed protocols.
+
+Required properties:
+--------------------
+- compatible: Must be:
+  - Tegra210: "nvidia,tegra210-xudc"
+  - Tegra186: "nvidia,tegra186-xudc"
+- reg: Must contain the base and length of all registers used.
+- interrupts: Must contain the XUSB device interrupt.
+- clocks: Must contain an entry for all clocks used.
+  See ../clock/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+   - dev: Clock to enable core XUSB dev clock.
+   - ss: Clock to enable XUSB super speed clock.
+   - ss_src: Clock to enable XUSB super speed dev clock.
+   - hs_src: Clock to enable XUSB high speed dev clock.
+   - fs_src: Clock to enable XUSB full speed dev clock.
+- power-domains: A list of PM domain specifiers that reference each power-domain
+  used by the XUSB device mode controller. This list must comprise of a specifier
+  for the XUSBA and XUSBB power-domains. See ../power/power_domain.txt and
+  ../arm/tegra/nvidia,tegra20-pmc.txt for details.
+- power-domain-names: A list of names that represent each of the specifiers in
+  the 'power-domains' property. Must include 'ss' and 'dev'.
+- nvidia,xusb-padctl: phandle to the XUSB pad controller that is used to
+  configure the USB pads used by the XUDC controller.
+- phys: Must contain an entry for each entry in phy-names.
+  See ../phy/phy-bindings.txt for details.
+- phy-names: Should include an entry for each PHY used by the controller.
+  Names must be "usb2", and "usb3" if support SuperSpeed device mode.
+  - "usb3" phy, SuperSpeed (SSTX+/SSTX-/SSRX+/SSRX-) data lines.
+  - "usb2" phy, USB 2.0 (D+/D-) data lines.
+
+For Tegra210:
+- reg-names: Must include the following entries:
+   - base: XUSB device controller registers.
+   - fpci: XUSB device PCI Config registers.
+   - ipfs: XUSB device registers.
+- avddio-usb-supply: PCIe/USB3 analog logic power supply. Must supply 1.05 V.
+- hvdd-usb-supply: USB controller power supply. Must supply 3.3 V.
+
+
+Optional properties:
+--------------------
+- usb-role-switch: boolean property to indicate use of USB Role Switch driver.
+
+Sub-nodes:
+----------
+- The port would be added as subnode if use "usb-role-switch" property.
+  see graph.txt.
+
+Example:
+--------
+	pmc: pmc@7000e400 {
+		compatible = "nvidia,tegra210-pmc";
+		reg = <0x0 0x7000e400 0x0 0x400>;
+		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
+
+		powergates {
+			pd_xusbss: xusba {
+				clocks = <&tegra_car TEGRA210_CLK_XUSB_SS>;
+				resets = <&tegra_car 156>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_xusbdev: xusbb {
+				clocks = <&tegra_car TEGRA210_CLK_XUSB_DEV>;
+				resets = <&tegra_car 95>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
+	usb@700d0000 {
+		compatible = "nvidia,tegra210-xudc";
+		reg = <0x0 0x700d0000 0x0 0x8000>,
+		      <0x0 0x700d8000 0x0 0x1000>,
+		      <0x0 0x700d9000 0x0 0x1000>;
+		reg-names = "base", "fpci", "ipfs";
+
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&tegra_car TEGRA210_CLK_XUSB_DEV>,
+			 <&tegra_car TEGRA210_CLK_XUSB_SS>,
+			 <&tegra_car TEGRA210_CLK_XUSB_SSP_SRC>,
+			 <&tegra_car TEGRA210_CLK_XUSB_HS_SRC>,
+			 <&tegra_car TEGRA210_CLK_XUSB_FS_SRC>;
+		clock-names = "dev", "ss", "ss_src", "hs_src", "fs_src";
+
+		power-domains = <&pd_xusbdev>, <&pd_xusbss>;
+		power-domain-names = "dev", "ss";
+
+		nvidia,xusb-padctl = <&padctl>;
+
+		phys = <&micro_b>;
+		phy-names = "usb2";
+
+		avddio-usb-supply = <&vdd_pex_1v05>;
+		hvdd-usb-supply = <&vdd_3v3_sys>;
+
+		usb-role-switch;
+		port {
+			usb_role_switch: endpoint {
+				remote-endpoint = <&bconn_ep>;
+			};
+		};
+
+	};
-- 
2.7.4

