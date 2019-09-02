Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A9C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 21:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E1C22CF7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 21:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567458253;
	bh=Zx8L/XC2BFLItiRGrl3cOe+rbtk8egAWBK9C+0cxkIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RJra9r1FGsnFLXmNztXP7NnhM7t+mgNHbicqlIHv1/PzWjjsnqrVvCyksWToPt0iw
	 HumZvPwL5pXC0SPg2ADMQHfhlgLmF9DpVIF/AofNQqQywGEykDauMCCd9Davhp920M
	 KBQ6ibY3a6cKv99VFNjNOJJD91PnPncKCxPaL03Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfIBVEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 17:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbfIBVEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 17:04:12 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D9721881;
        Mon,  2 Sep 2019 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567458251;
        bh=Zx8L/XC2BFLItiRGrl3cOe+rbtk8egAWBK9C+0cxkIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jWLdNf0PKLwclUvZbu1DZnUgabeaQhVTVL/HpQzN3omh+pbG0G/jg6ra21Spel/2b
         ydAwGPdTlM4L2LKjWo6Vo0ykd1kKaDKwLyWSVrIUTrWlO0FrtNGerRYZ1ypHSQSZx3
         Arao3UqBWNRRW0D8sHLZs6NU2B1Yg09i+DvIvnOU=
Received: by earth.universe (Postfix, from userid 1000)
        id 2F59F3C0CFA; Mon,  2 Sep 2019 23:04:09 +0200 (CEST)
Date:   Mon, 2 Sep 2019 23:04:09 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        vincent.guittot@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Optimize the Spreadtrum SC27xx fuel gauge
Message-ID: <20190902210409.c4mdm6akdlgctgsq@earth.universe>
References: <cover.1564566425.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfh7b4cxthg4b7bi"
Content-Disposition: inline
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rfh7b4cxthg4b7bi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 31, 2019 at 06:00:22PM +0800, Baolin Wang wrote:
> This patch set adds new attributes for userspace, and fixes the the
> accuracy issue of coulomb counter calculation, as well as optimizing
> the battery capacity calibration in some abnormal scenarios.
>=20
> Any comments are welcome. Thanks.

Thanks, queued. I slightly modified patch 4, so that int_mode is
'bool' instead of 'int'.

-- Sebastian

>=20
> Yuanjiang Yu (6):
>   power: supply: sc27xx: Add POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN
>     attribute
>   power: supply: sc27xx: Fix conditon to enable the FGU interrupt
>   power: supply: sc27xx: Fix the the accuracy issue of coulomb
>     calculation
>   power: supply: sc27xx: Optimize the battery capacity calibration
>   power: supply: sc27xx: Make sure the alarm capacity is larger than 0
>   power: supply: sc27xx: Add POWER_SUPPLY_PROP_CALIBRATE attribute
>=20
>  drivers/power/supply/sc27xx_fuel_gauge.c |  175 +++++++++++++++++++++---=
------
>  1 file changed, 124 insertions(+), 51 deletions(-)
>=20
> --=20
> 1.7.9.5
>=20

--rfh7b4cxthg4b7bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1tg8UACgkQ2O7X88g7
+poO8w//bmAxDI11Vh1zSEL2o/rRXBuvC5zqDziZ1jJTbMuG1GHEiEw/tdMpJZkh
z+Kp5UXa8mglJXykHrNX1DTaUCTnazir9+Oc6FLTIRcMPFVP+bNhcR45FCcFf2AX
mUKsf23hYitaaN4FVYsk6wBZ28rbok8rSIdImkob5xebKt3Kz0YKT4kPs74wyU0e
O78gjOO72JQV57vNAy1xYUrzVDL+AuXO0teO8laQMC9gGe7QxJ4UN0cbGpXCf0vl
l597BB0RcX7Nxm5kqcjqanGiWl8Uv9Zg9DePolEonuU7gD1z5YxhPNJhH1Vnv4+R
h4eiZcBPTl8TVhVk4BtmDQlHUKx4cd+CNjtil03YkDkNxIuzb0VYZ3Olm0k0QvOQ
6ga0vhywJEhKj16iOGLnlptTMe5EFZQn313oKwj0si+0RnJcplyH3rNA6XtOyilw
p1JV5StI2ZSeRbRgS1K9AdIG0GGDI/CGU7afuGi/JEejUE3e26ckdRbtekghyxib
IZ5XIxnp6c83C8DDWuhwerRbMoLHkOwVxNdG6VdGXVlkXCWx29ioqadVjO3sLnjE
cRxU60Njk2oKl130fbNuxrJTzu4p6j1vZRQE91Ii2IXI3WXunRUhrs75LI/Y8BnL
tYMuhQK20zLL3VliTIcKxIz99zochoKkUG3guni6g90NGihTnf4=
=YqBc
-----END PGP SIGNATURE-----

--rfh7b4cxthg4b7bi--
