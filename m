Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2350DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DC220718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573759171;
	bh=0nzQppvn8eeRtspGJTnosUaDukolKvY2fmZcM8MyR4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gzKAd+Akd8aPm1+XkdKzWP7Ej5E0snDER3px3x+1GZomDKbjcW86kE5w7rsxZ50m6
	 wyeWWK5XkPe9g0w4bAhYNivZRaUcVQQnenxZnYBCpEJhB9SQHIX8Mii64OL61EYOU6
	 dzX8Wl4T93D7fOIjtniV+dxI0jUyHk3ZJOJpAulA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKNTT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:19:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43113 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKNTT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:19:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id l14so5850758oti.10;
        Thu, 14 Nov 2019 11:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4IsLNh9XMoQBdvulmO/iuC5KMTdNRjARPKR6yxL0CXE=;
        b=OdqkIjoDBl9FTaVlGrtmWZhftlMjHycKHf8cDGDo21D4PUS6JWw9UceGEPEdO/Mo0w
         byPQhV0mCIWXXm4xKL7SJL3VSwc7TjdwkD+Q+5NW/auskARhEDNjaYqREnk8ATOjqEul
         816ySVj6XCoBQymtNiCUVxdEwNRYWlgYoyor9TVkZ+i5mn53zk6CeLpo0HeQj5dce4hr
         H8MBPVCMjtWusvuZ332GGkdWPp8PLeJTQ61gI5IxbQ7hhY3IGI449bDufTbxmzapJvqr
         YjJX8hUrQFDQiV69rMB5PtDREZFp9Gi0QrbcrzAU8dJgxCpmIs0Duff8s2j28ZVuQN/h
         YPbA==
X-Gm-Message-State: APjAAAXo+rbHVAFhzxWtQ3TZg0tu+4lCBWN45hiDpz5i5n98UFudpry8
        BynGzT1IifoWAzEeJW99sg==
X-Google-Smtp-Source: APXvYqxy6xLFgw2Vf9ni3fg2riXq41C/XY5uv0o+qX+3pnZF5b8XhVjvliB2Nwyhkb/rsiwXorlYng==
X-Received: by 2002:a9d:1b70:: with SMTP id l103mr9142804otl.154.1573759168337;
        Thu, 14 Nov 2019 11:19:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t2sm2065500otm.75.2019.11.14.11.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:19:27 -0800 (PST)
Date:   Thu, 14 Nov 2019 13:19:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: Convert sprd board/soc bindings
 to json-schema
Message-ID: <20191114191927.GA12025@bogus>
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-2-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111090230.3402-2-chunyan.zhang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:02:26PM +0800, Chunyan Zhang wrote:
> 
> Convert Unisoc (formerly Spreadtrum) SoC bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../devicetree/bindings/arm/sprd.txt          | 14 ---------
>  .../devicetree/bindings/arm/sprd.yaml         | 29 +++++++++++++++++++
>  2 files changed, 29 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/sprd.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/sprd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/sprd.txt b/Documentation/devicetree/bindings/arm/sprd.txt
> deleted file mode 100644
> index 3df034b13e28..000000000000
> --- a/Documentation/devicetree/bindings/arm/sprd.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -Spreadtrum SoC Platforms Device Tree Bindings
> -----------------------------------------------------
> -
> -SC9836 openphone Board
> -Required root node properties:
> -	- compatible = "sprd,sc9836-openphone", "sprd,sc9836";
> -
> -SC9860 SoC
> -Required root node properties:
> -	- compatible = "sprd,sc9860"
> -
> -SP9860G 3GFHD Board
> -Required root node properties:
> -	- compatible = "sprd,sp9860g-1h10", "sprd,sc9860";
> diff --git a/Documentation/devicetree/bindings/arm/sprd.yaml b/Documentation/devicetree/bindings/arm/sprd.yaml
> new file mode 100644
> index 000000000000..8540758188d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sprd.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0

You made all the commits to the old file, so can you dual license:

# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

With that:

Reviewed-by: Rob Herring <robh@kernel.org>

> +# Copyright 2019 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/sprd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc platforms device tree bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sprd,sc9836-openphone
> +          - const: sprd,sc9836
> +      - items:
> +          - enum:
> +              - sprd,sp9860g-1h10
> +          - const: sprd,sc9860
> +
> +...
> -- 
> 2.20.1
> 
> 
