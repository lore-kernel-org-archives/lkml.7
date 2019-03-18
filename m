Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E444BC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF830213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfCRP5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:57:39 -0400
Received: from sauhun.de ([88.99.104.3]:36946 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfCRP5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:57:39 -0400
Received: from localhost (p54B330C6.dip0.t-ipconnect.de [84.179.48.198])
        by pokefinder.org (Postfix) with ESMTPSA id 5C49B2C2817;
        Mon, 18 Mar 2019 16:57:37 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 0/4] da9063: convert to SPDX
Date:   Mon, 18 Mar 2019 16:57:23 +0100
Message-Id: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When working with this driver while debugging something else, I noticed a typo
in one of the file headers and decided that it could be converted to SPDX while
I am at it anyhow.

These patches were "tested" on a Renesas Lager board (R-Car H2). No regressions
encountered. buildbot was happy, too.

The patches are based on v5.1-rc1. I'd think they can be picked up per
subsystem but am also fine with everything going via MFD. There is no
dependency or merge conflict with my platform_data removal series which I sent
a few minutes ago.

Looking forward to comments!

   Wolfram




Wolfram Sang (4):
  mfd: da9063: convert headers to SPDX
  regulator: da9063: convert header to SPDX
  input: da9063_onkey: convert header to SPDX
  rtc: da9063: convert header to SPDX

 drivers/input/misc/da9063_onkey.c    | 11 +----------
 drivers/mfd/da9063-core.c            |  8 ++------
 drivers/mfd/da9063-i2c.c             |  9 ++-------
 drivers/mfd/da9063-irq.c             |  9 ++-------
 drivers/regulator/da9063-regulator.c |  8 +-------
 drivers/rtc/rtc-da9063.c             | 14 +++-----------
 include/linux/mfd/da9063/core.h      |  7 +------
 include/linux/mfd/da9063/registers.h |  7 +------
 8 files changed, 13 insertions(+), 60 deletions(-)

-- 
2.11.0

