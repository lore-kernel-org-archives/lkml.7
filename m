Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DC3C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5AE20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbfHFNKT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:10:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:29072 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731515AbfHFNKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:10:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-31-8SN7SsMjODOE3pGV42hYng-1; Tue, 06 Aug 2019 14:10:15 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 6 Aug 2019 14:10:14 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 6 Aug 2019 14:10:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dan Carpenter' <dan.carpenter@oracle.com>,
        Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "florian.c.schilhabel@googlemail.com" 
        <florian.c.schilhabel@googlemail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>
Subject: RE: [PATCH] rtl8712: rtl871x_ioctl_linux.c: fix unnecessary typecast
Thread-Topic: [PATCH] rtl8712: rtl871x_ioctl_linux.c: fix unnecessary typecast
Thread-Index: AQHVTE2Sh/UbLvavCEKXN3OpolxoRabuFsqQ
Date:   Tue, 6 Aug 2019 13:10:14 +0000
Message-ID: <8d6c6714f9ca46ab90b2a747c05b899b@AcuMS.aculab.com>
References: <20190806013329.28574-1-joseespiriki@gmail.com>
 <20190806115305.GF1974@kadam>
In-Reply-To: <20190806115305.GF1974@kadam>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 8SN7SsMjODOE3pGV42hYng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter
> Sent: 06 August 2019 12:53
> On Mon, Aug 05, 2019 at 10:33:29PM -0300, Jose Carlos Cazarin Filho wrote:
> > Fix checkpath warning:
> > WARNING: Unnecessary typecast of c90 int constant
> >
> > Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
> > ---
> >  Hello all!
> >  This is my first commit to the Linux Kernel, I'm doing this to learn and be able
> >  to contribute more in the future
> >  Peace all!
> >  drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> > index 944336e0d..da371072e 100644
> > --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> > +++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> > @@ -665,8 +665,8 @@ static int r8711_wx_set_freq(struct net_device *dev,
> >
> >  /* If setting by frequency, convert to a channel */
> >  	if ((fwrq->e == 1) &&
> > -	  (fwrq->m >= (int) 2.412e8) &&
> > -	  (fwrq->m <= (int) 2.487e8)) {
> > +	  (fwrq->m >= 2.412e8) &&
> > +	  (fwrq->m <= 2.487e8)) {
> 
> I don't think we can do this.  You're not allowed to use floats in the
> kernel (because they make context switching slow).  I could have sworn
> that we use the -nofp to stop the compile when people use floats but
> this compiles fine for me.

My guess is the 'c90 int constant' text.

It rather implies that '2.412e8' has become the same as '2141200000'.
Which is rather worrying because suddenly 'int_var * 2.4e8' might
be an integer multiply rather than a double one and overflow.
Have the standard people broken code again?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

