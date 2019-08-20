Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54C1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C198122DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfHTPPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:15:55 -0400
Received: from fieldses.org ([173.255.197.46]:40282 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbfHTPPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:15:55 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C2A631C20; Tue, 20 Aug 2019 11:15:54 -0400 (EDT)
Date:   Tue, 20 Aug 2019 11:15:54 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jeff Layton <jeff.layton@primarydata.com>,
        Weston Andros Adamson <dros@primarydata.com>,
        Richard Sharpe <richard.sharpe@primarydata.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nfsd: remove duplicated include from filecache.c
Message-ID: <20190820151554.GA7026@fieldses.org>
References: <20190820013243.129865-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820013243.129865-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.--b.

On Tue, Aug 20, 2019 at 01:32:43AM +0000, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/nfsd/filecache.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 4759fdc8a07e..07939f4834e8 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -6,7 +6,6 @@
>  
>  #include <linux/hash.h>
>  #include <linux/slab.h>
> -#include <linux/hash.h>
>  #include <linux/file.h>
>  #include <linux/sched.h>
>  #include <linux/list_lru.h>
> 
> 
