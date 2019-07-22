Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A8FC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7E82229B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Tw0NjjLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfGVIjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:39:54 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:45694 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728120AbfGVIjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:39:52 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EA265C1227;
        Mon, 22 Jul 2019 08:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563784792; bh=gAQ84Z8uQYEqLwe3t0dAiOmw/qC87vcNk5Wf+7zF7eY=;
        h=From:To:Cc:Subject:Date:From;
        b=Tw0NjjLDtWP8eBnJ6Xt4QyVdruzgB9/y/J+RuQynTViyqlcHCEiVQDEA0qu2HSXEv
         YacB3+0odjiXogl/oj8vkMpzHN0Xb17sALqOGPbxvQT0NzMugg5Fq2pFUkgi0E+1C9
         ZUz3L4pKY8S7S/OuTysc5hdUycHpUFRg/T4DhZ+52yfym8VeZkes4+4sFikIrnNiya
         bee1H9EZhI8BiNJK2rnUAE+hoOwo9EhJHsxANi6lp9rJLsRJEOMjwhWzvh2BVu0aGR
         jwUq7yfvUijBi+RnXZfY6hMJ1r/LXxCeoLwsw7sUY+eVGGNY5WCZ+m843HTrUcIr2o
         0m3X94RXrr7yA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9FD1AA0057;
        Mon, 22 Jul 2019 08:39:44 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: stmmac: Two fixes
Date:   Mon, 22 Jul 2019 10:39:29 +0200
Message-Id: <cover.1563784666.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes targeting -net.

---
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Jose Abreu (2):
  net: stmmac: RX Descriptors need to be clean before setting buffers
  net: stmmac: Use kcalloc() instead of kmalloc_array()

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

-- 
2.7.4

