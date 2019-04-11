Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E6BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D87E2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDKMbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:31:00 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39905 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKMbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:31:00 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8A0BF240005;
        Thu, 11 Apr 2019 12:30:55 +0000 (UTC)
Date:   Thu, 11 Apr 2019 14:30:55 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/8] dt-bindings: gpu: add bus clock for Mali Midgard
 GPUs
Message-ID: <20190411123055.bpriih42puliuzoy@flea>
References: <20190411105720.32357-1-peron.clem@gmail.com>
 <20190411105720.32357-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="myl2sgr6sgtdqgpt"
Content-Disposition: inline
In-Reply-To: <20190411105720.32357-3-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--myl2sgr6sgtdqgpt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 12:57:14PM +0200, Cl=E9ment P=E9ron wrote:
> Some SoCs adds a bus clock gate to the Mali Midgard GPU.
>
> Add the binding for the bus clock.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

I'm not quite sure what you did there. If Icenowy is the author and
you're sending that commit on her behalf, then she should have the
authorship of that commit.

If you're the author of that commit, then we Icenowy's SoB is there?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--myl2sgr6sgtdqgpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK8zfwAKCRDj7w1vZxhR
xZ4lAQDP9Q3j0RuJWlCZajpX5CwSRe8E84a7g5izuduy3bZfKwD9GB7qxlqthCzK
nkf6aKAoGARkx8vi4MDpGUCwdyPQGQs=
=8LHD
-----END PGP SIGNATURE-----

--myl2sgr6sgtdqgpt--
