Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D758C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E35222DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CoUWIUDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfKSGvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:51:02 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10790 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfKSGvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:51:00 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd390d60000>; Mon, 18 Nov 2019 22:51:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 22:50:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 22:50:59 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 06:50:58 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 06:50:58 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Nov 2019 06:50:58 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.254]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd390d10000>; Mon, 18 Nov 2019 22:50:58 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 05/17] dt-bindings: soc: tegra-pmc: Add id for Tegra PMC blink control
Date:   Mon, 18 Nov 2019 22:50:22 -0800
Message-ID: <1574146234-3871-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574146262; bh=rzjEACmDAo3v51vjKD7mPrAFEwim/IXtmodBCpgf+vc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=CoUWIUDw7KlzW9hBWPiqlu5bPHVAer1LYYCoDfCANjzdtU1abVlonCRVyamhLJTOz
         ZifwSnJ7x3pgALMf37MOEwXDWQP8lnmv0HOYsjjRiWdSQs7nf3E1jCcYZEIQ3ANLov
         upoj7PtapcnUB3N6+3lsJy7+7DBi13Hg4vJKsthb9pfIwWy8nX06z6KmSYLCx4b+HB
         y9HUWL+iWKTf/fdb8E5qH74RmfLV3B1ZkCIJPN7j2CuGEopmN2BWyJm/ybvdEIsSB4
         Nwt6WZhykxTNMj5aK60nUKUqRAGjlqRUKIKlm1D8IwcxbSTJgvRW817qdbcDX+hBnL
         oXTeDampOLIig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has a blinking control to output 32 KHz clock to blink
pin.

This patch adds id for this blink control to use for enabling or
disabling the blink output through devicetree.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/soc/tegra-pmc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/soc/tegra-pmc.h
index fa1ccfc2514b..bcb24e17981f 100644
--- a/include/dt-bindings/soc/tegra-pmc.h
+++ b/include/dt-bindings/soc/tegra-pmc.h
@@ -12,5 +12,6 @@
 #define TEGRA_PMC_CLK_OUT_2		3
 #define TEGRA_PMC_CLK_OUT_3_MUX		4
 #define TEGRA_PMC_CLK_OUT_3		5
+#define TEGRA_PMC_CLK_BLINK		6
 
 #endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
-- 
2.7.4

