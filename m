Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE81C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F5C20825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfDOHxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:53:50 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:46958 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOHxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:53:49 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x3F7rhuV019429;
        Mon, 15 Apr 2019 00:53:44 -0700
Date:   Mon, 15 Apr 2019 13:23:38 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cxgb4: fix null pointer dereference on alloc_skb
 failure
Message-ID: <20190415075336.GA26935@chelsio.com>
References: <20190413160026.5873-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413160026.5873-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 04/13/19, 2019 at 21:30:26 +0530, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if alloc_skb fails to allocate the skb a null skb is passed
> to t4_set_arp_err_handler and this ends up dereferencing the null skb.
> Avoid the null pointer dereference by checking for a null skb and
> returning early.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: b38a0ad8ec11 ("RDMA/cxgb4: Set arp error handler for PASS_ACCEPT_RPL messages")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks,
Acked-by: Potnuri Bharat Teja <bharat@chelsio.com>

