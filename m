Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43AAC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B274520B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfFSGdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:33:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44049 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfFSGdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:33:22 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=lindsey)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1hdU9f-0001HK-Q8; Wed, 19 Jun 2019 06:33:12 +0000
Date:   Wed, 19 Jun 2019 01:33:08 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     viro@zeniv.linux.org.uk, agruenba@redhat.com,
        linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org
Subject: Re: [PATCH -next] ecryptfs: Make ecryptfs_xattr_handler static
Message-ID: <20190619063307.GA22021@lindsey>
References: <20190614155117.28988-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614155117.28988-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-14 23:51:17, YueHaibing wrote:
> Fix sparse warning:
> 
> fs/ecryptfs/inode.c:1138:28: warning:
>  symbol 'ecryptfs_xattr_handler' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the cleanup! I've pushed this to the eCryptfs next branch.

Tyler

> ---
>  fs/ecryptfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 1e994d7..18426f4 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -1121,7 +1121,7 @@ static int ecryptfs_xattr_set(const struct xattr_handler *handler,
>  	}
>  }
>  
> -const struct xattr_handler ecryptfs_xattr_handler = {
> +static const struct xattr_handler ecryptfs_xattr_handler = {
>  	.prefix = "",  /* match anything */
>  	.get = ecryptfs_xattr_get,
>  	.set = ecryptfs_xattr_set,
> -- 
> 2.7.4
> 
> 
