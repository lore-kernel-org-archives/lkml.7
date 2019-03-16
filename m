Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5396AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A120218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552754290;
	bh=/t0HOwvVX1Diuw1nVzA0mSALB4zSztVNwiXVGUDOsNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OM1kkGo9sylVu+f/BvbhhizhSWs3ufeR3GFPk8TBm0PbzgkH3dXFmdCP0tYJEdjCt
	 JvOcPPoce96lGtYE3Ub+kpL9thG49Z5c9M1Pq1xYvOKAbbZ4BfgavoYcYSZWcLavYZ
	 92n2iXGMlOQep8YGufFdjwN2UBFIJfw1StDChlFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfCPQiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfCPQiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:38:08 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAAE62186A;
        Sat, 16 Mar 2019 16:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552754286;
        bh=/t0HOwvVX1Diuw1nVzA0mSALB4zSztVNwiXVGUDOsNY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xyPNW5tX+lRCGQywysENCWOF+QoGab7bBWiHYjXZFyCi+zNw62OziVyHHZBP/CEUz
         5wv0lxgWhVHRjQFHHcp9yNAqIFwqbW0PCbXliTasejjryjTiAmtTEZB9oohCdAF9Io
         VRIUOlMUV0DSa0125I+bE38mG5YvnawAuMx41O0A=
Date:   Sat, 16 Mar 2019 16:38:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Cc:     "colin.king@canonical.com" <colin.king@canonical.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: fix indentation issue, remove extra tab
Message-ID: <20190316163801.42dcfabd@archlinux>
In-Reply-To: <1552641938.13791.2.camel@analog.com>
References: <20190314232603.30531-1-colin.king@canonical.com>
        <1552641938.13791.2.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 09:25:38 +0000
"Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:

> On Jo, 2019-03-14 at 23:26 +0000, Colin King wrote:
> > [External]
> >=20
> >=20
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > A return statement is indented one level too deeply; clean this
> > up by removing a tab.
> >=20
> > Signed-off-by: Colin Ian King <colin.king@canonical.com> =20
> Acked-by: Stefan Popa <stefan.popa@analog.com>
>=20
Applied thanks.

Jonathan

> Thanks!
>=20
> > ---
> > =C2=A0drivers/iio/adc/ad7124.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index 7d5e5311d8de..659ef37d5fe8 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -411,7 +411,7 @@ static int ad7124_init_channel_vref(struct
> > ad7124_state *st,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dev_err(&st->sd.spi->dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"Error, trying to use exter=
nal voltage
> > reference without a %s regulator.\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ad7124_ref_names[refsel]);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(st->vref[refsel]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 PTR_ERR(st->vref[refsel]);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0st->channel_config[channel_number].vref_mv =3D
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
regulator_get_voltage(st->vref[refsel]);
> > --
> > 2.20.1
> > =20

