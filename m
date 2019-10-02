Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47727C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D64B21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570025972;
	bh=GoZ65xAL0SVjoBf8dzBx9PjDE0FjbTkrG8MBTLxSrlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ngZtWQeWdiop9YlO+33J0GKTP4Fn7Svobwindvcimo8N0cN+XYX7fzGg72OfSioNB
	 rW+7RTm4UffdzQZpaMuEq5YQX7ZzR2rAbtuMNZZFfv6pjbQ1o7PA37nvWr+n+wIZvy
	 uItPj8ekcA3xhMDmvivesBco7JDWX/H4dN+mtqks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfJBOTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:19:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44112 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfJBOT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:19:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id u22so15120787qkk.11;
        Wed, 02 Oct 2019 07:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=ohxhS7j8qWWGNPOAmtHqFz2vVoD0+7/SI/0UtR2WuvI=;
        b=SkpAKRKDBLQKsf1uxaFz7cr4Y7A8v8Ll8bQfrrNkycGcUFc1XnLZX0m7pTRHefH+l5
         /Nv5juJHYgd5nAAuaO+f955PTqoRu0NjO30NsggdoDaGYz8cwbHTWODLgfwvtlAriIc6
         9AUMPBJwUc2JNPyZRTmQfDu4pEod/FkokXI70IgprmcGzFksEerYTz5LN2iENlGzAZQA
         cfhAjLd8qwYCPJnxpKCq7Z0xVWVSGhw5l0EK0sNVDUvEcUa2afqRhkqHskYADWzygKOh
         fHWeLHgWsOA0z5cEwIuIK8mPRSZ4r/hVt9PMy8xQKiFVfFNv5OZq6dJwFEa7OMzoXoU4
         5wNA==
X-Gm-Message-State: APjAAAVd6eqyZa3PceyHmkHR0qPNBoT3N153Xs6/XfWyXvbTdfkVqQBL
        H+Zk9NKg8IomuP54FjTnTw==
X-Google-Smtp-Source: APXvYqwWsLlH+FQ6F+eHLBi8M/PJn/BZl+hY+I2v9eAHVo5zIA7RzJv0id08JFiyhXd55o/TfZDPkQ==
X-Received: by 2002:a37:b702:: with SMTP id h2mr4038210qkf.166.1570025965021;
        Wed, 02 Oct 2019 07:19:25 -0700 (PDT)
Received: from localhost ([132.205.230.8])
        by smtp.gmail.com with ESMTPSA id g45sm10574897qtc.9.2019.10.02.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:19:24 -0700 (PDT)
Message-ID: <5d94b1ec.1c69fb81.bb720.6d97@mx.google.com>
Date:   Wed, 02 Oct 2019 09:19:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: maxbotix,mb1232.yaml: transform to yaml
References: <20190923174605.mhrbmdic3ynaw22o@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923174605.mhrbmdic3ynaw22o@arbad>
X-Mutt-References: <20190923174605.mhrbmdic3ynaw22o@arbad>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 07:46:34PM +0200, Andreas Klinger wrote:
> transform existing documentation of maxbotix,mb1232 ultrasonic ranger
> from text documentation format into yaml.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/maxbotix,mb1232.txt     | 29 -----------
>  .../bindings/iio/proximity/maxbotix,mb1232.yaml    | 56 ++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml

> diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
> new file mode 100644
> index 000000000000..8301a1ad2a47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/maxbotix,mb1232.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MaxBotix I2CXL-MaxSonar ultrasonic distance sensor
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description: |
> +  MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type  mb1202,
> +  mb1212, mb1222, mb1232, mb1242, mb7040 or mb7137 using the i2c interface
> +  for ranging
> +
> +  Specifications about the devices can be found at:
> +  https://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxbotix,mb1202
> +      - maxbotix,mb1212
> +      - maxbotix,mb1222
> +      - maxbotix,mb1232
> +      - maxbotix,mb1242
> +      - maxbotix,mb7040
> +      - maxbotix,mb7137
> +
> +  reg:
> +    description:
> +      i2c address of the device, see also i2c/i2c.txt

Drop this.

> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt used to announce the preceding reading request has finished
> +      and that data is available.  If no interrupt is specified the device
> +      driver falls back to wait a fixed amount of time until data can be
> +      retrieved.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +

Add a:

additionalProperties: false

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    proximity@70 {
> +      compatible = "maxbotix,mb1232";
> +      reg = <0x70>;
> +      interrupt-parent = <&gpio2>;
> +      interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +    };
> -- 
> 2.11.0

