Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D53C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5538B21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbfJAIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:30:21 -0400
Received: from hermes.aosc.io ([199.195.250.187]:51678 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfJAIaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:30:21 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id F21C082889;
        Tue,  1 Oct 2019 08:30:15 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] Pine64+ specific hacks for RTL8211E Ethernet PHY
Date:   Tue,  1 Oct 2019 16:29:09 +0800
Message-Id: <20191001082912.12905-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There're some Pine64+ boards known to have broken RTL8211E chips, and
a hack is given by Pine64+, which is said to be from Realtek.

This patchset adds the hack.

The hack is taken from U-Boot, and it contains magic numbers without
any document.

Icenowy Zheng (3):
  dt-bindings: add binding for RTL8211E Ethernet PHY
  net: phy: realtek: add config hack for broken RTL8211E on Pine64+
    boards
  arm64: allwinner: a64: dts: apply hack for RTL8211E on Pine64+

 .../bindings/net/realtek,rtl8211e.yaml        | 23 +++++++++++++++++++
 .../dts/allwinner/sun50i-a64-pine64-plus.dts  |  1 +
 drivers/net/phy/realtek.c                     | 14 +++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl8211e.yaml

-- 
2.21.0

