Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171CBC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA001222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfJDROf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:14:35 -0400
Received: from bues.ch ([80.190.117.144]:56986 "EHLO bues.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387534AbfJDROf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:14:35 -0400
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1iGR9n-0000iS-8y; Fri, 04 Oct 2019 19:14:19 +0200
Date:   Fri, 4 Oct 2019 19:14:17 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: driver-api: bt8xxgpio: Revive dead link
Message-ID: <20191004191417.09088c38@wiggum>
In-Reply-To: <20191004164059.10397-2-j.neuschaefer@gmx.net>
References: <20191004164059.10397-1-j.neuschaefer@gmx.net>
        <20191004164059.10397-2-j.neuschaefer@gmx.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IP7wLA+5es=/Ecd_j1ExC.Z";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IP7wLA+5es=/Ecd_j1ExC.Z
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  4 Oct 2019 18:40:56 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> www.bu3sch.de has been unusable for several years, but the same
> information is available on bues.ch.
>=20
> Cc: Michael Buesch <m@bues.ch>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/driver-api/gpio/bt8xxgpio.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/driver-api/gpio/bt8xxgpio.rst b/Documentation/=
driver-api/gpio/bt8xxgpio.rst
> index a845feb074de..d7e75f1234e7 100644
> --- a/Documentation/driver-api/gpio/bt8xxgpio.rst
> +++ b/Documentation/driver-api/gpio/bt8xxgpio.rst
> @@ -2,7 +2,7 @@
>  A driver for a selfmade cheap BT8xx based PCI GPIO-card (bt8xxgpio)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> -For advanced documentation, see http://www.bu3sch.de/btgpio.php
> +For advanced documentation, see https://bues.ch/cms/unmaintained/btgpio.=
html
>=20
>  A generic digital 24-port PCI GPIO card can be built out of an ordinary
>  Brooktree bt848, bt849, bt878 or bt879 based analog TV tuner card. The
> --
> 2.20.1
>=20
>=20

For both patches:
Acked-by: Michael B=C3=BCsch <m@bues.ch>

If you want, you can use the short-URL:
https://bues.ch/u/btgpio

--=20
Michael

--Sig_/IP7wLA+5es=/Ecd_j1ExC.Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAl2XfekACgkQ9TK+HZCN
iw5+ZxAA3JGJgQQDGoPjhdTpw2zOavbpWfM6Wot2AYNh9gcnX5xinIdwEXKusYJR
YKZB1V/QbCxvNHYx39KHsgp2MLFSZeJf5fFErL5ABFuD4YIfsAW3Hgua7i/ItHXk
4dTd88GBHGa4RvLC4ZKIRWqA5xUtqlzDz9Uq32bzYIZYLlvqky/zgUAID1S0LRmj
ikpZkQ0Ji4be9V7ny/6Utg/j/Gbr52u7AY0i7qIabW/zB3A8Y16GV/CRGDRtDcJw
+ps4ah0oieiJZPKLLoICc7FwECskdfpgKI42fj00cuYbDnpLsOZTjJ6sJBMwUddU
GR+Vf9uEvkyEhqNXO+rw322Rageg2SsY/OmitwIyUwX4b9FdKciSbUcbFLOVY8kN
Mw1+VxutNObDKuUX/+Sdwg6Th4Fpp8DnfKebJy3fVYglyw1LlHLyQCnljoAQO0TS
YtaI1lHlwSdorjt8I8xJ5ZL4nKMKanYPlaKrDPOMbLxtwaZ/7JqgCp0srqUqPa+S
gocuMXBLmer2LIkOtssCqagbSBIbAFb01ISGpvQW1ap9UdToz8XKW7BQtdGiFR3W
60sukQq3By7dE81fKLClQ2lvxBJADr6xRVshG1eck4atqne2vQ35mhWLOtEt0h3B
vGogcTdSV09ojsb0y3a4bqGYAfTyNMEMeiCr2P9Y66GgSgSby2Y=
=xIyy
-----END PGP SIGNATURE-----

--Sig_/IP7wLA+5es=/Ecd_j1ExC.Z--
