Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9792FC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5222520862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=azazel.net header.i=@azazel.net header.b="fajj1X75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfEWI1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:27:15 -0400
Received: from kadath.azazel.net ([81.187.231.250]:60530 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfEWI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=laWNxyj4QxC3MlDfbc/zEczN2hqihpcdSWmuVHZuqco=; b=fajj1X75+kvgbtjDHr6oPFkEj/
        MiNNaCTInJAOAbPSBJFJazJf3UWePctpC9O2VYE56tXqexuY7RNMBHpu1g3iQhE8+ruQpfM5mm/st
        4PMs3lJ1OpLrijksb19mSp5eE0BZAK7B70NEUnZxRoP7hNXlKt6VcVfeXrwph+qCoXaBtR5+++8o5
        o8c6aLJvwIy4XWpelzJbECR4b2wTZEpdAa2UieNKV/tQqqJGCXeXfvrI9G0sIIBJSHPXpvjuJKME9
        s1wqTgPr0NiYYNxxPxwNhuL7zMEfnilScXqoedZRph5mPROiMfaagi1JR5JFNFiIMi21bqn3h6s+7
        kYC/3/Wg==;
Received: from celephais.dreamlands ([192.168.96.3] helo=azazel.net)
        by kadath.azazel.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jeremy@azazel.net>)
        id 1hTj44-0000Ui-9t; Thu, 23 May 2019 09:27:04 +0100
Date:   Thu, 23 May 2019 09:27:02 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Nishka Dasgupta <nishka.dasgupta@yahoo.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fieldbus: anybuss: Remove unnecessary variables
Message-ID: <20190523082702.GB28231@azazel.net>
References: <20190523063504.10530-1-nishka.dasgupta@yahoo.com>
 <20190523072220.GC24998@kroah.com>
 <b8cc12d9-2fe3-754b-be08-f23055a31ffe@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <b8cc12d9-2fe3-754b-be08-f23055a31ffe@yahoo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 192.168.96.3
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2019-05-23, at 13:51:18 +0530, Nishka Dasgupta wrote:
> On 23/05/19 12:52 PM, Greg KH wrote:
> > On Thu, May 23, 2019 at 12:05:01PM +0530, Nishka Dasgupta wrote:
> > > In the functions export_reset_0 and export_reset_1 in
> > > arcx-anybus.c, the only operation performed before return is
> > > passing the variable cd (which takes the value of a function call
> > > on one of the parameters) as argument to another function. Hence
> > > the variable cd can be removed.  Issue found using Coccinelle.
> > >
> > > Signed-off-by: Nishka Dasgupta <nishka.dasgupta@yahoo.com>
> > > ---
> > >   drivers/staging/fieldbus/anybuss/arcx-anybus.c | 8 ++------
> > >   1 file changed, 2 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> > > index 2ecffa42e561..e245f940a5c4 100644
> > > --- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> > > +++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> > > @@ -87,16 +87,12 @@ static int anybuss_reset(struct controller_priv *cd,
> > >   static void export_reset_0(struct device *dev, bool assert)
> > >   {
> > > -	struct controller_priv *cd = dev_get_drvdata(dev);
> > > -
> > > -	anybuss_reset(cd, 0, assert);
> > > +	anybuss_reset(dev_get_drvdata(dev), 0, assert);
> > >   }
> >
> > While your patch is "correct", it's not the nicest thing.  The way the
> > code looks today is to make it obvious we are passing a pointer to a
> > struct controller_priv() into anybuss_reset().  But with your change, it
> > looks like we are passing any random void pointer to it.
> >
> > So I'd prefer the original code please.
>
> Thank you, I'll drop this patch then.
>
> > Also, you forgot to cc: Sven on this patch, please always use the output
> > of scripts/get_maintainer.pl.
>
> Which arguments should I use? If I use --nokeywords, --nogit,
> --nogit-fallback and --norolestats then only your name and the two
> mailing lists show up.  (Also, regarding the mailing lists: every mail
> sent to linux-kernel@vger.kernel.org is bouncing; should I not send to
> that list anymore?)

He is listed in the TODO:

  $ cat drivers/staging/fieldbus/TODO
  TODO:
  -Get more people/drivers to use the Fieldbus userspace ABI. It requires
   verification/sign-off by multiple users.

  Contact: Sven Van Asbroeck <TheSven73@gmail.com>

J.

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZ8d+2N/NBLDbUxIF0Z7UzfnX9sMFAlzmWU4ACgkQ0Z7UzfnX
9sPxGxAAiDRI2wAkIGuK975XrPrMZwvvlMOXh5wuhf8FoE9y5nOnUchJ+ly61zS/
21kZkjqEj8xySaijYwVSLVVfbB0rbM05b6dhHrscJ4GejDYeHSHvCNDY4j4uJqRW
SpuC5rRq7L4Z7v7AoJMgL8K3WXYdqEcydU3+kx6JodMc6aJfWWzjfLaKF2oQWITH
TsLk9MECPe143qLZe4Y/isjcvd5ixipcCy1wNv7VyXHf6ANWVf5R9LfOCgooe4uG
A4Gu8g9BguUQHJyQR4J3oZjTxUzf/jyrISHBMGSm60miDC0PLUyejHOmV5E+BZ/U
rVU9pZsEux/wfZR4AZkJ5TMF7Yn2bEKEJ4zhXoOHxZPYJi5guxwOe8exy4aBL+o+
OoaU8w2u5GUKkZXk1UT+DtKCuJfk3CKvKNbvrYzbq6jHJTV0y8MZwomGPvPV0PG7
ANBv2PXA0JuazFNzXcmgrBx42+3uaUlqtQrI6rsN1HDVuH8bo2Sbe/L3+eitqTvh
O8hFrQZRpouX9aux0KtMvfvWg+Qg9OXnRBVT15KxCfUvCvG4XWYjfvIjVdWdc392
X2To23kn1GqQ+R4FdVM1PTRQDpNTU0wH3q2WHjN9WWrcbZFFh8Tj2NeQmkAxVIod
wj+2bYR6LLl3/l02zjGAnvYM+g4a3u0iXiokdZxmFpPx772iimE=
=a6AF
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
