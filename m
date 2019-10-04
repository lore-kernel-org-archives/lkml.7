Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81A2215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cEi9KasX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbfJDIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:20:04 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11746 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388246AbfJDIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:20:00 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9700b70000>; Fri, 04 Oct 2019 01:20:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Oct 2019 01:19:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 04 Oct 2019 01:19:58 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 08:19:58 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 08:19:58 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 4 Oct 2019 08:19:58 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.105]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d9700ac0000>; Fri, 04 Oct 2019 01:19:57 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 5/7] dt-bindings: phy: tegra: Add Tegra194 support
Date:   Fri, 4 Oct 2019 16:19:39 +0800
Message-ID: <20191004081941.4831-6-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004081941.4831-1-jckuo@nvidia.com>
References: <20191004081941.4831-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570177207; bh=piBLNxKZI4hNCBcAg/I9AF5lQVFzLSysvJRLTsJvi4Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cEi9KasXUz/h1teNvhD5OQQq4GfzD8dMZEfFsY+NCv/z/jObtI+87/vJ0caseqI1z
         KxKr913TpgDpdBQbNIQbAnMquRYusbj5UQm1JLnECJ1REtN1RCQHYbQTR0xX/+7C4k
         dStc98neZNyjVqx9njLqa+MM77UL1pRKi2ROFWnEbs2Hh6f4LHfsL2pu+Ixes7gC91
         S1J2FbDR62ZjG5PcpVf4R84Ni8b8331pMhWP4BiiuOh6Us8pc2MNbA2hPhT2V+7L6/
         BSaIekXb0y+gPQI9oxqE65x8DDHR4mrGSDvEpmc0962rkJTcb6bounuTG3S+wgGrKL
         cj7j/CsAVidRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the bindings to cover the set of features found in Tegra194.
Note that, technically, there are four more supplies connected to the
XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
, but the power sequencing requirements of Tegra194 require these to be
under the control of the PMIC.

Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it is
possible for some platforms have long signal trace that could not
provide sufficient electrical environment for Gen 2 speed. To deal with
this, a new device node property "nvidia,disable-gen2" was added to
Tegra194 that be used to specifically disable Gen 2 speed for a
particular USB 3.0 port so that the port can be limited to Gen 1 speed
and avoid the instability.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
Changes in v2:
- fix a typo

 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
index 9fb682e47c29..59d870fa42e9 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
@@ -37,6 +37,7 @@ Required properties:
   - Tegra132: "nvidia,tegra132-xusb-padctl", "nvidia,tegra124-xusb-padctl"
   - Tegra210: "nvidia,tegra210-xusb-padctl"
   - Tegra186: "nvidia,tegra186-xusb-padctl"
+  - Tegra194: "nvidia,tegra194-xusb-padctl"
 - reg: Physical base address and length of the controller's registers.
 - resets: Must contain an entry for each entry in reset-names.
 - reset-names: Must include the following entries:
@@ -62,6 +63,10 @@ For Tegra186:
 - vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
 - vddio-hsic-supply: HSIC PHY power supply. Must supply 1.2 V.
 
+For Tegra194:
+- avdd-usb-supply: USB I/Os, VBUS, ID, REXT, D+/D- power supply. Must supply
+  3.3 V.
+- vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
 
 Pad nodes:
 ==========
@@ -154,6 +159,11 @@ For Tegra210, the list of valid PHY nodes is given below:
 - sata: sata-0
   - functions: "usb3-ss", "sata"
 
+For Tegra194, the list of valid PHY nodes is given below:
+- usb2: usb2-0, usb2-1, usb2-2, usb2-3
+  - functions: "xusb"
+- usb3: usb3-0, usb3-1, usb3-2, usb3-3
+  - functions: "xusb"
 
 Port nodes:
 ===========
@@ -221,6 +231,9 @@ Optional properties:
   is internal. In the absence of this property the port is considered to be
   external.
 
+- nvidia,disable-gen2: A boolean property whose presence determines that a port
+  should be limited to USB 3.1 Gen 1. This property is only for Tegra194.
+
 For Tegra124 and Tegra132, the XUSB pad controller exposes the following
 ports:
 - 3x USB2: usb2-0, usb2-1, usb2-2
@@ -233,6 +246,9 @@ For Tegra210, the XUSB pad controller exposes the following ports:
 - 2x HSIC: hsic-0, hsic-1
 - 4x super-speed USB: usb3-0, usb3-1, usb3-2, usb3-3
 
+For Tegra194, the XUSB pad controller exposes the following ports:
+- 4x USB2: usb2-0, usb2-1, usb2-2, usb2-3
+- 4x super-speed USB: usb3-0, usb3-1, usb3-2, usb3-3
 
 Examples:
 =========
-- 
2.17.1

