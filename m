Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27AEC352AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B04207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfI0DIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:08:04 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:45942 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfI0DID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:08:03 -0400
Received: from localhost (unknown [192.168.167.158])
        by lucky1.263xmail.com (Postfix) with ESMTP id 822C143EDB;
        Fri, 27 Sep 2019 11:00:37 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5565T139972115928832S1569553235679252_;
        Fri, 27 Sep 2019 11:00:37 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d2c50f30286dfff9eea87f826a4255ce>
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
Subject: [PATCH v3 0/5] clk: rockchip: Support for some new features
Date:   Fri, 27 Sep 2019 11:00:39 +0800
Message-Id: <1569553244-3165-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Support for some new features
2. fix up some error

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

 drivers/clk/rockchip/clk-pll.c    | 236 +++++++++++++++++++++++++++++++++++---
 drivers/clk/rockchip/clk-px30.c   |  29 ++---
 drivers/clk/rockchip/clk-rk3036.c |  13 ++-
 drivers/clk/rockchip/clk-rk3128.c |  15 ++-
 drivers/clk/rockchip/clk-rk3188.c |  24 ++--
 drivers/clk/rockchip/clk-rk3228.c |  18 +--
 drivers/clk/rockchip/clk-rk3288.c |  19 +--
 drivers/clk/rockchip/clk-rk3308.c |  46 ++++----
 drivers/clk/rockchip/clk-rk3328.c |  17 +--
 drivers/clk/rockchip/clk-rk3368.c |  17 +--
 drivers/clk/rockchip/clk-rk3399.c |  32 +++---
 drivers/clk/rockchip/clk-rv1108.c |  14 ++-
 drivers/clk/rockchip/clk.c        |  39 ++++++-
 drivers/clk/rockchip/clk.h        |  27 ++++-
 include/linux/clk-provider.h      |   2 +
 15 files changed, 422 insertions(+), 126 deletions(-)

-- 
1.9.1



