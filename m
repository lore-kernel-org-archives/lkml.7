Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93268C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCFB2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554905404;
	bh=Sl0RLrbnJrqDJYXcHbmdi5KA+YY75FjXOFc9bsfM5k8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nd872rrJaX2jALrZkYyXSEpDPR4/zqfFcwwiDHhsFD3M/C5YKL4ZLfSXfr+tpSHCP
	 TXqVvCWwXk2gN5lWiITZ20f2uNrR/Rz2p9rnuVZ9W5ZLrcFFKB1Rln7gvsZ97sogPc
	 0vM5+n7nPaOGfPq6W49RWUfEQlCNbUrQitegbBeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbfDJOKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:10:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37421 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbfDJOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:10:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id c16so2041119otn.4;
        Wed, 10 Apr 2019 07:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9GecMz2KPIeESiZKPs22diHS55qIWq05bHgPCBS/UHs=;
        b=arCblmzO7LXpyoM41FLr8knMFnxJJh3mnHwFzTQVl1OkjNik8x5/aviD7QZK+tJBMW
         ysd+M7bSjC3FYyb978mL0rcoRPxOBwphDt2+s2r/ilGCrjGYM+Ls0lz5kpkKzsZA22SC
         w54NdcJ8o7jS6PzIzWcUrBMaoAR0zU+NlOxzVCSzdkKlgJZadAPU/3ER2GakDkWjUwZo
         Xc9L293OjxqKSkuMcSNTGjI/nHvdHOsozkeyDJlKQzE0I1NhBhyMwlqhkze0tVzR0rbG
         pGBojuDZCw478N1JgXcvnOJ2YAM8Sx5VjGMjfafi6V6e4YaaRqveV8aC/twUk2unujT0
         UL1Q==
X-Gm-Message-State: APjAAAUOkpAvP4ekeWLhhdR3r6rppssKVLJPwICRgzfkwG8aWyx43h8j
        kyHNLSCmO5G64862Boc/pA==
X-Google-Smtp-Source: APXvYqxmDthSZ2TajMpXLpsmnUF0niYt4PWGNk1VCmf2itaQ81zGlHn9+bOAZkErl/A2sVaaTLiR6g==
X-Received: by 2002:a9d:32f5:: with SMTP id u108mr28426804otb.153.1554905401984;
        Wed, 10 Apr 2019 07:10:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h26sm12681838oih.22.2019.04.10.07.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 07:10:01 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:10:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     edubezval@gmail.com, dwmw@amazon.co.uk, jonnyc@amazon.com,
        rui.zhang@intel.com, hhhawa@amazon.com, ronenk@amazon.com,
        hanochu@amazon.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: al-thermal: Add binding
 documentation
Message-ID: <20190410141000.GA19197@bogus>
References: <1554373016-1442-1-git-send-email-talel@amazon.com>
 <1554373016-1442-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554373016-1442-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 01:16:55PM +0300, Talel Shenhar wrote:
> Add thermal binding documentation for Amazon's Annapurna Labs Thermal
> Sensor.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  .../bindings/thermal/amazon,al-thermal.txt         | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
> new file mode 100644
> index 0000000..af8cf18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
> @@ -0,0 +1,33 @@
> +Amazon's Annapurna Labs Thermal Sensor
> +
> +Simple thermal device that allows temperature reading by a single MMIO
> +transaction.
> +
> +Required properties:
> +- compatible: "amazon,al-thermal".
> +- reg: The physical base address and length of the sensor's registers.
> +- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a description.
> +
> +Example:
> +	thermal: thermal {
> +		compatible = "amazon,al-thermal";
> +		reg = <0x0 0x05002860 0x0 0x1>;
> +		#thermal-sensor-cells = <0x1>;
> +	};
> +
> +	thermal-zones {
> +		thermal_z0 {

thermal-z0 {

> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&thermal 0>;
> +			trips {
> +				thermalz0_crit {

critical {

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +					temperature = <105000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +		};
> +	};
> +
> -- 
> 2.7.4
> 
