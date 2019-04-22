Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4B4C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EA820874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555930109;
	bh=erHdP+oBPZSeJqL39m8/SsQdX5DS7XHgupRVSoSNFRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ckp0YPYyX+1OpqDG7yvOAylHPPZM6xL7QFf75LBX04XXHLL6FqFMEqN7P+F+kZx5M
	 EyzIgNTbtzp7N8SlCSPZqOoA/zmxm0fFjKTR4E4Ej5nqLheF4UI1O2zy4Mq79CCPoD
	 E1NQz8vShcDtlbYWYSdmodk9Vz8pVkF2NjeqLqf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDVKs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVKs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:48:27 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 385A620811;
        Mon, 22 Apr 2019 10:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555930106;
        bh=erHdP+oBPZSeJqL39m8/SsQdX5DS7XHgupRVSoSNFRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xwxiCWXAKXfkbz7PZi41leF9++F8i1xQ6YhNILl6e/elRzoPo6tnG1yGuEfJJNjNV
         ROqq77UB22LlOHJcNb813Oub8Ew4H0XHO6Y/vSdVJaoo1gNpuV+6mrnkAfIcq8oF1c
         h7Qi5Gl4pGQ+xcgdXCuGFcMRpCzV9B3kCkrbunD8=
Date:   Mon, 22 Apr 2019 11:48:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Mohan Kumar <mohankumar718@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: proximity: This patch fix the following
 checkpatch warning.
Message-ID: <20190422114821.5955d4fa@archlinux>
In-Reply-To: <CAJCx=gmi6=uXbydpE2gY2x-XijtAd=bfufoJ+gbO1KU1n++g3Q@mail.gmail.com>
References: <1555524925-15450-1-git-send-email-mohankumar718@gmail.com>
        <CAJCx=gmi6=uXbydpE2gY2x-XijtAd=bfufoJ+gbO1KU1n++g3Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 16:23:51 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> See comments inline
> 
> On Wed, Apr 17, 2019 at 11:15 AM Mohan Kumar <mohankumar718@gmail.com> wrote:
> >
> > As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
> > up to 20ms. so use usleep_range.
> >
> > Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> > ---
> >  drivers/iio/proximity/mb1232.c | 2 +-
> >  drivers/iio/proximity/srf08.c  | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> > index 166b3e6..74f7eae 100644
> > --- a/drivers/iio/proximity/mb1232.c
> > +++ b/drivers/iio/proximity/mb1232.c
> > @@ -81,7 +81,7 @@ static s16 mb1232_read_distance(struct mb1232_data *data)
> >                 }
> >         } else {
> >                 /* use simple sleep if announce irq is not connected */
> > -               msleep(15);
> > +               usleep_range(15000, 20000);  
> 
> This is actually less than ideal.. because usleep_range uses the
> hrtimers which forces an interrupt.
> 
> Unless you actually need to read between 15ms and 20ms it is best just
> to leave the msleep() as it is, and let it take a bit longer
> if required.
Good response.  Perhaps Mohan could follow up with a patch to add
a comment to this effect to save anyone else trying to 'fix' this
issue in future?

Thanks,

Jonathan
> 
> - Matt
> 
> >         }
> >
> >         ret = i2c_master_recv(client, (char *)&buf, sizeof(buf));
> > diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> > index f2bf783..605a582 100644
> > --- a/drivers/iio/proximity/srf08.c
> > +++ b/drivers/iio/proximity/srf08.c
> > @@ -150,7 +150,7 @@ static int srf08_read_ranging(struct srf08_data *data)
> >          * polling for not more than 20 ms should be enough
> >          */
> >         waittime = 1 + data->range_mm / 172;
> > -       msleep(waittime);
> > +       usleep_range(waittime * 1000, (waittime * 1000) + 2000);
> >         for (i = 0; i < 4; i++) {
> >                 ret = i2c_smbus_read_byte_data(data->client,
> >                                                 SRF08_READ_SW_REVISION);
> > @@ -158,7 +158,7 @@ static int srf08_read_ranging(struct srf08_data *data)
> >                 /* check if a valid version number is read */
> >                 if (ret < 255 && ret > 0)
> >                         break;
> > -               msleep(5);
> > +               usleep_range(5000, 15000);
> >         }
> >
> >         if (ret >= 255 || ret <= 0) {
> > --
> > 2.7.4
> >  

