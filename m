Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1930C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956762072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578498659;
	bh=gIS3hB+3rGczddeHB4k+qB8HUdXVsRLZxz611daogJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tSxvqvFoVhfH71RzkYBZ3bb8RXOTMvUZ7fBzTTnkdABoZqJKGn0lWqBUlj3TkWee1
	 cS99nfnXaZcHyWn4JhcTMmncnGpUZm0+aK60+NSuNLtua/Gs/C2MeOXCdlkzykpL85
	 5J3Pwa1uu+fkO+sT8ZacD7bKeslBtILRVTvxpBas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAHPu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:50:58 -0500
Received: from foss.arm.com ([217.140.110.172]:46396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgAHPu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:50:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05CC031B;
        Wed,  8 Jan 2020 07:50:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 837E23F534;
        Wed,  8 Jan 2020 07:50:57 -0800 (PST)
Date:   Wed, 8 Jan 2020 15:50:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] regulator: mpq7920: add mpq7920 regulator driver
Message-ID: <20200108155056.GA4036@sirena.org.uk>
References: <20200108131234.24128-1-sravanhome@gmail.com>
 <20200108131234.24128-4-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20200108131234.24128-4-sravanhome@gmail.com>
X-Cookie: My vaseline is RUNNING...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2020 at 02:12:33PM +0100, Saravanan Sekar wrote:

> +	for_each_child_of_node(np, child) {
> +		for (i = 0; i <= MPQ7920_BUCK4; i++) {
> +			struct regulator_desc *rdesc = &info->rdesc[i];
> +
> +			if (strcmp(rdesc->name, child->name))
> +				continue;

You can replace this loop with an of_parse_cb callback, please send an
incremental patch doing this.

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4V+loACgkQJNaLcl1U
h9COqwf/fFpfXig6rh7ARcurwTgTV49oOWEbpumCuN5gZAi1vxKX7avl4APGbadS
jvOJPUCAxapnVoKqG43Y+SkZyz8Tu6pDz7yaGbSvo91UayuEbwkTy5edLuxld1cV
0x6Jv4WQo6Kz7XMypUI9Zi8ahxS8ZnA5WJvCMveRa16uC7DeBpoYVhr2Q8TEcHZQ
oulZOkT+j2y049GY3ZHTSdg6PAgu+XlfFXoppg2Unqwfpb8C6/IdPgW6mvEJgdTY
ZukNejDLOsvG8bnc4VeZ/5y8qlG65DkBJDYfIpOqQVVcQbvR7jNk0eSWf7/o27FJ
U6r8PglFKgzEtFa0MLLDrvZE2rpK0w==
=0O/A
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
