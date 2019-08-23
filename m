Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36A3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B182339D
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395422AbfHWOsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:48:11 -0400
Received: from orion.archlinux.org ([88.198.91.70]:36400 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393839AbfHWOsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:48:11 -0400
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id B204C14C6D77B8;
        Fri, 23 Aug 2019 14:48:08 +0000 (UTC)
Received: from saetre (unknown [154.53.1.40])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Fri, 23 Aug 2019 14:48:08 +0000 (UTC)
Message-ID: <3c37ccc992d7979358e8472fbf52a583c6e1068f.camel@archlinux.org>
Subject: Re: [Resubmit] Read battery voltage from Logitech Gaming mice
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pedro Vanzella <pedro@pedrovanzella.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <CAO-hwJ+=dAyFnUfiPSmiGpzYTj=9BPDdeKQOY7UoCOvwQ5CH7Q@mail.gmail.com>
References: <20190822201849.28924-1-pedro@pedrovanzella.com>
         <CAO-hwJKQcTpmk8cVf-YmKu2awXv_53=qfpy2yfmy2rgMu_DEug@mail.gmail.com>
         <e6014a01-1094-9ec7-9b37-2abdf70e305f@pedrovanzella.com>
         <CAO-hwJ+=dAyFnUfiPSmiGpzYTj=9BPDdeKQOY7UoCOvwQ5CH7Q@mail.gmail.com>
Organization: Archlinux
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZL5yhscn243euPwV8D1/"
Date:   Fri, 23 Aug 2019 15:48:07 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.32.4 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZL5yhscn243euPwV8D1/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-23 at 16:32 +0200, Benjamin Tissoires wrote:
> The problem I have with quirks, and that I explained to Filipe on IRC
> is that this is kernel ABI. Even if there is a very low chance we have
> someone using this, re-using the same drv_data bit in the future might
> break someone's device.

But we can reserve those bits. I don't expect there to be a ton of
devices that need to be quirked, so using the remaining bits should be
perfectly fine. Do you agree?

--=-ZL5yhscn243euPwV8D1/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl1f/J4ACgkQ+JPGdIFq
qV1G+g//WbYJozb4H2J6ysdXZTZSMtds+YY9NHGZ6oA7l4GPAiiIIBHl7NCdY5c1
F3J+MwhKjk+UrDx/CoLcJUbi1qcRamThb1CULX5PZgE4orvNZ02CNvfZPMF2I60G
1tj9bAyJft80sgB7fnLHnLUuhNDhQvALqFTlVZPUc9mcAWr85YJkp1GX215Woxa/
En5TyPZd9G/mLpTx+FzHHtCXfhHLkrIwe1E26bnAKyifdsNPX/Zat2WcglgTFZu8
kZwXVIUOtzqqawLUzFcfjTdiSmzqpsbmWW1ohFQCQLAMy9Xeg6syBlLBbeb7Pcxm
vxHXAObpyBazshnxtwjrAKqzV8Erjijy5mncOZ1USQQAEgwObZgJAgDZvrI3d3jc
24DtU/CbEMSGkQzVMa5oh3rwHjjVbW+k7gVrINCgY8d0woQvKw7EJ6cPp5yy2agO
mZLA5DzhFrHsiwQHbzYpDmtnbARJImUi0CTEi5+dEU05IrZZTdduUfwfmeUf7q9m
Y4kGBfG8HFHXBcONrl93cTpwNb3U8ZIYkd1aoG/W7Lmkas2rPakqRO1Tu9Aoe8xm
A2VecXM0nh/Z0mbZYk6fgjSkiOwEygUHtxXW5OalNcN5Eqw0rTy6lomgfNZMTFFj
DfRjzfKzMitVDFWrVP7hEQv23OmcVTqWNvLaspQ9+eCMtTC1jDs=
=aZob
-----END PGP SIGNATURE-----

--=-ZL5yhscn243euPwV8D1/--
