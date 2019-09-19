Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9482BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FA5218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bP+WUl6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391317AbfISPcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:32:10 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45718 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391251AbfISPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:32:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8JFW2wx045534;
        Thu, 19 Sep 2019 10:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568907122;
        bh=v7EJCOSHhKLQF2mY+JduPanblT1fN416i9W6CtVEMCM=;
        h=From:To:CC:Subject:Date;
        b=bP+WUl6OFcsG4LJfJXwI0CKOg5H5/I4cP+pNe4WIJIOzJMv1gr8brph4a20l0luTe
         cvVazDu8P5CNVNDLYssGvuEfSjJvZDm5H+xONVq0dJbfvRxdLc2yoPmWpiWzcxSDKg
         nNiOMNyqCGPoYTEtM7Ffo2xcTjUtW7VujIh3Qg40=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8JFW2D2012524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Sep 2019 10:32:02 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 19
 Sep 2019 10:32:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 19 Sep 2019 10:32:02 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8JFVxwK001224;
        Thu, 19 Sep 2019 10:32:00 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>
Subject: [PATCH 0/2] Add Support for MMC/SD for J721e-base-board
Date:   Thu, 19 Sep 2019 21:02:40 +0530
Message-ID: <20190919153242.29399-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following are dts patches to add MMC/SD Support on TI's J721e base
board.

Patches depend on Lokesh's gpio patches[1] and device exclusivity patches[2].

[1] https://patchwork.kernel.org/cover/11085643/
[2] https://patchwork.kernel.org/cover/11051559/

Faiz Abbas (2):
  arm64: dts: ti: j721e-main: Add SDHCI nodes
  arm64: dts: ti: j721e-common-proc-board: Add Support for eMMC and SD
    card

 .../dts/ti/k3-j721e-common-proc-board.dts     | 34 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 50 +++++++++++++++++++
 2 files changed, 84 insertions(+)

-- 
2.19.2

