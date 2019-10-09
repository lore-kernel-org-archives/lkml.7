Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4AFC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653F8206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CqvwFXq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfJICoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 22:44:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12377 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbfJICoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 22:44:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9d497b0000>; Tue, 08 Oct 2019 19:44:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Oct 2019 19:44:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Oct 2019 19:44:01 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Oct
 2019 02:44:01 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Oct 2019 02:44:01 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.249]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d9d496f0000>; Tue, 08 Oct 2019 19:44:00 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v4 3/5] dt-bindings: phy: tegra: Add Tegra194 support
Date:   Wed, 9 Oct 2019 10:43:41 +0800
Message-ID: <20191009024343.30218-4-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009024343.30218-1-jckuo@nvidia.com>
References: <20191009024343.30218-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570589051; bh=z4ayTrGq2BsZWVL11Lgco56gdGHdhI/wTDj28xS3jzI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=CqvwFXq+V9Sm0zIwP17vosa1Ur+jdMU7e/tvWxzRhfFutickDTTUhfv6PSoDKN4OK
         MI3JiLtMkQ9UXDQeR8h73+kwZT8jc+M+oKmnTho0X57SWxKV5DkYkbeFdMeFN8A8nt
         WvAlYgibEgYvS3efhlXm5upHIas65ryn73bhpqfoOuqsPofLN+nzcy+UoI+WxQP07q
         +uqRpmzo07EaMbU2r68I+NCDP/6q6Eez2uL9sARNQU9NfUF8mW3n5ksvgAxCqTqJGp
         ZvSOLLZBhwwWG5Np4FvZJbLXyvK97a6t7BMVHMaCDfbJaTrq8/m2/8LNoE4F76cTqI
         BFw8iggX3df1g==
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
Changes in v4: none
Changes in v3: none
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

