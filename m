Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEB8C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE083213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfEUA4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 20:56:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60260 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfEUA4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 20:56:45 -0400
Received: from localhost (50-78-161-185-static.hfc.comcastbusiness.net [50.78.161.185])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 46BB0140F8471;
        Mon, 20 May 2019 17:56:45 -0700 (PDT)
Date:   Mon, 20 May 2019 20:56:44 -0400 (EDT)
Message-Id: <20190520.205644.1160707171896552897.davem@davemloft.net>
To:     weifeng.voon@intel.com
Cc:     mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joabreu@synopsys.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        boon.leong.ong@intel.com
Subject: Re: [PATCH net] net: stmmac: dma channel control register need to
 be init first
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1558417118-28985-1-git-send-email-weifeng.voon@intel.com>
References: <1558417118-28985-1-git-send-email-weifeng.voon@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 May 2019 17:56:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weifeng Voon <weifeng.voon@intel.com>
Date: Tue, 21 May 2019 13:38:38 +0800

> stmmac_init_chan() needs to be called before stmmac_init_rx_chan() and
> stmmac_init_tx_chan(). This is because if PBLx8 is to be used,
> "DMA_CH(#i)_Control.PBLx8" needs to be set before programming
> "DMA_CH(#i)_TX_Control.TxPBL" and "DMA_CH(#i)_RX_Control.RxPBL".
> 
> Fixes: 47f2a9ce527a ("net: stmmac: dma channel init prepared for multiple queues")
> Reviewed-by: Zhang, Baoli <baoli.zhang@intel.com>
> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>

Applied and queued up for -stable.

Thanks.
