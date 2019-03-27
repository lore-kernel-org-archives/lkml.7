Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B1BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121EA2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553687891;
	bh=SzIv1QoTzrrqhrbcJ2RfOKHfo8HFbPOp5r8++/MPsy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W1t1RiNwlCNPsXJ3digQhH50i1IANuaaVPj0Z7ctcvQ9ph/S0aVbZwh7zLaVgLUFK
	 LAw1FHtmCq0+0FMZ662Bet5DjN1VxUym3LQcoTi76Nuat7hDvAKAsRh9+vXpdrZs7n
	 7Ho15EruDvA3I9RUjNXjtpu54emrqnJDJZybITLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfC0L6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:58:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58332 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0L6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9d69b/QXfoYGWqfguLUdUfQSZItwCRrq/XtCINmWXYA=; b=FYX93jVCfRd7RO4wRhrB6O2YT
        pRhSmq6t+a3H90iCB0S9mT65yjY/hBj7rgiX4dfWvC0iUtvjp/WAj+IrnND2mzKlllPyMMkE9DVUU
        3dYiK/mTbaOb5Lz0c80P4CbXXix5Gxa4ZJuW6isc7NEHCoNTxmCcxbkRLJjr/vmQNgAk4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h97Bi-0006TP-Bq; Wed, 27 Mar 2019 11:57:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9F93511288FA; Wed, 27 Mar 2019 11:57:45 +0000 (GMT)
Date:   Wed, 27 Mar 2019 11:57:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190327115745.GA11404@sirena.org.uk>
References: <20190326133349.3d9427dc@canb.auug.org.au>
 <20190326131550.GB10898@sirena.org.uk>
 <87pnqdndmk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <87pnqdndmk.fsf@concordia.ellerman.id.au>
X-Cookie: May be too intense for some viewers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 03:29:55PM +1100, Michael Ellerman wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Hrm, seems PowerPC is still not using the common clock API - is there
> > any plan for that?  There are some ASoC PowerPC uses so it's going to be
> > a bit of an issue as we expand our use of the clock API.

> I don't know anything about the common clock API. What would it involve
> for powerpc to use it?

It's what's in drivers/clk - you'd have to provide clock drivers for all
the clocks that are current supported by arch-specific code, make sure
that those drivers can be instantiated and then remove the custom
implementation of the clock API in arch/powerpc in favour of those.

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlybZTgACgkQJNaLcl1U
h9B1Swf+PbhuOweQKwnnpdgGWrrDdszCdLjzP1NdPdjWVhB1B+Y8gm8uA2CbgSCQ
FHCL9GmY1si64Jg2+W+uD7o+rdg3neUXfZ3rmQ60mdvdmg8O+iz6ngwn2iJIbGy2
5zuQoky3maZLgElEQMKWlZ8A3nHQpk6BkWra83M7tZJJnU5SOQ69vE2oKK6sGfTf
Xu7R13qHpVeRNQU2baIRdbkhgQFl01wiRswA8JbJSAQmeMX3XcjwrDakT10USHNy
PnNPllnXLAE9brC8AeYr9vNQj7vTL5fjn94Gz9P0yX2dWbnVSy2Yc2QASwiKB4P+
2qblx6/w3O4uBa8dTNx45qHwObNlHw==
=kXyA
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
