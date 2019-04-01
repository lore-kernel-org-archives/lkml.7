Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DCEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B18E20850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfDAGuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:50:04 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:60990 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDAGuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:50:03 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.242])
        by regular1.263xmail.com (Postfix) with ESMTP id D014B29D;
        Mon,  1 Apr 2019 14:43:13 +0800 (CST)
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
        Mon, 01 Apr 2019 14:43:12 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3ae5eece80481e72920b9eb8750ebbfc>
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
Subject: [PATCH v1 2/3] dt-bindings: rockchip-thermal: Support the PX30 SoC compatible
Date:   Mon,  1 Apr 2019 14:43:04 +0800
Message-Id: <1554100985-11385-3-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible for thermal founding on PX30 SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index 43d744e5305e..c6aac9bcacf1 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible : should be "rockchip,<name>-tsadc"
+   "rockchip,px30-tsadc":   found on PX30 SoCs
    "rockchip,rv1108-tsadc": found on RV1108 SoCs
    "rockchip,rk3228-tsadc": found on RK3228 SoCs
    "rockchip,rk3288-tsadc": found on RK3288 SoCs
-- 
1.9.1



