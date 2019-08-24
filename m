Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E273CC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B696D20674
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfHXVV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:21:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfHXVV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 17:21:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9358615252E02;
        Sat, 24 Aug 2019 14:21:58 -0700 (PDT)
Date:   Sat, 24 Aug 2019 14:21:58 -0700 (PDT)
Message-Id: <20190824.142158.1506174328495468705.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     nbd@openwrt.org, john@phrozen.org, sean.wang@mediatek.com,
        nelson.chang@mediatek.com, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] net: mediatek: remove set but not used variable
 'status'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190822063026.70044-1-maowenan@huawei.com>
References: <20190822063026.70044-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 24 Aug 2019 14:21:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Thu, 22 Aug 2019 14:30:26 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function mtk_handle_irq:
> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1951:6: warning: variable status set but not used [-Wunused-but-set-variable]
> 
> It is not used since commit 296c9120752b ("net: ethernet: mediatek: Add MT7628/88 SoC support")

This is not a standard commit tag, please use Fixes: or similar.
