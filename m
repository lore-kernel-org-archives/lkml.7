Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49551C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204DF20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDHIBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:01:02 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33409 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfDHIBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:01:02 -0400
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D180A100010;
        Mon,  8 Apr 2019 08:00:56 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:00:56 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     megous@megous.com
Cc:     wens@csie.org, robh@kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        mark.rutland@arm.com, Ziping Chen <techping.chan@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-input@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH RESEND v4 3/4] ARM: dts: sunxi: Add R_LRADC support for
 A83T
Message-ID: <20190408080056.lfzjxfkvs65oabuu@flea>
References: <20190327023339.25975-1-megous@megous.com>
 <20190327023339.25975-4-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h4pyodfm67kr7ci6"
Content-Disposition: inline
In-Reply-To: <20190327023339.25975-4-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h4pyodfm67kr7ci6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 03:33:38AM +0100, megous@megous.com wrote:
> From: Ziping Chen <techping.chan@gmail.com>
>
> Allwinner A83T SoC has a low res adc like the one in Allwinner A10 SoC.
> Now the driver has been modified to support it.
>
> Add support for it.
>
> Signed-off-by: Ziping Chen <techping.chan@gmail.com>

It's missing your SoB.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--h4pyodfm67kr7ci6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKr/uAAKCRDj7w1vZxhR
xQe3APwPV/uNMtJCYZdEY980nSAiLJrsBoNliOj1MZJUiPZceQEAhuyV7OZ0bleI
7gl7pHo5BIy+S04DW3S+AraKXKOkfw4=
=kjpd
-----END PGP SIGNATURE-----

--h4pyodfm67kr7ci6--
