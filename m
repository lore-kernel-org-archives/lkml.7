Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ADCC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B21C2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560707723;
	bh=d0RGGfQllTO5+OTHP8JYkWAhgVmpG2+sN+yX0OyDV00=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uwachRKzEfybA0WxzbQ7lWpFRQeCXHmwPzzFFfxdwn22A/ktjX1bPbPSdDMWmMO+9
	 5w5yd4lqFjZe491Rqasey1hCOESH+m52Zm5MsjpppNPTmfaS2BBuYei+iqM3TyjHfU
	 lFX/YMqERz6FDOKnko5fyY7znVL/DVlcTqn/SZaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfFPRzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 13:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbfFPRzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 13:55:21 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE732087F;
        Sun, 16 Jun 2019 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560707720;
        bh=d0RGGfQllTO5+OTHP8JYkWAhgVmpG2+sN+yX0OyDV00=;
        h=From:To:Cc:Subject:Date:From;
        b=CF500ixgjgJqaIRFaZRGGfNUN3ri0WjWg/j5FMiZJ3XqKs1OJi4ZWTwhjMmTBLm8n
         f67gjy2tYWcPeb20FvjMCUljQ78KJpIYdJYamDr8wg4INmdom4kDxkpxcTm1qaw3in
         GAUgDUhIYZgpt12SdIphwZ7qQ5HGr4pSOPwQ3XkU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: dts: exynos: Pull for v5.3
Date:   Sun, 16 Jun 2019 19:55:13 +0200
Message-Id: <20190616175513.3681-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.3

for you to fetch changes up to d2cac68e0d9b038da7207c0b63e1399c4f9f60c4:

  ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU (2019-06-11 20:37:21 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.3

1. Fixes for minor warnings.
2. Enable ADC on Exynos5410 Odroid XU board.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      ARM: dts: exynos: Move CPU OPP tables out of SoC node on Exynos5420
      ARM: dts: exynos: Raise maximum buck regulator voltages on Arndale Octa
      ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU

 arch/arm/boot/dts/exynos5410-odroidxu.dts     |   5 +
 arch/arm/boot/dts/exynos5410.dtsi             |   6 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |  14 +-
 arch/arm/boot/dts/exynos5420.dtsi             | 234 +++++++++++++-------------
 arch/arm/boot/dts/exynos54xx.dtsi             |   9 +
 5 files changed, 142 insertions(+), 126 deletions(-)
