Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D25C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553716795;
	bh=CRIPndZeDNzJZg4P+/um6rV+gu/u+NAYh2P7PgPuL2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b8PQha7HYR7k4P2rez4tSuaonIT4XXu5Y7nND7n8qXxtkvxbp3lsY5G7aYZqjzo6e
	 UnMxvBZ+NJimV4NGFuiPoK25Cs+YjuY/ltmYeLndvkLC8Wlyzutp7Ezfqd5p8Dzkb/
	 /CACVvFSWwzQ2WXJ2rPdILKwznY4bDsJbT2cLsaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfC0T7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:59:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46574 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfC0T7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:59:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id x188so13901449oia.13;
        Wed, 27 Mar 2019 12:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hnbq2IQ9CS3J8yCqLirlJFI/GUJpyAmi53++5Xl1k0=;
        b=AXuYxZ5s+MlKVCnf/Nhq9JLMprf4RphZfXG96N55mMq1LPoJc7UCY4nxeanwZdgJfd
         29+LtAEAbETmsammrogpMuQ49qyXjXbcVmA8QQvRxNFuDfzy/tBxl4/3Sm2NdLjpiljU
         emcKsxW+QpdgGqgcWWiwdhpTOuBK+tacsxQVeGiWTBukR/pt+T2NWxnYBAb/gPqBJ8RT
         z5KfvjloW2TJytCdrnnwAUuPlQ/0VAuaNxPnmfW1zh1WOHNsps+6gGMNku+ZTwkAFCJC
         Ud9XqSLcZJCEe6gFeZSKZiAEzcvlKpWAhEwqHIJTbTP/7+Rf+FBg1aohvAOGEO904JpV
         C7Tw==
X-Gm-Message-State: APjAAAVETYmc3zHdV5sFjBxG2/04LOqlBCN2PwrMdsqG3PaXSzITz5R1
        /s+UvsVM5vBmtPKtPkjTGw==
X-Google-Smtp-Source: APXvYqyxfOb/MnvNQYtl+JIb2iywt5oOgFCe4QxN1EHxbAb/6zH0mz3/1qOmzhsxYrGO+9pQhPg5Hg==
X-Received: by 2002:aca:db0b:: with SMTP id s11mr19516689oig.37.1553716791419;
        Wed, 27 Mar 2019 12:59:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e23sm1212527otl.61.2019.03.27.12.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 12:59:50 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:59:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        hhhawa@amazon.com, jonnyc@amazon.com, ronenk@amazon.com,
        hanochu@amazon.com
Subject: Re: [PATCH 1/2] dt-bindings: thermal: thermal_mmio: Add binding
 documentation
Message-ID: <20190327195949.GA800@bogus>
References: <1551602966-2334-1-git-send-email-talel@amazon.com>
 <1551602966-2334-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551602966-2334-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 10:49:25AM +0200, Talel Shenhar wrote:
> Add thermal binding documentation for thermal MMIO driver.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../devicetree/bindings/thermal/thermal_mmio.txt   | 173 +++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal_mmio.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal_mmio.txt b/Documentation/devicetree/bindings/thermal/thermal_mmio.txt
> new file mode 100644
> index 0000000..1f4d738
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal_mmio.txt
> @@ -0,0 +1,173 @@
> +Generic Thermal MMIO Driver

Bindings aren't for drivers.

Do h/w specific bindings and map those to a generic driver if you like. 
We simply don't do single register level bindings because that doesn't 
scale and things never turn out to be so generic.

> +
> +The generic thermal driver enables easy connectivity between "simple"
> +thermal HW devices to the thermal subsystem. "simple" - thermal HW that
> +doesn't need any configuration (such as power reset or clock enable) by a
> +driver and only exports the temperature via simple MMIO access, or,
> +alternatively, all the configuration is done by other entity (e.g.
> +bootloader).
> +
> +Any system that allows temperature reading via a single memory map read, be
> +it register or shared memory, is a potential candidate to work with this
> +driver.
> +This driver allows manipulations on the read value in order to allow some
> +flexibility for the various thermal HW, e.g. sensor-factor which will be
> +multiplied by the read value.
> +
> +This driver is most suitable for cases such as the following:
> +- The entire thermal HW setup (e.g. configure the thermal HW to work in
> +  continuous mode) is done by another SW entity (e.g. bootloader) and all
> +  that is left is to read the current temperature from a register
> +- The thermal reading is done by an external CPU (e.g. micro-controller)
> +  and that CPU is exporting the reading via a shared memory
> +- The thermal HW setup and reading is done via CPLD, which exports the
> +  current temperature to the system via a register
> +- The thermal HW is working out-of-the-box and only reports temperature via
> +  a single register access
> +
> +Some examples for cases that this driver is not suitable for:
> +- Your HW need clock enabling to be done by thermal driver

...or avoiding disabling of a clock, regulator, etc.

