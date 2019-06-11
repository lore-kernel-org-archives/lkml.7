Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4551FC0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8862173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392098AbfFKTNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:13:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50544 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388777AbfFKTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:13:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 681AF1525A43D;
        Tue, 11 Jun 2019 12:13:51 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:13:50 -0700 (PDT)
Message-Id: <20190611.121350.119608921995403526.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next v2] packet: remove unused variable 'status' in
 __packet_lookup_frame_in_block
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190611013213.142745-1-maowenan@huawei.com>
References: <CAF=yD-+g1bSGOubFUE8veZNvGiPy1oYsf+dFDd=hqXYD+k4g_Q@mail.gmail.com>
        <20190611013213.142745-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Jun 2019 12:13:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Tue, 11 Jun 2019 09:32:13 +0800

> The variable 'status' in  __packet_lookup_frame_in_block() is never used since
> introduction in commit f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer
> implementation."), we can remove it.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  v2: don't change parameter from 0 to TP_STATUS_KERNEL when calls 
>  prb_retire_current_block(). 

Applied.
