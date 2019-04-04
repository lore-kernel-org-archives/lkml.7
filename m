Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BDAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC112082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDDCiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:38:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40334 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDDCiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:38:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBsH3-0006sp-2A; Thu, 04 Apr 2019 02:38:41 +0000
Date:   Thu, 4 Apr 2019 03:38:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, willemb@google.com, edumazet@google.com,
        fw@strlen.de, sagi@lightbitslabs.com, hch@lst.de,
        pabeni@redhat.com, pctammela@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] iov_iter: Fix build error without CONFIG_CRYPTO
Message-ID: <20190404023840.GA2217@ZenIV.linux.org.uk>
References: <20190403095031.11720-1-yuehaibing@huawei.com>
 <20190404023114.30304-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404023114.30304-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:31:14AM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> If CONFIG_CRYPTO is not set or set to m,
> gcc building warn this:
> 
> lib/iov_iter.o: In function `hash_and_copy_to_iter':
> iov_iter.c:(.text+0x9129): undefined reference to `crypto_stats_get'
> iov_iter.c:(.text+0x9152): undefined reference to `crypto_stats_ahash_update'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: d05f443554b3 ("iov_iter: introduce hash_and_copy_to_iter helper")
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
