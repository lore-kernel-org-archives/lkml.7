Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1BFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F69D206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577399093;
	bh=m4Ju/o9t4gAgk+H7nnBIXf6IV4gFEYVFIdQdh6R0tUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cxx8VxqGzA3CuUEH8DKVevvotH4kO/KZTqToI7UvyXBXpUsz0qHXf0z8g2TPgbhbY
	 HXYn9d/5nppz5uXT80RAFKECyGVeaXaCvwNgRq0sRnnKjHGWzhnqyNTTl3lEuvFYaf
	 jMWF9k8seEmtj7HgS8Vcg0kxZbPwVd67hQ72GT4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLZWYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:24:52 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36601 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZWYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:24:52 -0500
Received: by mail-io1-f65.google.com with SMTP id r13so14272074ioa.3;
        Thu, 26 Dec 2019 14:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=37uqwtRwSPKrS7mePUoQwRbRxVBQ1BJulsNk0ZshgZ4=;
        b=hW2qpQV1f1r8UgwfPA+eJshGpiDUYDLTwGHOxaA5NxraSPkGomehuIjOLkjEsHy0a7
         vsj2HEBoHgYuAZXp7IKPKpEZaC3Jn5sEXcGQBY7MZds9jEIyowRTvm7RBoaXZFF6a+/l
         lwzx+y9lreGzVJU5UFm4aJGYycAZGIGz8uiJbCCFXZ8ahzSC2mE6kgRz+WNpP/B8lPsy
         SYUj0VCfCCY3vbwxCxPo5VhshmvkUFpFJPLKeY7LCyXj1fKBKrFa0DQg3RbGkU/YHFZ2
         lpaAeztx5LT1OuBUti9Kk75myGktYEX9mUUxjSHU8lS+y/T4tUGrE7Tj9rK7hhpaaKuX
         rRpA==
X-Gm-Message-State: APjAAAUzGO1D9Qf5t/+E5c7NhX8EwI7jcm1a52sT0hgxJoWZq1VCjEUW
        cyW9X07h5Xju5K5TBv8r8Q==
X-Google-Smtp-Source: APXvYqwpmWnPzmhjJucVegrp/qxb0MG6G7PSqjM7NScWUgWQvP5DpgC4uYsIS18fm8wbuiIy81ilQg==
X-Received: by 2002:a5d:8996:: with SMTP id m22mr33343498iol.141.1577399091059;
        Thu, 26 Dec 2019 14:24:51 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m24sm8970619ioc.37.2019.12.26.14.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:24:50 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:24:49 -0700
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: Add documentation for
 Toshiba tc358768
Message-ID: <20191226222449.GA8816@bogus>
References: <20191217101506.18910-1-peter.ujfalusi@ti.com>
 <20191217101506.18910-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217101506.18910-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:15:05PM +0200, Peter Ujfalusi wrote:
> TC358768/TC358778 is a Parallel RGB to MIPI DSI bridge.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../display/bridge/toshiba,tc358768.yaml      | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> new file mode 100644
> index 000000000000..8f96867caca0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/toshiba,tc358768.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toschiba TC358768/TC358778 Parallel RGB to MIPI DSI bridge
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@ti.com>
> +
> +description: |
> +  The TC358768/TC358778 is bridge device which converts RGB to DSI.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - toshiba,tc358768
> +      - toshiba,tc358778
> +
> +  reg:
> +    maxItems: 1
> +    description: base I2C address of the device
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to active low RESX pin
> +
> +  vddc-supply:
> +    maxItems: 1

Drop this. Not an array. *-supply doesn't need further constraints.

> +    description: Regulator for 1.2V internal core power.
> +
> +  vddmipi-supply:
> +    maxItems: 1
> +    description: Regulator for 1.2V for the MIPI.
> +
> +  vddio-supply:
> +    maxItems: 1
> +    description: Regulator for 1.8V - 3.3V IO power.

Blank line here.

> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: refclk
> +
> +  ports:
> +    type: object
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      port@0:
> +        type: object
> +        additionalProperties: false
> +
> +        description: |
> +          Video port for RGB input
> +
> +        properties:
> +          reg:
> +            const: 0
> +
> +        patternProperties:
> +          endpoint:
> +            type: object
> +            additionalProperties: false
> +
> +            properties:
> +              data-lines:
> +                enum: [ 16, 18, 24 ]
> +
> +              remote-endpoint: true
> +
> +        required:
> +          - reg
> +
> +      port@1:
> +        type: object
> +        description: |
> +          Video port for DSI output (panel or connector).
> +
> +        properties:
> +          reg:
> +            const: 1
> +
> +        patternProperties:
> +          endpoint:
> +            type: object
> +            additionalProperties: false
> +
> +            properties:
> +              remote-endpoint: true
> +
> +        required:
> +          - reg

No additionalProperties on this one?

> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddc-supply
> +  - vddmipi-supply
> +  - vddio-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c1 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      dsi_bridge: tc358768@0e {
> +        compatible = "toshiba,tc358768";
> +        reg = <0x0e>;
> +
> +        clocks = <&tc358768_refclk>;
> +        clock-names = "refclk";
> +
> +        /* GPIO line is inverted before going to the bridge */
> +        reset-gpios = <&pcf_display_board 0 1 /* GPIO_ACTIVE_LOW */>;
> +
> +        vddc-supply = <&v1_2d>;
> +        vddmipi-supply = <&v1_2d>;
> +        vddio-supply = <&v3_3d>;
> +
> +        dsi_bridge_ports: ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            rgb_in: endpoint {
> +              remote-endpoint = <&dpi_out>;
> +              data-lines = <24>;
> +            };
> +          };
> +
> +          port@1 {
> +            reg = <1>;
> +            dsi_out: endpoint {
> +              remote-endpoint = <&lcd_in>;
> +            };
> +          };
> +        };
> +      };
> +    };
> +    
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
