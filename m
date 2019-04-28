Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A2EC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E8D20644
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556462566;
	bh=2nlDegaPHckDGqoHmsfpGv9MEmyJ160PcbaY/t9ACE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=utwp0c6XPdKAVo2/bYzfjnf2y5oS2ykO76HyddYIb6UXo8lzmjVZsXZLqKxjmmH/J
	 v5WpKlCaxCIlToK1bucgQkiHFlGlD4BUA6rs4MIWJoxwO0DqVE+N49SY1ngEdTwtQ0
	 TS7VPQV2+/Ts+0rBUGv3h3hYt9C09lYOIB4kMkpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfD1Omf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 10:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfD1Omf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 10:42:35 -0400
Received: from localhost.localdomain (unknown [194.230.155.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E932075D;
        Sun, 28 Apr 2019 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556462554;
        bh=2nlDegaPHckDGqoHmsfpGv9MEmyJ160PcbaY/t9ACE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWy/XlAYlvhVZ/Us2vVCsBS0TxZ4Z9k54C0yk37jbQPhrXueCV1dSndf80v6WnBwl
         Cs0+ktFug4eb01KLicjW1dDvJmHJAartz7PEHxB2EOpmaF0ruM0nHQdj9YfxzLOFYH
         OS7jzUXNabq/7BDJ6LWb7P95vEqahew3rEN/OLfM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/2] arm64: dts: exynos: Second round for v5.2
Date:   Sun, 28 Apr 2019 16:42:21 +0200
Message-Id: <20190428144221.11187-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428144221.11187-1-krzk@kernel.org>
References: <20190428144221.11187-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 77fc46976e0bfcd78d30fb4c9f0169752b4339c9:

  arm64: dts: exynos: Add SlimSSS to Exynos5433 (2019-03-20 19:29:57 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.2-2

for you to fetch changes up to f36afdd0f53583759562cef3a8453919e3b86a7c:

  arm64: dts: exynos: Move fixed-clocks out of soc (2019-04-24 19:57:59 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.2, second round

DTC warning fixes: move fixed-clocks, timer and pmu nodes outside of soc
node.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      arm64: dts: exynos: Move pmu and timer nodes out of soc
      arm64: dts: exynos: Move fixed-clocks out of soc

 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 49 ++++++++++++-------------
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 57 +++++++++++++++---------------
 2 files changed, 54 insertions(+), 52 deletions(-)
