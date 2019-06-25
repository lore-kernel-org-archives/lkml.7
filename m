Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74362C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4054020883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561491304;
	bh=hQjKnhcZZUBXPnB4E3tB9Mrbs5scGFUowmnD4/pB2Ek=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=i31DrPOLB0sp5TAjCTl6sOckg/VQn2zNDqF3e1UBtSMX+n9eKT+2JZ2xxWo/G4sog
	 4DYg7Ycxc3EQjeoRkEuDuVVGZBiWLglHlSx80dZ2pyS8m/ln+zPVOzb1xgpw1pzyUe
	 jflcR/djUxngTkQ7wBfIVFBE4ZW8jItd/7vO2Tn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfFYTfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfFYTfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:35:02 -0400
Received: from localhost.localdomain (unknown [194.230.155.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D024120883;
        Tue, 25 Jun 2019 19:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561491301;
        bh=hQjKnhcZZUBXPnB4E3tB9Mrbs5scGFUowmnD4/pB2Ek=;
        h=From:To:Cc:Subject:Date:From;
        b=o1JcsmuO60aZ0R5wdaDmtQYeoEr+vUjp9eyMf0/7AhX9CexsHk+Lgq3EJ3rLVbX1E
         +DDGwuTD03wkgpirHBdbD4tn8V8fWf5s0EkgbwWzmhlQRwyWy/yKI3rBQg8Q/GB6I7
         uIKtvkplzhyp150qaAzyMLS/wPGqSwYvGGDQWJOE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/4] ARM: defconfig: Samsung/Exynos for v5.3
Date:   Tue, 25 Jun 2019 21:34:48 +0200
Message-Id: <20190625193451.7696-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-5.3

for you to fetch changes up to dd50a69b5697532666023766688c6ea642e5a443:

  ARM: exynos_defconfig: Enable Panfrost and Lima drivers (2019-06-19 19:23:35 +0200)

----------------------------------------------------------------
Samsung defconfig changes for v5.3

1. Trim several configs with savedefconfig.
2. Enable Lima and Panfrost drivers for Mali GPU.

----------------------------------------------------------------
Krzysztof Kozlowski (4):
      ARM: exynos_defconfig: Trim and reorganize with savedefconfig
      ARM: defconfig: samsung: Cleanup with savedefconfig
      ARM: multi_v7_defconfig: Enable Panfrost and Lima drivers
      ARM: exynos_defconfig: Enable Panfrost and Lima drivers

 arch/arm/configs/exynos_defconfig   | 65 +++++++++++++++++--------------------
 arch/arm/configs/mini2440_defconfig | 43 ++++++++++--------------
 arch/arm/configs/multi_v7_defconfig |  3 +-
 arch/arm/configs/s3c2410_defconfig  | 24 +++++---------
 arch/arm/configs/s3c6400_defconfig  | 11 +++----
 5 files changed, 62 insertions(+), 84 deletions(-)
