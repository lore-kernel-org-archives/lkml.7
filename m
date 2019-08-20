Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BE2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C97922DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfHTUrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:47:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50840 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfHTUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:47:18 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 37C961481204E;
        Tue, 20 Aug 2019 13:47:17 -0700 (PDT)
Date:   Tue, 20 Aug 2019 13:47:06 -0700 (PDT)
Message-Id: <20190820.134706.1034655132989299239.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     idosch@mellanox.com, jiri@mellanox.com, mcroce@redhat.com,
        jakub.kicinski@netronome.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] netdevsim: Fix build error without
 CONFIG_INET
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190820141446.71604-1-yuehaibing@huawei.com>
References: <20190819120825.74460-1-yuehaibing@huawei.com>
        <20190820141446.71604-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 20 Aug 2019 13:47:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 20 Aug 2019 22:14:46 +0800

> If CONFIG_INET is not set, building fails:
> 
> drivers/net/netdevsim/dev.o: In function `nsim_dev_trap_report_work':
> dev.c:(.text+0x67b): undefined reference to `ip_send_check'
> 
> Use ip_fast_csum instead of ip_send_check to avoid
> dependencies on CONFIG_INET.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: da58f90f11f5 ("netdevsim: Add devlink-trap support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: use ip_fast_csum instead of ip_send_check

Applied, thank you.
