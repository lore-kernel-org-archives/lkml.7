Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CA9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8884D218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oAJ/EN2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfC2OWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:22:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44170 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfC2OWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:22:20 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TEMHgb022762;
        Fri, 29 Mar 2019 09:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553869337;
        bh=uqrJeNX7elceFcCbiTMejO65QUvGwgQ5qujKeePMVT0=;
        h=From:To:CC:Subject:Date;
        b=oAJ/EN2+vWi+BS3383IsbDxv+dNs2aPKd5UrSsxQpXAQSpLznHQWhkMKS48wI/2wJ
         7v5UloPX5zLMuHr7eQlcA5mhdU7pMPV5i8V6OE3emz7KmqNbVzMBSe3ggX4OzX28en
         bgS5WmIf10qiN18MGno4eIBxFq0s/e5XkWbio1mU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TEMH80118158
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 09:22:17 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 09:22:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 09:22:17 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TEMFPH097780;
        Fri, 29 Mar 2019 09:22:15 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 0/2] Add QUIRK for special HISPD bit in am65x-evm
Date:   Fri, 29 Mar 2019 19:52:00 +0530
Message-ID: <20190329142202.15000-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add a QUIRK for enabling HISPD bit under special
conditions and set the QUIRK for am65x-evm.

Faiz Abbas (2):
  mmc: sdhci: Add Quirk for enabling HISPD under special conditions
  mmc: sdhci_am654: Add QUIRK2_TI_HISPD_BIT

 drivers/mmc/host/sdhci.c       | 36 ++++++++++++++++++++++------------
 drivers/mmc/host/sdhci.h       |  2 ++
 drivers/mmc/host/sdhci_am654.c |  3 ++-
 3 files changed, 28 insertions(+), 13 deletions(-)

-- 
2.19.2

