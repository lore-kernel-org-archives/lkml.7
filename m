Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39054C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DE1206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEGTSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:18:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33084 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:18:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6C1A714B56316;
        Tue,  7 May 2019 12:17:59 -0700 (PDT)
Date:   Tue, 07 May 2019 12:17:58 -0700 (PDT)
Message-Id: <20190507.121758.1374598572835036372.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     g.nault@alphalink.fr, jian.w.wen@oracle.com, edumazet@google.com,
        kafai@fb.com, xiyou.wangcong@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] l2tp: Fix possible NULL pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190506144404.25220-1-yuehaibing@huawei.com>
References: <20190506144404.25220-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 May 2019 12:17:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 6 May 2019 22:44:04 +0800

> BUG: unable to handle kernel NULL pointer dereference at 0000000000000128
 . ..
> ---[ end trace 8322b2b8bf83f8e1
> 
> If alloc_workqueue fails in l2tp_init, l2tp_net_ops
> is unregistered on failure path. Then l2tp_exit_net
> is called which will flush NULL workqueue, this patch
> add a NULL check to fix it.
> 
> Fixes: 67e04c29ec0d ("l2tp: unregister l2tp_net_ops on failure path")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied and queued up for -stable, thanks.
