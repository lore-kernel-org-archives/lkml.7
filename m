Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094A2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36852087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfC0Wly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:41:54 -0400
Received: from sauhun.de ([88.99.104.3]:39626 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfC0Wly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:41:54 -0400
Received: from localhost (p5486CE6B.dip0.t-ipconnect.de [84.134.206.107])
        by pokefinder.org (Postfix) with ESMTPSA id 825872E35A2;
        Wed, 27 Mar 2019 23:41:52 +0100 (CET)
Date:   Wed, 27 Mar 2019 23:41:52 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
        Michael Cheng <ccheng@broadcom.com>
Subject: Re: [PATCH v5 2/8] i2c: iproc: Add slave mode support
Message-ID: <20190327224152.GA19245@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-3-ray.jui@broadcom.com>
 <20190327221452.GA15396@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20190327221452.GA15396@kunai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	/* flush TX/RX FIFOs */
> > +	val =3D (BIT(S_FIFO_RX_FLUSH_SHIFT) | BIT(S_FIFO_TX_FLUSH_SHIFT));
> > +	writel(val, iproc_i2c->base + S_FIFO_CTRL_OFFSET);
>=20
> Will flushing FIFOs work when a slave is register while a master
> transfer is on-going at the same time?

Sorry, my bad, this can't happen. Registering a slave is protected by
the adapter lock.


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyb/DAACgkQFA3kzBSg
KbZN8Q//eSDQHv6MeKmwMRekegPzcadxm/hDQDIQUXHCjJ9CvIxQVtlU7qLmmMdv
zeN78fBCGvLGuKXg+zWWEl/E/7Grp4V9SsAw03/fd3P0t8YfyHEy6qPCkTj12vyW
di04vwF1BMPRTK2aBYukG+PsyadGkGpusS9foTFGue/53lcksx7g6IgG3jknwSEJ
RHmbHwMBI3WllQWQp3gcpOudmglHZuqmXbOTkf2BrrMPZ2DqO/GZa0Nv7nlyE7St
vag7Nbho9kisogNiVUEPC9TT0xYCTGVYBGVeXep5o85zcKacNCow5SAOUoFeIZuP
3XFGjkxnIIyXlBRR0PIL6KFxRXyN7y2HYfU4qeA8Xet8oHcdfqcRXsSJUGcREo4M
6VBtZjslLywN92cub+rZkJQ5Kd+5dauPDjYFRyZfUnB5R6kbOK1BOb3B8HjEESEl
oOSUxAudMSmCSqeqKNP0qTOX8vFXMG9MU71QBpet37OUeHVpjgrw0VNb1BenA61x
dphA5IB/H8Fi1GIEI5mjl61BgnICJZjPYdqS8hXeB2aQsYr/fhUax7R47FXmESfQ
kd6N2BW7wZ69HotE7YP3jMc9gJMtjq5oN0/OcLEZVQPR0/hLR3VALb61F7w6Errw
6kCRUU75IpN2bJKzAej3cf2vAVD1t4hx70F0xuiDQjPzwoHJ/b8=
=k9RI
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
