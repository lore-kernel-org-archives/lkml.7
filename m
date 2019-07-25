Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BC5C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7262081B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564040801;
	bh=4UcEQNmlJvi9gGhfQJufu+mVSE9Yfv6XMx4Zl1E3xJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iMnDiJIY0TpgvpyFxGqj2OpWL8Br/lsTpZX7+cesKHQKxLQTefoLADwmcEgopzPMI
	 aKP7Y3BiDmw3ZuMPIcgUtcbjPKhYWNGb4zH3lYlUwtfqro/68wWwVgWVUS4J+jHYgw
	 ZKdSFksU1yEdaBLczedq0dxlxXughvAJXxmIipxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbfGYHqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388187AbfGYHqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:46:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727952081B;
        Thu, 25 Jul 2019 07:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564040797;
        bh=4UcEQNmlJvi9gGhfQJufu+mVSE9Yfv6XMx4Zl1E3xJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=velcbiV1Wy/WrI//kr6s+Z4iop+NiwHmNkPl/NPAOSBXjfLXcnUF03lIE5FQ+nGOl
         Zm1qmFvGNR0CqIiByLLBJjaGlw86qt4T/3foSXAIO80HGhsLDLYxragd68iJeRVWg0
         e/VP1qAQVs9nypLg06ZnCBFTK5hbGnoJo/MMwtS8=
Date:   Thu, 25 Jul 2019 09:46:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        Matt.Sickler@daktronics.com, jhubbard@nvidia.com,
        devel@driverdev.osuosl.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: kpc2000: Convert put_page to put_user_page*()
Message-ID: <20190725074634.GB15090@kroah.com>
References: <20190720173214.GA4250@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190720173214.GA4250@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 11:02:14PM +0530, Bharath Vedartham wrote:
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d ("mm: introduce put_user_page*(), placeholder versions").

Please line-wrap this line.

> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Matt Sickler <Matt.Sickler@daktronics.com>
> Cc: devel@driverdev.osuosl.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
> Changes since v1
>        - Improved changelog by John's suggestion.
>        - Moved logic to dirty pages below sg_dma_unmap
>        and removed PageReserved check.
> Changes since v2
>        - Added back PageResevered check as suggested by John Hubbard.
> Changes since v3
>        - Changed the commit log as suggested by John.
>        - Added John's Reviewed-By tag
> 
> ---
>  drivers/staging/kpc2000/kpc_dma/fileops.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> index 6166587..75ad263 100644
> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> @@ -198,9 +198,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
>  	sg_free_table(&acd->sgt);
>   err_dma_map_sg:
>   err_alloc_sg_table:
> -	for (i = 0 ; i < acd->page_count ; i++){
> -		put_page(acd->user_pages[i]);
> -	}
> +	put_user_pages(acd->user_pages, acd->page_count);
>   err_get_user_pages:
>  	kfree(acd->user_pages);
>   err_alloc_userpages:
> @@ -221,16 +219,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
>  	
>  	dev_dbg(&acd->ldev->pldev->dev, "transfer_complete_cb(acd = [%p])\n", acd);
>  	
> -	for (i = 0 ; i < acd->page_count ; i++){
> -		if (!PageReserved(acd->user_pages[i])){
> -			set_page_dirty(acd->user_pages[i]);
> -		}
> -	}
> -	
>  	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
>  	
> -	for (i = 0 ; i < acd->page_count ; i++){
> -		put_page(acd->user_pages[i]);
> +	for (i = 0; i < acd->page_count; i++) {
> +		if (!PageReserved(acd->user_pages[i]))
> +			put_user_pages_dirty(&acd->user_pages[i], 1);
> +		else
> +			put_user_page(acd->user_pages[i]);
>  	}
>  	
>  	sg_free_table(&acd->sgt);
> -- 
> 2.7.4

This patch can not be applied at all :(

Can you redo it against the latest staging-next branch and resend?

thanks,

greg k-h
