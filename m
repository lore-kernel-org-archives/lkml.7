Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD7B20818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbfCAQo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:44:26 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:36822 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388913AbfCAQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:44:24 -0500
Received: from ip092042140082.rev.nessus.at ([92.42.140.82]:42692 helo=purcell.lan)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1gzlGT-00060u-RL; Fri, 01 Mar 2019 17:44:01 +0100
From:   Christoph Muellner <christoph.muellner@theobroma-systems.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Lin Huang <hl@rock-chips.com>, Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: mmc: Add a new property disable-cqe-dcmd.
Date:   Fri,  1 Mar 2019 17:43:46 +0100
Message-Id: <20190301164349.60589-2-christoph.muellner@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190301164349.60589-1-christoph.muellner@theobroma-systems.com>
References: <20190301164349.60589-1-christoph.muellner@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents the new proprty disable-cqe-dcmd
for the Arasan eMMC 5.1 driver.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 1edbb049cccb..ec699bf98b7c 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -44,6 +44,10 @@ Optional Properties:
     properly. Test mode can be used to force the controller to function.
   - xlnx,int-clock-stable-broken: when present, the controller always reports
     that the internal clock is stable even when it is not.
+  - disable-cqe-dcmd: The eMMC 5.1 standard specifies direct commands (DCMDs)
+    as part of the command queue engine (CQE). On controllers with a CQHCI,
+    such as the Arasan eMMC 5.1 host controller, the driver has to enable DCMDs.
+    This is done unless disable-cqe-dcmd is specified.
 
 Example:
 	sdhci@e0100000 {
-- 
2.11.0

