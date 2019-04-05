Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62EAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8D1217D6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfDEAhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:37:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55270 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfDEAhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:37:01 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 357311473769C;
        Thu,  4 Apr 2019 17:37:01 -0700 (PDT)
Date:   Thu, 04 Apr 2019 17:37:00 -0700 (PDT)
Message-Id: <20190404.173700.1333439177305813741.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     mpe@ellerman.id.au, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -next] net: pasemi: remove set but not used variable
 'cpyhdr'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190403075027.26744-1-yuehaibing@huawei.com>
References: <20190403075027.26744-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Apr 2019 17:37:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Wed, 3 Apr 2019 15:50:27 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/pasemi/pasemi_mac.c: In function 'pasemi_mac_queue_csdesc':
> drivers/net/ethernet/pasemi/pasemi_mac.c:1358:29: warning: variable 'cpyhdr' set but not used [-Wunused-but-set-variable]
> 
> It's never used since commit 8d636d8bc5ff ("pasemi_mac: jumbo
> frame support") and can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
