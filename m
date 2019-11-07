Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6648EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6B62166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfKGWVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:21:12 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:32815 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGWVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:21:11 -0500
X-Originating-IP: 92.184.100.203
Received: from localhost (unknown [92.184.100.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C9CB4C0004;
        Thu,  7 Nov 2019 22:21:08 +0000 (UTC)
Date:   Thu, 7 Nov 2019 23:20:50 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.5
Message-ID: <20191107222050.GA202089@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

New i2c features for sama5d4 and sama5d2 xplained boards. A new kizbox
and a rework of the existing kizbox device trees.

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.5-dt

for you to fetch changes up to e58ee34217246c34cd6bc9f129fb2dc3315ad27c:

  ARM: dts: at91: kizbox: use node labels (2019-11-07 00:38:15 +0100)

----------------------------------------------------------------
AT91 DT for 5.5

 - New Overkiz Kizbox3 board
 - Rework of the other Kizbox device trees
 - New filters for i2c on sama5d4 and sama5d2

----------------------------------------------------------------
Eugen Hristev (3):
      ARM: dts: at91: sama5d27_som1_ek: add mmc capabilities for SDMMC0
      ARM: dts: at91: sama5d2_xplained: add analog and digital filter for i2c
      ARM: dts: at91: sama5d4_xplained: add digital filter for i2c

Kamel Bouhara (7):
      ARM: dts: at91: sama5d2: add an rtc label for derived boards
      dt-bindings: Add vendor prefix for Overkiz SAS
      dt-bindings: arm: at91: Document Kizbox3 HS board binding
      ARM: dts: at91: add Overkiz KIZBOX3 board
      dt-bindings: arm: at91: Document Kizbox2-2 board binding
      ARM: dts: at91: add a dts and dtsi file for kizbox2 based boards
      ARM: dts: at91: kizbox: use node labels

 .../devicetree/bindings/arm/atmel-at91.yaml        |  14 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/at91-kizbox.dts                  | 172 +++++----
 arch/arm/boot/dts/at91-kizbox2-2.dts               |  26 ++
 arch/arm/boot/dts/at91-kizbox2-common.dtsi         | 258 +++++++++++++
 arch/arm/boot/dts/at91-kizbox2.dts                 | 244 ------------
 arch/arm/boot/dts/at91-kizbox3-hs.dts              | 309 ++++++++++++++++
 arch/arm/boot/dts/at91-kizbox3_common.dtsi         | 412 +++++++++++++++++++++
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |   1 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   6 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |   1 +
 arch/arm/boot/dts/sama5d2.dtsi                     |   2 +-
 13 files changed, 1116 insertions(+), 334 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-2.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-common.dtsi
 delete mode 100644 arch/arm/boot/dts/at91-kizbox2.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox3-hs.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox3_common.dtsi

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
