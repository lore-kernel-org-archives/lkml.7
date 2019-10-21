Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BD8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E1F21BE5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571681115;
	bh=ToYS4x8WHhQ96kguiwcjMG4uFgJwdCUKs39Q+zM3LpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YnO4n4P/ng6lVy30vsZcgadMrNELtSBHktlRcAIrAEAP91lYo+ujafyoTMX1lZhah
	 Ou5/dzVPf6UAGxTQM52ImQJL//55uZNdn8y8FuKFHpbTC6xKztD0JCFeVgdaX6yor5
	 STU42/cZSwF0R2elRSkkrpeq40DEd7NwmRHgdmPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfJUSFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbfJUSFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:05:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B78FC21906;
        Mon, 21 Oct 2019 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571681113;
        bh=ToYS4x8WHhQ96kguiwcjMG4uFgJwdCUKs39Q+zM3LpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvpmUP3ikLg963U1Z9OA9ivg8wVqkDuC/wdT0IT+BcyGlavi4G2tVtxiTPlJQU38h
         8+LV179AYUZOygjGtfz+qZaZqadPCbtb/ocjfasvy0anuulWtoosQfY/lP7QbxJkjO
         nZEwUCcst8QARig3szqGz2pS1ZO3c/jQc8VS3j74=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/5] drivers: memory: Samsung for v5.5
Date:   Mon, 21 Oct 2019 20:04:50 +0200
Message-Id: <20191021180453.29455-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021180453.29455-1-krzk@kernel.org>
References: <20191021180453.29455-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Topic branch/pull for DMC driver in memory. Patchset had many iterations
on mailing lists and waited for very long.

Best regards,
Krzysztof


The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-dmc-5.5

for you to fetch changes up to bbf918863e183d66adf00ca1b24fb641149a0d3d:

  memory: samsung: exynos5422-dmc: Add support for interrupt from performance counters (2019-10-02 19:37:37 +0200)

----------------------------------------------------------------
Samsung DMC driver for v5.5

Add Samsung Dynamic Memory Controller for Exynos5422 which provides
scaling of frequency and voltage of memory controller and DRAM.  The
driver allows to reduce energy usage without performance impact.

----------------------------------------------------------------
Colin Ian King (1):
      memory: samsung: exynos5422-dmc: Fix spelling mistake "counld" -> "could"

Lukasz Luba (4):
      memory: Extend of_memory with LPDDR3 support
      memory: Add DMC driver for Exynos5422
      memory: samsung: exynos5422-dmc: Fix kfree() of devm-allocated memory and missing static
      memory: samsung: exynos5422-dmc: Add support for interrupt from performance counters

 MAINTAINERS                             |    8 +
 drivers/memory/jedec_ddr.h              |   61 ++
 drivers/memory/of_memory.c              |  149 +++
 drivers/memory/of_memory.h              |   18 +
 drivers/memory/samsung/Kconfig          |   13 +
 drivers/memory/samsung/Makefile         |    1 +
 drivers/memory/samsung/exynos5422-dmc.c | 1550 +++++++++++++++++++++++++++++++
 7 files changed, 1800 insertions(+)
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c
