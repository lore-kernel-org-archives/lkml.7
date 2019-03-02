Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5354CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A1F20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Yhucr6Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfCBFUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 00:20:47 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15109 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfCBFUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 00:20:44 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7a12aa0000>; Fri, 01 Mar 2019 21:20:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Mar 2019 21:20:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Mar 2019 21:20:43 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 Mar
 2019 05:20:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 2 Mar 2019 05:20:43 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.172.134]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7a12a80000>; Fri, 01 Mar 2019 21:20:42 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 05/11] dt-bindings: mmc: tegra: document Tegra194 compatible string
Date:   Fri, 1 Mar 2019 21:20:19 -0800
Message-ID: <1551504025-3541-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551504042; bh=LvXE/tIRMDd6Jvph5xVoFpxz86mo5Xzi+B7NL7GSoWE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Yhucr6Sa2LgK8pOmrKImqFiJ9P76s0iUTRQ3NoPwvi5P6RP/GwkSQKH3WsXDQ+DhU
         4VVraMeQQBkmaKUz/kTKyhxGqnDd4bqdk/rZ09sgCzqrPFrYDzNPPpkbjkWp0CaAT6
         6TMYNZlg5lsGWPGzunsBpr0HuEPR+oDyhPF6+fBjT7k9mgfV64Yojj2Rql6PZ2Jswv
         ylTiRMsgVTNiESUm2Y6aRzXilbTU17biyJqqEz2Lv8W46Z+22DfffILtUHYC9h9IEO
         Etjqu0ViP8Q4itJIC+rkr7f8+7P0IdiVNGaegKuFCd0Ib0GjFx1DZUiosk93m46TC2
         DO4noBxCUNOTw==
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

