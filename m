Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7CFC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC092087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfD2Fv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 01:51:57 -0400
Received: from david.siemens.de ([192.35.17.14]:38825 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfD2Fv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:51:56 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x3T5pjuP025630
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 07:51:50 +0200
Received: from [139.22.43.249] ([139.22.43.249])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x3T5picZ006404;
        Mon, 29 Apr 2019 07:51:45 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] stmmac: pci: Fix typo in IOT2000 comment
To:     David Miller <davem@davemloft.net>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID: <59169e7b-d58c-8c7e-e644-f8a7c8f60188@siemens.com>
Date:   Mon, 29 Apr 2019 07:51:44 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index cc1e887e47b5..26db6aa002d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -160,7 +160,7 @@ static const struct dmi_system_id quark_pci_dmi[] = {
 		.driver_data = (void *)&galileo_stmmac_dmi_data,
 	},
 	/*
-	 * There are 2 types of SIMATIC IOT2000: IOT20202 and IOT2040.
+	 * There are 2 types of SIMATIC IOT2000: IOT2020 and IOT2040.
 	 * The asset tag "6ES7647-0AA00-0YA2" is only for IOT2020 which
 	 * has only one pci network device while other asset tags are
 	 * for IOT2040 which has two.
-- 
2.16.4
