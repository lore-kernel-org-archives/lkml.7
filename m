Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114BFC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 23:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C994620835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 23:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551655915;
	bh=AoEdZ/QvUWCT1+KJXviGS/rfEaJIKp+DQSyY5pfJA4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WLErHJE5gxM8TGXof6AyEWNfnFp70+YBUv5rrlwTo40ehCo3knArDg/j0qtGUjLvM
	 Yo5VtEOYqtFvi2uiMNnHIfC6/c16ndMj4jcg34K+ElZCE43wAtMSYtIN1s+ahjWWmp
	 R5C/IDbNx9ciFzYhGEApJsmWd5fV1LImFuhdNZkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfCCXbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 18:31:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51968 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCCXbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 18:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zPF3PZ/4xX7SB0kmbBIZIBD5Od4zY0RToWk/97KIMUQ=; b=kLTXkpwHo8U/WaLg5IWM/jnko
        sXwWLAagBPdIJbvPEpSUMSk9T3BHqj3ibfHSPKLvljIMYk+NV0bpZKC7Km+vRuKnJtG3eyh9eXzq0
        bbIrAEAKoSduMpISidj1uRdsbUlC6DDW3PrDQqqZ67WlrL8bjHmJ3xRFeEQIx7HajwOPA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0aaB-0007KG-5g; Sun, 03 Mar 2019 23:31:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CBC10440082; Sun,  3 Mar 2019 23:31:45 +0000 (GMT)
Date:   Sun, 3 Mar 2019 23:31:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: snps,dw-apb-ssi: Add clock bindings documentation
Message-ID: <20190303233145.GN23441@sirena.org.uk>
References: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
 <1551360342-23981-2-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Content-Disposition: inline
In-Reply-To: <1551360342-23981-2-git-send-email-gareth.williams.jx@renesas.com>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 01:25:41PM +0000, Gareth Williams wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>=20
> The driver requires a clock property, so detail it in the docs.
> Fix a typo, 'pis' to 'pins'.
> Add documentation for a separate, optional, interface clock.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx8Y+AACgkQJNaLcl1U
h9Axywf5ATfT/UOnBvU8MseRTp4zANwg1TdBhCNVMBtJXhAY8I/beO9iGjeT0XCR
zDBZI2I1mnhLqoTvQON38XSaZsdDiOZ+uJsQK3T2LIam80sKEn/jTKomj/1exz3D
f958wKv3vRW4MdzBX3K9A7kFKVrnetZnUL9a1wVETkYlZCFx0E9s9uo+FVLUvo8Y
nAxF8kl1UCgWfNT44QnNYDbDEDpbaM7cT3rOr5OTJrHq23mwh6bH5AgrjeulJD8J
b+J3cZOi+UqtowufhzuIhe/d1xxepIeDWGfFtIEfTmmiMrhoMz3kIch3u+t2AJCy
9wn/BCklmV9jaTs7CAKIKs8C5XzLsQ==
=OdOn
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--
