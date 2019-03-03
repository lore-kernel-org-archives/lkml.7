Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1FAC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD93F20835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551635833;
	bh=fOd9ZG/Qjb/AjNqGE7CQRbJZni6sQ31Pys7I9H2ErzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ejbip19+LYAiCtmeXpGDjn54diW8NcohpHFzZxN+FckDfVRJs10jsiI7bcVN2WDFK
	 bIR9EIdTpjtypAmUOOyT1mf7vG5YDZ8psZGkqWBVXSPbM1SiiJ/cVIWI4crXii276R
	 NamXZbujTfadfnaWW5H6EYwYDbMhpo43VOJc/8aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfCCR4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfCCR4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:56:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E3C20830;
        Sun,  3 Mar 2019 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551635812;
        bh=fOd9ZG/Qjb/AjNqGE7CQRbJZni6sQ31Pys7I9H2ErzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbQxNEBnCQoJf7oVegEjGm2XdAQ1oHYVlwwHvTQxJM+Bb7cxBgzvfpij8ZlzaXhO4
         uy5ScNpOgvMJ73uGVkjjfVntJ0a2wuufxVQmhELpiFho8duLilEYZ0Wyij7IrBn/M1
         P84Xt+L2VLHHtYBKEo3Tklyc3hTMOEbLHRsrDrRA=
Date:   Sun, 3 Mar 2019 18:56:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: Re: [RESEND][PATCH 0/2] staging: sm750fb: trivial style fixes.
Message-ID: <20190303175649.GB16636@kroah.com>
References: <20190303165532.23727-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303165532.23727-1-tomli@tomli.me>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 12:55:30AM +0800, Yifeng Li wrote:
> Hello.
> 
> >From January to February, there have been two trivial sm750fb patches
> submitted to linux-fbdev, one by me, one by Jin Chen, but both without
> any response. Further, it seems both maintainers, Sudip Mukherjee and
> Teddy Wang, are currently unavailable, getting an "Ack-by" would be
> unfeasible.
> 
> Since they're extremely trivial. Hereby, I picked them up, reworded
> commit message, and now resubmit them as trivial patches, and send them
> to trivial@kernel.org. I hope it could be directly applied by either a
> fbdev, a staging maintainer or by Jiri Kosina.
> 
> Thanks for your time!
> 
> Yifeng Li (2):
>   staging: sm750fb: trivial comment indention fix.
>   staging: sm750fb: trivial Camel Case removal for setDisplayControl().
> 
>  drivers/staging/sm750fb/ddk750_display.c |  6 ++---
>  drivers/staging/sm750fb/sm750_accel.c    | 32 ++++++++++++------------
>  2 files changed, 19 insertions(+), 19 deletions(-)

Always use scripts/get_maintainer.pl when sending patches in.  It would
have saved you time...

Anyway, my tree is closed right now, but I'll look at these once 5.1-rc1
is out, thanks.

greg k-h
