Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C611CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D65214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572890357;
	bh=7ghGrmoiEIxN4IpLB8JEUAW5aI+a94fxk1XNN5k5Y9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zVSzh/X8QhIfgJnczTmfZtmN+91jNqibwJeUeen4rOLqlHYkB11nwzAk3YvvZwBXZ
	 kRGSGQ6vM20V6fSgIzq55vYCSiiMmLnKwMAMrLn1E6HUH+ePR7fxv6LAQNqx9soAx+
	 Yd7116XV7L7WsyxG2OBTH+hmH5vFs+naFb6UdH1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfKDR7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:59:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbfKDR7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:59:15 -0500
Received: from localhost.localdomain (unknown [194.230.155.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E7C02184C;
        Mon,  4 Nov 2019 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572890354;
        bh=7ghGrmoiEIxN4IpLB8JEUAW5aI+a94fxk1XNN5k5Y9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOZ2pWZA0y4VDkNtlai4dc6Nq9LOmCdV/DcOiR1N/0WcdNsF/8p2ySJPWeDEVKL9A
         Ph29g1ciVxTQJ1RupdWgogkr8PqdgCnGMIN2AeYweO7xsMNS9UPLKKTD2dQnJR0RjJ
         DypJkGVPfiHpfw5U8/MGYHG5mpnUR+WWwLwSMwlU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/2] ARM: samsung: S3C/Exynos for v5.5
Date:   Mon,  4 Nov 2019 18:59:02 +0100
Message-Id: <20191104175902.12224-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104175902.12224-1-krzk@kernel.org>
References: <20191104175902.12224-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.5

for you to fetch changes up to 4134b762eb133787273500101223e10728c154cd:

  ARM: exynos: Enable exynos-asv driver for ARCH_EXYNOS (2019-10-28 18:22:33 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v5.5

1. Minor cleanups in S3C platforms,
2. Enable newly added EXYNOS_ASV (Adaptive Supply Voltage) driver.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      ARM: s3c: Rename s3c64xx_spi_setname() function
      ARM: s3c: Rename s5p_usb_phy functions

Sylwester Nawrocki (1):
      ARM: exynos: Enable exynos-asv driver for ARCH_EXYNOS

 arch/arm/mach-exynos/Kconfig                 | 1 +
 arch/arm/mach-s3c24xx/s3c2416.c              | 2 +-
 arch/arm/mach-s3c24xx/s3c2443.c              | 2 +-
 arch/arm/mach-s3c24xx/spi-core.h             | 2 +-
 arch/arm/mach-s3c64xx/setup-usb-phy.c        | 4 ++--
 arch/arm/plat-samsung/devs.c                 | 4 ++--
 arch/arm/plat-samsung/include/plat/usb-phy.h | 4 ++--
 7 files changed, 10 insertions(+), 9 deletions(-)
