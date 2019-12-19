Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33F4C2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799312176D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLSAPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:15:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38880 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLSAPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:15:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A161D2929C1
Received: by earth.universe (Postfix, from userid 1000)
        id EB1DA3C0C7B; Thu, 19 Dec 2019 01:15:31 +0100 (CET)
Date:   Thu, 19 Dec 2019 01:15:31 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     krzk@kernel.org, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH v2 0/2] Add MAX17055 fuel guage
Message-ID: <20191219001531.gnav4roprttdwknc@earth.universe>
References: <20191214152755.25138-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ldrttufjxpp4b6bw"
Content-Disposition: inline
In-Reply-To: <20191214152755.25138-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ldrttufjxpp4b6bw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 14, 2019 at 07:27:53AM -0800, Angus Ainslie (Purism) wrote:
> Extend the max17042_battery driver to include the MAX17055.

Thanks, queued to power-suply's for-next branch.

-- Sebastian

>=20
> Changes since v1:
>=20
> Change blacklist driver checks to whitelists.
>=20
> Angus Ainslie (Purism) (2):
>   power: supply: max17042: add MAX17055 support
>   device-tree: bindings: max17042_battery: add all of the compatible
>     strings
>=20
>  .../power/supply/max17042_battery.txt         |  6 ++-
>  drivers/power/supply/max17042_battery.c       | 17 +++++--
>  include/linux/power/max17042_battery.h        | 48 ++++++++++++++++++-
>  3 files changed, 66 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.17.1
>=20

--ldrttufjxpp4b6bw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36wSMACgkQ2O7X88g7
+prFWg//T5ntYoriOV0sVbe5bCXhTS18S9n3MAj7Hs+duWtve7xbPHcs3O1BV44O
IbqHmQLQtH+U7aWnaCkAzgMfK7YuoXmWgxFQTdYnAsmbjSN8DEd39BS7xUdLmJtE
Lfvk3nxlzeS2EveNYb5XGkjGQIjITUauyc+eKqKcgY6HMXedrlNzRUJaRCZYmUGn
0FAr3OxJ79L6Q/UYT/FomElClPYF9CXPs/klh/yD70unAunigCU0Qyvm2nj6uPRI
w18nyHijjmz+TD2MfKiHaNiVvtsRzvDPRgo7FfZ7g00SwYy20gWqnibYpOs9TYFI
Mzg8LBmpngGbGj0xPfX9KxfFRGWHAYPlltdXndvLYAywXZ3w+BKLCYL2JoiVVPdW
43eUaBqXa1m8wxZMswz4xV4ouk68kAkh1gs3loxB06+Az4hrqBjJLTGSIMUzhm3y
s8Vvo5BFthKYNETL2X+ruzSSWCw/yHAcPYj8lIvoCSeB0BWdwXrO5e3u62kAZgi5
rOwF+Zxv+iyUZMgh0zKnBkFDCGBI9TR3tcuQcLc9ta6G6u4/oIxn23CbcruN0VJO
kf4X3k0l/rLBsyKCYqGtUMe3SoWz0CUB6zakGTzYUERZXV7LcsfhAVsxcbeV2Opa
FN7uQO/5il0cCN3/A6Mis6v7cvVxolYl8mB56UUPFZ5FgK+BrpM=
=aycy
-----END PGP SIGNATURE-----

--ldrttufjxpp4b6bw--
