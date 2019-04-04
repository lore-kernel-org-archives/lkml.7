Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F044CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FA920855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554357311;
	bh=l5Mppc1/vV/37Kp1Im4eiFoXFoSTN0cooYcGwRU9qT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E5nJEosiKWj/AGoI5gbcX1R7U3rMMRn07raQ4/4+PEl8hA+8YMLYATWHgSifdGWxf
	 giZvBSbI29/go+gBYM8DPjUr5pkUv49V7scLxqDG7e9pfkPbvXejv6IviiOba5JB1G
	 r/fNgvVhrO/4lHhl2ewiJWGO0X6FOMH4TVv8Utvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfDDFzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:55:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38500 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDFzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aCp8o3GlfGjGMYHgv+edwCvQrV025OKbZfk/NkLpEg4=; b=vzys+EIlEtVTsxgHBm7HQBYFS
        q6firQq5R4zGPVhXo8TEQ/qRaWUQUCtcvRQaWq5B6PN669LcAOGeZhl+E+i/ZkEnrVIKrbGIUBO8n
        1gfz7ZC05SLuRrtMpTj6KBNM+/YUCK+zjE29fM4MjKoN8vofE/701b6PaY9gBEF54DEi4=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBvL8-0004Ke-Es; Thu, 04 Apr 2019 05:55:06 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CD840441D3C; Thu,  4 Apr 2019 12:55:02 +0700 (+07)
Date:   Thu, 4 Apr 2019 12:55:02 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/9] drivers: regulator: qcom_spmi: enable linear
 range info
Message-ID: <20190404055502.GA5683@sirena.org.uk>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-2-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-2-niklas.cassel@linaro.org>
X-Cookie: Smile!  You're on Candid Camera.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 07:09:22AM +0200, Niklas Cassel wrote:
> From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>=20
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/regulator/qcom_spmi-regulator.c | 7 +++++++
>  1 file changed, 7 insertions(+)

This doesn't build:

  CC      drivers/regulator/qcom_spmi-regulator.o
drivers/regulator/qcom_spmi-regulator.c: In function =E2=80=98qcom_spmi_reg=
ulator_probe=E2=80=99:
drivers/regulator/qcom_spmi-regulator.c:1837:29: error: =E2=80=98SPMI_REGUL=
ATOR_LOGICAL_TYPE_HFS430=E2=80=99 undeclared (first use in this function); =
did you mean =E2=80=98SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS=E2=80=99?
   if (vreg->logical_type =3D=3D SPMI_REGULATOR_LOGICAL_TYPE_HFS430) {
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                             SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS
drivers/regulator/qcom_spmi-regulator.c:1837:29: note: each undeclared iden=
tifier is reported only once for each function it appears in

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlylnDUACgkQJNaLcl1U
h9AMPwf/aDf9L7eeGIoDVWVU65Kp3f2gwyQ0PmX4DMGbvsowE4iCxu0CqhxPOcUM
Y6/rHpBpN51nlHzhofqRYBZ8EGADqoxBBZOn7ClcJDNEVPgLiBRyWgZzcG1np6uO
YkdZbufeEzM7of85tGt6jAOjZ6QxIlNBKiPnLz0dJhFa31/d5C0k1tDWVYjW35sS
X/lOW1WAU3tly/wDqIDA0pC17IGoBS8Sf1yhFF/tbWCb6WITZy2zB5ihNM5kGi3P
RPdhmmUjPWU5E6AUhx5Z/TTeR6XddvzwUyba4ns7/I+fLuUBynAQL2WPHfveDWJ9
WbfIkUpYhQoqiUly4o0dLzbrHOd9Jg==
=skud
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
