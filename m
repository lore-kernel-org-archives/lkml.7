Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE84C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078442087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfD2Gfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:35:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43510 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727289AbfD2Gfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:35:37 -0400
X-UUID: da58d30bcd724d6d9fd2b2b472bf1f65-20190429
X-UUID: da58d30bcd724d6d9fd2b2b472bf1f65-20190429
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1905090922; Mon, 29 Apr 2019 14:35:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 29 Apr 2019 14:35:29 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Apr 2019 14:35:28 +0800
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
        <biao.huang@mediatek.com>, <jianguo.zhang@mediatek.com>
Subject: [PATCH 0/2] net-next: stmmac: add some features in stmmac driver
Date:   Mon, 29 Apr 2019 14:35:22 +0800
Message-ID: <1556519724-1576-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add some features in stmmac driver.                                 
        1. add support for hash table size 128/256                              
        2. add mdio clause 45 access from mac device for dwmac4.                
                                                                                
Biao Huang (2):                                                                 
  net-next: stmmac: add support for hash table size 128/256 in dwmac4           
  net-next: stmmac: add mdio clause 45 access from mac device for               
    dwmac4                                                                      
                                                                                
 drivers/net/ethernet/stmicro/stmmac/common.h      |   18 ++-                   
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      |    4 +-                    
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c |   53 ++++---               
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c  |    1 +                     
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    4 +                     
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  167 +++++++++++++++++++-- 
 6 files changed, 205 insertions(+), 42 deletions(-)                            
                                                                                
--                                                                              
1.7.9.5

