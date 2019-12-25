Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA03C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 17:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82D62072A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 17:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577295944;
	bh=IuwT3V5kwELLqyNHj8lSEwnAQ29oaQdiyYlWIj5veIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aSO9LQJPbnCKRDmFqqnXenPe9t8zvPEB7mk3wbNlmCRJf0VM8WO/5f6KZcIA2BUBK
	 EXnp+ALIKliTrkafwAv1CrV2wpjHtWvDju8w//AOnFkdIVXtABp5nau421jyWbo0OB
	 hPraqSHehQt973QtM1xrFNrHraykxLT5nEb0IdDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLYRpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 12:45:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58060 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 12:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sqZ9HRtCdnjD8DXcSEjuElmOGdM4XxRfBfU9GjfcdkE=; b=xh2L9IAY8F6aToclrkfPNsiKO
        R8JsvHw7bcWKqp0cboXhHjwtyrucBbi1vATkutReqRA4LzuzYDlH02xLmnb8ciFJWajJdZIgafPTZ
        U/yVAsVzL3fUesDItZipgPIS4Ije67vI/Ktfkce9tGLz6u/jKaG116BPMHbDjrM8DMOXU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikAiu-0001hl-Qx; Wed, 25 Dec 2019 17:45:28 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 14D67D01A22; Wed, 25 Dec 2019 17:45:27 +0000 (GMT)
Date:   Wed, 25 Dec 2019 17:45:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?amVmZl9jaGFuZyjlvLXkuJbkvbMp?= <jeff_chang@richtek.com>
Cc:     Jeff Chang <richtek.jeff.chang@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Message-ID: <20191225174527.GB27497@sirena.org.uk>
References: <1576836934-5370-1-git-send-email-richtek.jeff.chang@gmail.com>
 <20191220121152.GC4790@sirena.org.uk>
 <7a9bcf5d414c4a74ae8e101c54c9e46f@ex1.rt.l>
 <20191224235145.GA27497@sirena.org.uk>
 <938f562e322849328d5a7782b2c1de97@ex1.rt.l>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <938f562e322849328d5a7782b2c1de97@ex1.rt.l>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 25, 2019 at 01:45:43AM +0000, jeff_chang(=E5=BC=B5=E4=B8=96=E4=
=BD=B3) wrote:

> This is adau1997 driver on upstream branch

> @ sound/soc/codecs/adau1997.c

> // SPDX-License-Identifier: GPL-2.0-only
> /*
>  * ADAU1977/ADAU1978/ADAU1979 driver

This is the result of an automatic conversion which wasn't
reviewed, it's not ideal.

> It seems not whole comment use c++. Only first line at source file, Right?

Please do it like this:

// SPDX-License-Identifier: GPL-2.0-only
//
// ADAU1977/ADAU1978/ADAU1979 driver

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4DoDMACgkQJNaLcl1U
h9Dp2Af/aU0nU+b2UxZTkVGZHR3/l8NBevpw5Tzd3SGjZgaPfnLnnupSxFRHbMJh
AYQybA/K1pTWIJsLSNcPjn0x/YstXMil9in42PqCANDLY6qQxi1nHQpqWo26S2+O
u6x9f+rSrJA5zzbjVcbxvBFaEjUtl/O7DTfvf6LNKZ2Nr6DtIlO4vyX8Q5RjhtG8
zvotyES221ovg8TpQ9uv140oUlNtxDyBzstcRQhNXK7gaKqTIHde082f7uqmTspi
xdwhz8EVLpe2LDDYLO5lFH5TKDeektnfhFfelKj26AJ3aFj7Qfn7faKPSNJR3Udy
kXcrZVVgsxfIAjdAGGxzwXGoqw7gLQ==
=YJiP
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
