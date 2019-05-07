Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0716BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D70206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557252072;
	bh=Mp/HjbvtE5nVEbdDNQk2fWnPDyFLe9Vh/gHeSPClAxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pDxshv/gWtdPhYX7qglUkzh2cPGzN+cTMI0xejy2CnbB6ET0/PWHJUxARKD2e16E8
	 wgzWmLdN03AGxq6X5h7Lgy6p1qJyTQ7qgoDnMzf6jWevZl+hDfTU83RGeDmkBR7hC6
	 CxnnDMiueSweSVOdb65UBtW1oQvp3PhcSAUswOlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfEGSBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfEGSBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:01:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264082054F;
        Tue,  7 May 2019 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557252070;
        bh=Mp/HjbvtE5nVEbdDNQk2fWnPDyFLe9Vh/gHeSPClAxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2wTQHoOCno+0CmCUP72wemgA/de0ptsX7TfB92rG91n8Hd6Y+3y4A702t5JzgERK
         kit3ThAS4oAsN3OybS17ah6IF8BrQ5U8mc8qyQv3sDJRF8DmdmTPDcf0UtKq9lNaEq
         Zb/HYe3GXl+YseEPsMCLf5Fqp6VSuV7w20lQ32CA=
Date:   Tue, 7 May 2019 20:01:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.2-rc1
Message-ID: <20190507180108.GC11857@kroah.com>
References: <20190507175853.GA11568@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507175853.GA11568@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 07:58:53PM +0200, Greg KH wrote:
> The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:
> 
>   Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.2-rc1
> 
> for you to fetch changes up to e2a5be107f52cefb9010ccae6f569c3ddaa954cc:
> 
>   staging: kpc2000: kpc_spi: Fix build error for {read,write}q (2019-05-03 08:23:20 +0200)
> 
> ----------------------------------------------------------------
> Staging / IIO driver patches for 5.2-rc1
> 
> Here is the big staging and iio driver update for 5.2-rc1.
> 
> Lots of tiny fixes all over the staging and IIO driver trees here, along
> with some new IIO drivers.
> 
> Also we ended up deleting two drivers, making this pull request remove a
> few hundred thousand lines of code, always a nice thing to see.  Both of
> the drivers removed have been replaced with "real" drivers in their
> various subsystem directories, and they will be coming to you from those
> locations during this merge window.
> 
> There are some core vt/selection changes in here, that was due to some
> cleanups needed for the speakup fixes.  Those have all been acked by the
> various subsystem maintainers (i.e. me), so those are ok.
> 
> We also added a few new drivers, for some odd hardware, giving new
> developers plenty to work on with basic coding style cleanups to come in
> the near future.
> 
> Other than that, nothing unusual here.
> 
> All of these have been in linux-next for a while with no reported
> issues, other than an odd gcc warning for one of the new drivers that
> should be fixed up soon.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I forgot to mention that the "counter" subsystem was added in here as
well, as it is needed by the IIO drivers and subsystem.  It's reflected
in the shortlog and diffstat, but I forgot to cover it in the text
above, sorry.

thanks,

greg k-h
