Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_HTML_ATTACH,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36323CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1476D21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfKAJ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:56:11 -0400
Received: from palmtree.beeroclock.net ([178.79.160.154]:43800 "EHLO
        palmtree.beeroclock.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfKAJ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:56:11 -0400
Received: from mailpile.local (palmtree.beeroclock.net [IPv6:2a01:7e00::f03c:91ff:fe93:f66c])
        by palmtree.beeroclock.net (Postfix) with ESMTPSA id 0B2B91F5F4;
        Fri,  1 Nov 2019 09:56:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==dfMgusfixQzId7TUr6mVi4VQHy2UIi==";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2-IoT Box
From:   Karl Palsson <karlp@tweak.net.au>
To:     "Maxime Ripard" <mripard@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>
In-Reply-To: <20191101091050.iw3n4qiqyueoymif@hendrix>
References: <20191101091050.iw3n4qiqyueoymif@hendrix>
User-Agent: Mailpile
Message-Id: <kCnyFRBTNPaksjpFGz3Vnx92t6yIivNcqixk5m2h238c@mailpile>
Date:   Fri, 01 Nov 2019 09:55:41 -0000
OpenPGP: id=9F020B9C40DA5E6F2CAF63B319A8B50FD4D5CAF6; preference=signencrypt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==dfMgusfixQzId7TUr6mVi4VQHy2UIi==
Content-Type: multipart/mixed; boundary="==6XUY4k733sLmhYDr9vLMLPKA8mjsL3=="
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2-IoT Box
From: Karl Palsson <karlp@tweak.net.au>
To: "Maxime Ripard" <mripard@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "wens@csie.org" <wens@csie.org>
In-Reply-To: <20191101091050.iw3n4qiqyueoymif@hendrix>
References: <20191101091050.iw3n4qiqyueoymif@hendrix>
User-Agent: Mailpile
Date: Fri, 01 Nov 2019 09:55:41 -0000
OpenPGP: id=9F020B9C40DA5E6F2CAF63B319A8B50FD4D5CAF6; preference=signencrypt

--==6XUY4k733sLmhYDr9vLMLPKA8mjsL3==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Maxime Ripard <mripard@kernel.org> wrote:
> On Thu, Oct 31, 2019 at 11:12:16PM +0000, Karl Palsson wrote:
> > The IoT-Box is a dock for the NanoPi Duo2, adding two USB host ports, a
> > 10/100 ethernet port, a variety of pin headers for i2c and uarts, and a
> > quad band 2G GSM module, a SIM800C.
> >
> > Full documentation and schematics available from vendor:
> > http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2_IoT-Box
> >
> > Signed-off-by: Karl Palsson <karlp@tweak.net.au>
> 
> It seems like it's something that can be connected /
> disconnected at will?
> 
> If so, then it should be an overlay, not a full blown DTS.

Fine with me, I wasn't sure on the best procedure for things like
this. It's not something you plug / unplug at run time, you'd
tend to just always have this, or not. Is it best to just have
user space distributions handle selecting the overlay then? and
they maintain the overlay file?

I'd considered overlays something for _per user_ customization,
but I'm perfectly happy if it it's intended to be used for per
product customization too if that's the right method.

Sincerely,
Karl Palsson

--==6XUY4k733sLmhYDr9vLMLPKA8mjsL3==--

--==dfMgusfixQzId7TUr6mVi4VQHy2UIi==
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

iQIzBAABCgAdFiEEnwILnEDaXm8sr2OzGai1D9TVyvYFAl28ASgACgkQGai1D9TV
yva6Fg//arUD3Wm4LKdJb2Y5FiyHKH9+EM8RG0ItbqkcpW/k5TU6BMSzBzhBMtki
zc3pBvoOQ6YMIkS/N3lBYMWLIY4LE0SuZ5ID86qnQpX0EyQMcQUUYEifwKidJONH
7hDEPFL+H2MEv3sSw8XoAmO255Nna07umfpHjbRnDx/mpq4quVRDFLIr7vhEdGHI
xagzo02ezR5dX/JDjQVOBYWcVoBHwbIo+eRLefV0dDxQiSjyHglkvaDIYoleTlez
jrKOZ6tu36zJyKEne1EfHajXBIksFNMGuXr1dPCunQoEFgkkI7QI2pALbTsfvr/R
jvdrqenzDLHEOGsN++RRdLmbOd+8G7SNWvKGOc7VWVd9g+dXsGx3eHrtjhBNgCSI
yi8Uxt+M79j5Px59pLLWWyvulL9HHnkxdfHHw1flwGJfhBMXAmTM1qeSS6xl5R8g
G5W+EzDowAq6KA65fTH14cY3rXtG+oqSyrIk0wDQAFEE32q9kWw+bQsSEddVn+vx
xxr75K8F0OkX54R5kwA1aeWkJV8kgaKPMVhL3D3tBID2S1uo08WjU03mlnen6ghX
wA66QaEFPf57ug/GXAHmcS4JpBRauBFQ8cMadu8OaUR57TiVzLvmwSSKQfkLAm0N
h74hapJd604V0sjfryVTpUGarXQLqLXHfXASPxbikZaVAYzTiV0=
=8FW9
-----END PGP SIGNATURE-----

</pre><hr><i><a href='https://www.mailpile.is/'>Generated by Mailpile</a>.</i></body></html>
--==dfMgusfixQzId7TUr6mVi4VQHy2UIi==--

