Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5A420896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDAJKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:10:54 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50471 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfDAJKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:10:53 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id ED2B4E003E;
        Mon,  1 Apr 2019 09:10:50 +0000 (UTC)
Date:   Mon, 1 Apr 2019 11:10:50 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     ARM-SoC Maintainers <arm@kernel.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: cpu: Fix JSON schema
Message-ID: <20190401091050.cwph7xlpv3pmkwnq@flea>
References: <20190318100521.29109-1-maxime.ripard@bootlin.com>
 <CAL_JsqJ_LYycXazkdP2Q=e-jynKiX+z5En0bz0AWpDjsevwQTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2tjdwgjf4v6o3rdy"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ_LYycXazkdP2Q=e-jynKiX+z5En0bz0AWpDjsevwQTg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2tjdwgjf4v6o3rdy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sugaya, Arnd, Olof,

On Thu, Mar 28, 2019 at 02:35:54PM -0500, Rob Herring wrote:
> +arm-soc
>
> On Mon, Mar 18, 2019 at 5:05 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Commit fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for
> > Milbeaut") added support for a new cpu enable-method, but did so using
> > tabulations to ident. This is however invalid in the syntax, and resulted
> > in a failure when trying to use that schemas for validation.
> >
> > Use spaces instead of tabs to indent to fix this.
> >
> > Fixes: fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for Milbeaut")
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> This should be applied to arm-soc tree having the commit.

Could you pick up that patch?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2tjdwgjf4v6o3rdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKHVmgAKCRDj7w1vZxhR
xW1YAQCR/A/H5YjdmsVxCdhdYOcorF7S6Kum5Nfjp8cTGgEPmwEAttw3vzwXSa4I
TDaAxsQ3rSpABs4PIS2QDbqgIU2b0wY=
=qVao
-----END PGP SIGNATURE-----

--2tjdwgjf4v6o3rdy--
