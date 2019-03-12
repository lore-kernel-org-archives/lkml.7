Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06190C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3AC214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCLPw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:52:59 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58133 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfCLPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:52:57 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id CF9EBC001A;
        Tue, 12 Mar 2019 15:52:53 +0000 (UTC)
Date:   Tue, 12 Mar 2019 16:52:53 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: sun6i MIPI DSI driver EoTp
Message-ID: <20190312155253.kdsqgby32jgagdta@flea>
References: <ff953218-219e-7f92-476d-91e2b9904776@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3jzijxynu3ren5ic"
Content-Disposition: inline
In-Reply-To: <ff953218-219e-7f92-476d-91e2b9904776@orpaltech.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3jzijxynu3ren5ic
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 11, 2019 at 09:43:36PM +0300, Sergey Suloev wrote:
> according to MIPI DSI spec chapter 8.8.2=A0 the EoTp packet can be enable=
d or
> disabled on the protocol level.
> It seems like that it might be required for the panel I am working on (Hi=
max
> HX8379A-based panel).
> Here is some crappy driver I found on github showing that it might be an
> issue=A0 [1]
>=20
> May I ask you if this feature supported by sun6i MIPI DSI driver and
> where ?
> As there is no datasheet available, could you please help to support this
> feature (if not yet) ?

I haven't seen any panel that used it so far, so I have no idea.

I guess this would be controlled through
SUN6I_DSI_BASIC_CTL0_HS_EOTP_EN in the driver.

> The second point is that the panel requires NON-BURST-WITH-SYNC-EVENTS mo=
de.
> Could it be a problem with the current driver?

That should be supported in -next

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3jzijxynu3ren5ic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIfV1QAKCRDj7w1vZxhR
xV5oAPsFedPiPD/nq+8Tw50Q+I2KJdaBDg9+bDxvZdQlNYitXAEA/zDjzP4ba6j4
a6V6BxbJdp6FExNa7cu4ndJVMQi5awI=
=j6+k
-----END PGP SIGNATURE-----

--3jzijxynu3ren5ic--
