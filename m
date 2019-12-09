Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777AFC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4093D207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NBwxxhZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLISB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:01:58 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43480 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLISB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:01:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9I1qIK087440;
        Mon, 9 Dec 2019 12:01:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575914512;
        bh=NVEdmtqnF1FgORctGvl5SiwspTg/hxgrR/2+ib3BYgA=;
        h=From:To:CC:Subject:Date;
        b=NBwxxhZD5gqGRacKerGB5I1+h++zxhq2FYqv+93TAAVS5lgydpNhF9bFvaohMAfOj
         RD9qAOngiUybFfVwX7XmICvbb7YTpY0U8JMRp/5fhBf0ofPOpYsOqYANa4f5K+PC94
         70MXdoTRoPCx2gMyrka7x9Jn7OxrfPbyHhYw8UqI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB9I1qpr046727
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 12:01:52 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 12:01:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 12:01:52 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9I1qbi099391;
        Mon, 9 Dec 2019 12:01:52 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <bunk@kernel.org>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v2 0/2] Rebase of patches
Date:   Mon, 9 Dec 2019 11:59:41 -0600
Message-ID: <20191209175943.23110-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This is a rebase of the dp83867 patches on top of the net-next tree

Dan

Dan Murphy (2):
  dt-bindings: dp83867: Convert fifo-depth to common fifo-depth and make
    optional
  net: phy: dp83867: Add rx-fifo-depth and tx-fifo-depth

 .../devicetree/bindings/net/ti,dp83867.txt    | 12 +++-
 drivers/net/phy/dp83867.c                     | 62 +++++++++++++++----
 2 files changed, 58 insertions(+), 16 deletions(-)

-- 
2.23.0

