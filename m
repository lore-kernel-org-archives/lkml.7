Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264F7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA67220818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554910112;
	bh=U03/qHpxJxs29IQh4joNjReOMEodLnWXIlYzGi2pCKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=opIssgv/7aV4L1jFln/kdXWPGAlXRAq4aqybn2vFpC01TdoifRNaNDvhg1Uf000OM
	 pPlCX9DVqd+mEGmOIYeKj3a8pSyyxOfy33Wl/uxXRF51gQDMYUQQKY9ndg1inLaO7C
	 1LOi4t047GThEh/X66Q/BwYGnTYT5GER6dxp7Fmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfDJP2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:28:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53052 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfDJP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1H3AikjRLKMjOzjKrOkFEgAgAKiYZ3fFdjiJpid7JNs=; b=Jsuze32TwYqVFXbNSI8Snlcud
        xTKjCmn6pDDN4QetLB7PSxHVWfxmVAOyMhx2FAssRahuozpx4fr8MkpRisseeKxGpzdgr8vBBSpHF
        qS9Knlgfpb8yCqKYgODTxuzNNLI3DKQJC6p7dbyi3NRr93TEh7eCeGQGmrXRAph48tSv0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEF9B-0001K8-TO; Wed, 10 Apr 2019 15:28:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0171D1128ED3; Wed, 10 Apr 2019 16:28:20 +0100 (BST)
Date:   Wed, 10 Apr 2019 16:28:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Message-ID: <20190410152820.GT6106@sirena.org.uk>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
 <20190410125612.GR6106@sirena.org.uk>
 <6eeaf42f4d3f42c58546c429194213b8@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wiiWofWi8Et/oezL"
Content-Disposition: inline
In-Reply-To: <6eeaf42f4d3f42c58546c429194213b8@asem.it>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wiiWofWi8Et/oezL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 02:05:38PM +0000, Flavio Suligoi wrote:
> Hi Mark,

> > While this isn't going to hurt anything and might actually help so it's
> > fine doesn't this also suggest that there's an issue with deferred probe
> > going on as well?

> I think that the problem could be related to how the DMA channel is reque=
sted.
> At the moment the function used are:

> pxa2xx_spi_dma_setup --> dma_request_slave_channel_compat -->
> --> __dma_request_slave_channel_compat --> dma_request_slave_channel -->
> --> dma_request_chan

> Actually the final function "dma_request_chan" return
> the channel number or "-EPROBE_DEFER" if it's not ready.
> But this information ("-EPROBE_DEFER") is lost in the penultimate functio=
n=20
> "dma_request_slave_channel", which return only the chann, if all is ok, or
> NULL, in case of errors.
> So the deferral mechanism is not used.

Right, yes - that analysis seems correct.  The interfaces seem a bit
weird here but fixing them looks like the most complete and robust fix.

--wiiWofWi8Et/oezL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyuC5QACgkQJNaLcl1U
h9AzTQf/R/KL3VH0zEc0hVwvrBj1cDrGwBjBmXW9R97WwaXIq1RcLAJp9jazopLd
siILLz9Fl/KtflQ3YgkgdyizttANuiXYEf0PSWMzeTkUXlaIcIrKYjrMPZtpvCZi
crpQq730PNf3sbtH+AqNQl1Dgo2LO82hsNekA4irONWIKNRP6EUyccd5BtcbUdp3
AQUEAd1EDYeOKFI8EHbY4GBHu9hN53Bak1CBmd5y3LsA9P5jfA7dsFkGILTTesII
DqA0NiLQEcKppgE/IRaK+DmlWXnAk+KKVQOho+QWcQz/PvyrEg62r8c7GsRo2dFe
C8YNkpxNhOcXxCPou5xpMwPjQNF46g==
=TuEH
-----END PGP SIGNATURE-----

--wiiWofWi8Et/oezL--
