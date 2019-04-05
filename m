Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5684C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCDD2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDEU5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:57:50 -0400
Received: from hermes.aosc.io ([199.195.250.187]:36923 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEU5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:57:50 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 807F76CD37;
        Fri,  5 Apr 2019 20:57:46 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v5 0/5] Allwinner H6 USB3 support
Date:   Sat,  6 Apr 2019 04:57:31 +0800
Message-Id: <20190405205736.55177-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds device tree binding and driver support for Allwinner
H6 USB3 PHY. The controller is just a DWC3 controller from Synposys.

Because of the suggest of Rob Herring, this revision uses the USB
connector device tree binding, and enhanced it by adding Vbus supply
property to it.

Icenowy Zheng (5):
  dt-bindings: usb-connector: add Vbus regulator for Type-A/B
  dt-bindings: phy: add binding for Allwinner USB3 PHY
  phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
  arm64: allwinner: dts: h6: add USB3 device nodes
  arm64: allwinner: dts: h6: enable USB3 port on Pine H64

 .../bindings/connector/usb-connector.txt      |   3 +
 .../bindings/phy/sun50i-usb3-phy.txt          |  28 ++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  13 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  32 +++
 drivers/phy/allwinner/Kconfig                 |  12 +
 drivers/phy/allwinner/Makefile                |   1 +
 drivers/phy/allwinner/phy-sun50i-usb3.c       | 260 ++++++++++++++++++
 7 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c

-- 
2.18.1

