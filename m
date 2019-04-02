Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D11C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6AC2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfDBKSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:18:00 -0400
Received: from sauhun.de ([88.99.104.3]:38622 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfDBKSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:18:00 -0400
Received: from localhost (p5486CD10.dip0.t-ipconnect.de [84.134.205.16])
        by pokefinder.org (Postfix) with ESMTPSA id B0C2C2CF606;
        Tue,  2 Apr 2019 12:17:57 +0200 (CEST)
Date:   Tue, 2 Apr 2019 12:17:57 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
Message-ID: <20190402101757.GC2960@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-7-ray.jui@broadcom.com>
 <20190327222439.GC15396@kunai>
 <0b97cacd-9bf4-135a-b2ee-1d51ab380b1c@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <0b97cacd-9bf4-135a-b2ee-1d51ab380b1c@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Note APE is a co-processor that is not visible from the Linux running
> from the host processor.
>=20
> "brcm,iproc-nic-i2c" here is introduced to allow the I2C port from APE
> to be completely owned by the host CPU, to meet the requirement of
> certain use cases. At the same time, the control of the I2C port from
> APE will be disabled.
>=20
> The "brcm,ape-hsls-addr-mask" defines the address translation and be
> programmed into some configuration registers to allow the host to
> directly access the I2C registers of APE. Note those configuration
> registers are owned by the host, and that address is not APE's address
> space nor the host is intending to take over the control of APE.
>=20
> Therefore, I think it makes way more sense to use an address mask type
> of DT property here.

Thanks for the explanation! Well, since Rob is already OK with it, then
so am I.


--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyjNtEACgkQFA3kzBSg
KbZsNhAAqxsHCfBYJ33tztPs31q8C+sO9ENStERBsehhnKVof2x0ArFYXmPzyOU4
J/Fc7OM9vVZhYoogbIxSZvL0ixi/v1WYDCQiyxAEOKOb4kr35gdawRM41KgP9390
9Re6BIB0MdW5pvgoTz2Kypd6StyIHOlinvjC1eSedA4/CXd4n7e5e1k85UqopYpk
7gY1CzTrZ073k/hE6WR9cRmj17TxyWnhQNJw7tmcc+5DUmaOVaNy+n2tUBF40W1a
ALldjj+BwY4oIir4jmfGar4DWUBNW8LYKfZHY63FC9CWPkjNNpSA60yH9V2ZM5wd
LznGq3MBfS6V4yVGaFHkJRp9BQRgkTe1kLxDrNskDxxYfjVcuavf4c7xgdsIXi+m
KDY5voyZxIf5tVq6J/J3fYw2KYn4Ep1DL7RJ0kA/9fmfYD0l+KXTTs+v/ofipWsR
N8+0aJ2xH77H8XoFJtaFqdcVtJmZu+RUXq8O2TvhVxQ7KgHFMW0RyaflJSxcspR/
eMZBLKvCvZrsyZzYf/AH8merQtDWXlO0a7mgc5MbZflZFtWyCOXmBI14o67y6EyA
S60JTbEsLfO7NLvpK2P1DvY2CT9I3UGQPupTBR3vDh5lj3E4Cek9UC+KZ+v4I9CQ
DfDshJFLrmPetrEvx2auDtKuhdI86a7/BwCV3yYqQsqcb/ZsOh0=
=c8Wy
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
