Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4982AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121192082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576586249;
	bh=5YvBsHQOxmA34K9T0xQbE8k/6MwlrTqIfOTtiy0crqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eBYUwuSznseui3ijMcwpTWcSRJSd/mtLfdFHwOvNpsYGy6Dyk/9oMpz835sj3h7EY
	 IrZ4nkOqog22TY1cXzt+xdB0FrRzHr59rcAsRWQUbgMc1PqY98GMUDsaVoLUPgGLwx
	 GfNekpsmYkDSnwbK6InUxPFreanKkAhX20YMvoQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfLQMh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:37:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfLQMh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:37:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDDD02082E;
        Tue, 17 Dec 2019 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576586247;
        bh=5YvBsHQOxmA34K9T0xQbE8k/6MwlrTqIfOTtiy0crqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFJ9Bp/jjS+N+ugpvcJknjz0PJbPGNVm6bFMd2sM5JS3YxixU8QIQzJ8XIh+84n0Y
         A/Ju4Z6SD4f5NfLFW56sMhfFLjZE7T3Tp8QGm5dQOh2CsF+NmX2od75jzHXi4eZx2l
         yRm273w/A/s4geYWSOnM2VRJmpGPLCDhQJn8/V+o=
Date:   Tue, 17 Dec 2019 13:37:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Scott Schafer <schaferjscott@gmail.com>
Cc:     devel@driverdev.osuosl.org, GR-Linux-NIC-Dev@marvell.com,
        Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/23] staging: qlge: Fix WARNING: Missing a blank
 line after declarations
Message-ID: <20191217123725.GA3161766@kroah.com>
References: <cover.1576086080.git.schaferjscott@gmail.com>
 <815a27ebb89b7a08e616fddbe0583eabd3c4401b.1576086080.git.schaferjscott@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815a27ebb89b7a08e616fddbe0583eabd3c4401b.1576086080.git.schaferjscott@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:12:33PM -0600, Scott Schafer wrote:
> Fix WARNING: Missing a blank line after declarations in the following
> files:
> qlge.h
> qlge_dbg.c
> qlge_main.c
> qlge_mpi.c
> 
> Signed-off-by: Scott Schafer <schaferjscott@gmail.com>
> ---
>  drivers/staging/qlge/qlge.h      |  2 +-
>  drivers/staging/qlge/qlge_dbg.c  | 10 +++++-----
>  drivers/staging/qlge/qlge_main.c | 26 +++++++++++++-------------
>  drivers/staging/qlge/qlge_mpi.c  | 12 ++++++------
>  4 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
> index 89502a8300f6..d45c53a053c2 100644
> --- a/drivers/staging/qlge/qlge.h
> +++ b/drivers/staging/qlge/qlge.h
> @@ -2227,7 +2227,7 @@ static inline void ql_write_db_reg_relaxed(u32 val, void __iomem *addr)
>  static inline u32 ql_read_sh_reg(__le32  *addr)
>  {
>  	u32 reg;
> -	
> +

The description of this patch is NOT what this patch is doing.  It's
fixing up the mess you added in the previous patch :(

thanks,

greg k-h
