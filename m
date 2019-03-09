Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D708EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA7920815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552153690;
	bh=K1bxJb8OW+tClNhftMqE0139mWDhsgtgRDTEGBocZZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PVybewi6nsq5Z2HKPl6VEr+LgBkesYdff1CUJ14FJ3YyJI4W90KeR1ag3v4EMIMl0
	 51PrnmBc75MQqsKtisKxIOV7tK8N00DeuvyVY/FJR+UTJZLtfI72/J0ip5MWHCfeei
	 ioD4nWQzxhUMNAMF/rdUhMUHfXNzTPl4T3ag63YY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCIRsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:48:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfCIRsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:48:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CE3207E0;
        Sat,  9 Mar 2019 17:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552153686;
        bh=K1bxJb8OW+tClNhftMqE0139mWDhsgtgRDTEGBocZZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o9pFD+2zSZwyzZeA4B0MlFCbqrEzBA2/hagiv9TeuGCZRS0dmRhcOJUp0IGo1tbV9
         VnXNHDFtNuZjT/yh+MSg3kcPb8qIM1gktNZY3PhuTBmDVzbaOaG6c0CqNgTSHYRx0G
         We+JnJNl42S1jxdjuhRNFdD5VLyeADYs9fRC/Nw4=
Date:   Sat, 9 Mar 2019 17:47:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Subject: Re: [PATCH v4 4/9] staging:iio:ad7780: add chip ID values and mask
Message-ID: <20190309174759.2c6b1435@archlinux>
In-Reply-To: <20190309001928.uhwia4ujvqqwawlg@renatolg>
References: <cover.1551358569.git.renatogeh@gmail.com>
        <90c573cd53bb54d49de6ac270bcff66880ccfeb5.1551358569.git.renatogeh@gmail.com>
        <190e26b19b8ed6559b92d3a000d852bbb0099a52.camel@analog.com>
        <20190303140107.ljjo3flatwmd44ya@renatolg>
        <20190303145347.41d49646@archlinux>
        <13ef212f8aeebd0c893be253cb4834a3e4d741b8.camel@analog.com>
        <20190309001928.uhwia4ujvqqwawlg@renatolg>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 21:19:29 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> On 03/04, Ardelean, Alexandru wrote:
> >On Sun, 2019-03-03 at 14:53 +0000, Jonathan Cameron wrote:  
> >> [External]
> >>
> >>
> >> On Sun, 3 Mar 2019 11:01:09 -0300
> >> Renato Lui Geh <renatogeh@gmail.com> wrote:
> >>  
> >> > On 03/01, Ardelean, Alexandru wrote:  
> >> > > On Thu, 2019-02-28 at 11:24 -0300, Renato Lui Geh wrote:  
> >> > > >
> >> > > >
> >> > > > The ad7780 supports both the ad778x and ad717x families. Each chip
> >> > > > has
> >> > > > a corresponding ID. This patch provides a mask for extracting ID
> >> > > > values
> >> > > > from the status bits and also macros for the correct values for the
> >> > > > ad7170, ad7171, ad7780 and ad7781.
> >> > > >
> >> > > > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> >> > > > ---
> >> > > >  drivers/staging/iio/adc/ad7780.c | 8 ++++++--
> >> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> >> > > >
> >> > > > diff --git a/drivers/staging/iio/adc/ad7780.c
> >> > > > b/drivers/staging/iio/adc/ad7780.c
> >> > > > index 56c49e28f432..ad7617a3a141 100644
> >> > > > --- a/drivers/staging/iio/adc/ad7780.c
> >> > > > +++ b/drivers/staging/iio/adc/ad7780.c
> >> > > > @@ -26,10 +26,14 @@
> >> > > >  #define AD7780_RDY             BIT(7)
> >> > > >  #define AD7780_FILTER          BIT(6)
> >> > > >  #define AD7780_ERR             BIT(5)
> >> > > > -#define AD7780_ID1             BIT(4)
> >> > > > -#define AD7780_ID0             BIT(3)
> >> > > >  #define AD7780_GAIN            BIT(2)
> >> > > >
> >> > > > +#define AD7170_ID              0
> >> > > > +#define AD7171_ID              1
> >> > > > +#define AD7780_ID              1
> >> > > > +#define AD7781_ID              0
> >> > > > +
> >> > > > +#define AD7780_ID_MASK         (BIT(3) | BIT(4))  
> >> > >
> >> > > This also doesn't have any functionality change.
> >> > > The AD7170_ID, AD7171_ID, AD7780_ID & AD7781_ID IDs are also unused
> >> > > (maybe
> >> > > in a later patch they are ?).  
> >> >
> >> > They aren't. I added them following a previous review suggestion.
> >> > Should
> >> > I remove them?  
> >>
> >> Can we check them?  It's always useful to confirm that the device is
> >> the one you think it is.  Then we can either use what is there
> >> with a suitable warning, or if that is tricky just fault out as the
> >> dt is giving us the wrong part number.
> >>
> >> J  
> >
> >I guess `dev_warn_ratelimited()` could be used to make sure syslog isn't
> >spammed-to-death when doing multiple conversions, and the ID isn't correct.
> >Since these IDs are read after you get a sample, I'm a bit fearful of log-
> >spam.
> >
> >I wouldn't throw an error in the ad7780_postprocess_sample() for this, but
> >warning [with rate-limit] sounds reasonable.  
> 
> Looking at dev_warn_ratelimited's definition (and its use in other parts
> of the kernel), I see that we'd need the device to be stored somewhere
> (perhaps in ad7780_state?) in order for us to pass it as argument to
> dev_warn from within postprocess_sample. Should this be stored in
> ad7780_state?  Or can I get the spi_device some other way?
Ah. I was being lazy and hadn't looked at the datasheet.

If they are that nasty to get to, don't bother checking them.
Mostly we can assume people don't claim to have the wrong
compatible device.

Jonathan

> >  
> >>  
> >> > >
> >> > > I would also leave the AD7780_ID1 & AD7780_ID0 definitions in place,
> >> > > since
> >> > > they're easier matched with the datasheet.
> >> > >  
> >> > > >
> >> > > >  #define AD7780_PATTERN_GOOD    1
> >> > > >  #define AD7780_PATTERN_MASK    GENMASK(1, 0)
> >> > > > --
> >> > > > 2.21.0
> >> > > >  
> >>
> >>  

