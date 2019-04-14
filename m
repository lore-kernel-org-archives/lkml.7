Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE49FC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAABC218FC
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555256901;
	bh=jSyW4Js/ipLEvuaqXRvnEGsSmkFH7KXhQHhdQZ7pTUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VW2PvB1B+G4VKvkKZLvOLseG0ydFBuyWK7Mo2NdzCgTd6GC3IM+w/QjahcuP3DziQ
	 HAEaK/BlOHS5zOrubSmzydcIIWkstoeOkI5d6vN3uN4IfuzifnF/Sj68X/VAU696tP
	 gH5/TuFl5qLsgXUC7l6lRJleGbWXuYK7sJbDiHiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDNPsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfDNPsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:48:17 -0400
Received: from localhost.localdomain (unknown [194.230.158.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFB4F218FC;
        Sun, 14 Apr 2019 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555256896;
        bh=jSyW4Js/ipLEvuaqXRvnEGsSmkFH7KXhQHhdQZ7pTUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nB+w6Ly0ePPbDvNlm4Cx04U/S91vELUz7bqInU7vPFUWu74dGwZz56CzKPvsFyISh
         FCX7+U0Vlg6sqANFvHgQ1lYyMtY3lozoftlhE+EUlQOYt7M5PmxvoD3IpZAx1EOvlK
         +j77RuCzIoHXIvy7EFiyx67BRk2ycTM611L/KPLU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/3] arm64: dts: exynos: Changes for v5.2
Date:   Sun, 14 Apr 2019 17:48:04 +0200
Message-Id: <20190414154805.10188-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190414154805.10188-1-krzk@kernel.org>
References: <20190414154805.10188-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.2

for you to fetch changes up to 77fc46976e0bfcd78d30fb4c9f0169752b4339c9:

  arm64: dts: exynos: Add SlimSSS to Exynos5433 (2019-03-20 19:29:57 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.2

1. Use proper clock rates for GSCALER module on TM2 boards.
2. Add clocks for local paths on DECON and GSCALER modules of
   Exynos5433.
3. Add Slim SecuritySubSystem to Exynos5433.

----------------------------------------------------------------
Andrzej Hajda (2):
      arm64: dts: exynos: configure GSCALER related clocks on TM2
      arm64: dts: exynos: add DSD/GSD clocks to DECONs and GSCALERs of Exynos5433

Kamil Konieczny (1):
      arm64: dts: exynos: Add SlimSSS to Exynos5433

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |  6 ++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  6 ++--
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 34 +++++++++++++++-------
 3 files changed, 34 insertions(+), 12 deletions(-)
