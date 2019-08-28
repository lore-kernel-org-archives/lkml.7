Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B16C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0276E208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfH1KJm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:09:42 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48047 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1KJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:09:41 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 460C31C0006;
        Wed, 28 Aug 2019 10:09:39 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, soc@kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: mvebu: dt64 for v5.4 (#1)
Date:   Wed, 28 Aug 2019 12:09:38 +0200
Message-ID: <875zmhzjml.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the first pull request for dt64 for mvebu for v5.4.

Gregory

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-5.4-1

for you to fetch changes up to c00bc38354cf81ce83b678ff13ecf01e75d0e8da:

  arm64: dts: marvell: Add cpu clock node on Armada 7K/8K (2019-08-27 16:39:22 +0200)

----------------------------------------------------------------
mvebu dt64 for 5.4 (part 1)

 - Add mailbox support on Armada 37xx
 - Add cpu clock node needed for CPU freq on Armada 7K/8K
 - Enhance CP110 COMPHY support used by PCIe, USB3 and SATA

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm64: dts: marvell: Add cpu clock node on Armada 7K/8K

Marek Behún (1):
      arm64: dts: marvell: armada-37xx: add mailbox node

Miquel Raynal (5):
      arm64: dts: marvell: Add CP110 COMPHY clocks
      arm64: dts: marvell: Add 7k/8k per-port PHYs in SATA nodes
      arm64: dts: marvell: Add 7k/8k PHYs in USB3 nodes
      arm64: dts: marvell: Add 7k/8k PHYs in PCIe nodes
      arm64: dts: marvell: Convert 7k/8k usb-phy properties to phy-supply

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  7 ++++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 37 +++++++++++++------
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     | 22 ++++++++---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 43 +++++++++++++++++++---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 38 +++++++++++++++----
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  5 ++-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  7 ++++
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 13 +++++++
 8 files changed, 139 insertions(+), 33 deletions(-)
 
-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
