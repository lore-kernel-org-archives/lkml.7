Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85AACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03942083E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfJ2XQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:16:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60922 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2XQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:16:28 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4B60614EBBF90;
        Tue, 29 Oct 2019 16:16:27 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:16:26 -0700 (PDT)
Message-Id: <20191029.161626.1023293284198194402.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     epomozov@marvell.com, igor.russkikh@aquantia.com,
        pavel.belous@aquantia.com, dmitry.bezrukov@aquantia.com,
        dmitry.bogdanov@aquantia.com, ndanilov@aquantia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] net: aquantia: make two symbols be static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191026020738.130606-1-maowenan@huawei.com>
References: <20191026020738.130606-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 29 Oct 2019 16:16:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Sat, 26 Oct 2019 10:07:38 +0800

> When using ARCH=mips CROSS_COMPILE=mips-linux-gnu-
> to build drivers/net/ethernet/aquantia/atlantic/aq_ptp.o
> and drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.o,
> below errors can be seen:
> drivers/net/ethernet/aquantia/atlantic/aq_ptp.c:1378:6:
> warning: symbol 'aq_ptp_poll_sync_work_cb' was not declared.
> Should it be static?
> 
> drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c:1155:5:
> warning: symbol 'hw_atl_b0_ts_to_sys_clock' was not declared.
> Should it be static?
> 
> This patch to make aq_ptp_poll_sync_work_cb and hw_atl_b0_ts_to_sys_clock
> be static to fix these warnings.
> 
> Fixes: 9c477032f7d0 ("net: aquantia: add support for PIN funcs")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Applied.
