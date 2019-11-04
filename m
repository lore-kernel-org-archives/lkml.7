Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB9ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB40214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572890353;
	bh=LGIo8ZmiAbwfkL3OFX1XtCq8eoQUgUNanwlaQmqqLIk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bzrd4BYgusxjodamkTFPyCn0Kuj1bj2Bvow2bjAolWfJEVZ/ISUvFpW4e4m3xSw7V
	 wPElqHPLiHbifYx4OVm9cEJFtr3Tpy0aXLIeYg6xCaq1WY9wK3Im2jaLO1tGEryBS+
	 eRma8Sq84jG5NNyrQx8BCpEV4J+ESBJHccz+iioo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfKDR7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbfKDR7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:59:11 -0500
Received: from localhost.localdomain (unknown [194.230.155.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0CC620B7C;
        Mon,  4 Nov 2019 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572890351;
        bh=LGIo8ZmiAbwfkL3OFX1XtCq8eoQUgUNanwlaQmqqLIk=;
        h=From:To:Cc:Subject:Date:From;
        b=nrxoEJpw15kTTwxCPN6JNJjPoR41rcctJ4NZpnAanKB7BK2d9kEASyceLFBzeYMi0
         kutqZYMXKDVmMyLdVFNZoETmfEd/+8Tn+wmJomRBptRyrt5vD4YxBcE9ok9ohGFREr
         aU5WLrGnnQy4FKIjYkDyrliLa9vR7BQYyA3/5OMo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/2] soc: samsung: Drivers for v5.5
Date:   Mon,  4 Nov 2019 18:59:01 +0100
Message-Id: <20191104175902.12224-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This includes dependency from PM/OPP.

Best regards,
Krzysztof


The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-5.5

for you to fetch changes up to 89e551e83869732d5b9fd21d7cfdb1f8d62cf5d0:

  soc: samsung: exynos-asv: Potential NULL dereference in exynos_asv_update_opps() (2019-10-30 19:04:32 +0100)

----------------------------------------------------------------
Samsung soc drivers changes for v5.5

1. Minor fixes to Exynos Chipid driver.
2. Add Exynos Adaptive Supply Voltage driver allowing to adjust voltages
   used during CPU frequency scaling based on revision of SoC.  This
   also pulls dependency from PM/OPP tree - driver uses newly added
   dev_pm_opp_adjust_voltage() function.

----------------------------------------------------------------
Dan Carpenter (1):
      soc: samsung: exynos-asv: Potential NULL dereference in exynos_asv_update_opps()

Krzysztof Kozlowski (1):
      Merge tag 'opp-5.4-support-adjust-voltages' of https://git.kernel.org/.../vireshk/pm into next/drivers

Stephen Boyd (1):
      PM / OPP: Support adjusting OPP voltages at runtime

Sylwester Nawrocki (3):
      soc: samsung: chipid: Make exynos_chipid_early_init() static
      soc: samsung: Add Exynos Adaptive Supply Voltage driver
      soc: samsung: chipid: Drop "syscon" compatible requirement

 drivers/opp/core.c                   |  69 +++++
 drivers/soc/samsung/Kconfig          |  10 +
 drivers/soc/samsung/Makefile         |   3 +
 drivers/soc/samsung/exynos-asv.c     | 177 ++++++++++++
 drivers/soc/samsung/exynos-asv.h     |  71 +++++
 drivers/soc/samsung/exynos-chipid.c  |  12 +-
 drivers/soc/samsung/exynos5422-asv.c | 505 +++++++++++++++++++++++++++++++++++
 drivers/soc/samsung/exynos5422-asv.h |  31 +++
 include/linux/pm_opp.h               |  13 +
 9 files changed, 889 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos-asv.c
 create mode 100644 drivers/soc/samsung/exynos-asv.h
 create mode 100644 drivers/soc/samsung/exynos5422-asv.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.h
