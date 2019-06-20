Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CDF2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfFTH55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:57:57 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33601 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfFTH54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:57:56 -0400
X-Originating-IP: 90.88.23.150
Received: from localhost (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 45FB72000A;
        Thu, 20 Jun 2019 07:57:50 +0000 (UTC)
Date:   Thu, 20 Jun 2019 09:57:49 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH 1/4] dt-bindings: display: Convert common panel
 bindings to DT schema
Message-ID: <20190620075749.o6i76exxhe2xbpfo@flea>
References: <20190619215156.27795-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4oxwmcz4cekh22my"
Content-Disposition: inline
In-Reply-To: <20190619215156.27795-1-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4oxwmcz4cekh22my
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2019 at 03:51:53PM -0600, Rob Herring wrote:
> Convert the common panel bindings to DT schema consolidating scattered
> definitions to a single schema file.
>
> The 'simple-panel' binding just a collection of properties and not a
> complete binding itself. All of the 'simple-panel' properties are
> covered by the panel-common.txt binding with the exception of the
> 'no-hpd' property, so add that to the schema.
>
> As there are lots of references to simple-panel.txt, just keep the file
> with a reference to panel-common.yaml for now until all the bindings are
> converted.
>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4oxwmcz4cekh22my
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQs8fQAKCRDj7w1vZxhR
xWqfAQC4mg5/Loj8+ISTLoz6dZc1DK9gRuM+Zd0n3nqR5qy78gEA6zQubCUl5ZuG
Q2QwmDebJXYojsaueg4Yq1I2Jd28oQE=
=8Jp7
-----END PGP SIGNATURE-----

--4oxwmcz4cekh22my--
