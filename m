Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC5C04AB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 03:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8344214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 03:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfENDBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 23:01:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63043 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726387AbfENDBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 23:01:04 -0400
X-UUID: af5e15beccf84fb7ab8bb6ae5dbf458c-20190514
X-UUID: af5e15beccf84fb7ab8bb6ae5dbf458c-20190514
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1626085022; Tue, 14 May 2019 11:00:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 14 May 2019 11:00:51 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 May 2019 11:00:50 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Jose Abreu <joabreu@synopsys.com>, <davem@davemloft.net>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>,
        <biao.huang@mediatek.com>, <jianguo.zhang@mediatek.comi>,
        <boon.leong.ong@intel.com>
Subject: [v2, PATCH] add some features in stmmac
Date:   Tue, 14 May 2019 11:00:42 +0800
Message-ID: <1557802843-31718-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7892806FA5617C579E8B0AFF4DE23E520B0F3533254FF1AFAE9D24DC087D60F92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:                                                                  
        1. reverse Christmas tree order in dwmac4_set_filter                    
        2. remove clause 45 patch, waiting for cl45 patch from Boon Leong       
v1:                                                                             
This series add some features in stmmac driver.                                 
        1. add support for hash table size 128/256                              
        2. add mdio clause 45 access from mac device for dwmac4.                
                                                                                
Biao Huang (1):                                                                 
  net: stmmac: add support for hash table size 128/256 in dwmac4                
                                                                                
 drivers/net/ethernet/stmicro/stmmac/common.h      |    7 +--                   
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      |    4 +-                    
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c |   50 ++++++++++++--------- 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c  |    1 +                     
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    4 ++                    
 5 files changed, 40 insertions(+), 26 deletions(-)                             
                                                                                
--                                                                              
1.7.9.5

