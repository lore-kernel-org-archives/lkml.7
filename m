Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57736C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D87214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566937226;
	bh=ijXh+hkphL60QBk0vowa1TEgUgqrTFmFEnXgvKseK2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DYljLP//mm5zcp3pMqwwLwX35ejuCvpT33f/TNT9lDIAkJqM7UyrLYAa2dVdjhnRI
	 5L3m9qvJrPMyNxWSJFWerVC6VcLD7GvCMkd1RNV1V9FBcSmP8Ul6cxNhHTMVAZn23U
	 osUwDJsUYiPJQHZi25eC6+43j0HZhwt533txHz3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfH0UUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:20:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33759 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0UUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:20:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so477862oto.0;
        Tue, 27 Aug 2019 13:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yEs6l2fJU7RmZsOxPVyhORblbcAOtVtSRpHm1RzNSjc=;
        b=cIRPqUIliTuXONmO2IiEaNVWgUL1D2h5ni9lYXeoQbSvg5Flw9lDI1sB+P6Tp4aeud
         8AodjTscUNxVCETlW4IU6CpWhyy5h9YmyZnilC2ipCuuUL7GFSA8xfEXr8Sd+3O9RNHh
         /cEy7BoMSL9LvPrSUmeS49Vi8Qz9+7m4cyyR++nvuf04c7IZWajSDjsGigOU9gIaaiic
         eZn4eFr8RwpqBU+QpvTqvkLWgehfgtxKl8ZpsuOP7oeuDeswIIspLJKHVHbw1bxfKOYY
         sg6eOyGEVvTKAM9HphsURMkl/nwVwMgVUmoYj/iR4bOyGuTujYDZRJq+xCOp/Z807mDv
         pf2Q==
X-Gm-Message-State: APjAAAXoAC+yZ6MqtQWa83xLHCkCnFz3u2xz+a3JEP42SncpFXpps9ZU
        dQkYEl7QBShV1e2Oqc9Bqw==
X-Google-Smtp-Source: APXvYqzrjs49PpZDuNJPU/9JKUModDuntpB/Dbk2/J/J20C5B4I5e2NRQqruQtkzoQr+yDWUgW4LGw==
X-Received: by 2002:a9d:7145:: with SMTP id y5mr389282otj.290.1566937223616;
        Tue, 27 Aug 2019 13:20:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t18sm147987otk.73.2019.08.27.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 13:20:22 -0700 (PDT)
Date:   Tue, 27 Aug 2019 15:20:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, spapothi@codeaurora.org,
        bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v4 1/4] dt-bindings: soundwire: add slave bindings
Message-ID: <20190827202022.GA7783@bogus>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
 <20190823065340.GD2672@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823065340.GD2672@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 12:23:40PM +0530, Vinod Koul wrote:
> On 23-08-19, 00:37, Srinivas Kandagatla wrote:
> > This patch adds bindings for Soundwire Slave devices that includes how
> > SoundWire enumeration address and Link ID are used to represented in
> > SoundWire slave device tree nodes.
> > 
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  .../soundwire/soundwire-controller.yaml       | 75 +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> > new file mode 100644
> > index 000000000000..91aa6c6d6266
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SoundWire Controller Generic Binding
> 
> Controller does not make sense here, why not use spec terminology and
> say "SoundWire Slave Generic Binding"

It's both IMO. It's describing the structure of child devices of a 
controller (aka a bus).

> 
> > +
> > +maintainers:
> > +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > +
> > +description: |
> > +  SoundWire busses can be described with a node for the SoundWire controller
> > +  device and a set of child nodes for each SoundWire slave on the bus.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^soundwire(@.*|-[0-9a-f])*$"

'-[0-9a-f]' was to handle cases like spi-gpio or i2c-gpio. Would a 
bit banged interface be possible here?

> > +
> > +  "#address-cells":
> > +    const: 2
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^.*@[0-9a-f]+$":

If there are distinct fields in the address, they are typically comma 
separated in the unit-address.

> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
> > +      description:
> > +	  Is the textual representation of SoundWire Enumeration
> > +	  address. compatible string should contain SoundWire Version ID,
> > +	  Manufacturer ID, Part ID and Class ID in order and shall be in
> > +	  lower-case hexadecimal with leading zeroes.
> > +	  Valid sizes of these fields are
> > +	  Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
> > +	  and '0x2' represents SoundWire 1.1 and so on.
> > +	  MFD is 4 nibbles
> > +	  PID is 4 nibbles
> > +	  CID is 2 nibbles
> > +	  More Information on detail of encoding of these fields can be
> > +	  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
> > +
> > +      reg:
> > +        maxItems: 1
> > +        description:
> > +          Instance ID and Link ID of SoundWire Device Address.
> 
> This looks better :) Thanks.
> 
> Apart from the minor nit above this looks good to me, I can merge the
> sdw parts if Rob is fine with them.
> 
> Thanks
> 
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +examples:
> > +  - |
> > +    soundwire@c2d0000 {
> > +        #address-cells = <2>;
> > +        #size-cells = <0>;
> > +        compatible = "qcom,soundwire-v1.5.0";

This will probably change once I review it. :)

> > +        reg = <0x0c2d0000 0x2000>;
> > +
> > +        speaker@1 {
> > +            compatible = "sdw10217201000";
> > +            reg = <1 0>;
> > +        };
> > +
> > +        speaker@2 {
> > +            compatible = "sdw10217201000";
> > +            reg = <2 0>;
> > +        };
> > +    };
> > +
> > +...
> > -- 
> > 2.21.0
> 
> -- 
> ~Vinod
