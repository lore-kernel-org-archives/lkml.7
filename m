Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525FBC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2494B20665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfHAMu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:50:26 -0400
Received: from sauhun.de ([88.99.104.3]:52594 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731335AbfHAMu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:50:26 -0400
Received: from localhost (p54B333D2.dip0.t-ipconnect.de [84.179.51.210])
        by pokefinder.org (Postfix) with ESMTPSA id 62C102C2817;
        Thu,  1 Aug 2019 14:50:24 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:50:24 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Anson.Huang@nxp.com
Cc:     aisheng.dong@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] i2c: mxs: use devm_platform_ioremap_resource() to
 simplify code
Message-ID: <20190801125023.GH1659@ninjato>
References: <20190717084017.30987-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cfJ13FhsvNR/yOpm"
Content-Disposition: inline
In-Reply-To: <20190717084017.30987-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cfJ13FhsvNR/yOpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 04:40:16PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied to for-next, thanks!


--cfJ13FhsvNR/yOpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1C4A8ACgkQFA3kzBSg
KbbuCQ/+Jh3jQy7mSWoI1drhM0j9+MC/Kq5i599BC0Fr4mV3KNiHW9aKVRPpNKnm
PPe6xTh0GiT8TetvzKh0k8snQi0xhZOB4NagfqVK3sZ1zKgQFLX2420Gf1V6rF9+
e7OqfHEkIbJDfn4649lJCjpjfkDFBrOgItFISc7in0APZjhlFVFeNyErUe4xIaqu
XdBZ3s5hJNdvF8l759DZEf8Ue77+RkjOFjjM5elGRz3qCEjCsSXVgs2x0toozBd4
mAxgRx3r7eBWSeuhyWqJSNEVo24rwS7Aw1UUR5vPWLWfVkJLqdxPEdirywXtIW3d
3GPu/D6W8YK63Mg7ncs+ryD3giFfNz5IFhGFKm7kFPvwju7IR2kzIjZTrMo92vTO
O780yEYiDnnqLTJrVBBYEXMu7xJB6U+IbiCC+2r1eJg4mgJo1eHYxIK7PxBSCZs4
pdwFNeSzJJRXJgM4+bMb253AJVtVmkkxFbsv+UXc//8hFqvIWnqg2Jn7NKncFkjh
wZK1gRASN1uEE79J1Z3P7RdMElW2a6LRSqErfOduznRQUlo5bdSX/u4bxJdv3qLY
Y37hMgqJnrP5Nf4yktdfTXJIa76Z+eNkfhRihK23Nr4mXxYey06lRvRsqjsO8Fam
kP9TB/6L5ENQ4zn9MASaLP9MhA6dekax5msNYj97Ww0oXG8Fy0U=
=niRb
-----END PGP SIGNATURE-----

--cfJ13FhsvNR/yOpm--
