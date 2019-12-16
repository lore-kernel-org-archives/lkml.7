Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3942C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4FF206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576505067;
	bh=eqhwT21aMAQai25oTPNjuF/wi6Lr8PnjARGwV07MqLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C3uCXmTl7M2gRPjdzHyMyZ9FGdgK5k/YloAuLQWDS3mdoJ3kNZhBZaarlfve21gL4
	 jtM5436mBC6xUkL7UtlNYIvtAJKL5QzQk6uZkLrbWDaP/UtKJ8ES/EthiBazaQRHLD
	 kq28zFaGjQvqlGfzR+CDjftvkC1oooaFKrrkXKR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfLPOE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:04:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfLPOE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:04:26 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C951C206A5;
        Mon, 16 Dec 2019 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576505065;
        bh=eqhwT21aMAQai25oTPNjuF/wi6Lr8PnjARGwV07MqLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8aG72OOaT8znWL8+GmFhVW5bWEDI5ITGF2n2FOZQrOGAZPAK8TwebfG6yZ/idgLI
         72X8kyE2neY4gEQpT7V7jx7S3d/A8I93FNZ7g4n7lf6lWWMvpr01tj0/lLzWy59qJT
         uaTK+pIxRpmLZ3iLVuMB5bPe6qQRh9KJfGq2Dmw0=
Date:   Mon, 16 Dec 2019 15:04:22 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 2/8] dt-bindings: mailbox: Add a sun6i message box
 binding
Message-ID: <20191216140422.on4bredklgdxywbw@gilmour.lan>
References: <20191215042455.51001-1-samuel@sholland.org>
 <20191215042455.51001-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6kpcajowhdygmdk2"
Content-Disposition: inline
In-Reply-To: <20191215042455.51001-3-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6kpcajowhdygmdk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Dec 14, 2019 at 10:24:49PM -0600, Samuel Holland wrote:
> This mailbox hardware is present in Allwinner sun6i, sun8i, sun9i, and
> sun50i SoCs. Add a device tree binding for it. As it has only been
> tested on the A83T, A64, H3/H5, and H6 SoCs, only those compatibles are
> included.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../mailbox/allwinner,sun6i-a31-msgbox.yaml   | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
>
> diff --git a/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
> new file mode 100644
> index 000000000000..dd746e07acfd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/allwinner,sun6i-a31-msgbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner sunxi Message Box
> +
> +maintainers:
> +  - Samuel Holland <samuel@sholland.org>
> +
> +description: |
> +  The hardware message box on sun6i, sun8i, sun9i, and sun50i SoCs is a
> +  two-user mailbox controller containing 8 unidirectional FIFOs. An interrupt
> +  is raised for received messages, but software must poll to know when a
> +  transmitted message has been acknowledged by the remote user. Each FIFO can
> +  hold four 32-bit messages; when a FIFO is full, clients must wait before
> +  attempting more transmissions.
> +
> +  Refer to ./mailbox.txt for generic information about mailbox device-tree
> +  bindings.
> +
> +properties:
> +  compatible:
> +     items:
> +      - enum:
> +          - allwinner,sun8i-a83t-msgbox
> +          - allwinner,sun8i-h3-msgbox
> +          - allwinner,sun50i-a64-msgbox
> +          - allwinner,sun50i-h6-msgbox
> +      - const: allwinner,sun6i-a31-msgbox

This will fail for the A31, since it won't have two compatibles but
just one.

You can have something like this if you want to do it with an enum:

compatible:
  oneOf:
    - const: allwinner,sun6i-a31-msgbox
    - items:
      - enum:
        - allwinner,sun8i-a83t-msgbox
        - allwinner,sun8i-h3-msgbox
        - allwinner,sun50i-a64-msgbox
        - allwinner,sun50i-h6-msgbox
      - const: allwinner,sun6i-a31-msgbox

> +  reg:
> +    items:
> +      - description: MMIO register range

There's no need for an obvious description like this.
Just set it to maxItems: 1

> +
> +  clocks:
> +    maxItems: 1
> +    description: bus clock
> +
> +  resets:
> +    maxItems: 1
> +    description: bus reset
> +
> +  interrupts:
> +    maxItems: 1
> +    description: controller interrupt

Ditto, you can drop the description here.

> +  '#mbox-cells':
> +    const: 1

However, you should document what the argument is about?

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - interrupts
> +  - '#mbox-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sun8i-h3-ccu.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/sun8i-h3-ccu.h>
> +
> +    msgbox: mailbox@1c17000 {
> +            compatible = "allwinner,sun8i-h3-msgbox",
> +                         "allwinner,sun6i-a31-msgbox";
> +            reg = <0x01c17000 0x1000>;
> +            clocks = <&ccu CLK_BUS_MSGBOX>;
> +            resets = <&ccu RST_BUS_MSGBOX>;
> +            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +            #mbox-cells = <1>;
> +    };

Look good otherwise, thanks!
Maxime

--6kpcajowhdygmdk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfeO5gAKCRDj7w1vZxhR
xZz1AP4ummpThYn1v2bFsXFQFsYqcm6TRKjZ8eZz+DriVOSSjAEAgxnXw2btNZrv
PVGRNuENk6kHsBf7eVmnaJa2MVik5Qs=
=/Mdk
-----END PGP SIGNATURE-----

--6kpcajowhdygmdk2--
