Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B9CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A5C2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfJUIqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:46:07 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:54320 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUIqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:46:06 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 2005162611;
        Mon, 21 Oct 2019 16:46:02 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P9443T140135366645504S1571647557719797_;
        Mon, 21 Oct 2019 16:46:02 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <58dcc17083b16c9ce514e6fb9eaa6e1c>
X-RL-SENDER: andy.yan@rock-chips.com
X-SENDER: yxj@rock-chips.com
X-LOGIN-NAME: andy.yan@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Andy Yan <andy.yan@rock-chips.com>
To:     heiko@sntech.de
Cc:     kever.yang@rock-chips.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 1/4] dt-bindings: Add doc about rk3308 General Register Files
Date:   Mon, 21 Oct 2019 16:45:55 +0800
Message-Id: <20191021084555.28356-1-andy.yan@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021084437.28279-1-andy.yan@rock-chips.com>
References: <20191021084437.28279-1-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3308 GRF is divided into four sections: GRF, SGRF,
DETECTGRF, COREGRF. This patch add documentation for
it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2: None

 .../devicetree/bindings/soc/rockchip/grf.txt          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index d7debec26ba4..61d89749918a 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -10,6 +10,12 @@ From RK3368 SoCs, the GRF is divided into two sections,
 
 On RK3328 SoCs, the GRF adds a section for USB2PHYGRF,
 
+ON RK3308 SoC, the GRF is divided into four sections:
+- GRF, used for general non-secure system,
+- SGRF, used for general secure system,
+- DETECTGRF, used for audio codec system,
+- COREGRF, used for pvtm,
+
 Required Properties:
 
 - compatible: GRF should be one of the following:
@@ -19,10 +25,15 @@ Required Properties:
    - "rockchip,rk3188-grf", "syscon": for rk3188
    - "rockchip,rk3228-grf", "syscon": for rk3228
    - "rockchip,rk3288-grf", "syscon": for rk3288
+   - "rockchip,rk3308-grf", "syscon": for rk3308
    - "rockchip,rk3328-grf", "syscon": for rk3328
    - "rockchip,rk3368-grf", "syscon": for rk3368
    - "rockchip,rk3399-grf", "syscon": for rk3399
    - "rockchip,rv1108-grf", "syscon": for rv1108
+- compatible: DETECTGRF should be one of the following:
+   - "rockchip,rk3308-detect-grf", "syscon": for rk3308
+- compatilbe: COREGRF should be one of the following:
+   - "rockchip,rk3308-core-grf", "syscon": for rk3308
 - compatible: PMUGRF should be one of the following:
    - "rockchip,px30-pmugrf", "syscon": for px30
    - "rockchip,rk3368-pmugrf", "syscon": for rk3368
-- 
2.17.1



