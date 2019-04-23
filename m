Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B495C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2DC218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfDWR00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:26:26 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:39640 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfDWR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:26:23 -0400
Received: from pgsop.sopnet.com.ar (unknown [179.40.38.12])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id 9D4C37B3072;
        Tue, 23 Apr 2019 14:26:12 -0300 (-03)
From:   Pablo Greco <pgreco@centosproject.org>
To:     linux-sunxi@googlegroups.com
Cc:     Pablo Greco <pgreco@centosproject.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] ARM: dts: sun8i: v40 Rewrite BPi M2 Berry DTS based on BPi M2 Ultra
Date:   Tue, 23 Apr 2019 14:25:57 -0300
Message-Id: <1556040365-10913-1-git-send-email-pgreco@centosproject.org>
X-Mailer: git-send-email 1.8.3.1
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: 9D4C37B3072.A0799
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPi M2 Berry is a trimmed down version of the BPi M2 Ultra, completely
software compatible.

Changes include:
- 2GiB -> 1GiB
- no eMMC
- no onboard microphone
- no IR
- no blue LED
- no charging (and power jack to USB)
- dropped USB2 and connect USB1 to a 4-port HUB.

Changes in v5:
- Changed commit order
- Removed regulator-always-on from gpio regulators
- Copied commit log for the bluetooth node from the m2-ultra

Changes in v4:
- Went back to v2
- Added GPIO pin-bank regulators (both m2-ultra and m2-berry)

Changes in v3:
- Removed "Sort device node dereferences" (already applied)
- Added basic pio node
- Tied GMAC regulators to the pio (both m2-ultra and m2-berry)

Changes in v2:
- Split into smaller patches

Pablo Greco (7):
  ARM: dts: sun8i: r40: bananapi-m2-ultra: Add GPIO pin-bank regulator  
      supplies
  ARM: dts: sun8i: v40: bananapi-m2-berry: Add GPIO pin-bank regulator  
      supplies
  ARM: dts: sun8i: v40: bananapi-m2-berry: Enable GMAC ethernet
    controller
  ARM: dts: sun8i: v40: bananapi-m2-berry: Enable HDMI output
  ARM: dts: sun8i: v40: bananapi-m2-berry: Enable AHCI
  ARM: dts: sun8i: v40: bananapi-m2-berry: Fix WiFi regulator
    definitions
  ARM: dts: sun8i: v40: bananapi-m2-berry: Add Bluetooth device node

 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts |   6 ++
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 123 ++++++++++++++++++++++
 2 files changed, 129 insertions(+)

-- 
1.8.3.1

