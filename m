Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B6EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D869324686
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576748108;
	bh=lzp1HN2f5DdnttpS7dgrg/0gOfedhdb2VhqMZkrhDjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dKY1vZzCd4h425BQln7eCP7knU4mhqOJ6BkKFX5XwYW9r6TCNcUweVM+zYv2dy0pj
	 oSRdp2w/POzrrfvYtGBdNWZsVlL17jBCd54DbZ4DdvwsbQOBbJOMdNrFEWFhBpLTwe
	 EADKlHqGErMG7NJC2/EfPgagjGerheRrr2sWBmA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfLSJfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfLSJfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:35:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58DA42467F;
        Thu, 19 Dec 2019 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576748106;
        bh=lzp1HN2f5DdnttpS7dgrg/0gOfedhdb2VhqMZkrhDjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOFJmpkN7vgml3UaRrTM6bC0PDdH26Plkk7ZvLMW+uGaRmVSejxFr5SKP1COPqTCi
         UuW+GOd092mTgyH4g2BzrrIs/qqFhAZOV62ihMeU6zC7g0DoRuGs3hk0cvvLcel93F
         DT/D4RE0d8aTaSOVDSJUq44VmJdUZEvslZ1X/bnM=
Date:   Thu, 19 Dec 2019 10:35:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simran Sandhu <f20171454@hyderabad.bits-pilani.ac.in>
Cc:     sudipm.mukherjee@gmail.comm, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Staging: sm750fb: sm750.h:Fixed Coding Style Issue
Message-ID: <20191219093504.GB1198515@kroah.com>
References: <20191219090553.13243-1-f20171454@hyderabad.bits-pilani.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219090553.13243-1-f20171454@hyderabad.bits-pilani.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 02:35:53PM +0530, Simran Sandhu wrote:
> Fixed the checkpath error: function definition arguments
> should also have identifier names
> 
> Signed-of-by: Simran Sandhu <f20171454@hyderabad.bits-pilani.ac.in>
> ---
>  drivers/staging/sm750fb/sm750.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index ce90adcb449d..cf986bad7210 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -66,9 +66,9 @@ struct lynx_accel {
>  						u32, u32, u32, u32,
>  						u32, u32, u32, u32);
>  
> -	int (*de_imageblit)(struct lynx_accel *, const char *, u32, u32, u32, u32,
> -							       u32, u32, u32, u32,
> -							       u32, u32, u32, u32);
> +	int (*de_imageblit)(struct lynx_accel *A, const char *B, u32 C, u32 D,
> +		       						u32 E, u32 F, u32 G, u32 H, u32 I,
> +							       	u32 J, u32 K, u32 L, u32 M, u32 N);
>  

You just caused another coding style violation with this one :(

Always run your patches though checkpatch.pl to ensure you do not add
new problems when trying to fix up things.

greg k-h
