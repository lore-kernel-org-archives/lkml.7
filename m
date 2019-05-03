Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F025C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4289C205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864260;
	bh=5vEsn3t0K5FrUDpqgBN9YEaqzn044x2H/vNzN5bOsSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DnqAmHboe8Py32w8f1zJ0ackiGzSKj0Uu5dSvlIYn1eZAOrk34GbBP9vttkJWQH26
	 HlA0YdCFl9Bo0NOUYLAxn7uLikyBJNseEq8B9vH36Nnsv4BCEGmsSaRzaKE8FzHfx6
	 ++ov6NLqgWjNkVj+baVIwdBint15hJSgkLNitG+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfECGRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:17:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50540 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfECGRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5vEsn3t0K5FrUDpqgBN9YEaqzn044x2H/vNzN5bOsSA=; b=jkvoYfxSRYUtsrQF/SohdXboz
        LNRNw18UJAMAdf4Pi8lnV9aYdCMRMVl4UClh3xD0l34qM8EdZin1Nu1FUc7jV66JOaTebvLSZtlfk
        HQvhnVfItGdyPFE6uwngD70qLFVvtaXDQ+kXCqCrIGGpdhfCBNVZM7fZ4qvxcQtRxcO1I=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRVi-0000TX-AZ; Fri, 03 May 2019 06:17:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D198A441D3C; Fri,  3 May 2019 07:17:25 +0100 (BST)
Date:   Fri, 3 May 2019 15:17:25 +0900
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 1/3] ASoC: fsl_asrc: Fix the issue about unsupported
 rate
Message-ID: <20190503061725.GA5107@sirena.org.uk>
References: <cover.1555908545.git.shengjiu.wang@nxp.com>
 <2cea4cb992a445863e88fa7865f55a02a83e031e.1555908545.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <2cea4cb992a445863e88fa7865f55a02a83e031e.1555908545.git.shengjiu.wang@nxp.com>
X-Cookie: All true wisdom is found on T-shirts.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 04:52:02AM +0000, S.j. Wang wrote:
> When the output sample rate is [8kHz, 30kHz], the limitation
> of the supported ratio range is [1/24, 8]. In the driver
> we use (8kHz, 30kHz) instead of [8kHz, 30kHz].
> So this patch is to fix this issue and the potential rounding
> issue with divider.
>=20
None of this series applies either, with similar error messages:

Applying: ASoC: fsl_asrc: Fix the issue about unsupported rate
Using index info to reconstruct a base tree...
error: patch failed: sound/soc/fsl/fsl_asrc.c:282
error: sound/soc/fsl/fsl_asrc.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

(I get the same error message for your PM patch when applying without
using patchwork as my main workflow does.)

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzL3PUACgkQJNaLcl1U
h9AuFwf9GU1mu4UAbguaCvzQD7KN7UOFPnMm2fjMErvpmxgq/cV7aFQEJv6Kc9Z6
A2/l/TYJ+iNoJ01SPYwRKqw63mJmthjOsikQzaH3VISq6kF09ENT35Z4U1r8zOkb
6IbPno6mpS6rBk0ckEJ7TLf4dl9zDh4djeaGWVK8MFX+D2eW86vfn0qNSWVCO55O
p46Qvf2iwJJyc9HVx1AR8hJFAtadOWlmfPYUbUJ0DIJpAzT1aCFtoIGqj2Ef40hl
YMo9B11fGc9xoae/INeoJIAOInjLKeS/Pm0n4N5FJpPeke/b13n0bDJ7EuHOy+td
YCXUiBuuUhxXCy372VZHevRq1JK7hw==
=B7sO
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
