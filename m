Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HTML_ATTACH autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC9ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14072080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfKAKAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:00:43 -0400
Received: from palmtree.beeroclock.net ([178.79.160.154]:43818 "EHLO
        palmtree.beeroclock.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfKAKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:00:43 -0400
Received: from mailpile.local (palmtree.beeroclock.net [IPv6:2a01:7e00::f03c:91ff:fe93:f66c])
        by palmtree.beeroclock.net (Postfix) with ESMTPSA id 310AF1F5F4;
        Fri,  1 Nov 2019 10:00:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==XWc4LnSndNetJSQtLBzrXgdspr5mXY==";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [PATCH 2/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2
From:   Karl Palsson <karlp@tweak.net.au>
To:     "Chen-Yu Tsai" <wens@csie.org>
Cc:     "Maxime Ripard" <mripard@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAGb2v67PLemQvj+SOF2h_cfc4HcnAyvs866Bas7GRUF9Y1Lo1A@mail.gmail.com>
References: <CAGb2v67PLemQvj+SOF2h_cfc4HcnAyvs866Bas7GRUF9Y1Lo1A@mail.gmail.com>
User-Agent: Mailpile
Message-Id: <FbCSL9o7LLRZJoCAokdTzGW6y5cRWs88rHTPoqG2238c@mailpile>
Date:   Fri, 01 Nov 2019 10:00:33 -0000
OpenPGP: id=9F020B9C40DA5E6F2CAF63B319A8B50FD4D5CAF6; preference=signencrypt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==XWc4LnSndNetJSQtLBzrXgdspr5mXY==
Content-Type: multipart/mixed; boundary="==YNFVxqfDdewuHhTDfY9tCavnXqx3Gk=="
Subject: Re: [PATCH 2/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2
From: Karl Palsson <karlp@tweak.net.au>
To: "Chen-Yu Tsai" <wens@csie.org>
Cc: "Maxime Ripard" <mripard@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAGb2v67PLemQvj+SOF2h_cfc4HcnAyvs866Bas7GRUF9Y1Lo1A@mail.gmail.com>
References: <CAGb2v67PLemQvj+SOF2h_cfc4HcnAyvs866Bas7GRUF9Y1Lo1A@mail.gmail.com>
User-Agent: Mailpile
Date: Fri, 01 Nov 2019 10:00:33 -0000
OpenPGP: id=9F020B9C40DA5E6F2CAF63B319A8B50FD4D5CAF6; preference=signencrypt

--==YNFVxqfDdewuHhTDfY9tCavnXqx3Gk==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Chen-Yu Tsai <wens@csie.org> wrote:

(will fix all other comments)

> > +               // on opi-win, shutdown is pl4, is BT-RST-N is moduel pin 34
> > +               // YES; PG13 is correct.
> 
> I'm guessing all these comments are from your development
> cycle? Please remove them.

Yes, gross mistake squishing it all and rebasing, my apologies.

> 
> > +               shutdown-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
> > +       };
> > +};
> 
> The board also has SPI flash. Can you add that as well?

It doesn't come mounted standard, it's just a blank footprint, so
I felt it should be left out?

Sincerely,
Karl Palsson
--==YNFVxqfDdewuHhTDfY9tCavnXqx3Gk==--

--==XWc4LnSndNetJSQtLBzrXgdspr5mXY==
Content-Type: application/pgp-signature; name="OpenPGP-digital-signature.html"
Content-Description: OpenPGP Digital Signature
Content-Disposition: attachment; filename="OpenPGP-digital-signature.html"

<html><body><h1>Digital Signature</h1><p>

This is a digital signature, which can be used to verify
the authenticity of this message. You can safely discard
or ignore this file if your e-mail software does not
support digital signatures.

</p><pre>
-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEnwILnEDaXm8sr2OzGai1D9TVyvYFAl28Ai8ACgkQGai1D9TV
yvZqZRAAqzoj/fQIFzqbUDDwOJzUdS2I5t3imDOuMjRM7d27AXwN+Dj6lrtMMzR9
0ZFQ1z3fGELU1CwCkRyrnmLeSt4ttIxK4IgpAZ2lMPe9+gH58SzXDDvKxVN+xRSn
nczcYHYlB8/7GX3f/PA1RJiGgpSdI8q/cCVKQVRIU4SkCLU6s+05Dip6DtWJrijO
W/f/Bvwx/gqMXwYhcYnr8cVqphYr8a+URtpneHpM52IgygPDC0JujDD3Pm3K7m9E
7WM9LYxHyk+VzI2brQBqHfaWQUr7X43LB/HkEmALO/QDFBeL9ap05TLrXaGHptxK
f5rVw94zucQAsLGLVNGmEDBmOsAQUvQ0NcAg73ZUO66uBhV1l4e4tlcUsYgtVoQw
GQmqno8Rzbslll2nnMyTLNXdj9ICywSWeykpD9dFcrkRx/PjFshk8GFW2uYIPRGQ
U0RH+mqatGgqe+icELR2E6OHtIF0li/Pk3/Cq3nG9Zln+KO60MFx3cCR3F5e0Yon
GUN678VD1zRwER+2EVIr2bVdZQIkjpjXsmTbk8upTr75nlm7QQuBfWD4ElZZiluA
LuP3DEb6SuxWmPkb60R6BaMMYXE880nQx8R7cabtpQ4fv35Vy7KmnJaPLg3ti4qK
qVDO8XL300QN6b5R8b7JvXblcymfS/LWL9usCFPKnQWusKdBIho=
=n1cL
-----END PGP SIGNATURE-----

</pre><hr><i><a href='https://www.mailpile.is/'>Generated by Mailpile</a>.</i></body></html>
--==XWc4LnSndNetJSQtLBzrXgdspr5mXY==--

