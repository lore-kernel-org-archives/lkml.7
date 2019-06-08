Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C2C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FA6214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560023530;
	bh=RgVlU1FphHQ8a0Buvri5uIq/ULpe71jqRpW2Pu9WNug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g8X5+e9gKEFnPRcOji5iUAy62Crj1zZ5HhcxsetSUU6QgXsFqtej3/qEwIBrSwutb
	 USMX25jNx1JlXVhcgACaHn6pMImOo+TIZH9ku7Sr90zAsTXIdSLEfrTzo5s25A6ZES
	 oHKdoRezb7Gy9046GIvU196pmUAm9kBJzAnyfK9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFHTwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:52:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49998 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFHTwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RgVlU1FphHQ8a0Buvri5uIq/ULpe71jqRpW2Pu9WNug=; b=Rl/GYJCY+7qh+7jC7Uiwiy8R1
        +Pd8W/Rn2KYCq4rGEyro3aI9Ayk/od4kWYu5e4vwPn1y8PSvA8jYSsEc5xX0QCecjMRy3Urq3OJuJ
        m2lC8uxnI8kWiknIDDrAUn+0ucidWizD1rEJ8tZGlGpHHjLA09aQRBkRULSwab7uojTcg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hZhNg-00076h-I2; Sat, 08 Jun 2019 19:52:00 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 2F47B440046; Sat,  8 Jun 2019 20:51:59 +0100 (BST)
Date:   Sat, 8 Jun 2019 20:51:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     keerthy <j-keerthy@ti.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, t-kristo@ti.com
Subject: Re: [PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561 regulator
 support
Message-ID: <20190608195159.GA5316@sirena.org.uk>
References: <20190516043218.8222-1-j-keerthy@ti.com>
 <20190516043218.8222-4-j-keerthy@ti.com>
 <20190522153528.GG8582@sirena.org.uk>
 <1712197d-7d43-38a8-efde-11b99537eae9@ti.com>
 <20190528132755.GK2456@sirena.org.uk>
 <e68d9939-a56a-b3c5-7f6d-e5783e16a6de@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <e68d9939-a56a-b3c5-7f6d-e5783e16a6de@ti.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 08, 2019 at 09:26:31AM +0530, keerthy wrote:

> mfd patches are on linux-next already. Hope you can pull this one now that
> dependencies are met.

Someone will need to send me a copy of the patch, if I acked it I was
expecting it to go in with the MFD changes.

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz8Ed4ACgkQJNaLcl1U
h9AGHAf/bKw40uSf8TiKMNME3+rtTwA5jmWpVk6ZKGFMQ8VdpA0HGY2JRsIUTuTq
XbcwJiElcnNPObYFWifauDWDKbu0cyobZncfVmOsGvWlyNXa2KHH5dyGKINCwtIl
VSoLYzZ/bOj7ksFVyLTLmPgAdXaPOzPfTxHaERRXb5D9Oaxq1SqpPjwRP2LRPtwC
fNZQ2uSB2SJTC7hDdM/RSjvgsghIVUKPgurkfh+AzeHJQhFeZ2reQsx0A+3G37qZ
K85r0eLHEI4XEg9lZgIc9ypA8EXZiuLYtEi3B4M6tsnQXqkEbs3tZKoflF7ZiBR/
teHq8C9MOoAu7hQAIXAPBZ35SGEYuA==
=mYL3
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
