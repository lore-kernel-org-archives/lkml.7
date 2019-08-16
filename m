Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CF6C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2F52173B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565973055;
	bh=aO/6758MN7/RW1bNMET+Zow/5HJauuEWmahCmyZ+QO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PiqaTYkxFHBicHqSSdo22PDy9hEXeQ2+rts2wXoHUozl1h0z37NV8GrWhoqrWzN5r
	 UbaoDKhS9gwHMIfRmK0i4YDgQ1X8HDQd1hYyAZnhR/MNNGY++cZiwQfMH5noySphMb
	 wx4SeXnAakiXgoOX+rENW8/HTt4QheoG3raKO10s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfHPQay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfHPQax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:30:53 -0400
Received: from localhost.localdomain (unknown [194.230.155.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44C2621726;
        Fri, 16 Aug 2019 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565973053;
        bh=aO/6758MN7/RW1bNMET+Zow/5HJauuEWmahCmyZ+QO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGLBtl1MvgfiOIQ9n9p62C0/WjBydOJcjSi7nrhH8bMQIHIFinDSx2XfNjQEii5nF
         FN+asI5NHNtZmyJ8oedWDkTSyarlI+ocDqEuqVjRQMCwDGw9+xCN/u2eufUsd+4qte
         bMajju6KZRyva59zekAaQqvmQSGUbrchx1hft1EM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/3] ARM: dts: exynos: DT for v5.4
Date:   Fri, 16 Aug 2019 18:30:41 +0200
Message-Id: <20190816163042.6604-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816163042.6604-1-krzk@kernel.org>
References: <20190816163042.6604-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.4

for you to fetch changes up to bfb77169306d5d560a8b62eebaf6d69d02e8d152:

  ARM: dts: exynos: Add CAM power domain to Exynos5422/5800 (2019-08-12 19:02:59 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.4

1. Add AHCI to Exynos5250,
2. Add camera and GPU power domains to Exynos5422,
3. Minor cleanup.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: exynos: Use space after '=' in exynos4412-itop-scp-core

Marek Szyprowski (4):
      ARM: dts: exynos: Add port map to Exynos5250 AHCI node
      ARM: dts: exynos: Move MSC power domain to the right (sorted) place
      ARM: dts: exynos: Add G3D power domain to Exynos542x
      ARM: dts: exynos: Add CAM power domain to Exynos5422/5800

 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 18 +++++++++---------
 arch/arm/boot/dts/exynos5250.dtsi               |  1 +
 arch/arm/boot/dts/exynos5420.dtsi               | 13 ++++++++++---
 arch/arm/boot/dts/exynos5800.dtsi               |  9 +++++++++
 4 files changed, 29 insertions(+), 12 deletions(-)
