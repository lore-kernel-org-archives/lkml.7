Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2291AC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE49E20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ZV0xfoo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDLFbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 01:31:50 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:34836 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfDLFbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 01:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R91wb3xUa5htKq9djRgpWzXjsd8bpzhoUX30u1hy17U=; b=ZV0xfoo2hHvNcGgdNCQ0vi04e
        iwq3jAFeoHOby8JpoijZjAjM2GWCgQSjK+/2VePXHSwgTRN9ynlFSWILK+vwRDxwxSWJsApQnBHsd
        oPLui2fxEGB8oO1V4irSvkg+tO0En+BwBOeoCG4PNahPc4dfaw8yVouBsZPQL26bQ4/Mg=;
Received: from [77.247.85.102] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hEomq-00035v-V4; Fri, 12 Apr 2019 07:31:41 +0200
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hEomm-0003aD-Fr; Fri, 12 Apr 2019 07:31:36 +0200
Date:   Fri, 12 Apr 2019 07:31:24 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: sun8i: h3: bluetooth for Banana Pi M2 Zero
 board
Message-ID: <20190412073124.6f04e105@kemnade.info>
In-Reply-To: <20190408081404.554zdbcotnidljsl@flea>
References: <20190301185212.26837-1-andreas@kemnade.info>
        <20190407222321.11ec297d@kemnade.info>
        <20190408081404.554zdbcotnidljsl@flea>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Wej8p2Dft83Sj2Tb9NyHpdn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wej8p2Dft83Sj2Tb9NyHpdn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 8 Apr 2019 10:14:04 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Sun, Apr 07, 2019 at 10:23:21PM +0200, Andreas Kemnade wrote:
> > ping
> >
> > On Fri,  1 Mar 2019 19:52:12 +0100
> > Andreas Kemnade <andreas@kemnade.info> wrote:
> > =20
> > > The Banana Pi M2 Zero board has an AP6212 BT+Wifi combo chip
> > > with broadcom internals attached to UART1 and some gpios.
> > > This addition is in line with similar boards
> > >
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info> =20
>=20
> I never received that patch, who did you send it to?
>=20
Seems that I only have sent you the first version of that patch. Somehow
I must have left you out during copy and paste of adresses.

Regards,
Andreas

--Sig_/Wej8p2Dft83Sj2Tb9NyHpdn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlywIq0ACgkQl4jFM1s/
ye+X4Q//UYhkarSSxswTQLL7gML8IvH4+OF+6Gbi3CsW86AZ7vq9FElGvcWpXusC
rQQQGt6oAfA1Nyc1JGTZB3tNoBjAQJ2xqFtLNVbixUNIs+dOeRrBnj3hAmIae0ko
gqBkKdwGCwvrLk2u4F1B06IES34cV+PO4jZCSrifUIwmu5CqqXo6Wt0kdHMpeViG
7cIwSF8K3+J0smj0muJgGtHnoPzRm2oQjXImcp4Akb3edVXkAJSVM2Z4cRbJvbzU
NnBMG9vpB3MXTZp6jwd//vDl4eyIAsIn+RxcAvlpvXiGtTAWqwpSspFrbyw35LcS
8UTU67ApH13KKs+0+5uSzAd2Q3iBWKUHaGnvxwSYJGu0VcpKLafzbx/UzRGkqWtU
j/c0tjujvL4DXUUg1LdWSf9w4o1meIaTBkRwR6HYLnWcskvsfDSlqTdmnFwA36Vn
/NVPSiVFOu0+8e+S/HJhZl2YLEcR6UDCqbh9BBSNfRcOd4awEbGFQcO4114H6e9v
iGxrJrk2JQuGg0nBn8mVoUlhJNBuYm/Ns+agQso2XrxmVCdPSo7llnzaNPQdz4h6
2cMNV+T1YynsxAqUjyguWPNxukIiWD79aurbTE27nT3G8BJw4heu7+8W2THVCCge
SzRidYL5fjKy2hZd8hB8F84u2f//d9C4p2vlREZwJ2kfxzTpFAs=
=gLI5
-----END PGP SIGNATURE-----

--Sig_/Wej8p2Dft83Sj2Tb9NyHpdn--
