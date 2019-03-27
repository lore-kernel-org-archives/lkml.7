Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCCAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CF12075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553730142;
	bh=CpVBbV4/n9Nn+hSsk6vs2Q8bn13JOai4VdTcknXssj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MbQvKQG901zmly2jy66PRbovIM54QYAOSarKbH7c/XOgc8ltg55TZWiMZgtQl3OCw
	 WQe3px1l3rAZzQ/FhF67brB+E9uieFgFPyiTdoK+QhsPx5KgcIw4BTMck7o7J7pQV0
	 9Y6f34AnTlrQKBHyvvIU8bdJao51VMsy50paFV+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbfC0XmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:42:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38068 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0XmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:42:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id w137so14353124oiw.5;
        Wed, 27 Mar 2019 16:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jM1YAH+dUeGPSEFWIfr8mp8aRgrdg8/JqaIad+3AEzk=;
        b=TEfbkSqjkp87muXwx/oDHJ0eiZsSreOYS3rJHs2CWnLXDEFyKkbgvNNmvdbIPb9leZ
         PnNkCYt7SYnTq2gGfVkocMoAEKKIGj7v8wZG81qhErCDOK9yrItF68tXvSsbk4sgGqLq
         8EFPQqRrT3JAZKnTgpSx2uzdolF7pKU6BQaLccSMBUckIkN3R754jTyQfnY2wjcjQV8b
         GkoXi/fpp110QzEBDBia3G1nJ1XZ+c+oy05W8PazBfHUuxg5WC2QyfzXX/eDg+0e3ozv
         INGAsXvYvJqSErV6OZk9aF3ZjlJaSx2ObYrpB8C5ztX9Gy8PFtcqY9TxomAtHmH9UlvX
         75rg==
X-Gm-Message-State: APjAAAUieaNK50LL1CEv82/OQEcolSLcfF/7OHGWToWjOCEH7A6iEkBa
        MSIRGYKVhSYZZFBes5UzfQ==
X-Google-Smtp-Source: APXvYqw8MmIw5o5JcQflIL3L5UJoL/6cMcIvqRJMhSLibcAwlmp736kOu5kuqGzu4f0jJhx/Mhyp3w==
X-Received: by 2002:aca:c246:: with SMTP id s67mr7540598oif.159.1553730138788;
        Wed, 27 Mar 2019 16:42:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o16sm6187334ota.15.2019.03.27.16.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 16:42:17 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:42:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amelie.delaunay@st.com, felipe.balbi@linux.intel.com
Subject: Re: [PATCH] dt-bindings: usb: dwc2: document the vbus-supply property
Message-ID: <20190327234217.GA8346@bogus>
References: <20190306212431.5779-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306212431.5779-1-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:24:31PM +0100, Martin Blumenstingl wrote:
> Various boards have an external VBUS supply regulator. This regulator
> depends on the current mode of the controller which is defined as:
> - dr_mode set to either "host" or "peripheral" (fixed value)
> - dr_mode set to "otg", based on the OTG status the dwc2 controller
>   internally switches between "host" and "peripheral" mode (selection
>   happens at runtime)
> 
> Based on the current mode the regulator has to be enabled or disabled:
> - host: provide power to the connected USB device, thus the regulator
>   has to be enabled
> - peripheral: the host device to which the controller is connected
>   provides power, thus the regulator has to be disabled
> 
> Add the dt-bindings documentation for this property so .dts authors know
> that this property exists and how it behaves.
> 
> Fixes: 531ef5ebea9639 ("usb: dwc2: add support for host mode external vbus supply")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> index 6dc3c4a34483..1e8a775a0e72 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> @@ -31,6 +31,10 @@ Refer to clk/clock-bindings.txt for generic clock consumer properties
>  Optional properties:
>  - phys: phy provider specifier
>  - phy-names: shall be "usb2-phy"
> +- vbus-supply: reference to the VBUS regulator. Depending on the current mode
> +  this is enabled (in "host" mode") or disabled (in "peripheral" mode). The
> +  regulator is updated if the controller is configured in "otg" mode and the
> +  status changes between "host" and "peripheral".

This is actually wrong IMO unless Vbus is powering the controller 
itself. If it is just a regulator routed to the USB connector, then the 
DT should use the usb-connector binding and put vbus-supply there. If 
the driver needs it, then it can walk the tree/graph and get it. For 
some reason folks seem to think everything the driver needs has to be in 
the node associated with the driver.

</rant>

I guess given this is already in use:

Acked-by: Rob Herring <robh@kernel.org>

>  Refer to phy/phy-bindings.txt for generic phy consumer properties
>  - dr_mode: shall be one of "host", "peripheral" and "otg"
>    Refer to usb/generic.txt
> -- 
> 2.21.0
> 
