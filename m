Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6B6C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DBC207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCIJoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 04:44:55 -0500
Received: from sauhun.de ([88.99.104.3]:39986 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfCIJoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 04:44:55 -0500
Received: from localhost (p5486CD1C.dip0.t-ipconnect.de [84.134.205.28])
        by pokefinder.org (Postfix) with ESMTPSA id 2325F2E3551;
        Sat,  9 Mar 2019 10:44:53 +0100 (CET)
Date:   Sat, 9 Mar 2019 10:44:52 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Shikai Wang <sxauwsk@163.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: cadence: try reset when master receive
 arbitration lost
Message-ID: <20190309094452.GB1340@kunai>
References: <20190219012447.5900-1-sxauwsk@163.com>
 <20190223094842.GF1018@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <20190223094842.GF1018@kunai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2019 at 10:48:43AM +0100, Wolfram Sang wrote:
> On Tue, Feb 19, 2019 at 09:24:47AM +0800, Shikai Wang wrote:
> > When the adapter receive arbitration lost error interrupts,
> > cdns_i2c_master_xfer return to the caller directly instead of resetting
> > the adapter which resulted in the adapter being out of control.
> >=20
> > So when driver detect err_status such as arbitration lost,
> > then try to repair and fix it.
>=20
> Just checking because resetting looks like a big hammer to me: there is
> no way to gracefully recover form 'arbitration lost' interrupt?

I am still wondering about this but since it is acked by the maintainer:

Applied to for-current, thanks!


--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyDixQACgkQFA3kzBSg
KbZoDw//dfwpM+U7L54v9ts0GdpP/4y51a7yCJmrs40qEaLaK/8v04JW8o0/4UaR
K6YHGGT7EYLcs/eYleYQh9Pyjzj5RdxlnPcMHjUrWFCt0P+z1m0b4yJQpRoYbIH1
a+BHvWoddxJ/U+McGLHqoBHXh7NX2J5wMVdNjh+e46Lxvt3i3KMsJzNDY5XsRpA1
i0PiyhZ3P1THw+X7DRYxIOptqXpjXWEuRKoNDjG/SN5eTPFzsyCV6F/WBqhQZ2T8
SU8+XbxrDIuy/eh0WwPp2kl4UWLAtxb/ZEsD5alVzWBcLOVVnJ6cayIEeSmrCelh
djmNwN9PEP128vtoWYaHY74MgStj4X4IDVpJOSUYTsJMwMzQwEjVeHwVwZr9nmsv
S0c33NsSJwQJB7SpgET+j9JWaALGmSZLB0G7gyOPTNVXcPWmNn9X88ul61xIKIba
Au7pTg9fokkNMi6yWPosaKRVXO4RDc28xbp3rz9B0NhKBi28l4Bkwx4bOo0ydX7e
ho+QCENy7Dk4EkcXR6s4THiywDdNj2sKsQnMhRKNvqeMKf3sA/O0W+loUXE3oF4j
hhvAG8eLsUtnQlDwNnI/WK0c8cnr/PZaiCeBu7nkxBWiECX8+YU8Bw4WKFKUFDPD
rjGK0/8X96kgadurkDZJ5jg9QRcjX7GTf7UMgIC3M7gKsrQCZ4A=
=eNxl
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
