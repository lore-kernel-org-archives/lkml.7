Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28DBC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B7E2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563266380;
	bh=ssPZAo5dXHHPNouNGTvVRALYu0oPoZ+PbbXzdC0B6Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ji+SSLoBZHj/W1Ydiq6yUIVtgtzI/+ZU2oovwGFrGrWMVD67WfxEJ/1X12sRJtr1e
	 kbxACDN1Rjy/iqlXIqVrsVCsmCV54A6qjum5oFjvLh/kd9zlwjbaVV3WUTqFSmF2gE
	 m0zp1BdfhIdRCQYcnDyDtT+GrPvB7HSUqyD1R0N0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbfGPIjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfGPIji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:39:38 -0400
Received: from localhost (unknown [113.157.217.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B244206C2;
        Tue, 16 Jul 2019 08:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563266378;
        bh=ssPZAo5dXHHPNouNGTvVRALYu0oPoZ+PbbXzdC0B6Kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7JVunjjTnc01kKlaG12hQOaomPng4ObG+rthUu1fZurnw5j/g+wfAA0osSY06CcO
         OFTJxTUzD+e5WBTlt7HfrbSkiUwbSezum1FV7QTjCH0ReSSgz4uYeg4AFpgB2keKLE
         x6N7nZgDYCTGru+0tcfxeQvNtD6zcuJBomrr7cEI=
Date:   Tue, 16 Jul 2019 17:36:53 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     john.hubbard@gmail.com
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, Vandana BN <bnvandana@gmail.com>,
        Geordan Neukum <gneukum1@gmail.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Subject: Re: [PATCH] staging: kpc2000: whitespace and line length cleanup
Message-ID: <20190716083653.GB26457@kroah.com>
References: <20190715212123.432-1-jhubbard@nvidia.com>
 <20190715212123.432-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190715212123.432-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 02:21:23PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> This commit was created by running indent(1):
>     `indent -linux`
> 
> ...and then applying some manual corrections and
> cleanup afterward, to keep it sane. No functional changes
> were made.
> 
> In addition to whitespace changes, some strings were split,
> but not strings that were likely to be a grep problem
> (in other words, if a user is likely to grep for a string
> within the driver, that should still work in most cases).
> 
> A few "void * foo" cases were fixed to be "void *foo".
> 
> That was enough to make checkpatch.pl run without errors,
> although note that there are lots of serious warnings
> remaining--but those require functional, not just whitespace
> changes. So those are left for a separate patch.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Simon Sandström <simon@nikanor.nu>
> Cc: Geordan Neukum <gneukum1@gmail.com>
> Cc: Jeremy Sowden <jeremy@azazel.net>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Vandana BN <bnvandana@gmail.com>
> Cc: devel@driverdev.osuosl.org
> Cc: Bharath Vedartham <linux.bhar@gmail.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/staging/kpc2000/kpc2000_i2c.c         | 189 +++++++++++------
>  drivers/staging/kpc2000/kpc2000_spi.c         | 116 +++++-----
>  drivers/staging/kpc2000/kpc_dma/dma.c         | 109 ++++++----
>  drivers/staging/kpc2000/kpc_dma/fileops.c     | 199 +++++++++++-------
>  .../staging/kpc2000/kpc_dma/kpc_dma_driver.c  | 113 +++++-----
>  .../staging/kpc2000/kpc_dma/kpc_dma_driver.h  | 156 +++++++-------
>  6 files changed, 509 insertions(+), 373 deletions(-)

THat's way too many different types of changes to do all at once, and
some of these are making the code look worse, not better.

There's a reason we don't run lindent :)

If you want to do one-type-of-fix-per-patch, I'll gladly take these,
otherwise, I recommend leaving this for those people learning how to do
development to do.

thanks,

greg k-h
