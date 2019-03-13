Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F94D20854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="N+C/8P1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfCMStN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:49:13 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58860 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMStN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:49:13 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 82F135AA;
        Wed, 13 Mar 2019 19:49:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552502949;
        bh=mfoesGub1qFyMbTmO+chGDDiViuXbFAfqJLMk5w/hJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+C/8P1LPwXPY3eonA40bS5Fr99iOHJq/NLGiWHgtjPGYq188uvsdjvpnDoljs/AB
         QsydIaV9QWYW3vrUJcdPXlBsHO1UY2YOeY+p8igk25bwmvGe8ICzcjp+9D7utp54An
         fWtMITsZ0pSzS6F3XKYWhmBUkh8jFYgzMcw69140=
Date:   Wed, 13 Mar 2019 20:49:02 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vince Kim <vince.k.kim@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: display: bridge: TI FPD-Link III
 Serializer/Deserializer
Message-ID: <20190313184902.GR4722@pendragon.ideasonboard.com>
References: <20190313183527.22883-1-vince.k.kim@gmail.com>
 <20190313183527.22883-2-vince.k.kim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190313183527.22883-2-vince.k.kim@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vince,

Thank you for the patch.

Are you aware of the "[PATCH 0/7] mfd/pinctrl: add initial support of TI
DS90Ux9xx ICs" patch series
(https://lore.kernel.org/lkml/20181012060314.GU4939@dell/T/) ?

On Wed, Mar 13, 2019 at 11:34:58AM -0700, Vince Kim wrote:
> Add documments of device tree bindings for TI FPD-Link III Serializer
> and Deserializer chips;  DS90UB927, DS90UB949, DS90UB948
> 
> Signed-off-by: Vince Kim <vince.k.kim@gmail.com>
> ---
>  .../bindings/display/bridge/ti,ds90ub9xx.txt  | 39 +++++++++++++++++++
>  .../bindings/display/bridge/ti,fpdlink.txt    | 25 ++++++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub9xx.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,fpdlink.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub9xx.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub9xx.txt
> new file mode 100644
> index 000000000000..351d9cb79ebd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub9xx.txt
> @@ -0,0 +1,39 @@
> +Binding for TI FPD-Link III Bridge Serializers; TI DS90UB927, DS90UB949
> +TI FPD-Link III Bridge Deserializer; DS90UB948
> +
> +Required properties:
> +- compatible: shall be one of
> +		"ti,ds90ub927"
> +		"ti,ds90ub948"
> +		"ti,ds90ub949"
> +- reg: i2c device address
> +
> +
> +Optional properties:
> +- power-en-pin: GPIO pin for power enable
> +- reg_config: register address and value to be written during initialization

That property is a software policy, not a system description. It doesn't
belong in DT.

> +
> +
> +Example:
> +--------
> +I2c-master-node {
> +...
> +	fpdlink_serializer_i2c3: serializer@0c {
> +		status = "okay";
> +		compatible = "ti,ds90ub949";
> +		reg = <0x0c>;
> +	/* Enabling passthrough for GPIO0 on serializer for touchscreen IRQ */
> +		reg_config = <0x0d 0x25>;
> +	};
> +
> +	fpdlink_deserializer_i2c3: deserializer@2c {
> +		status = "okay";
> +		compatible = "ti,ds90ub948";
> +		power-en-pin =  <&gpio9 8  GPIO_ACTIVE_HIGH>;
> +		reg = <0x2c>;
> +		/* 0x90 for DISP enable, 0x9 is for Touch enable on GPIO1 and 2*/
> +		reg_config = <0x1e 0x99>;
> +	};

The connection between the serializer and deserializer, as well as
between those two chips and the other part of the display (or camera)
pipeline should be described using ports (see the OF graph bindings).

> +...
> +}
> +
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,fpdlink.txt b/Documentation/devicetree/bindings/display/bridge/ti,fpdlink.txt
> new file mode 100644
> index 000000000000..2f2e1a269722
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,fpdlink.txt
> @@ -0,0 +1,25 @@
> +Binding for TI FPD-Link III Bridge driver
> +
> +Wrapper DRM Bridge driver for TI FPD-Link III Serializer and Deserializer
> +
> +Required properties:
> +- compatible: "ti,fpdlink"
> +- fpdlink-serializer-i2c-handle: i2c node for TI FPD-Link III serializer driver
> +- fpdlink-deserializer-i2c-handle: i2c node for TI FPD-Link III deserializer driver
> +
> +
> +Example:
> +--------
> +fpdlink_lvds: fpdlink_bridge@0 {
> +	status = "okay";
> +	compatible = "ti,fpdlink";
> +	fpdlink-serializer-i2c-handle = <&fpdlink_serializer_i2c0>;
> +	fpdlink-deserializer-i2c-handle = <&fpdlink_deserializer_i2c0>;
> +};

This doesn't correspond to hardware, you shouldn't have such a node in
DT. Instead your drivers should operate properly using the two nodes
above, corresponding to the serializer and deserializer.

> +
> +consumer: {
> +...
> +	fpdlink-bridge-handle = <&fpdlink_lvds>;

This is very device-specific and would require the consumer to be aware
of fpdlink. You should instead use OF graph to describe connections.

> +...
> +}
> +

-- 
Regards,

Laurent Pinchart
