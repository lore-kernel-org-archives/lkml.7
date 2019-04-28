Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658D6C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA3D206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556462554;
	bh=w/rU7LVgIYiKJvGCsk3PphaPgE7GMKwBPLNwd/xvtTE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=v4lhirGC3nOtI1n7IswDwKjXibtW8d8zy29EwQRaf/5FjnjZcAnoSq7v1kr/M67qr
	 uN4WiEMdYcvwQaw0LIkq1t2DyoWaA4v6hOr5tObCcvYZPPXdyuyAL5CPSgjMfgh3QI
	 FiLEARjs/argozNf81NE8bmHUtLqjT27FoMPbapI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfD1Omc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 10:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfD1Omc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 10:42:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3EB20644;
        Sun, 28 Apr 2019 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556462551;
        bh=w/rU7LVgIYiKJvGCsk3PphaPgE7GMKwBPLNwd/xvtTE=;
        h=From:To:Cc:Subject:Date:From;
        b=1rvgk865ANImqrhNp3jACRVPQx74Aum+dL3iba7aK2fMxZ2ilYJh4uTvw4qQISDWc
         CeSNnvm3wtHhR+ZfbbC2+jFmochLdS+Tb9go966wPZLZl/8QOYCDk5/Y8fcQoCa6kZ
         D3R2kefMcTDqmRdJhE9MTJALh5XtqMTh8l0AnpaY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/2] ARM: dts: exynos: Second round for v5.2
Date:   Sun, 28 Apr 2019 16:42:20 +0200
Message-Id: <20190428144221.11187-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 8cc76b1c75722196fb3d7ffe67cbfeb721a7b0e3:

  ARM: dts: exynos: Remove console argument from bootargs (2019-04-10 18:13:31 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.2-2

for you to fetch changes up to b4bcbdee137833aab04942671b48a9a3beb0801b:

  ARM: dts: s5pv210: Fix camera clock provider on Goni board (2019-04-24 19:55:14 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.2, second round

1. DTC warning fixes: move timer and pmu nodes outside of soc node,
2. Properly override MDMA0 on Universal C210,
3. Fix camera clock provider (to match bindings and driver) on Goni.

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      ARM: dts: exynos: Move pmu and timer nodes out of soc
      ARM: dts: exynos: Remove unneeded address/size cells from fixed-clock on Exynos3250
      ARM: dts: exynos: Move fixed-clocks out of soc on Exynos3250
      ARM: dts: exynos: Properly override node to use MDMA0 on Universal C210
      ARM: dts: s5pv210: Fix camera clock provider on Goni board

 arch/arm/boot/dts/exynos3250.dtsi               | 72 ++++++++++++-------------
 arch/arm/boot/dts/exynos4.dtsi                  | 14 ++---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 17 +++++-
 arch/arm/boot/dts/exynos5250.dtsi               | 40 +++++++-------
 arch/arm/boot/dts/exynos54xx.dtsi               | 38 ++++++-------
 arch/arm/boot/dts/s5pv210-goni.dts              |  2 +-
 arch/arm/boot/dts/s5pv210.dtsi                  |  6 +--
 7 files changed, 100 insertions(+), 89 deletions(-)
