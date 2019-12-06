Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A0EC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A3324673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLFTuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:50:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60024 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:50:51 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D9CA01511E7DD;
        Fri,  6 Dec 2019 11:50:50 -0800 (PST)
Date:   Fri, 06 Dec 2019 11:50:50 -0800 (PST)
Message-Id: <20191206.115050.2225203369041453711.davem@davemloft.net>
To:     neidhard.kim@lge.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, joabreu@synopsys.com,
        alexandre.torgue@st.com, peppe.cavallaro@st.com
Subject: Re: [PATCH] net: stmmac: reset Tx desc base address before
 restarting Tx
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191206114000.27283-1-neidhard.kim@lge.com>
References: <20191206114000.27283-1-neidhard.kim@lge.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 06 Dec 2019 11:50:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jongsung Kim <neidhard.kim@lge.com>
Date: Fri,  6 Dec 2019 20:40:00 +0900

> Refer to the databook of DesignWare Cores Ethernet MAC Universal:
> 
> 6.2.1.5 Register 4 (Transmit Descriptor List Address Register
> 
> If this register is not changed when the ST bit is set to 0, then
> the DMA takes the descriptor address where it was stopped earlier.
> 
> The stmmac_tx_err() does zero indices to Tx descriptors, but does
> not reset HW current Tx descriptor address. To fix inconsistency,
> the base address of the Tx descriptors should be rewritten before
> restarting Tx.
> 
> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>

Applied.
