Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9DAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4364E214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zWpslC+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfCLJPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:15:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53870 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfCLJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:15:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2C9FY3w087130;
        Tue, 12 Mar 2019 04:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552382134;
        bh=vqyCqRbSqMuELCcEBLfa1kIhZY0jFSZOhi265Y4B6T4=;
        h=From:To:CC:Subject:Date;
        b=zWpslC+XTE7UHnMOC4jE0NGeo1+2l3qSaI5Bot1awQcWATA53DiHBKTKthMWjKtoE
         3NwRjuc6dohilJnX2v4+IPA70s2GpYVYCTDKkYBw4f2Vc6rvQ1fQJYkCIgUWApZ5dF
         R6WSEidSMSuxxZPq/J6zG8XCoV7nu+RfBKDM4be8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2C9FYcm006062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 04:15:34 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 04:15:34 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 04:15:34 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2C9FVdv008524;
        Tue, 12 Mar 2019 04:15:32 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] pwm: tiehrpwm: Enable EHRPWM for AM654 SoCs
Date:   Tue, 12 Mar 2019 14:46:27 +0530
Message-ID: <20190312091629.31701-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for EHRPWM IP on TI AM654 SoC

Vignesh Raghavendra (2):
  dt-bindings: pwm: tiehrpwm: Add TI AM654 SoC specific compatible
  pwm: Kconfig: Enable ehrpwm driver to be compiled for ARCH_K3

 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 1 +
 drivers/pwm/Kconfig                                    | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.21.0

