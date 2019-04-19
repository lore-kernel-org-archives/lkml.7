Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CF9C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C3E222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698100;
	bh=LOYJYi8yRYty55xfk85OOpyfuIB1K+6jGPiTYiNlM8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w6S59aOdbAFOEhmEQ30w3+lcd0UceJXOF7/dbPpgBVIj+wgeRaVjbNH2SyenLEmJk
	 bU8OCrw4WiuheDWaEWqC4nQ1DoGHtGs9FM1EzntnxIuNzh5jDyrUr4NzDavN4StYZQ
	 +l9gzIj+gSackUpNq1wzjgLx3kSM2y3vDhwVhzl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfDSSVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:21:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfDSSVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CR0l63MsMkbpSElEofDsa9+rQQWzCQ5B3utGWeqKvco=; b=TuVsJDeYTMOrdR3CxkNl30bQ1
        hpRroV5TZAolAnMG18k9U7TGYcmLHVfcPcjc75G3RsLVzrloIwlRHGUpT06dmQ46QfwrVGxnQzxfD
        4MsEcqkkhI0Skn1hsFAxwA4d3UGFKUOYWrTzYwjCTtB6m88HwPXE1oA8TVqx2ezT6KaZc=;
Received: from 188.29.164.213.threembb.co.uk ([188.29.164.213] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hHVO0-0008Io-Ox; Fri, 19 Apr 2019 15:25:08 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 35253441D3B; Fri, 19 Apr 2019 16:25:07 +0100 (BST)
Date:   Fri, 19 Apr 2019 16:25:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH V2] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190419152507.GU2803@sirena.org.uk>
References: <VE1PR04MB6479A85982748088CC42901DE3270@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4WCFFtl4AQpQKunj"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479A85982748088CC42901DE3270@VE1PR04MB6479.eurprd04.prod.outlook.com>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4WCFFtl4AQpQKunj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2019 at 11:01:21AM +0000, S.j. Wang wrote:

> > fsl_esai_probe(struct platform_device *pdev)
> >                 return ret;
> >         }
> >=20
> > +       pm_runtime_enable(&pdev->dev);
> > +

> I just have a question, do I need to add pm_runtime_idle(&pdev->dev)?

It gets used to help drivers get into the correct state on startup, if
you're unsure if it's 100% required it shouldn't hurt.

--4WCFFtl4AQpQKunj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly56FIACgkQJNaLcl1U
h9CGCwf/V4SKmPiu420k0g+uofTrLtN6Jv9aTQuGhf7zO7AX1stWXlkVwZwj6RZK
XC7w1TLKHMVSJUp+U5nUKH9lrbIPsldykON2Mn1cK7TQRIXMXoXgZgBZRagddQkU
iP0RupSAma6LT4/o4RHV6pjp2qDMU8oJfIUcBqiyFQsmaEMvYK14izz7hOScKwIb
VZMnFG60t8T7AxVCKda6cW72ikkuV1pvAENJ2j36iTNfaFA9Ufo/du99PNZK+9bW
o34ZkH1FrcKZRgM0gQ3icbYUxQQV+WflxfFayC4M/qfCXjJiVoAbvEpLzfSSVYtW
Irvy3o+JKq311kA8vioI3gdp9HFhUg==
=6lYl
-----END PGP SIGNATURE-----

--4WCFFtl4AQpQKunj--
