Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212F8C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DA920748
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfKTOvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:51:19 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49271 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731836AbfKTOvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:51:17 -0500
X-Originating-IP: 90.76.211.102
Received: from aptenodytes (lfbn-1-2154-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id ECDB740005;
        Wed, 20 Nov 2019 14:51:14 +0000 (UTC)
Date:   Wed, 20 Nov 2019 15:51:14 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: Document the Xylon LogiCVC
 display controller
Message-ID: <20191120145114.GB4331@aptenodytes>
References: <20190927100738.1863563-1-paul.kocialkowski@bootlin.com>
 <20190927100738.1863563-2-paul.kocialkowski@bootlin.com>
 <20190927222038.GA22180@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20190927222038.GA22180@bogus>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 27 Sep 19, 17:20, Rob Herring wrote:
> On Fri, Sep 27, 2019 at 12:07:37PM +0200, Paul Kocialkowski wrote:
> > The Xylon LogiCVC is a display controller implemented as programmable
> > logic in Xilinx FPGAs.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../display/xylon,logicvc-display.yaml        | 313 ++++++++++++++++++
> >  1 file changed, 313 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/xylon,log=
icvc-display.yaml
>=20
> Any response to my last mail on v1?

Just answered on that thread, sorry for the delay.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl3VUuIACgkQ3cLmz3+f
v9H6/QgAmZDcI/0gblSW95D8aMF2UP+4tUc1NYzzzlGmCGvAisyVWulup7L5PvSv
uLxiM+7Kmq6KX9A0AOQ00+/d6noUI/sX9Zi6eY3EgyLQMnTNM87Z0SjSkO7oMkv2
67GflREHdXIBr/jOI/tQ1Tqd04otcEN0iy7fzziWrK0gf33JTIhYE/v1k/3HKJyw
jQjAU89SGWCTLrQUnWSXEkW7LyqX1XX/j5uVfeWJOBDdZYrHhpzRLvCRtbYKHqAk
69VZQSm6NsoPtYGaZmuuTzegqphpJ/wG0BdOa8hIofGmGHsiwI//Ndx28cUELQCi
rhXxUVq4zMUePbQId7kIskGuQjC3Kg==
=oRfo
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
