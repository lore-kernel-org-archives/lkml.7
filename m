Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E061C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134DC20665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfHAMpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:45:55 -0400
Received: from sauhun.de ([88.99.104.3]:52522 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730458AbfHAMpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:45:54 -0400
Received: from localhost (p54B333D2.dip0.t-ipconnect.de [84.179.51.210])
        by pokefinder.org (Postfix) with ESMTPSA id A00772C2817;
        Thu,  1 Aug 2019 14:45:52 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:45:52 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: tegra: Compile PM functions unconditionally
Message-ID: <20190801124552.GF1659@ninjato>
References: <20190707231234.11679-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Content-Disposition: inline
In-Reply-To: <20190707231234.11679-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2019 at 02:12:34AM +0300, Dmitry Osipenko wrote:
> The I2C driver fails to probe if CONFIG_PM_SLEEP=3Dn because runtime PM
> doesn't depend on the PM sleep and in this case the runtime PM ops are
> not included in the driver, resulting in I2C clock not being enabled.
> It's much cleaner to simply allow compiler to remove the dead code
> instead of messing with the #ifdefs.
>=20
> This patch fixes such errors when CONFIG_PM_SLEEP=3Dn:
>=20
>   tegra-i2c 7000c400.i2c: timeout waiting for fifo flush
>   tegra-i2c 7000c400.i2c: Failed to initialize i2c controller
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Applied to for-next, thanks!


--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1C3vsACgkQFA3kzBSg
KbYELg//d7ixrsPiRwLtaLHuba30xC1YeUezmk5+ixVYw/7+c14MZLNZga8JxydY
AOkuAOmM9FifwuQpYFO6dHilZuF0zPngcwPKTUusPoFZacSJVfU4qfPjRNtpqPrJ
aEy7kgRYpvAgtXhX/Yl/7l/19Gq8Jw3nzJ8XMG6QWVhAsE5c8FJr2fSUGJmVRE7I
Aof/qD1QStABjSa42ClCvBn5DRnJRYYH/aAz4RlKI5N+Tqm6Jkh8MQOn6slg415K
9vtZDG9OY9lO6fkSRhrDkNwIR/K7acJV9mjjCJ6xiOA0sFhyuB1xw5Z1uJSCzHlj
3Oh7aiVYAxK23Z8XugdCheppSvauuNqV14x8i/wmLImjBoK+KFfJSq6m5uMgtjHz
0qW4YQH69OPA83L2Ko1g63UKqL2wYMChGAGcLu/qZECP4Y2RYIAE/eL0Zx1h3ezv
bR1pg7DGVxs6DPm7bcM69i8pinqrBnKtq8eRmVGsLrwjCgWXMyJT8rjUqzJOA4GC
8+2Urg9mjGRFhUwFaawvffzqUzfLMIiOSTbZLw+C0FWjarFlc7bv5lY/ODefhQl2
uy9oqBNlXHVcsm8O7FTa4t8qyL/zm1/92OREQiHE3fRogrhmJsOXNcN+TwgkBkaB
3lZFAFQA3eqAK8W6bW/250JMsuAlac2LB/4dQm3vDLrLf9XMVWU=
=1CO3
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
