Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9828D20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfCSVMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:12:14 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53780 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfCSVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:12:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B66BC146947B5;
        Tue, 19 Mar 2019 14:12:11 -0700 (PDT)
Date:   Tue, 19 Mar 2019 14:12:11 -0700 (PDT)
Message-Id: <20190319.141211.85606832263655146.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     sagi@lightbitslabs.com, xiyou.wangcong@gmail.com,
        kgraul@linux.ibm.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] datagram: Make __skb_datagram_iter static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190319145946.20504-1-yuehaibing@huawei.com>
References: <20190319145946.20504-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Mar 2019 14:12:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Tue, 19 Mar 2019 22:59:46 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> net/core/datagram.c:411:5: warning:
>  symbol '__skb_datagram_iter' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
