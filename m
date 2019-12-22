Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD2EC2D0D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56141206D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y5m40p2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfLVPwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 10:52:06 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:6221 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfLVPwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 10:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577029925; x=1608565925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=I3EYtzQbRAfNRK5hA12CxBpw3x/2mYR4qU/x1I+vIWU=;
  b=Y5m40p2SMWzMXtKDb60AcD4KAmuR2fQ0+LhwCH9i5AEC44BEdTZp9K60
   x9EoXd//vCsLBYm5AbtjAmMcXtsWmgp54IkDaoxxTTqisofTR7MFRSiWG
   b1K4n52F9w4QDP0I+J0pCmxpfyXFjWeCp5vgJXPHwQXMFTtX3nbONeeXQ
   4=;
IronPort-SDR: mEON2zOetAv/BvMLusKPQnyHXXDVRYBpi03R9eUSfQ1x4vwipA6r+bmp0ghqHcvGBLPhEhL4O8
 H8guyOHvvYZA==
X-IronPort-AV: E=Sophos;i="5.69,344,1571702400"; 
   d="scan'208";a="6616124"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Dec 2019 15:51:58 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 2FEB2A215C;
        Sun, 22 Dec 2019 15:51:57 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Dec 2019 15:51:56 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.9) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Dec 2019 15:51:45 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <hhhawa@amazon.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <tglx@linutronix.de>,
        <xuwei5@hisilicon.com>, <scott.branden@broadcom.com>,
        <dinguyen@kernel.org>, <zhang.lyra@gmail.com>, <treding@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v3 2/6] arm64: dts: amazon: rename al folder to be amazon
Date:   Sun, 22 Dec 2019 17:50:34 +0200
Message-ID: <20191222155038.30633-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222155038.30633-1-hhhawa@amazon.com>
References: <20191222155038.30633-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.9]
X-ClientProxiedBy: EX13D19UWA002.ant.amazon.com (10.43.160.204) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation to add device tree binding for Amazon's Annapurna Labs
Alpine v3 support. Rename al device tree folder to be amazon.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 MAINTAINERS                                          | 2 +-
 arch/arm64/boot/dts/Makefile                         | 2 +-
 arch/arm64/boot/dts/{al => amazon}/Makefile          | 0
 arch/arm64/boot/dts/{al => amazon}/alpine-v2-evp.dts | 0
 arch/arm64/boot/dts/{al => amazon}/alpine-v2.dtsi    | 0
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm64/boot/dts/{al => amazon}/Makefile (100%)
 rename arch/arm64/boot/dts/{al => amazon}/alpine-v2-evp.dts (100%)
 rename arch/arm64/boot/dts/{al => amazon}/alpine-v2.dtsi (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc0a4a8ae06a..eb02eda3761a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1519,7 +1519,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-alpine/
 F:	arch/arm/boot/dts/alpine*
-F:	arch/arm64/boot/dts/al/
+F:	arch/arm64/boot/dts/amazon/*
 F:	drivers/*/*alpine*
 
 ARM/ARTPEC MACHINE SUPPORT
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index f19b762c008d..6f3e1556ce42 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 subdir-y += actions
-subdir-y += al
 subdir-y += allwinner
 subdir-y += altera
+subdir-y += amazon
 subdir-y += amd
 subdir-y += amlogic
 subdir-y += apm
diff --git a/arch/arm64/boot/dts/al/Makefile b/arch/arm64/boot/dts/amazon/Makefile
similarity index 100%
rename from arch/arm64/boot/dts/al/Makefile
rename to arch/arm64/boot/dts/amazon/Makefile
diff --git a/arch/arm64/boot/dts/al/alpine-v2-evp.dts b/arch/arm64/boot/dts/amazon/alpine-v2-evp.dts
similarity index 100%
rename from arch/arm64/boot/dts/al/alpine-v2-evp.dts
rename to arch/arm64/boot/dts/amazon/alpine-v2-evp.dts
diff --git a/arch/arm64/boot/dts/al/alpine-v2.dtsi b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/al/alpine-v2.dtsi
rename to arch/arm64/boot/dts/amazon/alpine-v2.dtsi
-- 
2.17.1

