Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58180C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3062F20850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfDAGuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:50:04 -0400
Received: from regular1.263xmail.com ([211.150.70.198]:45310 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAGuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:50:03 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Apr 2019 02:50:02 EDT
Received: from zhangqing?rock-chips.com (unknown [192.168.167.242])
        by regular1.263xmail.com (Postfix) with ESMTP id 91E352AE;
        Mon,  1 Apr 2019 14:43:10 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3952T139731360794368S1554100987369530_;
        Mon, 01 Apr 2019 14:43:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e4435b5044714414e331bddf05fcf0dd>
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
Subject: [PATCH v1 0/3] thermal: rockchip: fix up thermal driver
Date:   Mon,  1 Apr 2019 14:43:02 +0800
Message-Id: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. add pinctrl control.
2. support PX30 soc

Elaine Zhang (3):
  thermal: rockchip: add pinctrl control
  dt-bindings: rockchip-thermal: Support the PX30 SoC compatible
  thermal: rockchip: Support the PX30 SoC in thermal driver

 .../bindings/thermal/rockchip-thermal.txt          |   1 +
 drivers/thermal/rockchip_thermal.c                 | 100 ++++++++++++++++++---
 2 files changed, 90 insertions(+), 11 deletions(-)

-- 
1.9.1



