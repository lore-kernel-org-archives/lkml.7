Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B47C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05652184D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfFNUa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:30:56 -0400
Received: from sauhun.de ([88.99.104.3]:56660 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfFNUay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:54 -0400
Received: from localhost (p5486CF81.dip0.t-ipconnect.de [84.134.207.129])
        by pokefinder.org (Postfix) with ESMTPSA id C679A2CF690;
        Fri, 14 Jun 2019 22:30:52 +0200 (CEST)
Date:   Fri, 14 Jun 2019 22:30:51 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andreas Noever <andreas.noever@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Corey Minyard <minyard@acm.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Kershner <david.kershner@unisys.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Airlie <airlied@linux.ie>,
        Felipe Balbi <balbi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Jamet <michael.jamet@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v2 04/28] bus_find_device: Unify the match callback with
 class_find_device
Message-ID: <20190614203051.GA7991@kunai>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-5-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <1560534863-15115-5-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 06:53:59PM +0100, Suzuki K Poulose wrote:
> There is an arbitrary difference between the prototypes of
> bus_find_device() and class_find_device() preventing their callers
> from passing the same pair of data and match() arguments to both of
> them, which is the const qualifier used in the prototype of
> class_find_device().  If that qualifier is also used in the
> bus_find_device() prototype, it will be possible to pass the same
> match() callback function to both bus_find_device() and
> class_find_device(), which will allow some optimizations to be made in
> order to avoid code duplication going forward.  Also with that, constify
> the "data" parameter as it is passed as a const to the match function.
>=20
> For this reason, change the prototype of bus_find_device() to match
> the prototype of class_find_device() and adjust its callers to use the
> const qualifier in accordance with the new prototype of it.

Acked-by: Wolfram Sang <wsa@the-dreams.de> # for the I2C parts


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0EA/cACgkQFA3kzBSg
KbbXHBAAstp9GpPxsxW8LEQOVfaMLoMg9Dnm0OuY4goxVWlgniJP6l0iDHJlYr35
QxpIPfO7Hg9F5jykwiY7mppMva+ORnWPpoeKNCUl5D/4DhYyteQJTay9YeH15YAf
jg6hBpIHFXaQ1Pjb2ffw4m/sUtxT+69SjUdtzHOvfsP6v3ASIc76xlK/bC9IOawr
bGbpbdX8PMGbq0v1DlF/1VjeWFHAvkO1/bnMFrZSczAtJyLnSyH43wNMyOIbHC/P
hN4qbazCTw2uofmlV9yIDwa5ByiTH+DVDJbwhzE3wPqnTmJrFhH4wqhdfaFyvm9W
4VLIGOOBzsr4vCwVCpwL5XCgYnuOIMVB3fHoehmWH052O495D0yxTvu5M6zHZVp8
MJ/m5t/8D1PBDExf1THKVC5p2C/i+Qy0hbTo1jHN7uxgx6qTE/9/xPC8TS0E2vXe
TEs7HJtni+uZhOojf85CqpJYeUrvkjadriphh/dYKt2cepPCsmbpI8ko+Waeam8I
KM4gDxBTtInIAiw+5VfGmA1z9ijz69ol0yQfLPbr4OmOqLt54e1j183EJuyDSXpD
P621n54QpbOmnNymvjXZxSanlFTMuWudI3ahHaaKrVex1nTDTXriA0LvQywqCjQo
Sf5pz6vvfxrb4G+0YB8gt0gBQLytl7OHJWhIBvosSo39VLFv7VQ=
=59Uk
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
