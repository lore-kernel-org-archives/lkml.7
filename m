Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E24C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712D2218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="jbAM7o/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfDXJXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:23:39 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53482 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfDXJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:23:38 -0400
Received: by mail-it1-f193.google.com with SMTP id z4so873575itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DauuNczlRd9X8buzI4xdSHwEG9c8tCZ2JlYBlpW6XHM=;
        b=jbAM7o/jMWtDNPN71AU7EcKbPEPfOvzM9x9Bwgv7w8iIv14glHWomJsz8FQzvaEwc7
         CvsGTHmh+qRjyd1wKzANoPEBn9hztP6JCe9P2Js+h7/lvAPZm9HqnSCyuod2Ua+MRsAC
         RDWyKmn2GX3U6zMdHdp3n1pPfaJxOlvME7dfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DauuNczlRd9X8buzI4xdSHwEG9c8tCZ2JlYBlpW6XHM=;
        b=CUGycDlWPG9yID9FHIEPir1+6PJg3qVqxWXSfAZMmw9rnGIiV1dmLHz7QMXltPd4Tu
         43HLnmJewXE5nrZDrANKgniuqojqX6ymiqgLGzBFYfrlH1/xPD5NHLYVAVL91L37riyu
         pxRSqukVcmjyKoe4UVVdDXZhJ8hIj2kDIctf7N/Tm+T4soAdZAHeqQcdFNcQ8L4zEJD5
         7SOeD92+0GzeaYEXgh1jubSbGEXBF37Y2nC9VFMXC88MJfnsI7/9YKEoI/8OUuBbzt7h
         vnbpYgiKh4gb/j9/U+S5T2yhKY/1b1nfiuJlFIgOjKB75YmgqsF+tvtKyDZcPspgxh1e
         jUdw==
X-Gm-Message-State: APjAAAUL1ASDahTnKup0/oyoJEFUyG/NAAySAG19pwG+5U1J7KNkKBel
        3U9N5DW97lueJ7w6FVINYDK0yhzufiAkZkwo2kzpSw==
X-Google-Smtp-Source: APXvYqzjLJ8vwMexMemwHkt6YTrRa37njJ4Z0PN+iUwfptrXohQ0V4k1sNaTeSY+EZNeB+TY2tmG95/ocRHghGrfjtc=
X-Received: by 2002:a05:660c:209:: with SMTP id y9mr6066409itj.31.1556097817751;
 Wed, 24 Apr 2019 02:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <1555524925-15450-1-git-send-email-mohankumar718@gmail.com>
 <CAJCx=gmi6=uXbydpE2gY2x-XijtAd=bfufoJ+gbO1KU1n++g3Q@mail.gmail.com> <20190422114821.5955d4fa@archlinux>
In-Reply-To: <20190422114821.5955d4fa@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Wed, 24 Apr 2019 17:23:26 +0800
Message-ID: <CAJCx=g=8WEAVxdhOQni1gd2D-mTbuc8kTa6nQhF3nQ9JfGDJKg@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: proximity: This patch fix the following
 checkpatch warning.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mohan Kumar <mohankumar718@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 6:48 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 18 Apr 2019 16:23:51 -0700
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> > See comments inline
> >
> > On Wed, Apr 17, 2019 at 11:15 AM Mohan Kumar <mohankumar718@gmail.com> wrote:
> > >
> > > As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
> > > up to 20ms. so use usleep_range.
> > >
> > > Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> > > ---
> > >  drivers/iio/proximity/mb1232.c | 2 +-
> > >  drivers/iio/proximity/srf08.c  | 4 ++--
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> > > index 166b3e6..74f7eae 100644
> > > --- a/drivers/iio/proximity/mb1232.c
> > > +++ b/drivers/iio/proximity/mb1232.c
> > > @@ -81,7 +81,7 @@ static s16 mb1232_read_distance(struct mb1232_data *data)
> > >                 }
> > >         } else {
> > >                 /* use simple sleep if announce irq is not connected */
> > > -               msleep(15);
> > > +               usleep_range(15000, 20000);
> >
> > This is actually less than ideal.. because usleep_range uses the
> > hrtimers which forces an interrupt.
> >
> > Unless you actually need to read between 15ms and 20ms it is best just
> > to leave the msleep() as it is, and let it take a bit longer
> > if required.
> Good response.  Perhaps Mohan could follow up with a patch to add
> a comment to this effect to save anyone else trying to 'fix' this
> issue in future?

Change of the warning message in the checkpatch.pl script you mean?

- Matt

>
> Thanks,
>
> Jonathan
> >
> > - Matt
> >
> > >         }
> > >
> > >         ret = i2c_master_recv(client, (char *)&buf, sizeof(buf));
> > > diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> > > index f2bf783..605a582 100644
> > > --- a/drivers/iio/proximity/srf08.c
> > > +++ b/drivers/iio/proximity/srf08.c
> > > @@ -150,7 +150,7 @@ static int srf08_read_ranging(struct srf08_data *data)
> > >          * polling for not more than 20 ms should be enough
> > >          */
> > >         waittime = 1 + data->range_mm / 172;
> > > -       msleep(waittime);
> > > +       usleep_range(waittime * 1000, (waittime * 1000) + 2000);
> > >         for (i = 0; i < 4; i++) {
> > >                 ret = i2c_smbus_read_byte_data(data->client,
> > >                                                 SRF08_READ_SW_REVISION);
> > > @@ -158,7 +158,7 @@ static int srf08_read_ranging(struct srf08_data *data)
> > >                 /* check if a valid version number is read */
> > >                 if (ret < 255 && ret > 0)
> > >                         break;
> > > -               msleep(5);
> > > +               usleep_range(5000, 15000);
> > >         }
> > >
> > >         if (ret >= 255 || ret <= 0) {
> > > --
> > > 2.7.4
> > >
>
