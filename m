Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 02:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D273120815
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 02:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfHZCGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 22:06:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57746 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfHZCGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 22:06:48 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3B3FA14C36B36;
        Sun, 25 Aug 2019 19:06:47 -0700 (PDT)
Date:   Sun, 25 Aug 2019 19:06:43 -0700 (PDT)
Message-Id: <20190825.190643.573913079872386152.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     nbd@openwrt.org, john@phrozen.org, sean.wang@mediatek.com,
        nelson.chang@mediatek.com, matthias.bgg@gmail.com,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] net: mediatek: remove set but not used
 variable 'status'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190826013118.22720-1-maowenan@huawei.com>
References: <20190824.142158.1506174328495468705.davem@davemloft.net>
        <20190826013118.22720-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 25 Aug 2019 19:06:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Mon, 26 Aug 2019 09:31:18 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function mtk_handle_irq:
> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1951:6: warning: variable status set but not used [-Wunused-but-set-variable]
> 
> Fixes: 296c9120752b ("net: ethernet: mediatek: Add MT7628/88 SoC support")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Are you sure the register isn't being read in order to make some
hardware side effect happen?

Have you tested this on effected hardware?

I'm not applying this without definitive answers to these questions.
