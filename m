Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F6EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB06C21734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EWcXliNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406806AbfFKSDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:03:34 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36220 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406723AbfFKSDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:03:33 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 28BD32AF;
        Tue, 11 Jun 2019 20:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1560276211;
        bh=exWMQpzVUcVHbArclfchPQA20MY/zWqw3zj3LWT3EWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWcXliNyKKtOO/SjPheM3h6upHk9ZqRoe9SojrbSZElysefFhoOiKK5BZxyrCCuMe
         rQ9suCr4VtdEkkjJ3d5hcTBZ7Z7FZW/rwIo1IzOpdQEjQGbw5HaA60UMBus69bF5gB
         BB9xoqtbaPqC+Naa6cZlwUpaEucDEGxLJRs43PNI=
Date:   Tue, 11 Jun 2019 21:03:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michael Drake <michael.drake@codethink.co.uk>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
Subject: Re: [PATCH v1 01/11] dt-bindings: display/bridge: Add bindings for
 ti948
Message-ID: <20190611180316.GS5016@pendragon.ideasonboard.com>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
 <20190611140412.32151-2-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611140412.32151-2-michael.drake@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch.

On Tue, Jun 11, 2019 at 03:04:02PM +0100, Michael Drake wrote:
> Adds device tree bindings for:
> 
>   TI DS90UB948-Q1 2K FPD-Link III to OpenLDI Deserializer
> 
> The device has the compatible string "ti,ds90ub948", and
> and allows an arrray of strings to be provided as regulator

s/arrray/array/

> names to enable for operation of the device.
> 
> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
>  .../bindings/display/bridge/ti,ds90ub948.txt  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
> new file mode 100644
> index 000000000000..f9e86cb22900
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
> @@ -0,0 +1,24 @@
> +TI DS90UB948-Q1 2K FPD-Link III to OpenLDI Deserializer
> +=======================================================
> +
> +This is the binding for Texas Instruments DS90UB948-Q1 bridge deserializer.
> +
> +This device supports I2C only.

Then the DT node should be a child of its I2C controller, and have a reg
property.

> +
> +Required properties:
> +
> +- compatible: "ti,ds90ub948"
> +
> +Optional properties:
> +
> +- regulators: List of regulator name strings to enable for operation of device.

There's a standard binding for regulators, using *-supply properties.
Please use them.

You should also use the OF graph DT bindings to model the data
connections.

> +
> +Example
> +-------
> +
> +ti948: ds90ub948@0 {
> +	compatible = "ti,ds90ub948";
> +
> +	regulators: "vcc",
> +	            "vcc_disp";
> +};

-- 
Regards,

Laurent Pinchart
