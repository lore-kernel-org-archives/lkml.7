Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6237C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8254721852
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574173236;
	bh=bDknmdXel1QhemGwQ74XJ2xEvUlEwuXxxvu6HOA2Uek=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oo+JahO2UhIrArYSgj8q0tNPhIDRBLn6kqwvlq5mks4/dFy34CyByFEIfcOZIXOY2
	 0OY8gBdheX8OK5hDOxWk2B5DnfG9oAmbeuFTeX/6qqLdkdA9hlVmTMZpvSUgOziUOq
	 lL7np4WQtCTUjTpTPodGkM5lp/QrRR31i2ndLeDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfKSOUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:20:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfKSOUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:20:34 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF85821852;
        Tue, 19 Nov 2019 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574173233;
        bh=bDknmdXel1QhemGwQ74XJ2xEvUlEwuXxxvu6HOA2Uek=;
        h=From:To:Cc:Subject:Date:From;
        b=D+UMymV5RJXQGaDr1xNwW0igze7OsE0mJxe/AeIC9IeHqKddkQss4Npl1JCSz/IV+
         4icbHQsvk6C33XK9EKKgrRDT9OkTdf1TH5V15YriRB6FpHbqC8nUk/h8bIKhJ4e8RE
         nN6VZH1lEJt/Z1PhUP5lPy9kQZrGu+y5hoet7DTs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: dts: exynos: Second pull for v5.5
Date:   Tue, 19 Nov 2019 15:20:26 +0100
Message-Id: <20191119142026.7190-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request - minor updates for next cycle.


Best regards,
Krzysztof


The following changes since commit d60d0cff4ab01255b25375425745c3cff69558ad:

  ARM: dts: s3c64xx: Fix init order of clock providers (2019-10-08 22:45:20 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.5-2

for you to fetch changes up to 1a5a85c5640241ba1407c77792a96cb6d0253483:

  ARM: dts: exynos: Add Mali/GPU node on Exynos5420 and enable it on Odroid XU3/4 (2019-11-18 13:45:22 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.5, part 2

1. Cleanup by adjusting DTS to bindings,
2. Add touch-sensitive buttons to Midas (Galaxy S III family phones),
3. Add GPU/Mali to Exynos542x and Odroid XU3/XU4 family.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: exynos: Rename children of SysRAM node to "sram"

Marian Mihailescu (1):
      ARM: dts: exynos: Add Mali/GPU node on Exynos5420 and enable it on Odroid XU3/4

Simon Shields (1):
      ARM: dts: exynos: Add support for the touch-sensitive buttons on Midas family

 arch/arm/boot/dts/exynos3250.dtsi               |  4 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts |  6 +--
 arch/arm/boot/dts/exynos4210.dtsi               |  4 +-
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi     |  5 +++
 arch/arm/boot/dts/exynos4412-midas.dtsi         | 29 ++++++++++++++
 arch/arm/boot/dts/exynos4412-n710x.dts          |  5 +++
 arch/arm/boot/dts/exynos4412.dtsi               |  4 +-
 arch/arm/boot/dts/exynos5250.dtsi               |  4 +-
 arch/arm/boot/dts/exynos5420.dtsi               | 50 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   |  6 ++-
 arch/arm/boot/dts/exynos54xx.dtsi               |  4 +-
 11 files changed, 107 insertions(+), 14 deletions(-)
