Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09337C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC5922BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564143094;
	bh=s9B5Bn0sq7OrH/Ur+r/evxxA7wBBdyuURHmd/GNzHX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OoTI9F5ninmGw9kkAzrzSATwRgkubFRrhyhCZHkkvB5t7koluUfMepqakZmEda0Wr
	 5f9NtLxBRODUj3dc77hiKmO0Snq2UvgLTufA2+8mZMjX0KAXmF7ug5X5kKk9cTvDSs
	 /at366Mjaom6HyFDQfQIgE1zETlwtCkL1E0fsMdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfGZMLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:11:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfGZMLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zWH1HzHWTTOCtqXLaOsKtptgTOZvy4cv9Binkani0EE=; b=TgjB94n9T+uXyDkpjPi5iTBNa
        4ZY9Y271kuxB9ysKglxBsjkJikVOnVF6sMjSf0Bdq1LxaRHuPW5kU/03Jor9jrqpTdvVfTq40nPBp
        btAbtT+2Sr56dwTGhb6+8MIVTlK/AhxPGiY9J5YH3OFR7QvrEieMPu6k8xcbzmNDsvazA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqz4J-0001ZR-Qi; Fri, 26 Jul 2019 12:11:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4A2DD2742B63; Fri, 26 Jul 2019 13:11:27 +0100 (BST)
Date:   Fri, 26 Jul 2019 13:11:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190726121127.GB55803@sirena.org.uk>
References: <20190726072752.2acb2149@canb.auug.org.au>
 <14710d5e-7dfd-84e0-2ea1-712863c4e455@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <14710d5e-7dfd-84e0-2ea1-712863c4e455@ti.com>
X-Cookie: Think sideways!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2019 at 09:04:37AM +0300, Peter Ujfalusi wrote:

> Mark: can you either drop the patch and I'll send a new one with fixed
> SHA1 or can you fix the commit message in place?

Both of which involve rebasing :(  Against my better judgement I
rebased.

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl067e4ACgkQJNaLcl1U
h9BzQgf8Dz9ldhvbs+BNcizQURg8b60KSK5yLwlP+ngImwdkmtpaOTWHkDYspieN
ygjAUzrkFTagoj77lCJTrHjDcKMOI4eIy7RWtGlc6nyEKNBSHbBD16lUv5anljY8
Ok7ab49RLEy20Ti9l90GhAqbZzYQ+UOhGerSi1bkqQA8uiHjBIi7BcrsFi85msr7
mxVCurAhhFnAQRXLOyvTMB0bWgX1lbUNAvMW3TM6qJdtZukC0GSoMCEpyae1nvCV
RoDjvmBGH04qIq5GxYbzMXNiebmiB+3kcUkmnOnRqylyh7IMpayn1coQEtH4Eka2
I8TecNXYaICzr6U0F8Nu4/QH30cqFQ==
=2nhj
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
