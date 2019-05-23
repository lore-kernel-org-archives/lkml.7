Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA2CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE9420851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfEWJFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:05:48 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59025 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfEWJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:05:48 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6583D1C0022;
        Thu, 23 May 2019 09:05:41 +0000 (UTC)
Date:   Thu, 23 May 2019 11:05:40 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: Add ANX6345 DP/eDP transmitter binding
Message-ID: <20190523090540.nhxrjpz3scx6jt23@flea>
References: <20190523065013.2719D68B05@newverein.lst.de>
 <20190523065400.BD9EB68B05@newverein.lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rseevv2olje4ipja"
Content-Disposition: inline
In-Reply-To: <20190523065400.BD9EB68B05@newverein.lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rseevv2olje4ipja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2019 at 08:54:00AM +0200, Torsten Duwe wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> The anx6345 is an ultra-low power DisplayPort/eDP transmitter designed
> for portable devices.
>
> Add a binding document for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>  .../bindings/display/bridge/anx6345.txt       | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx6345.txt b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> new file mode 100644
> index 000000000000..e79a11348d11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> @@ -0,0 +1,56 @@
> +Analogix ANX6345 eDP Transmitter
> +--------------------------------
> +
> +The ANX6345 is an ultra-low power Full-HD eDP transmitter designed for
> +portable devices.
> +
> +Required properties:
> +
> + - compatible		: "analogix,anx6345"
> + - reg			: I2C address of the device
> + - reset-gpios		: Which GPIO to use for reset
> + - dvdd12-supply	: Regulator for 1.2V digital core power.
> + - dvdd25-supply	: Regulator for 2.5V digital core power.
> +
> +Optional properties:
> +
> + - Video ports for RGB input and eDP output using the DT bindings
> +   defined in [1]

The output node can be optional, but the input one is probably going
to be needed all the time, since otherwise you won't be able to fill
the output port of the upstream device in the graph.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rseevv2olje4ipja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOZiZAAKCRDj7w1vZxhR
xVuoAQD8Ba3TZQabw5gulT70AFWp+5Sbt6VGImJ5sGI0rt0q8gD+JlFZu4467xk+
FfHXnIhv1o34YAkciYHqAXsdLkLl5A4=
=PktN
-----END PGP SIGNATURE-----

--rseevv2olje4ipja--
