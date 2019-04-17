Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34314C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E0820675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WY4cJ3Y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfDQHnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:43:51 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:46334 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727282AbfDQHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:43:50 -0400
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Apr 2019 03:43:50 EDT
Received: from mailhost1.synopsys.com (us02-dmz-cl-eth-s1p4c0.internal.synopsys.com [10.12.241.126])
        by smtprelay-out1.synopsys.com (Postfix) with ESMTP id 51CCCC0AF4;
        Wed, 17 Apr 2019 07:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555486393; bh=HqAhbYLd7RmI5BX+kxh7mY0Nd11dOpSyA2GfFO/LK8A=;
        h=From:To:Cc:Subject:Date:From;
        b=WY4cJ3Y1qMv7y6X32KplROPEmVxH5s7pxUad63rLypDF7fJ2T6/Hc4Xn/wKjXWsVv
         sQ/+qGvEOHNZhlcPEps7hHzZQnObkaFSCBdqSvffn5Dhd2EO4EJSqqbGMXpo7EoTFf
         4BY90R2IDFJpzVTHa6IAwptDJ4NB0O1tA5JdWLcAnXK2bL6kD1ajlJjemIjF1C8+K5
         ZqCpvDP8sG/kpg1KWdJ1tASdA9810UNyFvkk8/I6ecnVrMbr8e6mby77OGnbuzRau6
         4A+3Spr0EwLUJordGHoPi4jmnES9hqX1AH+URekgD1L9JqBRQ120n+WL1GvfcUDIiO
         seFK8SdEDUnBA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 0EA0B5019;
        Wed, 17 Apr 2019 00:33:09 -0700 (PDT)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 0/2] net: stmmac: Enable Flow Control
Date:   Wed, 17 Apr 2019 09:33:03 +0200
Message-Id: <cover.1555486210.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know of any specific reason why Flow Control is off by default but
do let me know if there is any.

Tested in B2B between XGMAC2 and GMAC5.

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>

Jose Abreu (2):
  net: stmmac: dwxgmac: Finish the Flow Control implementation
  net: stmmac: Set Flow Control to automatic mode in the driver

 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  5 +++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 46 ++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 +-
 3 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.7.4