> +- Your HW need some registers configurations in order to start reporting
> +  temperatures and it is not doable by other entities (e.g. bootloader)
> +- Your HW allows reading of temperatures only between ADCs (or any other
> +  timing constrains)
> +- In case your HW was configured by a bootloader and it lose the
> +  configuration as part of low-power-state and need to be reconfigured.
> +  (bootloader configuration typically is not sustained across low power
> +  states)
> +- In case the reading from the MMIO require any type of locking

Or filtering/averaging of values.

> +
> +So the only operation this driver will do is MMIO read for the temperature.
> +In case you are using HW that require some configurations this driver is
> +not suitable (you can decide to move all the configuration logic into your
> +bootloader and only leave the temperature reading to this driver but this
> +is up to you).
> +
> +An example of a system that uses this driver is the Amazon Nitro SoC in
> +which there is the main CPU and micro-controller:
> +(1) The micro-controller accesses an SBUS controller to read the thermal
> +    sensor from an SBUS slave called Avago Technologies digital
> +    Temperature/Voltage Sensor (ip16_SENS_thermvolt25_0)
> +(2) Once the micro-controller gathers the temperature it relays it to the
> +    main CPU via a Shared Integrated RAM which is MMIO accessible by the CPU
> +(3) The thermal_mmio driver that runs on the main CPU will read the
> +    temperature via an MMIO access to the Shared RAM
> +
> ++------------------+      +----------------+
> +|                  | (3)  |                |
> +|     Main CPU     +----->+ Integrated RAM |
> +|                  |      |                |
> ++------------------+      +---------^------+
> +                                    |(2)
> ++-----------------+       +------------------+
> +|                 |  (1)  |                  |
> +| SBUS controller <-------+ micro-controller |
> +|                 |       |                  |
> ++--------+--------+       +------------------+
> +         |
> ++--------v---------------------+
> +|                              |
> +|  Avago Technologies digital  |
> +|  Temperature/Voltage Sensor  |
> +|  (ip16_SENS_thermvolt25_0)   |
> +|                              |
> ++------------------------------+

Very specific information for a 'generic' binding.

> +
> +Required properties:
> +- compatible: "thermal-mmio".
> +- reg: The physical base address and length of the sensor's registers.
> +- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a description.
> +
> +Optional properties:> +- sensor-width: Width (in bytes) of each consecutive sensor.
> +		 Supported: 1, 2, 4.
> +		 (Default = 4)
> +- sensor-mask: Mask to be applied on the raw read value before any
> +	       calculation.
> +	       (Default = 0xFFFFFFFF)
> +- sensor-factor: Scale value by which to multiple the masked read value
> +		 This is a signed 32 bit value.
> +		 (Default = 1)
> +- sensor-bias: Bias value to be added to the scaled value.
> +	       This is a signed 32 bit value.
> +	       (Default = 0)
> +- sensor-divider: Dividing value by which to divide the calculated value.
> +		  Diving will be Integer Division.
> +		  This is a unsigned 32 bit value.
> +		  (Default = 1)

If you are going to abstract all the h/w access, then get rid of all of 
this and just put Celsius values into the "register".

> +
> +Conversion formula from HW MMIO read value to millidegrees (Celsius):
> +T_millidegrees = (bias + (T_raw & mask)*factor)/divider
> +
> +Example 1, two thermal devices with one thermal sensor each, that uses only
> +the required properties (uses default):
> +
> +	thermal_d1: thermal_d1 {
> +		compatible = "thermal-mmio";
> +		reg = <0x0 0x05002860 0x0 0x4>;
> +		#thermal-sensor-cells = <0x1>;
> +	};
> +
> +	thermal_d2: thermal_d2 {
> +		compatible = "thermal-mmio";
> +		reg = <0x0 0x05000730 0x0 0x4>;
> +		#thermal-sensor-cells = <0x1>;
> +	};
> +
> +	thermal-zones {
> +		thermal_d1_z0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&thermal_d1 0>;
> +			trips {
> +				thermal_d1_z0_crit {
> +					temperature = <105000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +		};
> +
> +		thermal_d2_z0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&thermal_d2 0>;
> +			trips {
> +				thermal_d2_z0_crit {
> +					temperature = <105000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
> +Example 2, one thermal device with two sensors of 6 bits each each, that
> +has a factor of -5, bias of 23 and dividing of 2:
> +
> +	thermal_d3: thermal_d3 {
> +		compatible = "thermal-mmio";
> +		reg = <0x0 0x05005700 0x0 0x2>;
> +		#thermal-sensor-cells = <0x1>;
> +		sensor-width = <1>;
> +		sensor-mask = <0x3F>;
> +		sensor-factor = <(-5)>;
> +		sensor-bias = <23>;
> +		sensor-divider = <2>;
> +	};
> +
> +	thermal-zones {
> +		thermal_d3 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&thermal_d3 0>;
> +			trips {
> +				thermal_d3_z0_crit {
> +					temperature = <105000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> -- 
> 2.7.4
> 
