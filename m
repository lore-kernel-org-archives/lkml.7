Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC9C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2619B21855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDEU5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:57:55 -0400
Received: from hermes.aosc.io ([199.195.250.187]:36944 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEU5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:57:55 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id EFAEA6CDF5;
        Fri,  5 Apr 2019 20:57:51 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v5 1/5] dt-bindings: usb-connector: add Vbus regulator for Type-A/B
Date:   Sat,  6 Apr 2019 04:57:32 +0800
Message-Id: <20190405205736.55177-2-icenowy@aosc.io>
In-Reply-To: <20190405205736.55177-1-icenowy@aosc.io>
References: <20190405205736.55177-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Type-A and Type-B connectors have a Vbus pin, which provides +5V
power to bus-powered devices.

Add a power supply regulator property for this pin.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
New patch in v5.

 Documentation/devicetree/bindings/connector/usb-connector.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
index a9a2f2fc44f2..5608feeb1105 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.txt
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -17,6 +17,9 @@ Optional properties:
 - self-powered: Set this property if the usb device that has its own power
   source.
 
+Optional properties for usb-a-connector or usb-b-connector:
+- vbus-supply: phandle to a regulator supplying the VBUS voltage.
+
 Optional properties for usb-c-connector:
 - power-role: should be one of "source", "sink" or "dual"(DRP) if typec
   connector has power support.
-- 
2.18.1

