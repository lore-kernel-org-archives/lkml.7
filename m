Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF37FC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DED22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619432;
	bh=/GY26QI0Q0gbFhW694JTrgCRqeBhXVLVrh3+/U5tGno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XfceerX9K1PNkHKVHNOaW7rb6ZmsU9nYY8MJF7g2G1aCa65QUaCXtwriIJHYpCkC/
	 bxFmR18/zup5Cx3kb293AaJ7YrfXE7loYtkMaOBgUxFQNuIS2l03f4RsIp//uGxF4T
	 X0WSHxGwnYj7z2uNHp09IyPVnbh2wtAVQ0VvCiJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfIDRub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfIDRub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:50:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506182341C;
        Wed,  4 Sep 2019 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619430;
        bh=/GY26QI0Q0gbFhW694JTrgCRqeBhXVLVrh3+/U5tGno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOhBFOWIey4Drc9rZPVC+o62tCPCxqHoVj6GJHZtsfCnwHNk5BCb+EHO2TNXK0+zJ
         TXDRpNw0ty7EGkclyMM57hCyIxo1tX4Xw+S4STTmpEEv/50wnDw0uGd6Gtl6rmj75M
         z5ob51MShXEKNqS7yJ+1Cfw7dpPRmiP9wnUH6P6E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 4/5] ARM: samsung: mach for v5.4, second (replacing previous)
Date:   Wed,  4 Sep 2019 19:50:01 +0200
Message-Id: <20190904175002.10487-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904175002.10487-1-krzk@kernel.org>
References: <20190904175002.10487-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Replaces previous pull (and it includes it).

Best regards,
Krzysztof


The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.4-2

for you to fetch changes up to c663d542bfb40eeeb6d393ed155c23a4666d65e1:

  MAINTAINERS: Extend patterns for Samsung SoC, Security Subsystem and clock drivers (2019-08-22 21:04:45 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v5.4

1. Minor fixup in plat and mach code (S3C platforms),
2. Enable exynos-chipid driver to provide SoC related information,
3. Extend the patterns for Samsung maintainer entries to cover all
   important files.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      MAINTAINERS: Extend patterns for Samsung SoC, Security Subsystem and clock drivers

Linus Walleij (1):
      ARM: samsung: Include GPIO driver header

Masahiro Yamada (1):
      ARM: s3c64xx: squash samsung_usb_phy.h into setup-usb-phy.c

Pankaj Dubey (1):
      ARM: exynos: Enable exynos-chipid driver

 MAINTAINERS                                    |  9 +++++++--
 arch/arm/mach-exynos/Kconfig                   |  1 +
 arch/arm/mach-s3c64xx/setup-usb-phy.c          |  5 +++++
 arch/arm/plat-samsung/include/plat/gpio-core.h |  1 +
 arch/arm/plat-samsung/include/plat/usb-phy.h   |  2 --
 include/linux/usb/samsung_usb_phy.h            | 17 -----------------
 6 files changed, 14 insertions(+), 21 deletions(-)
 delete mode 100644 include/linux/usb/samsung_usb_phy.h
