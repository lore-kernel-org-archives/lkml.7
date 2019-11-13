Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34083206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573681621;
	bh=n96/5PzGOEYZcGlnrAyxzYgSCUiVw6VEfwgsiPPkn1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VY6DtQuMYYSX5grapMa5MrMTKD5w/TGur/PCivyd2qovdZ6OEj9/iitzUOC6Xf1Ma
	 PPoHl6gtzoh8MB1EhWQExBlW00Sfc/TreLNuW20DHxZ0Lj59K2EDm1gRZlsbQLDA48
	 4mU0AgxeAMgSfav+8jetzUAZC4PkGCjDFPNo8Pfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKMVq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:46:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfKMVq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:46:58 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E062D206EE;
        Wed, 13 Nov 2019 21:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573681619;
        bh=n96/5PzGOEYZcGlnrAyxzYgSCUiVw6VEfwgsiPPkn1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTZftfOKsYoPcVvvlTZZ8ykjYfA+IusaYfJnZQwrRLhsSel6Ge4Mg5TBwKlqVUrxa
         WVJVT3qzQMw7oKE9wU5WVMWxXopD7Eh8Fz/yUoAEm18YdlE10U1/FtUvx1DuR9wAfP
         oLgeo9NhvWT/+rZTWI+c+UWbvaexu+DFzlzlLoL8=
Date:   Thu, 14 Nov 2019 05:46:55 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Javier F. Arias" <jarias.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: Fix CamelCase in function names
Message-ID: <20191113214655.GB3926041@kroah.com>
References: <20191113174348.oxek47hs7rxruisr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113174348.oxek47hs7rxruisr@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 12:43:48PM -0500, Javier F. Arias wrote:
> This patch fixes CamelCase in function names with the ffs prefix.
> Issue found by checkpatch.
> 
> Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
> ---
>  drivers/staging/exfat/exfat_super.c | 84 ++++++++++++++---------------
>  1 file changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
> index 23002aefc964..a6bbf0d7d378 100644
> --- a/drivers/staging/exfat/exfat_super.c
> +++ b/drivers/staging/exfat/exfat_super.c
> @@ -343,7 +343,7 @@ static inline void exfat_save_attr(struct inode *inode, u32 attr)
>  		EXFAT_I(inode)->fid.attr = attr & (ATTR_RWMASK | ATTR_READONLY);
>  }
>  
> -static int ffsMountVol(struct super_block *sb)
> +static int ffs_mount_vol(struct super_block *sb)

Can't you just get rid of the crazy ffs prefix as well?

That would be best, look at the TODO file, it says to do just that :)

thanks,

greg k-h
