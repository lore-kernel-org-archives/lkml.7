Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70471C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 10:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EEB20838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 10:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577355195;
	bh=XKgSXeOZ0xu54J+uvOH0sgeJ1AtiZFyRjKDwwibbcW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kHKbo/Y/0whmrswxwR7CyAHFBcXuvAfR7Kz0fUn0uY+kCPrH7jgEKR5O8dwJ8V5oe
	 0/tDKJ5uFKTiT+ki0ktpC1o8K0xK0ShkEAI+RO+CVoEelA89FFRmHnQdF8jwRg4xE1
	 sF3VqYSf8Yjq7p+uL32OKGftWPG/hYbA94Hto/fU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfLZKNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 05:13:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfLZKNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 05:13:14 -0500
Received: from localhost (lfbn-lyo-1-633-204.w90-119.abo.wanadoo.fr [90.119.206.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39CD206CB;
        Thu, 26 Dec 2019 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577355192;
        bh=XKgSXeOZ0xu54J+uvOH0sgeJ1AtiZFyRjKDwwibbcW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KwTdXUr1oybIqcY+zz8Tn7EC3Hclm9AVvfiTY3R0W08IEvfxOAeOIFuevCq/W7lkK
         EfgIdzfGctRyFoUIaNcOdrihgZEBrD+Q/erSrApvVu15Tr0XI8y85f2mb/7YVqPjKu
         fU0bQSkvA0Rkxj0LCb1S+JLLDXGl9GV8PJ/aSnX4=
Date:   Thu, 26 Dec 2019 11:14:33 +0100
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
Message-ID: <20191226101433.is5jqzkn3f7qv6jt@hendrix.home>
References: <20191215042455.51001-1-samuel@sholland.org>
 <20191215042455.51001-3-samuel@sholland.org>
 <20191216140422.on4bredklgdxywbw@gilmour.lan>
 <d3a1c7c2-953a-cbfe-970e-c00f9a9f5742@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="emgowsokxyl7s5kc"
Content-Disposition: inline
In-Reply-To: <d3a1c7c2-953a-cbfe-970e-c00f9a9f5742@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--emgowsokxyl7s5kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Dec 16, 2019 at 01:45:08PM -0600, Samuel Holland wrote:
> On 12/16/19 8:04 AM, Maxime Ripard wrote:
> > Hi,
> >
> > On Sat, Dec 14, 2019 at 10:24:49PM -0600, Samuel Holland wrote:
> >> This mailbox hardware is present in Allwinner sun6i, sun8i, sun9i, and
> >> sun50i SoCs. Add a device tree binding for it. As it has only been
> >> tested on the A83T, A64, H3/H5, and H6 SoCs, only those compatibles are
> >> included.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  .../mailbox/allwinner,sun6i-a31-msgbox.yaml   | 78 +++++++++++++++++++
> >>  1 file changed, 78 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
> >> new file mode 100644
> >> index 000000000000..dd746e07acfd
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
> >> @@ -0,0 +1,78 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/mailbox/allwinner,sun6i-a31-msgbox.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Allwinner sunxi Message Box
> >> +
> >> +maintainers:
> >> +  - Samuel Holland <samuel@sholland.org>
> >> +
> >> +description: |
> >> +  The hardware message box on sun6i, sun8i, sun9i, and sun50i SoCs is a
> >> +  two-user mailbox controller containing 8 unidirectional FIFOs. An interrupt
> >> +  is raised for received messages, but software must poll to know when a
> >> +  transmitted message has been acknowledged by the remote user. Each FIFO can
> >> +  hold four 32-bit messages; when a FIFO is full, clients must wait before
> >> +  attempting more transmissions.
> >> +
> >> +  Refer to ./mailbox.txt for generic information about mailbox device-tree
> >> +  bindings.
> >> +
> >> +properties:
> >> +  compatible:
> >> +     items:
> >> +      - enum:
> >> +          - allwinner,sun8i-a83t-msgbox
> >> +          - allwinner,sun8i-h3-msgbox
> >> +          - allwinner,sun50i-a64-msgbox
> >> +          - allwinner,sun50i-h6-msgbox
> >> +      - const: allwinner,sun6i-a31-msgbox
> >
> > This will fail for the A31, since it won't have two compatibles but
> > just one.
>
> You asked me earlier to only include compatibles that had been tested, so I did.
> This hasn't been tested on the A31, so there's no A31-only compatible.

The binding is the description, and that description already matches
the A31 compatible, and it's completely abstract from whether we have
software to support it.

We have bindings that have no drivers in the tree for example, but are
just there to make the representation complete.

In this case, we shouldn't enable it in the A31 DTSI, but we should
document the binding properly.

> >> +  '#mbox-cells':
> >> +    const: 1
> >
> > However, you should document what the argument is about?
>
> Ok. "Number of cells used to encode a mailbox specifier" should work.

It's not really what I meant, what I meant is what is is that
specifier you're talking about here. The customers' mailbox properties
will have a phandle and a number: what is this number representing?

Maxime

--emgowsokxyl7s5kc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXgSICQAKCRDj7w1vZxhR
xcTaAP9BWdxgvK6iqBRFqkPE4oDAfjIRlh8hIgMDnZ2PpAYrggEAxyvUS1jgv0e/
PC/VTzMBZCU8znd1SCHWpM660gfLeQI=
=zc+u
-----END PGP SIGNATURE-----

--emgowsokxyl7s5kc--
