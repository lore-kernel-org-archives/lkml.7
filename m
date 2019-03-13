Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9A4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EF120854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RBh3vPkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfCMVp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:45:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1277 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfCMVp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:45:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c897a170000>; Wed, 13 Mar 2019 14:45:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 14:45:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Mar 2019 14:45:57 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 21:45:57 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 21:45:57 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 21:45:57 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.74]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c897a140006>; Wed, 13 Mar 2019 14:45:56 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V3 04/10] dt-bindings: mmc: tegra: document Tegra194 compatible string
Date:   Wed, 13 Mar 2019 14:45:46 -0700
Message-ID: <1552513552-23423-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552513559; bh=LvXE/tIRMDd6Jvph5xVoFpxz86mo5Xzi+B7NL7GSoWE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=RBh3vPkJlZEWr+MDMAUVmMJa2ms1iEYDQbM7sGONni77S9iWcVMzvqD7WwQZd0LHF
         47mOOWvNQxO+DKP6qc+3HZdveHbCWS9bagpPRSTweWevt9PoVEdbq/upqeR9mRke81
         Vct5rS4otTaDcn9j6S2t0CPnSRsDyq9bae84pCVINaoO1s4LT0PZxfI2oya1aU6qd+
         huXRzfJCnKyagBPSKiqq6ErpA4gPqYPBve+LeTRiPJzrx9qrWdkXPvpGCuTV6Z/tIg
         aF7EwiBJiG+nPQecq5gwr6xx8qsyvpLDtb+x/ODIurBxaiCxAbQTnwXp4xRzCDTBwe
         J55FozvhsUPmg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDHCI controller of Tegra194 is similar to SDHCI controller in Tegra186.
This patch documents Tegra194 sdhci compatible string.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 2cecdc71d94c..2cf3affa1be7 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -14,6 +14,7 @@ Required properties:
   - "nvidia,tegra124-sdhci": for Tegra124 and Tegra132
   - "nvidia,tegra210-sdhci": for Tegra210
   - "nvidia,tegra186-sdhci": for Tegra186
+  - "nvidia,tegra194-sdhci": for Tegra194
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
 - resets : Must contain an entry for each entry in reset-names.
-- 
2.7.4

