Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58332C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DA2218CD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554636415;
	bh=sIONTX6H5uUv4pMRgGFQC6jf6RsdT0Kup7QG7ooGzSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mw/nELPPApGO87VHFlLZ1k7Ph8HhaHj05/TKtJQgvfB09URguh74qMoiECpzXsG5N
	 Luo1FS7YMYNf9LXzrIqW+jzC6kTPb6QJR/K6VoQPX+ZAwKNe0txEH6abrDBnC2oRir
	 2l6iflQ3ExjxGBthUyYo4744J82kTVZP6e9wUNDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfDGL0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGL0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:26:53 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416CF213F2;
        Sun,  7 Apr 2019 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554636412;
        bh=sIONTX6H5uUv4pMRgGFQC6jf6RsdT0Kup7QG7ooGzSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Al98cl//lJqTi6rkuJDGnTPdbOUOX8No+tra6yCd+e5aS3HzRYNp2jT9gUp26tcF3
         5RRuLce2IlR2QW2JXBTQkEQprvR3M8Am8HCM2laFb0UPuUaRP2HrNATsMYXT/fWJXN
         60TAgDNJDzbsxWl0+VyABaXKKG3z+41owc+HSmUA=
Date:   Sun, 7 Apr 2019 12:26:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Mukesh Ojha <mojha@codeaurora.org>, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 2/4] staging: iio: ad9832: add SPDX identifier
Message-ID: <20190407122636.20e36147@archlinux>
In-Reply-To: <20190402144000.pjtygmqi4pxn2p5j@smtp.gmail.com>
References: <20190401143724.mcn73jhdtq3zp3nk@smtp.gmail.com>
        <ac167cc8-4236-2e15-d5f2-fa222d95da49@codeaurora.org>
        <20190401171355.GA19716@kroah.com>
        <20190402144000.pjtygmqi4pxn2p5j@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 11:40:00 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 04/01, Greg KH wrote:
> > On Mon, Apr 01, 2019 at 08:36:50PM +0530, Mukesh Ojha wrote:  
> > > 
> > > On 4/1/2019 8:07 PM, Marcelo Schmitt wrote:  
> > > > Add SPDX identifier of GPL-2.0 for the ad9832 driver.
> > > > 
> > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > > ---
> > > >   drivers/staging/iio/frequency/ad9832.c | 3 +--
> > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > > > index 50a583020072..d8d4a7936275 100644
> > > > --- a/drivers/staging/iio/frequency/ad9832.c
> > > > +++ b/drivers/staging/iio/frequency/ad9832.c
> > > > @@ -1,9 +1,8 @@
> > > > +// SPDX-License-Identifier: GPL-2.0  
> > > 
> > > FYI
> > > 
> > > Use C notations here as per https://lkml.org/lkml/2019/2/13/570.
> > > 
> > > <https://lkml.org/lkml/2019/2/13/570>  
> 
> OK, I'll check it out.
> 
> > > 
> > > Once you fix it then you can take mine
> > > Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>  
> > 
> > Did you read the documentation about how to put a proper SPDX line in
> > the kernel documentation?  For .c files, you have to use "//", not "/* */"
> > 
> > Please read:
> > 	Documentation/process/license-rules.rst
> > and see the section "Style" for all of the details.  
> 
> Thanks, I'll read it to understand the details.
> 
> > 
> > thanks,
> > 
> > greg k-h  
> 
> Thanks for the advises,
> 
> Marcelo
Greg cleaned up all the remaining IIO staging drivers SPDX entries
later in the week, so this one is no longer needed.

Thanks,

Jonathan


