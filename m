Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D2CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F312E2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561491308;
	bh=WRO1PJBOd9F1TBXQZFcn4VIz5X/p6G37KuMecoE/ay0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YCWp1cGCj2AhuVQN2OcrqAjwr6fgPbYdc/wnEIbEXi5RAzTdA9edz4yLucyVSX99w
	 NVeEccI/g64tZvOLt8YVfV5hGwnxi/hclB/QbIeDZnP29QKWeafHKPa1qQGCkJWv5/
	 /+4ZCZqBkTd8aVacA0DbuBiHFq+0lNszlQDTjcmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfFYTfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfFYTfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:35:05 -0400
Received: from localhost.localdomain (unknown [194.230.155.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC6B213F2;
        Tue, 25 Jun 2019 19:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561491304;
        bh=WRO1PJBOd9F1TBXQZFcn4VIz5X/p6G37KuMecoE/ay0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+XgcGS/ZPjwM5bW6dOKu56L+JFdBHODTKjmGMIHxo4cYeSQhWBRvbzA/Y+gLvGWC
         aWGdGlWXCup0cVFaxiQKghZgqPzLFmP2hUpYO8tFhrxFvZ5zSYi8OlvNwLxwllGqsN
         rnPrSLG/D8KJ2Eoj11Oj+ZfY5ZtXtyw+HB+DSrkM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/4] ARM: dts: exynos: Second pull for v5.3
Date:   Tue, 25 Jun 2019 21:34:49 +0200
Message-Id: <20190625193451.7696-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625193451.7696-1-krzk@kernel.org>
References: <20190625193451.7696-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit d2cac68e0d9b038da7207c0b63e1399c4f9f60c4:

  ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU (2019-06-11 20:37:21 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.3-2

for you to fetch changes up to 13efd80acaa4cdb61fde52732178ff9eb4141104:

  ARM: dts: exynos: Add GPU/Mali 400 node to Exynos4 (2019-06-24 20:03:42 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.3, second round

1. Add camera flash to Galaxy S3 boards,
2. Fix PMU affinity interrupt warning on Exynos4,
3. Improve regulator configuration on Odroid XU3/XU4/HC1 family and
   Arndale Octa by disabling unneeded regulators and adding suspend
   configuration.  The suspend configuration brings significant reduce of
   energy usage in Suspend to RAM (e.g. 120 -> ~7 mA on Odroid HC1).
4. Add Mali nodes to Exynos3 and Exynos4.

----------------------------------------------------------------
Krzysztof Kozlowski (9):
      ARM: dts: exynos: Add PMU interrupt affinity to Exynos4 boards
      ARM: dts: exynos: Fix language typo and indentation
      ARM: dts: exynos: Disable unused buck10 regulator on Odroid HC1 board
      ARM: dts: exynos: Add regulator suspend configuration to Arndale Octa board
      ARM: dts: exynos: Add regulator suspend configuration to Odroid XU3/XU4/HC1 family
      ARM: dts: exynos: Use proper regulator for eMMC memory on Arndale Octa
      dt-bindings: gpu: mali: Add Samsung compatibles for Midgard and Utgard
      ARM: dts: exynos: Add GPU/Mali 400 node to Exynos3250
      ARM: dts: exynos: Add GPU/Mali 400 node to Exynos4

Simon Shields (1):
      ARM: dts: exynos: Add flash support to Galaxy S3 boards

 .../devicetree/bindings/gpu/arm,mali-midgard.txt   |  1 +
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  1 +
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |  5 ++
 arch/arm/boot/dts/exynos3250-monk.dts              |  5 ++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  5 ++
 arch/arm/boot/dts/exynos3250.dtsi                  | 33 ++++++++
 arch/arm/boot/dts/exynos4.dtsi                     | 38 ++++++++-
 arch/arm/boot/dts/exynos4210-origen.dts            |  5 ++
 arch/arm/boot/dts/exynos4210-trats.dts             |  4 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  5 ++
 arch/arm/boot/dts/exynos4210.dtsi                  | 31 ++++++-
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi        | 32 +++++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    |  5 ++
 arch/arm/boot/dts/exynos4412-midas.dtsi            |  5 ++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  5 ++
 arch/arm/boot/dts/exynos4412-prime.dtsi            |  7 ++
 arch/arm/boot/dts/exynos4412.dtsi                  | 27 ++++++
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 82 +++++++++++++++++-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 98 +++++++++++++++++++++-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  6 ++
 20 files changed, 392 insertions(+), 8 deletions(-)
