Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720B8C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E006241F6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfE2VTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:19:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41964 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfE2VTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:19:19 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5E3FE136DF6FB;
        Wed, 29 May 2019 14:19:18 -0700 (PDT)
Date:   Wed, 29 May 2019 14:19:15 -0700 (PDT)
Message-Id: <20190529.141915.945026439348535112.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: Fix build error without
 CONFIG_INET
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190528091040.20288-1-yuehaibing@huawei.com>
References: <20190528091040.20288-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 May 2019 14:19:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 28 May 2019 17:10:40 +0800

> Fix gcc build error while CONFIG_INET is not set
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.o: In function `__stmmac_test_loopback':
> stmmac_selftests.c:(.text+0x8ec): undefined reference to `ip_send_check'
> stmmac_selftests.c:(.text+0xacc): undefined reference to `udp4_hwcsum'
> 
> Add CONFIG_INET dependency to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
