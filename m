Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517C8C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230E320828
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562522487;
	bh=lsP5Zoo/8iHxNocirmfN8LDYdicr15IJWCPxxQZCuac=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GUQJVqDVvHXf18vwrpILdx44MWJY/u9x58X1MVN9yFEwsIkU07dhYxTnE5bpddbuZ
	 L5Cbp0AfayKHpMTCO69BmKeMRrK8apjNJmGAnRbfMjJlOrIHGTEmL5470c/e+7TR4a
	 VQ6grbBT53+Q/1NPyMI7NkPliPwxVbLDqTZGqZHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfGGSB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 14:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfGGSBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 14:01:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7577420828;
        Sun,  7 Jul 2019 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562522484;
        bh=lsP5Zoo/8iHxNocirmfN8LDYdicr15IJWCPxxQZCuac=;
        h=From:To:Cc:Subject:Date:From;
        b=aYZLB716cdJ9vvETO37jpgoOXnP21glMfS+sxwi9lTzhiavo91Hj69VdPMkWPUvbu
         0nhyQd6WSDuaDUY4WhIx6aQ0Y77KfoulEfUCWYkoD7wzlQpS/c5TdEs5Cl6upKY4Yf
         VoEp0gWJmw+3P+9a/9P4/9n9gZYZuiHhQDk2/7kM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: dts: exynos: Late pull for v5.3
Date:   Sun,  7 Jul 2019 20:01:15 +0200
Message-Id: <20190707180115.5562-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Late third pull of DTS changes, on top of previous pull request.
This contains important fix for stuff merged recently, one cleanup
and two minor fixups for regulators.

Best regards,
Krzysztof


The following changes since commit 13efd80acaa4cdb61fde52732178ff9eb4141104:

  ARM: dts: exynos: Add GPU/Mali 400 node to Exynos4 (2019-06-24 20:03:42 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.3-3

for you to fetch changes up to 841ed60264b3d37d5bf3e32cff168920e4923f88:

  ARM: dts: exynos: Adjust buck[78] regulators to supported values on Arndale Octa (2019-07-01 20:28:37 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.3, third round

1. Fix imprecise abort on Exynos4210 caused by newly added Mali nodes,
2. Reorganize Mali nodes under /soc,
3. Adjust buck regulators voltages on Arndale Octa and Odroid XU3/XU4
   family to sane values.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      ARM: dts: exynos: Adjust buck[78] regulators to supported values on Odroid XU3 family
      ARM: dts: exynos: Adjust buck[78] regulators to supported values on Arndale Octa

Marek Szyprowski (2):
      ARM: dts: exynos: Fix imprecise abort on Mali GPU probe on Exynos4210
      ARM: dts: exynos: Move Mali400 GPU node to "/soc"

 arch/arm/boot/dts/exynos3250.dtsi             | 66 +++++++++++++--------------
 arch/arm/boot/dts/exynos4.dtsi                | 50 ++++++--------------
 arch/arm/boot/dts/exynos4210.dtsi             | 20 ++++++++
 arch/arm/boot/dts/exynos4412.dtsi             | 22 +++++++++
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |  6 +--
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 10 ++--
 6 files changed, 97 insertions(+), 77 deletions(-)
