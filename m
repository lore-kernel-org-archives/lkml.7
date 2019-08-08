Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5371C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48E2214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565293945;
	bh=PSDTrjg5OqJrv/LqUf28t08mNAplVGnPGSObwD303Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f1614FIJx1ObJAZhm0oW1nyxV26v08aUp1CRo70AV7PlVJU9Ki+Bv9iJYHLU/pYef
	 4w4eSjVr2EQqpDJOnwWjVr4ZY61eKhHf8PjzzXIWvxgaQ5vbSkLB/CX+vbTNs3Aj6z
	 7Ehc7tog6MhrCiHEYai+bOGDrL0FBl13P5dOMedA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404034AbfHHTwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:52:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45696 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbfHHTwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1MWRQhv1JoqmBcDEPz0hEreVKta/Mv4QnU98H8se/ZU=; b=iVKOlFDOmWwddtjobr+BdDZW6
        yi04iCpOXEqFxbDYYsmEipmZPg8rHBBwAsU0nL4Ok75LgzN3S4EO5wGYbcXzSaNfZ7GXKJ0Og9v/T
        KwP0bMbCmrihAzqWFAF6GThe9BJcUiyTFktozEqRbs7MgWGONzwyvxaMPMIChKFKJNPts=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvoSO-0003rT-To; Thu, 08 Aug 2019 19:52:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 249062742B42; Thu,  8 Aug 2019 20:52:16 +0100 (BST)
Date:   Thu, 8 Aug 2019 20:52:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: soundwire: add slave bindings
Message-ID: <20190808195216.GM3795@sirena.co.uk>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
 <d346b2af-f285-4c53-b706-46a129ab7951@linux.intel.com>
 <cdd2bded-551c-65f5-ca29-d2bb825bdaba@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Content-Disposition: inline
In-Reply-To: <cdd2bded-551c-65f5-ca29-d2bb825bdaba@linaro.org>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 05:48:56PM +0100, Srinivas Kandagatla wrote:
> On 08/08/2019 16:58, Pierre-Louis Bossart wrote:

> > > +- sdw-instance-id: Should be ('Instance ID') from SoundWire
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 Enumeration Address. Instance ID is for =
the cases
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 where multiple Devices of the same type =
or Class
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 are attached to the bus.

> > so it is actually required if you have a single Slave device? Or is it
> > only required when you have more than 1 device of the same type?

> This is mandatory for any slave device!

If it's mandatory the wording is a bit unclear.  How about something
like:

	Should be ('Instance ID') from the SoundWire Enumeration
	Address.  This must always be provided, if multiple devices
	with the same type or class or attached to the bus each
	instance must have a distinct value.

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MfW8ACgkQJNaLcl1U
h9BC6Qf+MpoIdX8BiE+fy8vg1a5ZsWCGWK/V6LMgyk7vx2P8oWJylUyIG9xTvecn
zrFjIwW5t44x8P5ycsmXZCqG8JCU0/qPSQ9Aw4qC1jesy3Ue4Lwtmu0qH5gvFsSg
CKW/bidKNFSCg3t39fddxeawm+GiutGVwnCgnVtkH9tmcONusdDfnDdOLQiQUQa1
CsmQIbGs/BEuF6LF11Ho58rf7UHvuu4oF9mrKszQWdZKTkhNPfjgqy4n8/scVObd
TAbUUo0uixBk2YmmcxrwtF1V9QGPyifPM8LsHlXlxO3ZSH+/fARzkRoBYQlbwRju
aGWXSh12SOwhelEkD1Q19DG25zsCsQ==
=Nsvw
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--
