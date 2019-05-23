Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9437AC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47502217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558596484;
	bh=NOvXott0D9tjo6Zrqp6W2nvmyfgz4981kAidWgHl2lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EtTryvZ6KTaK8l9vKZ1ICQsPx5dP14KP0/UUvx43q9608dd0OOQGOhjEWDGLVzma8
	 SHWipbKKMTcT4QQIGWrciPJyjCnSn9Uy3z7foZa3RNLZW9f5X+u/9g+M57xdQ4QwMp
	 kSNEGH7zMT3MGjnm+BRg5EmkgrMSv4Raq6rl6vvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfEWH2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfEWH2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:28:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB092168B;
        Thu, 23 May 2019 07:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558596482;
        bh=NOvXott0D9tjo6Zrqp6W2nvmyfgz4981kAidWgHl2lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qSZHl4+l6q58tS08AulWiom5YQUviMyftpy2Yx393ooSdrh9XudIVusSF07GuRhIa
         zOOthMRZJeD1KJqWcmYxlJ19oO/4ucY9o5nhitHxEmLGmiArqgfGyv1Gt6kUQerysG
         aenpCRBGGqB0xktIA35VRm5sPJb5OMuPcjEZO/3o=
Date:   Thu, 23 May 2019 09:27:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: kpc2000: fix indent in cell_probe.c
Message-ID: <20190523072759.GA16656@kroah.com>
References: <20190522205849.17444-1-simon@nikanor.nu>
 <20190522205849.17444-2-simon@nikanor.nu>
 <20190523072625.GA16429@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523072625.GA16429@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 09:26:25AM +0200, Greg KH wrote:
> On Wed, May 22, 2019 at 10:58:44PM +0200, Simon Sandström wrote:
> > Use tabs instead of spaces for indentation.
> > 
> > Signed-off-by: Simon Sandström <simon@nikanor.nu>
> > ---
> >  drivers/staging/kpc2000/kpc2000/cell_probe.c | 574 +++++++++----------
> >  1 file changed, 287 insertions(+), 287 deletions(-)
> > 
> > diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> > index 0181b0a8ff82..6e034d115b47 100644
> > --- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
> > +++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> > @@ -25,7 +25,7 @@
> >   *                                                              D                   C2S DMA Present
> >   *                                                               DDD                C2S DMA Channel Number    [up to 8 channels]
> >   *                                                                  II              IRQ Count [0 to 3 IRQs per core]
> > -                                                                      1111111000
> > + *                                                                    1111111000
> >   *                                                                    IIIIIII       IRQ Base Number [up to 128 IRQs per card]
> >   *                                                                           ___    Spare
> >   *
> 
> This chunk does not match what you said this commit did :(
> 
> Please fix up and resend.

Actually, wait, rebase and resend after I apply your other patches.
I'll hand-edit this patch to remove this chunk as your other fixes are
good...

thanks,

greg k-h
