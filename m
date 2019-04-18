Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B07C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23958214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfDRGVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:21:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35500 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfDRGVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:21:03 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A0CEC103CB437;
        Wed, 17 Apr 2019 23:21:02 -0700 (PDT)
Date:   Wed, 17 Apr 2019 23:21:02 -0700 (PDT)
Message-Id: <20190417.232102.230088678014335132.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        aaro.koskinen@nokia.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Use bfsize1 in ndesc_init_rx_desc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190417014939.36656-1-yuehaibing@huawei.com>
References: <20190417014939.36656-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Apr 2019 23:21:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Wed, 17 Apr 2019 09:49:39 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> gcc warn this:
> 
> drivers/net/ethernet/stmicro/stmmac/norm_desc.c: In function ndesc_init_rx_desc:
> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:138:6: warning: variable 'bfsize1' set but not used [-Wunused-but-set-variable]
> 
> Like enh_desc_init_rx_desc, we should use bfsize1
> in ndesc_init_rx_desc to calculate 'p->des1'
> 
> Fixes: 583e63614149 ("net: stmmac: use correct DMA buffer size in the RX descriptor")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.
