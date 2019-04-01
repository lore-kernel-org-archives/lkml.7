Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB30C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67783208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554130871;
	bh=WvTpr6RPMieEUny8qMOsFJRfjnvwQ4xv3Poxolq3eNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c3AJjRYIy5GwiSuEa0Eql+J4v3KIShIb/XAbi9uZ4Oq2IF/MLL9syjp4JRu6IacBB
	 e9cxplOwhh23fYfxGJqqfMxkylchOuKNUzf4zTww3g5+VLDOxm6joKxhZQ7sZ4GZ2b
	 3MUn3OMtg8PdK/gGS+bc7fAlgZKk3WEuu6qLSoA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfDAPBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfDAPBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:01:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D443D20857;
        Mon,  1 Apr 2019 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554130869;
        bh=WvTpr6RPMieEUny8qMOsFJRfjnvwQ4xv3Poxolq3eNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEaKo6M9EB0DxjWRNODwzPft7XB7/GHWnZuws8/wI7yPYhIN+dnJvm8M2Q9eDZ1f3
         esMEG9OypFQ+tC4PeWksTxbM+mEyWVoih2SJIQGZyKWN5lmBX6/LnLFJBR4diKg9OR
         fPArIRPmACkxMcur/HQ0vHdlQd388UWHWHU/m1SI=
Date:   Mon, 1 Apr 2019 17:01:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Cunningham <wjcunningham7@gmail.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        mojha@codeaurora.org
Subject: Re: [PATCH v2] Staging: comedi: drivers: pcl818: Fixed a coding
 style error.
Message-ID: <20190401150106.GB21317@kroah.com>
References: <20190401140130.GA4311@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401140130.GA4311@titus.pi.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:01:30AM -0400, Will Cunningham wrote:
> Removed unnecessary parentheses.
> 
> Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
> ---
> Changes in v2:
>  - Removed a typo from the commit message.
> ---
>  drivers/staging/comedi/drivers/pcl818.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/pcl818.c b/drivers/staging/comedi/drivers/pcl818.c
> index 0af5315d4357..da5d53a288f7 100644
> --- a/drivers/staging/comedi/drivers/pcl818.c
> +++ b/drivers/staging/comedi/drivers/pcl818.c
> @@ -1012,7 +1012,7 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
>  		pcl818_alloc_dma(dev, it->options[2]);
>  
>  	/* use 1MHz or 10MHz oscilator */
> -	if ((it->options[3] == 0) || (it->options[3] == 10))
> +	if (it->options[3] == 0 || it->options[3] == 10)

Again, no, the original is best.

thanks,

greg k-h
