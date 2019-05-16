Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6E4C04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DEB20881
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEPH3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 03:29:11 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:59638 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfEPH3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:29:10 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.227])
        by regular1.263xmail.com (Postfix) with ESMTP id A0EE847C;
        Thu, 16 May 2019 15:28:58 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P7747T139724561819392S1557991736066321_;
        Thu, 16 May 2019 15:28:58 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e97b00e870e3be5f6951bfbdbadcb8a3>
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
Subject: [PATCH v2 0/6] clk: rockchip: Support for some new features
Date:   Thu, 16 May 2019 15:28:50 +0800
Message-Id: <1557991736-13580-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Support for some new features
2. fix up some error

Chang in V2:
[PATCH v2 5/6] : fix up the Register error, and add delay.


Elaine Zhang (4):
  clk: rockchip: fix up the frac clk get rate error
  clk: rockchip: add a clock-type for muxes based in the pmugrf
  clk: rockchip: add pll up and down when change pll freq
  clk: rockchip: support pll setting by auto

Finley Xiao (2):
  clk: rockchip: Add supprot to limit input rate for fractional divider
  clk: rockchip: add a COMPOSITE_DIV_OFFSET clock-type

 drivers/clk/rockchip/clk-pll.c    | 236 +++++++++++++++++++++++++++++++++++---
 drivers/clk/rockchip/clk-px30.c   |  29 ++---
 drivers/clk/rockchip/clk-rk3036.c |  13 ++-
 drivers/clk/rockchip/clk-rk3128.c |  15 ++-
 drivers/clk/rockchip/clk-rk3188.c |  24 ++--
 drivers/clk/rockchip/clk-rk3228.c |  18 +--
 drivers/clk/rockchip/clk-rk3288.c |  19 +--
 drivers/clk/rockchip/clk-rk3328.c |  17 +--
 drivers/clk/rockchip/clk-rk3368.c |  17 +--
 drivers/clk/rockchip/clk-rk3399.c |  32 +++---
 drivers/clk/rockchip/clk-rv1108.c |  14 ++-
 drivers/clk/rockchip/clk.c        |  48 ++++++--
 drivers/clk/rockchip/clk.h        |  50 +++++++-
 include/linux/clk-provider.h      |   2 +
 14 files changed, 425 insertions(+), 109 deletions(-)

-- 
1.9.1



