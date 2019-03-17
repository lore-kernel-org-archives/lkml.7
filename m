Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951DEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5930B2186A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552821077;
	bh=i0NGZzyXdIIEfD325rP2J96tKQfmru96uqQI9tMRnAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=imnLXCscNx8s0EhWL6Bxc9ykgXtZzuGzM0HiDOoZdTTfYIIKxNdYVCGwQH0xCIhCu
	 0Td2AhFSooC9nEZTBLL6wjV0zUo8VjxyaQSPnwQSC0WxPrE1/Nx6CONWT7bMWtLwNz
	 k/YGJKz7KcV+/JPI5Tn5Mi6A7WZYqXtjSr3GXlqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCQLLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfCQLLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:11:15 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE9F921019;
        Sun, 17 Mar 2019 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552821075;
        bh=i0NGZzyXdIIEfD325rP2J96tKQfmru96uqQI9tMRnAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZ0LA01q7r859m8UggxBcaS3IdCPBQ0MYSvKpr6cGLigsl9a3nYpKtQR8uRdZdRDZ
         O5Xzk3wNO2XNhH9N7bRwDQ7VY6rZN2SfXj3NkT35QVNmHGzUWeMgc6n1IqjetvmkKx
         E+4ueGpgLJ/Dj8X0Vnazlg/qfrG2flsaCC3jvKxQ=
Date:   Sun, 17 Mar 2019 12:11:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arshad Hussain <arshad.super@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, gaoxiang25@huawei.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        yuchao0@huawei.com
Subject: Re: [PATCH] [PATCH 1/1] staging: erofs: Add function comment for
 erofs/super.c
Message-ID: <20190317111112.GA4614@kroah.com>
References: <20190312210640.2175-1-arshad.super@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312210640.2175-1-arshad.super@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 02:36:40AM +0530, Arshad Hussain wrote:
> This patch adds functions comment for file erofs/super.c in
> sphinx format.
> 
> Signed-off-by: Arshad Hussain <arshad.super@gmail.com>
> ---
>  drivers/staging/erofs/super.c | 135 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 131 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index 15c784fba879..60bfc3e8db7a 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -30,6 +30,11 @@ static void init_once(void *ptr)
>  	inode_init_once(&vi->vfs_inode);
>  }
>  
> +/**
> + * erofs_init_inode_cache(): Create & initialize inode cache
> + *
> + * Returns: 0 on Success. Errno Otherwise.
> + */
>  static int __init erofs_init_inode_cache(void)

Why do you need kernel doc comments for local functions?  That should
not be needed.  No tool is going through this file to create
documentation, right?  And documentation is only needed for functions
that are called outside of the file at most, and usually only needed for
functions that other drivers/subsystems can call.

And for a function name like this, it is pretty obvious what it does, no
comment should be needed at all.

Same for the other changes here, I do not think it is needed at all.

thanks,

greg k-h
