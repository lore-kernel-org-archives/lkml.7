Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5AFC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8151120836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552157077;
	bh=nJgnlgcBl3FXXupWdM+ePo4w6VLSfbNnH3M9TbU0X6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1pTvxKqR6YyBOWa47HQfb+modnVfjoESflG+QLU6Rkx9zkpDiAP6cUOZmRUKtXG+t
	 T/28FfHKcwbtoIhEEbgO5wR3V+s0VHOtKxDWsPv1n6PejBOsXpvmXX36rbv+xg/fDi
	 EnLJOJBfikVbw3ZTkUzdLFv7TKRlDqetZYUgWTZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCISog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCISof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:44:35 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67DC20657;
        Sat,  9 Mar 2019 18:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552157074;
        bh=nJgnlgcBl3FXXupWdM+ePo4w6VLSfbNnH3M9TbU0X6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R2WZ4kH1BOAprIbFpORvUU0OWuPl7LcWx4UcGuzvtWpBXFcrCDc09WA1J+hPO+4ls
         m+D2lDGHFDfhwfW0ffVaMsCZaTx2ErMd/rHirvE3tyPOHAjzE2O2XPB2tW7IFh6lS4
         Bqhkd7Cq/96pTX2R0Ho5KjjKtGbh54MvpQdzh97c=
Date:   Sat, 9 Mar 2019 18:44:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anderson Reis <andersonreisrosa@gmail.com>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, matt.ranostay@konsulko.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Lucas Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: [PATCH v2 1/4] iio:potentiostat:lmp91000: remove unnecessary
 parentheses
Message-ID: <20190309184429.5af90912@archlinux>
In-Reply-To: <CAJut9009qPt50o4CDNpkZ=NQVetivYHJMi2pY_DrDUk=WN=XMw@mail.gmail.com>
References: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
        <20190308194655.5983-2-anderson.reis.rosa@usp.com>
        <20190308210425.GB32641@arch>
        <CAJut9009qPt50o4CDNpkZ=NQVetivYHJMi2pY_DrDUk=WN=XMw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 19:26:16 -0300
Anderson Reis <andersonreisrosa@gmail.com> wrote:

> Hi, Tomasz
> 
> thanks for the guidance.
Applied with the description tweaked.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> 
> 
> On Fri, Mar 8, 2019, 18:04 Tomasz Duszynski <tduszyns@gmail.com> wrote:
> 
> > On Fri, Mar 08, 2019 at 04:46:52PM -0300, Anderson Reis wrote:  
> > > From: Lucas Oshiro <lucasseikioshiro@gmail.com>
> > >
> > > Remove unnecessary parentheses on line 116, and solve these  
> > checkpatch.pl
> >
> > No need to explicitly point finger at changed lines. This is what
> > context lines are for.
> >  
> > > CHECKs:
> > >
> > > - lmp91000.c:116: CHECK: Unnecessary parentheses around 'state !=  
> > channel'  
> > > - lmp91000.c:116: CHECK: Unnecessary parentheses around 'channel ==  
> > LMP91000_REG_MODECN_TEMP'  
> > >
> > > Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> > > Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
> > > ---
> > >  drivers/iio/potentiostat/lmp91000.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/potentiostat/lmp91000.c  
> > b/drivers/iio/potentiostat/lmp91000.c  
> > > index 90e895adf997..03d277621861 100644
> > > --- a/drivers/iio/potentiostat/lmp91000.c
> > > +++ b/drivers/iio/potentiostat/lmp91000.c
> > > @@ -113,7 +113,7 @@ static int lmp91000_read(struct lmp91000_data *data,  
> > int channel, int *val)  
> > >               return -EINVAL;
> > >
> > >       /* delay till first temperature reading is complete */
> > > -     if ((state != channel) && (channel == LMP91000_REG_MODECN_TEMP))
> > > +     if (state != channel && channel == LMP91000_REG_MODECN_TEMP)
> > >               usleep_range(3000, 4000);
> > >
> > >       data->chan_select = channel != LMP91000_REG_MODECN_3LEAD;
> > > --
> > > 2.20.1
> > >  
> >  

