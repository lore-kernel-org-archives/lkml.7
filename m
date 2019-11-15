Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B68AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2656820732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKOJCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:02:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:39216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbfKOJCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:02:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBB52B1A9;
        Fri, 15 Nov 2019 09:02:34 +0000 (UTC)
Message-ID: <5bef91ad4e4a7ff9ba3f73c63ddb5f1605e82766.camel@suse.de>
Subject: Re: [PATCH v3 1/2] ARM: dts: bcm2711: force CMA into first GB of
 memory
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 15 Nov 2019 10:02:32 +0100
In-Reply-To: <0bc15362-1579-b0c5-bd68-7fb5cc6b09a9@gmail.com>
References: <20191107095611.18429-1-nsaenzjulienne@suse.de>
         <20191107095611.18429-2-nsaenzjulienne@suse.de>
         <20191107112020.GA16965@arrakis.emea.arm.com>
         <4f82d3b5-fe5e-03a5-220e-f1431cb3a50c@gmail.com>
         <8c84654e-f91e-7865-0cf7-99b30820b7d0@gmx.net>
         <0bc15362-1579-b0c5-bd68-7fb5cc6b09a9@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-72XmPvCKktpU+1X9KyMC"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-72XmPvCKktpU+1X9KyMC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-14 at 12:35 -0800, Florian Fainelli wrote:
> On 11/7/19 11:09 AM, Stefan Wahren wrote:
> > Am 07.11.19 um 18:59 schrieb Florian Fainelli:
> > > On 11/7/19 3:20 AM, Catalin Marinas wrote:
> > > > Hi Nicolas,
> > ...
> > > > Sorry, I just realised I can't merge this as it depends on a patch
> > > > that's only in -next: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberr=
y Pi
> > > > 4 support").
> > > >=20
> > > > I'll queue the second patch in the series to fix the regression
> > > > introduces by the ZONE_DMA patches and, AFAICT, the dts update can =
be
> > > > queued independently.
> > > I will take it directly, unless you have more stuff coming Stefan?
> > Please take. Thanks
>=20
> I picked up v2 because it had your explicit Acked-by tag, but amended in
> a similar way to what Nicolas did, except s/Raspberry Pi 4/BCM2711/:
>=20
>=20
https://github.com/Broadcom/stblinux/commit/d98a8dbdaec628f5c993cc711ba9ab9=
8fe909f0f
>=20
> neither of you will probably mind me having done that.

All good, thanks!


--=-72XmPvCKktpU+1X9KyMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3OaakACgkQlfZmHno8
x/52eQgApJu9OgrNdo/IjzBONKI1NqoPLPyGLsMVn+ebzEVoYvlfJKe5PIm3gDZ6
9j6zy4BIXi3jYIXQEW3VMn5tINFqgsUmYXZGxjUqHr39BlzDs2zIq31+jaYJKLre
SiGGAspZluS6FXzfPfNZRZDXYmol+LPsX6BTqnI58MsH75IdRumfIn6DpJwR82D8
4mDgshkCwGkyivJ+EGXLBQNkAbBlQm11aVo1jMeuthS+V9GOTNu9JqTdVG8pJV3a
LF/YxRDGIsAMGbNsrFXoVh8Yvl3TR8d4Ok/kExH1GNshnp0t/VgXmnvuUno848k7
9wiCpY/dxKGwXkIzw3OanB5f7ZGrkw==
=RjXb
-----END PGP SIGNATURE-----

--=-72XmPvCKktpU+1X9KyMC--

