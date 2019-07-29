Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8403C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8A621773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564443850;
	bh=IxOu/iSvnh/L0ZVNT/mjrBwuShkqS1cn9KOIl+RrKJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w1uDHCI2Lgxew07GcyBDLhqQCSInp2r6g64xuRoD6DFQCqQ9FFkifVSWTxGz0cypF
	 ggb6GOZOoNPm4FZSdVim+vh3gBOl2SzdxBqtOqQlz1Y7s8j04SKANITT4pB8ZAVwf4
	 rdQiwrRgnZdmhOY99GvRRXNh2RKuOTwyu7zw5oc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfG2XoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbfG2XoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:44:08 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F83421773;
        Mon, 29 Jul 2019 23:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564443847;
        bh=IxOu/iSvnh/L0ZVNT/mjrBwuShkqS1cn9KOIl+RrKJk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r95SCpHEMs9q9vTklvT2DcO7DVoioYsxCpnyXW/92OPQywcixAqLI0Yt1IOES73b5
         UATEroFniVQYZxHsWqsby/Gv9drl9vt1OTX6duOvubSzXHVG2amm7nHTiuFtiF24+z
         8gv+0ph9NR1IdjzZaGOrFMpKY5MhiGs0Uduzgncs=
Received: by mail-qk1-f175.google.com with SMTP id w190so45288035qkc.6;
        Mon, 29 Jul 2019 16:44:07 -0700 (PDT)
X-Gm-Message-State: APjAAAUy6gzZCUzvXQC0+KPVtqKATAvMMXQXE3SmOtau52D+PAt/fdeV
        QMtkY1YpzuQwNQvCt/YleNhtFuTCHYpE0RAwXQ==
X-Google-Smtp-Source: APXvYqzgNhcznp2+LVmYunsMkWxwj73/VsAe1JVQ931+ebUN7alNApAeftUQlmusggGCH8szHpLFoGVGMQwGn00/cZ4=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr9950009qke.393.1564443846662;
 Mon, 29 Jul 2019 16:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190721175915.27192-1-martin@kaiser.cx> <20190729114531.12386-1-martin@kaiser.cx>
 <20190729114531.12386-2-martin@kaiser.cx>
In-Reply-To: <20190729114531.12386-2-martin@kaiser.cx>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Jul 2019 17:43:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfMhR819mxTtam8AJQmy321-b1ut0az+tpPARE3HWzmg@mail.gmail.com>
Message-ID: <CAL_JsqLfMhR819mxTtam8AJQmy321-b1ut0az+tpPARE3HWzmg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: potentiometer: add max5432.yaml binding
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 5:46 AM Martin Kaiser <martin@kaiser.cx> wrote:
>
> Add a binding for the Maxim Integrated MAX5432-MAX5435 family of digital
> potentiometers.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> changes in v3
>  - split dt bindings and driver code into separate patches
>  - use yaml format for dt bindings
>  - fix formatting of parameter lists
>
> changes in v2
>  - use MAX5432_ prefix for all defines
>  - fix indentation
>  - convert void * to unsigned long, not to u32
>    (warning from kbuild test robot)
>
>  .../bindings/iio/potentiometer/max5432.yaml        | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5432.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/max5432.yaml b/Documentation/devicetree/bindings/iio/potentiometer/max5432.yaml
> new file mode 100644
> index 000000000000..448781b80f39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/max5432.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/potentiometer/max5432.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim Integrated MAX5432-MAX5435 Digital Potentiometers
> +
> +maintainers:
> +  - Martin Kaiser <martin@kaiser.cx>
> +
> +description: |
> +  Maxim Integrated MAX5432-MAX5435 Digital Potentiometers connected via I2C
> +
> +  Datasheet:
> +    https://datasheets.maximintegrated.com/en/ds/MAX5432-MAX5435.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max5432
> +      - maxim,max5433
> +      - maxim,max5434
> +      - maxim,max5435
> +

reg?

Also, add an 'additionalProperties: false' line. This means other
properties can't be present (except 'status' and a few we
automatically add).

> +examples:
> +  - |
> +    i2c0 {

i2c {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      max5434@28 {
> +        compatible = "maxim,max5434";
> +        reg = <0x28>;
> +      };
> +    };
> --
> 2.11.0
>
