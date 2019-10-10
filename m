Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654ABC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2CF22477
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697746;
	bh=fWJjbXpmFkxTYN182RrS0pGcx/QVyeR2dPDwnS/HsTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OnsbUhVyUjegm6K5CoLpcZ6zrQqZ5xEegqV9SIii1Q3VS+A3jzmJjy2Nf71FVm3g9
	 VgN1U5j0VPEG1o/9VjRLOy8MLtXnQLpvXb9oEjjO2LrC2ubeyOsQ0Z0GH7lx0s6WNI
	 YGJy3MsJ2VVKAVOoRQhmh3/obNm1bvlLnhfUUrs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389535AbfJJIzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388327AbfJJIzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:55:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C682190F;
        Thu, 10 Oct 2019 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697743;
        bh=fWJjbXpmFkxTYN182RrS0pGcx/QVyeR2dPDwnS/HsTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tqrbyxx7vQRb3pTZ4yaY7TfY+WhmKqOi6eLilR4NrlcMSSP0IWAve36knAdr3v+Xw
         vT6fVwb9maoaNVWLfj1OJaTMKtnXDY7OA7///Oti93WxRXDfYyv6FCyV2qPH/NZb1O
         Aa5/gG8zcshCE1q4zUMY9p7RqYR4afqPec9QQyQY=
Date:   Thu, 10 Oct 2019 10:49:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: fix "alignment should match open
 parenthesis" check
Message-ID: <20191010084912.GA394561@kroah.com>
References: <20191009135909.19474-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009135909.19474-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:59:09PM +0100, Jules Irenge wrote:
> Fix "alignment should match open parenthesis" check
>  issued by checkpatch.pl tool:
> "CHECK: Alignment should match open parenthesis".
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/qlge/qlge_dbg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

You sent 8 patches for the same driver, some patches with almost
identical subject lines, and some a bit different.  None of these gave
me any hint as to which ones superseed which, and which order to apply
any of these in.

Please resend all of the latest versions, in a patch series properly
numbered, so that I have a chance to apply them correctly.

thanks,

greg k-h
