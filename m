Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E11C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F2020880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfDOV35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:29:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46902 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfDOV3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:29:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id DCE82281AC2
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH v4 2/5] dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle.
Date:   Mon, 15 Apr 2019 17:29:45 -0400
Message-Id: <20190415212948.7736-3-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415212948.7736-1-gael.portay@collabora.com>
References: <20190415212948.7736-1-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
general register files to know the DRAM type, so add a phandle to the
syscon that manages these registers.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---

Changes in v4:
- [PATCH v3 2/5] Add Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>.

Changes in v3:
- [PATCH v2 2/5] Add Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>.

Changes in v2: None

Changes in v1:
- [RFC 2/10] Add reviewed and acked tags from Chanwoo Choi and Rob Herring

 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index 0ec68141f85a..951789c0cdd6 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -12,6 +12,8 @@ Required properties:
 			 for details.
 - center-supply:	 DMC supply node.
 - status:		 Marks the node enabled/disabled.
+- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
+			 files".
 
 Optional properties:
 - interrupts:		 The CPU interrupt number. The interrupt specifier
-- 
2.21.0

