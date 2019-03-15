Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C4FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6E021871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfCOLhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:37:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36523 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfCOLhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:37:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id e4so7339355edi.3;
        Fri, 15 Mar 2019 04:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJz01f1N1PDrlfNq3foi7tphh/syM5Z8B6xx+8J23qE=;
        b=cACaL3I4GJktiGLH+njrQm1wNDew3ztv2b/bT7nmADJD7I6U+30xErnhSMYG39fF4w
         nOZZ9YKdAJGthcKeA2MRa+w/RWC4p+8cMhVoVE8KykRSl6KT1EAQVRueT2qgKzc8AtRN
         wjihamEhh8pb+yzSBxGfq0VjxJPS1ODLNflXmZQqStWHqhFh4eVfk4aZwQAEr9A22D8E
         y7/KgexdL6rXPXID0ONCUifToLv6sPMS/13IJxX6Aymj6CEqPVmN2vnUIfG8HaoPworN
         L/mpm1S4PKMuNDKPnfPvjp0HJWPocA6DTHv23jHmgce5PSbbv4RISwgFctLhcBTAAGuv
         6grg==
X-Gm-Message-State: APjAAAVjXfURS/RQVbfO0uXfy+vmmXp3n/pB5RUP+Ckm6cblv4PbRh95
        xqVZQRk/Ph1gSl4l6yvMKOiZ9Eap0iI=
X-Google-Smtp-Source: APXvYqyk4/dyXCJKJqsush/3yiCbDleANaSUX8ZwfM4ZOXY/jbkG1i5IpWmd4GAjyIM2bXnn0YT/QA==
X-Received: by 2002:a50:95f2:: with SMTP id x47mr2487086eda.270.1552649872231;
        Fri, 15 Mar 2019 04:37:52 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id s9sm561724edb.94.2019.03.15.04.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 04:37:51 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id p8so9226530wrq.6;
        Fri, 15 Mar 2019 04:37:51 -0700 (PDT)
X-Received: by 2002:a5d:4741:: with SMTP id o1mr2189720wrs.188.1552649871360;
 Fri, 15 Mar 2019 04:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190315093651.24978-1-maxime.ripard@bootlin.com>
In-Reply-To: <20190315093651.24978-1-maxime.ripard@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 15 Mar 2019 19:37:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v66gXDU=Bt204dr_6yvUWCg_e0qZ0X+oDTwNjgjTsD2kyQ@mail.gmail.com>
Message-ID: <CAGb2v66gXDU=Bt204dr_6yvUWCg_e0qZ0X+oDTwNjgjTsD2kyQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add YAML description for Allwinner boards
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 5:37 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> We've never had a board compatibles documentation for the Allwinner boards
> so far.
>
> Let's create a json-schema for them.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../devicetree/bindings/arm/sunxi.yaml        | 792 ++++++++++++++++++
>  1 file changed, 792 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunxi.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> new file mode 100644
> index 000000000000..b34d9c5b7fd8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -0,0 +1,792 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR X11)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/sunxi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner platforms device tree bindings
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <maxime.ripard@bootlin.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +

[...]

> +      - description: Sinovoip BananaPi M1 Plus
> +        items:
> +          - const: sinovoip,bpi-m1-plus
> +          - const: allwinner,sun7i-a20
> +
> +      - description: Sinovoip BananaPi M2
> +        items:
> +          - const: sinovoip,bpi-m2
> +          - const: allwinner,sun6i-a31s
> +
> +      - description: Sinovoip BananaPi M2 Berry
> +        items:
> +          - const: sinovoip,bpi-m2-berry
> +          - const: allwinner,sun8i-r40
> +
> +      - description: Sinovoip BananaPi M2 Plus
> +        items:
> +          - const: sinovoip,bpi-m2-plus
> +          - const: allwinner,sun8i-h3
> +
> +      - description: Sinovoip BananaPi M2 Plus
> +        items:
> +          - const: sinovoip,bpi-m2-plus
> +          - const: allwinner,sun50i-h5
> +
> +      - description: Sinovoip BananaPi M2 Plus v1.2
> +        items:
> +          - const: bananapi,bpi-m2-plus-v1.2
> +          - const: allwinner,sun8i-h3
> +
> +      - description: Sinovoip BananaPi M2 Plus v1.2
> +        items:
> +          - const: bananapi,bpi-m2-plus-v1.2
> +          - const: allwinner,sun50i-h5
> +
> +      - description: Sinovoip BananaPi M2 Magic
> +        items:
> +          - const: sinovoip,bananapi-m2m
> +          - const: allwinner,sun8i-a33
> +
> +      - description: Sinovoip BananaPi M2 Ultra
> +        items:
> +          - const: sinovoip,bpi-m2-ultra
> +          - const: allwinner,sun8i-r40
> +
> +      - description: Sinovoip BananaPi M2 Zero
> +        items:
> +          - const: sinovoip,bpi-m2-zero
> +          - const: allwinner,sun8i-h2-plus
> +
> +      - description: Sinovoip BananaPi M3
> +        items:
> +          - const: sinovoip,bpi-m3
> +          - const: allwinner,sun8i-a83t
> +
> +      - description: Sinovoip BananaPi M64
> +        items:
> +          - const: sinovoip,bananapi-m64
> +          - const: allwinner,sun50i-a64

Any chance we could rename and list them as just BananaPi xxx?

When the BananaPi-R2 was mainlined, I asked the submitter to ask them
whether the vendor was Sinovoip or Bananapi, and they (Bananapi team)
said it was Bananapi.

We managed to convert a few (the BPI-M2+), but most still carry the
Sinovoip name.

ChenYu
