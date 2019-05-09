Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0FCC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E8D2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfEIQWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:22:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36452 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfEIQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:22:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 224DE14CF8672;
        Thu,  9 May 2019 09:22:35 -0700 (PDT)
Date:   Thu, 09 May 2019 09:22:34 -0700 (PDT)
Message-Id: <20190509.092234.285409406486740265.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuehaibing@huawei.com, xiyou.wangcong@gmail.com,
        weiyongjun1@huawei.com, eric.dumazet@gmail.com
Subject: Re: [PATCH net V3 1/2] tuntap: fix dividing by zero in ebpf queue
 selection
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1557372018-18544-1-git-send-email-jasowang@redhat.com>
References: <1557372018-18544-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 09 May 2019 09:22:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Wed,  8 May 2019 23:20:17 -0400

> We need check if tun->numqueues is zero (e.g for the persist device)
> before trying to use it for modular arithmetic.
> 
> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Fixes: 96f84061620c6("tun: add eBPF based queue selection method")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.
