Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51022073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLDIWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:22:16 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:46508 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfLDIWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:22:13 -0500
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 9B7AB7F168;
        Wed,  4 Dec 2019 16:22:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P8551T139845177427712S1575447579673282_;
        Wed, 04 Dec 2019 16:19:41 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <cea2e463ad378ee25ff8f0934b08a611>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v4 0/5] clk: rockchip: Support for some new features
Date:   Wed,  4 Dec 2019 16:18:54 +0800
Message-Id: <20191204081859.19454-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Support for some new features
2. fix up some error

Chang in V4:
[PATCH v3 1/5] : Update the commit message.

Chang in V3:
[PATCH v2 3/6] : It's been merged
So rebased and resubmit.

Chang in V2:
[PATCH v2 5/6] : fix up the Register error, and add delay.

Elaine Zhang (4):
  clk: rockchip: fix up the frac clk get rate error
  clk: rockchip: add a clock-type for muxes based in the pmugrf
  clk: rockchip: add pll up and down when change pll freq
  clk: rockchip: support pll setting by auto

Finley Xiao (1):
  clk: rockchip: Add supprot to limit input rate for fractional divider

 drivers/clk/rockchip/clk-pll.c    | 236 ++++++++++++++++++++++++++++--
 drivers/clk/rockchip/clk-px30.c   |  29 ++--
 drivers/clk/rockchip/clk-rk3036.c |  13 +-
 drivers/clk/rockchip/clk-rk3128.c |  15 +-
 drivers/clk/rockchip/clk-rk3188.c |  24 +--
 drivers/clk/rockchip/clk-rk3228.c |  18 ++-
 drivers/clk/rockchip/clk-rk3288.c |  19 ++-
 drivers/clk/rockchip/clk-rk3308.c |  46 +++---
 drivers/clk/rockchip/clk-rk3328.c |  17 ++-
 drivers/clk/rockchip/clk-rk3368.c |  17 ++-
 drivers/clk/rockchip/clk-rk3399.c |  32 ++--
 drivers/clk/rockchip/clk-rv1108.c |  14 +-
 drivers/clk/rockchip/clk.c        |  39 ++++-
 drivers/clk/rockchip/clk.h        |  27 +++-
 include/linux/clk-provider.h      |   2 +
 15 files changed, 422 insertions(+), 126 deletions(-)

-- 
2.17.1



