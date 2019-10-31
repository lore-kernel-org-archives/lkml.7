Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27CBCA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AAE20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfJaQxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:53:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:34760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727715AbfJaQxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:53:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80ED6B2FE;
        Thu, 31 Oct 2019 16:53:10 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 0/4] ARM: Initial RTD1195 and MeLE X1000 support
Date:   Thu, 31 Oct 2019 17:53:03 +0100
Message-Id: <20191031165308.14102-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds initial support for Realtek RTD1195 SoC
and adds a Device Tree for the MeLE X1000 TV set-top-box.

v2 cleans up memory reservations and enables the arch timer.

More details at:
https://en.opensuse.org/HCL:Mele_X1000

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* Do not redundantly select COMMON_CLK (Arnd)
* Drop further unneeded selects
* Clean up memory reservations (Rob)
* Enable arch timer

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>

Andreas Färber (4):
  dt-bindings: arm: realtek: Add RTD1195 and MeLE X1000
  ARM: Prepare Realtek RTD1195
  ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
  ARM: realtek: Enable RTD1195 arch timer

 Documentation/devicetree/bindings/arm/realtek.yaml |   6 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   3 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/rtd1195-mele-x1000.dts           |  31 +++++
 arch/arm/boot/dts/rtd1195.dtsi                     | 127 +++++++++++++++++++++
 arch/arm/mach-realtek/Kconfig                      |  11 ++
 arch/arm/mach-realtek/Makefile                     |   2 +
 arch/arm/mach-realtek/rtd1195.c                    |  53 +++++++++
 9 files changed, 237 insertions(+)
 create mode 100644 arch/arm/boot/dts/rtd1195-mele-x1000.dts
 create mode 100644 arch/arm/boot/dts/rtd1195.dtsi
 create mode 100644 arch/arm/mach-realtek/Kconfig
 create mode 100644 arch/arm/mach-realtek/Makefile
 create mode 100644 arch/arm/mach-realtek/rtd1195.c

-- 
2.16.4

