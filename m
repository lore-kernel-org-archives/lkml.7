Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF56C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79403217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfDYKMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:12:48 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:38620 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfDYKMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:12:46 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 195E326E;
        Thu, 25 Apr 2019 18:12:40 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P797T140025968707328S1556187150403323_;
        Thu, 25 Apr 2019 18:12:40 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d5425a7d9f6a76ad4bdfd0736e219b86>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 0/4] clk: rockchip: support clock controller for px30 SoC
Date:   Thu, 25 Apr 2019 18:12:30 +0800
Message-Id: <1556187154-22632-5-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
References: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in V3:
[PATCH v3 1/4]: Correct description
[PATCH v3 2/4]: Use an SPDX tag instead.
[PATCH v3 3/4]: Use an SPDX tag instead,
		parent_rate might overflow and fix it.
		fix up the checkpatch warning.
		add more CMPOSITE_xxx_HALFdiv.

Change in V2:
[PATCH v2 2/4]: modify the Author name
[PATCH v2 3/4]: provide a bit more explanation for commit message

Elaine Zhang (4):
  dt-bindings: add bindings for px30 clock controller
  clk: rockchip: add dt-binding header for px30
  clk: rockchip: add support for half divider
  clk: rockchip: add clock controller for px30

 .../bindings/clock/rockchip,px30-cru.txt           |   66 ++
 drivers/clk/rockchip/Makefile                      |    2 +
 drivers/clk/rockchip/clk-half-divider.c            |  231 +++++
 drivers/clk/rockchip/clk-px30.c                    | 1080 ++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         |   10 +
 drivers/clk/rockchip/clk.h                         |  126 ++-
 include/dt-bindings/clock/px30-cru.h               |  389 +++++++
 7 files changed, 1903 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-half-divider.c
 create mode 100644 drivers/clk/rockchip/clk-px30.c
 create mode 100644 include/dt-bindings/clock/px30-cru.h

-- 
1.9.1



