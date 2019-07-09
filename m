Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A1CC73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E2A20861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfGIN7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:59:12 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:33439 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGIN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:59:12 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2019 09:59:11 EDT
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 11FD618383;
        Tue,  9 Jul 2019 15:54:07 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id QvO7OHhFl5QD; Tue,  9 Jul 2019 15:54:06 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 656A718485;
        Tue,  9 Jul 2019 15:54:06 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5471F1A06F;
        Tue,  9 Jul 2019 15:54:06 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4915E1A065;
        Tue,  9 Jul 2019 15:54:06 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Tue,  9 Jul 2019 15:54:06 +0200 (CEST)
Received: from pc32929-1845.se.axis.com (pc32929-1845.se.axis.com [10.88.129.17])
        by seth.se.axis.com (Postfix) with ESMTP id 3CF0C2262;
        Tue,  9 Jul 2019 15:54:06 +0200 (CEST)
Received: by pc32929-1845.se.axis.com (Postfix, from userid 20456)
        id 3950E40B30; Tue,  9 Jul 2019 15:54:06 +0200 (CEST)
From:   Lars Persson <lars.persson@axis.com>
To:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc:     jespern@axis.com, linux-kernel@vger.kernel.org,
        Lars Persson <larper@axis.com>
Subject: [PATCH] mmc: usdhi6rol0: Add maintainers
Date:   Tue,  9 Jul 2019 15:53:51 +0200
Message-Id: <20190709135351.25628-1-larper@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usdhi6rol0 driver is exclusively used for the ARTPEC family of
SoCs. Other SoCs with the same IP of Panasonic origin use the tmio_mmc
driver. Therefore we assigner maintainer responsibility to us at Axis
until the two drivers become unified.

Change-Id: I38b6fd0addc1d93ae172332b67e6eb71c0871508
Signed-off-by: Lars Persson <larper@axis.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 677ef41cb012..a91d04e5c084 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1432,6 +1432,7 @@ F:	arch/arm/mach-artpec
 F:	arch/arm/boot/dts/artpec6*
 F:	drivers/clk/axis
 F:	drivers/crypto/axis
+F:	drivers/mmc/host/usdhi6rol0.c
 F:	drivers/pinctrl/pinctrl-artpec*
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 
-- 
2.11.0

