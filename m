Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B3ACA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4767620684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572033968;
	bh=8hN8Hv9eLukTkP62r19/zXbufonjh2wzbam9QGvS19w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YfP7x6HQFs0/4R9JI1HXe6K7Z/TBnekhhBdwpJCbxu8uOsTUOdXLZ0PjBxbaQ7tqj
	 c3ZB6QuCQqf4F2GozQ+ESnnbiGR7VwsBdQdypIxdyqhO0BHKROnL8G3KXcCMk1I7/B
	 gqfG/LAXoWELhALbyExnhcOdpzF2uq4LPzkDHTuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfJYUGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:06:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34308 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfJYUGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:06:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id 83so2437117oii.1;
        Fri, 25 Oct 2019 13:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jqVq5Lwo+/WODI/QAay9kwe24vPaTOucp+D1u3RaL4g=;
        b=oYeMQDUvuh/mRfJ69J5Y38zrlJbpFy+USUAeP/OmTtOJKn0B5M6AspQaKOMtV1m61J
         X2+mUaHbqYcNzLL3CsqKVM+CEOWqHF3anHN2RGNEPYIG1/deLm2A9fVCdNosg7o2oGo0
         vLIV8ueNpMOUTlwNfh4Zx/c1QWD88W+NQx3/GTz5alQaSuJtXvCYhja1DXQFT3GB+2A5
         Qc5v8hcegThA8UivP33YkQzNz4Otkoy96v/BC3sf+TZD0aKsSw374Rx7Pf+I+PDged6M
         9ggQSU3HQ0HfU9C8NSD4zgFMb3DksmBkD0EjQQaM6G0NptwBKms53xpdPFYITtZkQyr9
         pF1Q==
X-Gm-Message-State: APjAAAXcZ7MOyIu1WFIB3mkZNYtHUrowX+TIlbG0OuKitKQ0/kSxgBGo
        Sce0f/KieYE9ortJopP4BQ==
X-Google-Smtp-Source: APXvYqwzUR2rSINKzejZtbmIDPV5VUjpqLmVrlPP6Hwi7FH42fYZZYbpJxbgZMrvAlX2hTG7MzH0wg==
X-Received: by 2002:aca:e0d5:: with SMTP id x204mr4728531oig.112.1572033965315;
        Fri, 25 Oct 2019 13:06:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e5sm1030156otr.81.2019.10.25.13.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 13:06:04 -0700 (PDT)
Date:   Fri, 25 Oct 2019 15:06:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, aniljoy@cadence.com, adouglas@cadence.com,
        nsekhar@ti.com, jsarha@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C
 dir GPIO
Message-ID: <20191025200603.GA10839@bogus>
References: <20191024114042.30237-1-rogerq@ti.com>
 <20191024114042.30237-3-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024114042.30237-3-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:40:41PM +0300, Roger Quadros wrote:
> This is an optional GPIO, if specified will be used to
> swap lane 0 and lane 1 based on GPIO status. This is required
> to achieve plug flip support for USB Type-C.
> 
> Type-C companions typically need some time after the cable is
> plugged before and before they reflect the correct status of
> Type-C plug orientation on the DIR line.
> 
> Type-C Spec specifies CC attachment debounce time (tCCDebounce)
> of 100 ms (min) to 200 ms (max).
> 
> Allow the DT node to specify the time (in ms) that we need
> to wait before sampling the DIR line.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> index 8a1eccee6c1d..5dab0010bcdf 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -53,6 +53,21 @@ properties:
>    assigned-clock-parents:
>      maxItems: 2
>  
> +  typec-dir-gpios:

TI specific or could be generic?

> +    maxItems: 1
> +    description:
> +      GPIO to signal Type-C cable orientation for lane swap.
> +      If GPIO is active, lane 0 and lane 1 of SERDES will be swapped to
> +      achieve the funtionality of an exernal type-C plug flip mux.

s/exernal/external/

> +
> +  typec-dir-debounce:

Needs '-ms' suffix.

> +    $ref: '/schemas/types.yaml#/definitions/uint32'

then you can drop this because standard units have type already.

> +    description:
> +      Number of milliseconds to wait before sampling
> +      typec-dir-gpio. If not specified, the GPIO will be sampled ASAP.
> +      Type-C spec states minimum CC pin debounce of 100 ms and maximum
> +      of 200 ms.

Express this as constraints:

minimum: 100
maximum: 200
default: ???

If the spec minimum is 100ms, then doesn't sampling ASAP violate the 
spec?

> +
>  patternProperties:
>    "^pll[0|1]_refclk$":
>      type: object
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
