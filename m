Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15916C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B7B20872
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568227004;
	bh=zsAB6WKO0YUTRbf1KlkkihwcBaG99V4V6kcl0Y33ae4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VoJG3aMH3KV+PWehDfbzahX6NnQQeJ04McUqBLIzDdYsZBWGDrZSZtooCV7dLp8be
	 YTjMhJmRW/Mvyubm0bDnP50cReHvPwL6Rh+QT9DxHnffL+9Zl9DJJZbReB6dclzJ7f
	 bapfa0zv87+ey6z+4ZY/FlVwjTsayI5efkTHYPAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbfIKSgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729696AbfIKSgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:36:43 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC7D2084D;
        Wed, 11 Sep 2019 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568227002;
        bh=zsAB6WKO0YUTRbf1KlkkihwcBaG99V4V6kcl0Y33ae4=;
        h=From:To:Cc:Subject:Date:From;
        b=vFzY2gxxGLGsQPPMu4wBVwmwpKxTfRAY9t5Cj8YqhPr4ci7+zFL82rKfU2A/VwiPb
         SKFqk/aGXuL0w7oHpgS05xAWBZbHg+zi3Wsw028J7nJPFJP/P62rL8GoXNGB0LrH+e
         laizrxj2EEWRnQ3lB3iFetfQkvbxodu4fwIiyUqM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/2] arm64: dts: exynos: Pull for v5.4
Date:   Wed, 11 Sep 2019 20:36:31 +0200
Message-Id: <20190911183632.4317-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Unfortunately the patches were applied right after closing the linux-next.

Best regards,
Krzysztof


The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.4

for you to fetch changes up to 266cf9826de38efac416e744d42364ac7fa9dc5b:

  arm64: dts: exynos: Remove useless #address-cells property for GIC node (2019-09-05 21:27:17 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.4

1. Fix boot of Exynos7 due to wrong address/size of memory node,
2. Move GPU under /soc node,
3. Minor cleanup of #address-cells.

----------------------------------------------------------------
Marek Szyprowski (4):
      arm64: dts: exynos: Propagate address/size cell change to /memory node
      arm64: dts: exynos: Move GPU under /soc node for Exynos5433
      arm64: dts: exynos: Move GPU under /soc node for Exynos7
      arm64: dts: exynos: Remove useless #address-cells property for GIC node

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |   2 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 102 ++++++++++-----------
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   2 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  23 +++--
 4 files changed, 64 insertions(+), 65 deletions(-)
