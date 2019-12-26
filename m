Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD76CC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 10:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E9E2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 10:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLZKpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 05:45:34 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:46320 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 05:45:34 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 124811C210C; Thu, 26 Dec 2019 11:45:32 +0100 (CET)
Date:   Thu, 26 Dec 2019 11:45:31 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2] phy: cpcap-usb: Fix flakey host idling and enumerating
 of devices
Message-ID: <20191226104531.GI4033@amd>
References: <20191222180019.55417-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Content-Disposition: inline
In-Reply-To: <20191222180019.55417-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-12-22 10:00:19, Tony Lindgren wrote:
> We must let the USB host idle things properly before we switch to debug
> UART mode. Otherwise the USB host may never idle after disconnecting
> devices, and that causes the next enumeration to be flakey.
>=20
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Michael Scott <hashcode0f@gmail.com>
> Cc: NeKit <nekit1000@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> Cc: Sebastian Reichel <sre@kernel.org>
> Fixes: 6d6ce40f63af ("phy: cpcap-usb: Add CPCAP PMIC USB support")
> Signed-off-by: Tony Lindgren <tony@atomide.com>

But it does not apply on top of 5.5-rc3 AFAICT.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4Ej0sACgkQMOfwapXb+vIpXgCgpw8ow7BAI9AIa4DhiKn1Aloe
6RIAn13zm1SNFtJWZ+ZLsyiIZou3MwFe
=eChF
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--
