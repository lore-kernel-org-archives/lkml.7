Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2D0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704F6227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="psDn2i/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfLRJQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:16:56 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15870 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:16:55 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9ee690000>; Wed, 18 Dec 2019 01:16:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 01:16:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 18 Dec 2019 01:16:54 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:16:53 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Dec 2019 09:16:53 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df9ee810005>; Wed, 18 Dec 2019 01:16:53 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V2 01/18] dt-bindings: phy: tegra-xusb: Add usb-role-switch
Date:   Wed, 18 Dec 2019 14:46:14 +0530
Message-ID: <1576660591-10383-2-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576660586; bh=5Dzsrr2qt+mkgDc9tQPPuzpdjgZ4yUOtKP3vu91etk8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=psDn2i/pHiPpA2ksvJrkFB7qL5hSt9h+7/N05z9YZrbjcqlKt0dg2PQYdLkAHiyFO
         WZ0GgdtyUI2dwzhuoEntpo93fyB/bNjvTMLQJVqLeuvXllCucaJBOjhHzrSemOkU0F
         zfqyD1ajD4bNOguVRkECKyPNzBiuihp+guFtcY5XrOmSzVaHaFDwy7U+MYmD9C6msU
         PoRTWfvirJ4IjtsbsD+EhNxwvGl1jFqeWwUaUJuzkmSC+86M2Eh1WFJvVSNV7lLlPg
         q6EnyLhRqpeidgg/Up1Y4Xc2IIduMT29/TzEyQv/2iS0j+gdcUWnvZ8z59EIepFuZS
         +pZvXEqoiCxXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb-role-switch property for Tegra210 and Tegra186 platforms. This
entry is used by XUSB pad controller driver to register for role changes
for OTG/Peripheral capable USB 2 ports.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - Moved usb-role-switch to seperate Required section as suggested by Thierry.
 - Added reference to usb/usb-conn-gpio.txt for connector subnode.
---
 .../devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
index 9fb682e..23bf354 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
@@ -174,6 +174,12 @@ Required properties:
   - "device": for USB device mode
   - "otg": for USB OTG mode
 
+Required properties for OTG/Peripheral capable USB2 ports:
+- usb-role-switch: Boolean property to indicate that the port support OTG or
+  peripheral mode. If present, the port supports switching between USB host
+  and peripheral roles. Connector should be added as subnode.
+  See usb/usb-conn-gpio.txt.
+
 Optional properties:
 - nvidia,internal: A boolean property whose presence determines that a port
   is internal. In the absence of this property the port is considered to be
-- 
2.7.4

