Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E4C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB3E222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576754296;
	bh=uCfcUnxh33PvYAWYuAPadawClgv248lIzEeHpmP7iA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N0kQtCInU5LzicnpMJiKQuk2rZbaw8H6wWzDuIZ8ZpW9YYEg00+rmKew6iJhD0cC2
	 gkYRzd4k1FzYypB+TLpSJkskdbx24t8iwhMO1GV3MfuHOvhLrmK+MbPlX5h4YF9X8B
	 c0UTyeDIA3SNxcZsYDY6qFqRjVp9OwZ8dhVpATe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLSLSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfLSLSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:18:15 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A5C218AC;
        Thu, 19 Dec 2019 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576754294;
        bh=uCfcUnxh33PvYAWYuAPadawClgv248lIzEeHpmP7iA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/6si3b5D2Gkeyp7E+0HbQ+19rW6och0NnRFRcGxeQSjZwyNY1cODUWopKOvIt4Sd
         X0KJmA3d8ftdMASedreqirI+aEJZ9FVHwWDjWbzEGFOYbyJny3OZJpQDyHiol/bv5e
         G4msj0Y8B3xiaQjDmSJTC6u28WZG5UGv9eViUczA=
Date:   Thu, 19 Dec 2019 12:18:11 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de, shawnguo@kernel.org,
        laurent.pinchart@ideasonboard.com, icenowy@aosc.io,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: regulator: add document bindings for
 mpq7920
Message-ID: <20191219111811.6e3m3qvuijfi6ew6@gilmour.lan>
References: <20191219103721.10935-1-sravanhome@gmail.com>
 <20191219103721.10935-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yqt63ee6xqsyxvu7"
Content-Disposition: inline
In-Reply-To: <20191219103721.10935-3-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yqt63ee6xqsyxvu7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Dec 19, 2019 at 11:37:19AM +0100, Saravanan Sekar wrote:
> Add device tree binding information for mpq7920 regulator driver.
> Example bindings for mpq7920 are added.
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../bindings/regulator/mpq7920.yaml           | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml
>
> diff --git a/Documentation/devicetree/bindings/regulator/mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
> new file mode 100644
> index 000000000000..79000b745cfd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mpq7920.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power System MPQ7920 PMIC
> +
> +maintainers:
> +  - Saravanan Sekar <sravanhome@gmail.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "mpq@[0-9a-f]{1,2}"

The node name is supposed to be the class of the device, so pmic or
regulator seems more suited here.

> +  compatible:
> +    enum:
> +	- mps,mpq7920
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: string
> +    description: |
> +      list of regulators provided by this controller, must be named
> +      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
> +      The valid names for regulators are
> +      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5

This should be an enum with the valid values

> +
> +    properties:
> +       mps,time-slot:

I'm not sure what this is supposed to be doing?

Is that another property in the regulator node, or regulators is
supposed to be a node?

> +         - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       description: |
> +         power on/off sequence time slot/interval must be one of following values
> +         With:
> +          * 0: 0.5ms
> +          * 1: 2ms
> +          * 2: 8ms
> +          * 3: 16ms
> +          Defaults to 0.5ms if not specified.

So it's not an array, but just a single value?

Either wai, the valid values should be an enum, and the default
specified using the default keyword.

> +
> +    properties:
> +       mps,fixed-on-time:

You don't need to set properties all the time.

> +          - $ref: "/schemas/types.yaml#/definitions/boolean"
> +       description: |
> +           select power on sequence with fixed time interval mentioned in
> +           time-slot reg for all the regulators.

Can't you just derive that from the fact that time-slot is present?

> +    properties:
> +       mps,fixed-off-time:
> +          - $ref: "/schemas/types.yaml#/definitions/boolean"
> +       description: |
> +          select power off sequence with fixed time interval mentioned in
> +          time-slot reg for all the regulators.

Same thing here

> +    properties:
> +       mps,inc-off-time:
> +          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       description: |
> +          An array of 8, linearly increase power off sequence time
> +          slot/interval for each regulator must be one of following values
> +         * 0 to 15

This should be an enum, or a combination of minimum/maximum. And the
size of the array should be fixed too.

> +    properties:
> +       mps,inc-on-time:
> +          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       description: |
> +          An array of 8, linearly increase power on sequence time
> +          slot/interval for each regulator must be one of following values
> +          * 0 to 15

Ditto,

> +    properties:
> +       mps,switch-freq:
> +          - $ref: "/schemas/types.yaml#/definitions/uint8"
> +       description: |
> +          switching frequency must be one of following values
> +          * 0 : 1.1MHz
> +          * 1 : 1.65MHz
> +          * 2 : 2.2MHz
> +          * 3 : 2.75MHz
> +          Defaults to 2.2 MHz if not specified.

enum and default

> +    properties:
> +       mps,buck-softstart:
> +          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       description: |
> +          An array of 4 contains soft start time of each buck, must be one of
> +          following values
> +          * 0 : 150us
> +          * 1 : 300us
> +          * 2 : 610us
> +          * 3 : 920us
> +          Defaults to 300us if not specified.

Same story than mps,inc-off-time

> +    properties:
> +       mps,buck-ovp:
> +          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       description: |
> +           An array of 4 contains over voltage protection of each buck, must be
> +           one of following values
> +           * 0 : disabled
> +           * 1 : enabled
> +           Defaults is enabled if not specified.

Ditto

> +    properties:
> +        mps,buck-phase-delay:
> +          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       description: |
> +           An array of 4 contains each buck phase delay must be one of following
> +           values
> +           * 0: 0deg
> +           * 1: 90deg
> +           * 2: 180deg
> +           * 3: 270deg
> +           Defaults to 0deg for buck1 & buck2, 90deg for buck3 & buck4 if not
> +           specified.

ditto

> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mpq7920@69 {
> +	  compatible = "mps,mpq7920";
> +          reg = <0x69>;
> +
> +          mps,switch-freq = <1>;
> +          mps,buck-softstart = /bits/ 8 <1 2 1 3>;
> +          mps,buck-ovp = /bits/ 8 <1 0 1 1>;
> +
> +          regulators {
> +            buck1 {

So regulators isn't a string after all?

If it's supposed to be a node, it should be type: object

and you can check that the node has a valid value using propertyNames

Maxime

--yqt63ee6xqsyxvu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXftccwAKCRDj7w1vZxhR
xU4wAP9CjzOBCIts5MjFAsKirU/odMTpDcippKeKU9HZ77MYzgD/WHz9CiRGB65G
Rv6j2CQuzQV1YsVR9XBHZnZJro+J/Ag=
=awE3
-----END PGP SIGNATURE-----

--yqt63ee6xqsyxvu7--
