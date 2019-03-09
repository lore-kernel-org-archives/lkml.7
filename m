Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC6C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4493F207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfCIJtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 04:49:07 -0500
Received: from sauhun.de ([88.99.104.3]:40032 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfCIJtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 04:49:07 -0500
Received: from localhost (p5486CD1C.dip0.t-ipconnect.de [84.134.205.28])
        by pokefinder.org (Postfix) with ESMTPSA id 52A6F2E3551;
        Sat,  9 Mar 2019 10:49:05 +0100 (CET)
Date:   Sat, 9 Mar 2019 10:49:04 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Shikai Wang <sxauwsk@163.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: cadence: try reset when master receive
 arbitration lost
Message-ID: <20190309094904.GC1340@kunai>
References: <20190219012447.5900-1-sxauwsk@163.com>
 <20190223094842.GF1018@kunai>
 <20190309094452.GB1340@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <20190309094452.GB1340@kunai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 09, 2019 at 10:44:52AM +0100, Wolfram Sang wrote:
> On Sat, Feb 23, 2019 at 10:48:43AM +0100, Wolfram Sang wrote:
> > On Tue, Feb 19, 2019 at 09:24:47AM +0800, Shikai Wang wrote:
> > > When the adapter receive arbitration lost error interrupts,
> > > cdns_i2c_master_xfer return to the caller directly instead of resetti=
ng
> > > the adapter which resulted in the adapter being out of control.
> > >=20
> > > So when driver detect err_status such as arbitration lost,
> > > then try to repair and fix it.
> >=20
> > Just checking because resetting looks like a big hammer to me: there is
> > no way to gracefully recover form 'arbitration lost' interrupt?
>=20
> I am still wondering about this but since it is acked by the maintainer:
>=20
> Applied to for-current, thanks!

Oops, I was mixing this up with

[PATCHv4] i2c: cadence: Fix the driver in interrupt flurry case

This one doesn't have an ack from Michal. Dropping it again.


--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyDjBAACgkQFA3kzBSg
KbaNaw//drTiJ6nzanbRXofjnVzseQyZs4VIU81qISXsTCU3yKYn2afB4Le7tWpd
ke18r/D6tueNg+qCTGazP8hYGNz7FEyR5zvtCcpIVRh1vJG+J0R0us83NZJnmcVu
TBcuaOpzFMxzYQ8y1jGI3uaNlvFvxw36u2jg/IAhoPK+Mc/1KVbKMyrbavp9B0E+
eqN2vyfkHDC+RVNq3x5HnUyUdRQTDvoKEEBEP3YN1Z7tPpcW6b8ZnO4y5DWMXBnN
hxC5O1Ba9t8rIPlEFIu2p43FEPbVvIVH7o2HKq5NYR6toEe8Z0cDIf9WFE2qwg+X
d0QERdjFxK5lcni8XFN9cVe4u2h23gNiWbYdsfEMG9FOQ1c/qQM4BjdjMVATDv0o
iQ4ExRqL5orBSAY5XJhWceSF0gbfFtiyizTVD2b5Z3jrAFDEVw0xfVEgMo3oN9qf
hNX4hRcsxTz1Ayr4Y9qOjS4fMuLC2czoq0pxAprq2VmLlwSJ9rCBPrYeBEvJXHGu
oFlmkkIVIIQlFh9065ub4PnxoLCiRzFt8ZWHVQ9hiPECA5XTgXxCHeces9EcAH1L
lRQp5f9xpSMDIqZbyKnNmXKxD5BTzQE05AFxxv6P5WMea+Uc9r9Q8APr6J9dO3E2
mai2zT2+MouaFOePNpjIb63bH6++7+9tvX1Uj6bcW+Hc36Ht8Ug=
=Efbh
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
