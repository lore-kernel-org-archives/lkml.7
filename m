Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E646BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B636D2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571681130;
	bh=0CPJIU1rMIOyGYW8ZKtjAoM8g4H4SToVEeMTsL9SeOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=01OUPlgPYXlF7yy13UUz2QYhS1MDvdpCVKzXYzPw0OCnpoPzVpdr6tAIVG2SVns4S
	 jQD9QaGm5MjMhclrKMNYn33MFrJYJkwkq4C/B71xJR9IMpY/ZEn/LNYWbWYEcqHYKK
	 hzfwa+3gaerlj5wG7QmoStOhTK9ZNtrmZvBdyMQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfJUSF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730054AbfJUSF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:05:27 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86BBE20B7C;
        Mon, 21 Oct 2019 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571681127;
        bh=0CPJIU1rMIOyGYW8ZKtjAoM8g4H4SToVEeMTsL9SeOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhO3+gZ/Flb+yd21IPeK1WThLsplFx5zNC9VKGSJMJitEOeFANYtyZfHXWH4Y1NWh
         8JdltN9eMwkFvz0IErvQKIfpBcrl4wiQduz2abHB6uf6EI7sj42CuNP9/Y9PWtZRRx
         sM1fuBY1F+5JvRyb9ikYrxmAhv2eptbuMlFfnolc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/5] ARM: dts: exynos: memory DMC driver bindings for v5.5
Date:   Mon, 21 Oct 2019 20:04:53 +0200
Message-Id: <20191021180453.29455-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021180453.29455-1-krzk@kernel.org>
References: <20191021180453.29455-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Topic branch/pull for DMC driver bindings/DTS. Patchset had many iterations
on mailing lists and waited for very long.

Best regards,
Krzysztof


The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-dmc-5.5

for you to fetch changes up to 41f277be1d028e64fb8d5e91a7ce74df600bde54:

  dt-bindings: memory-controllers: exynos5422-dmc: Correct example syntax and memory region (2019-10-06 17:54:28 +0200)

----------------------------------------------------------------
Samsung DTS changes for DMC driver for v5.5

Add bindings and update device tree sources of Exynos5422 platforms with
new Dynamic Memory Controller nodes and properties.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      dt-bindings: memory-controllers: exynos5422-dmc: Correct example syntax and memory region

Lukasz Luba (9):
      dt-bindings: ddr: Rename lpddr2 directory
      dt-bindings: ddr: Add bindings for LPDDR3 memories
      dt-bindings: memory-controllers: Add Exynos5422 DMC device description
      ARM: dts: exynos: Add syscon compatible to clock controller on Exynos542x
      ARM: dts: exynos: Add DMC device to Exynos5422 and Odroid XU3-family boards
      dt-bindings: ddr: Add bindings for Samsung LPDDR3 memories
      dt-bindings: memory-controllers: exynos5422-dmc: Add interrupt mode
      ARM: dts: exynos: Extend mapped region for DMC on Exynos5422
      ARM: dts: exynos: Add interrupts to DMC controller in Exynos5422

 .../bindings/{lpddr2 => ddr}/lpddr2-timings.txt    |   0
 .../devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt |   2 +-
 .../devicetree/bindings/ddr/lpddr3-timings.txt     |  58 ++++++++++
 Documentation/devicetree/bindings/ddr/lpddr3.txt   | 101 ++++++++++++++++++
 .../bindings/memory-controllers/exynos5422-dmc.txt |  84 +++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi                  |  76 ++++++++++++-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 117 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5800.dtsi                  |   2 +-
 8 files changed, 437 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt (96%)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
