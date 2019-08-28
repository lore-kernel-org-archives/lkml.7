Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1DCC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C96217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566987222;
	bh=cR1MRHt25KPGl4mFCfGol5chmGdhJFoawjKAe5PvCws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c7d0dVnNBJyvmaUKAZe6dPuwCDB0R6YDPmq6I6yemJHnhpjqrA3ft+Jc85Y5pc6vK
	 g9rBlDqby4aBRw71qgM680ajnPmxEn6DvOsf9ZFxwCrk0gdz/F3ykvRkwe4eRCai2S
	 kRFT8WjDOBStsfbgDkKdhLSFPYWKi6kHbXXc64+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfH1KNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:13:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45530 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfH1KNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Hcdm4CpIqKt7py/aqpOB6jyd7ntLB//7FnB38ZJF1U=; b=N/n52wcJOLKSBwVrVhui/AseL
        stM3Olw+r2+yVWBBA6cP309MUYzht7vs60CNyvxjA7dpPAdC5b5wShwKcgoyh6rmEr7TsVOtb2NHE
        Wc/sUh4gsQQxQoP0QjpdajDbNv5/fxzIOVVG9365Esa8JuDQSu95Mk/1ltHrvl7R/sNRQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i2uxL-0003ZT-8c; Wed, 28 Aug 2019 10:13:35 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 81EAA2742A55; Wed, 28 Aug 2019 11:13:34 +0100 (BST)
Date:   Wed, 28 Aug 2019 11:13:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/8] regulator: add support for SY8824C regulator
Message-ID: <20190828101334.GB4298@sirena.co.uk>
References: <20190827163252.4982af95@xhacker.debian>
 <20190827163418.1a32fc48@xhacker.debian>
 <20190827194437.GO23391@sirena.co.uk>
 <20190828112705.5e683693@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20190828112705.5e683693@xhacker.debian>
X-Cookie: Oatmeal raisin.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 03:38:29AM +0000, Jisheng Zhang wrote:
> On Tue, 27 Aug 2019 20:44:37 +0100 Mark Brown wrote:

> >=20
> > Please send a patch which updates the entire comment block to be
> > C++ style so it looks consistent.

> Do you mean update the following style

> A:
>=20
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * SY8824C regulator driver
>  * ...

> as B:

> // SPDX-License-Identifier: GPL-2.0
> // SY8824C regulator driver
> // ...

> I'm not sure which style is correct. But I see B is commonly used
> in lots .c source files in other dirs, such as kernel/ mm/ etc.

Yes, please - update to style B.

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1mU80ACgkQJNaLcl1U
h9DQbAf9Etbge3YinPdjAxIYYWtuPv6r2hsxMHOm1iKbI1gItlt6aNtFLLilT4kk
pv2lx+YEFNZXPP/cuwzsgtKEfMkPEM4KDsz85mY+3v8y350N+RiVIX1nUirnDEYs
mWaLoK6D+DrKAPgDgH23zcNH6KoTKNYIPpUfdVQT/jiSXUWXRFDQnsko0e/zb2sw
cJjadPq1V8qjMFaR+xAOh/sT+LLKseWgIYgxWBXgKSj/in8Bbpk09Fy+rONS6/D7
5QRfNaUshg+L7SPK+TRfIs39VNnpuGQI3FqzHyzoht4uApVVmbozKx3KOy7SBks1
72cq7+eqDXUZFMnI5nToM26kFj/K9w==
=/Kyl
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
