Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92892C004C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5712081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556756246;
	bh=Yw1ASrwyfION5dP8hdlVa+Uchnc0v4ArZQpATPHWtZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RHiquBQiRablaDVRhnykpNr2s1xy0Td7IjfYHqK62ldhnp56za7a9KYaPjwcxC/l9
	 PLw0SmfBnNl/NDXS9I/6K80pkWbocsgluh67CbkXhFpIRajfeOzXJMpkGxi/Qy8Ds2
	 f/3uN43d0DPH9DrjJ8Bk15Ww7/oA9kWawvNLMWts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEBARZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 20:17:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42084 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfEBARY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:17:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so294977oig.9;
        Wed, 01 May 2019 17:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jWIIXa7r4wSVU7uMUDzVZd3yuor/i3n+WcnRwz2jzS8=;
        b=nWtUNUDuJXP6bCiL10PWlI5oiwkCLmeqpaKFvH4i6pplWccAs+3CoVTxadZ5dngx6e
         VbDD0lh1aLbzBoC5YtMote4f+hIsxnfPF2cmWJVV2NP6FqaUSby82JrgyDT81IVRYqw4
         24Y6iXbSutKZdE4mbugZblMkfXU12IV8vFDoiSVcq2gq10NtJtvufAlpUydpDov53jOF
         RfMz6geI3rrUivk6s3LsLdylUAA9U70ot5QiU0h/4mqbEml6x5kMMbuml4BbPf7SlAem
         wrbbGmupGZMezj+6mutA77zfdaZmNYURXcINME2YM0+ZZsjNew/c968Bw+GESIIoSC0e
         uNKw==
X-Gm-Message-State: APjAAAVSkPVnLVunJXgxIe5t3OHbVVja+Nhxi/j3BJ4xHQPaSrlhx5Gf
        rSRwSflXDjSStX8/b/WwmNEuVwE=
X-Google-Smtp-Source: APXvYqx0kLfOAvFCpRNZoeMh5ZIBFq3xfdPhfOPyNCZhlDHOQo6EXv/lMTskUycSLKJEeSnjxmCYSw==
X-Received: by 2002:aca:504d:: with SMTP id e74mr640674oib.51.1556756242847;
        Wed, 01 May 2019 17:17:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a15sm4262423oid.45.2019.05.01.17.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 17:17:22 -0700 (PDT)
Date:   Wed, 1 May 2019 19:17:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, mark.rutland@arm.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add silabs,si5341
Message-ID: <20190502001721.GA29391@bogus>
References: <20190424090216.18417-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424090216.18417-1-mike.looijmans@topic.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:02:16AM +0200, Mike Looijmans wrote:
> Adds the devicetree bindings for the si5341 driver that supports the

Bindings are for h/w, not a driver.

Perhaps 'dt-bindings: clock: ...' to give a bit more clue what this is 
in the subject.

> Si5341 and Si5340 chips.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  .../bindings/clock/silabs,si5341.txt          | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5341.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/silabs,si5341.txt b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
> new file mode 100644
> index 000000000000..1a00dd83100f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
> @@ -0,0 +1,141 @@
> +Binding for Silicon Labs Si5341 and Si5340 programmable i2c clock generator.
> +
> +Reference
> +[1] Si5341 Data Sheet
> +    https://www.silabs.com/documents/public/reference-manuals/Si5341-40-D-RM.pdf
> +
> +The Si5341 and Si5340 are programmable i2c clock generators with up to 10 output
> +clocks. The chip contains a PLL that sources 5 (or 4) multisynth clocks, which
> +in turn can be directed to any of the 10 (or 4) outputs through a divider.
> +The internal structure of the clock generators can be found in [1].
> +
> +The driver can be used in "as is" mode, reading the current settings from the
> +chip at boot, in case you have a (pre-)programmed device. If the PLL is not
> +configured when the driver probes, it assumes the driver must fully initialize
> +it.
> +
> +The device type, speed grade and revision are determined runtime by probing.
> +
> +The driver currently only supports XTAL input mode, and does not support any
> +fancy input configurations. They can still be programmed into the chip and
> +the driver will leave them "as is".
> +
> +==I2C device node==
> +
> +Required properties:
> +- compatible: shall be one of the following: "silabs,si5341", "silabs,si5340"

One per line please.

> +- reg: i2c device address, usually 0x74
> +- #clock-cells: from common clock binding; shall be set to 1.
> +- clocks: from common clock binding; list of parent clock
> +  handles, shall be xtal reference clock. Usually a fixed clock.

More indentation on the continued lines would help readability.

> +- clock-names: Shall be "xtal".
> +- #address-cells: shall be set to 1.
> +- #size-cells: shall be set to 0.
> +
> +Optional properties:
> +- silabs,pll-m-num, silabs,pll-m-den: Numerator and denominator for PLL
> +  feedback divider. Must be such that the PLL output is in the valid range. For
> +  example, to create 14GHz from a 48MHz xtal, use m-num=14000 and m-den=48. Only
> +  the fraction matters, using 3500 and 12 will deliver the exact same result.
> +  If these are not specified, and the PLL is not yet programmed when the driver
> +  probes, the PLL will be set to 14GHz.
> +- silabs,reprogram: When present, the driver will always assume the device must
> +  be initialized, and always performs the soft-reset routine. Since this will
> +  temporarily stop all output clocks, don't do this if the chip is generating
> +  the CPU clock for example.

I'm not too sure about this one. Seems like if you have child nodes, 
then you should re-program. If you don't then you don't re-program.

> +
> +==Child nodes==
> +
> +Each of the clock outputs can be overwritten individually by
> +using a child node to the I2C device node. If a child node for a clock
> +output is not set, the configuration remains unchanged.
> +
> +Required child node properties:
> +- reg: number of clock output.
> +
> +Optional child node properties:
> +- silabs,format: Output format, see [1], 1=differential, 2=low-power, 4=LVCMOS
> +- silabs,common-mode: Output common mode, depends on standard.

Possible values?

> +- silabs,amplitude: Output amplitude, depends on standard.
> +- silabs,synth-source: Select which multisynth to use for this output
> +- silabs,synth-frequency: Sets the frequency for the multisynth connected to
> +  this output. This will affect other outputs connected to this multisynth. The
> +  setting is applied before silabs,synth-master and clock-frequency.
> +- silabs,synth-master: If present, this output is allowed to change the
> +  multisynth frequency dynamically.

Boolean?

> +- clock-frequency: Sets a default frequency for this output.

range?

> +- always-on: Immediately and permanently enable this output. Particulary

Particularly

> +  useful when combined with assigned-clocks, since that does not prepare clocks.
> +
> +==Example==
> +
> +/* 48MHz reference crystal */
> +ref48: ref48M {
> +	compatible = "fixed-clock";
> +	#clock-cells = <0>;
> +	clock-frequency = <48000000>;
> +};
> +
> +i2c-master-node {
> +
> +	/* Programmable clock (for logic) */
> +	si5341: clock-generator@74 {
> +		reg = <0x74>;
> +		compatible = "silabs,si5341";
> +		#clock-cells = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&ref48>;
> +		clock-names = "xtal";
> +
> +		silabs,pll-m-num = <14000>; /* PLL at 14.0 GHz */
> +		silabs,pll-m-den = <48>;
> +		silabs,reprogram; /* Chips are not programmed, always reset */
> +
> +		/*
> +		 * Output 0 configuration:
> +		 *  LVDS 3v3
> +		 *  Source from Multisynth 3
> +		 *  Use 600MHz synth frequency, and generate 100MHz from that
> +		 *  Always keep this clock running
> +		 */
> +		out0 {

clock@0

With a reg property, you should have a unit address.

> +			/* refclk0 for PS-GT, usually for SATA or PCIe */
> +			reg = <0>;
> +			silabs,format = <1>; /* LVDS 3v3 */
> +			silabs,common-mode = <3>;
> +			silabs,amplitude = <3>;
> +			silabs,synth-source = <3>; /* Multisynth 3 */
> +			silabs,synth-frequency = <600000000>;
> +			silabs,synth-master;
> +			clock-frequency = <10000000>;
> +			always-on;
> +		};
> +
> +		/*
> +		 * Output 6 configuration:
> +		 *  LVDS 1v8
> +		 */
> +		out6 {
> +			/* FPGA clock 200MHz */
> +			reg = <6>;
> +			silabs,format = <1>; /* LVDS 1v8 */
> +			silabs,common-mode = <13>;
> +			silabs,amplitude = <3>;
> +		};
> +
> +		/*
> +		 * Output 8 configuration:
> +		 *  HCSL 3v3
> +		 *  run at 100MHz
> +		 */
> +		out8 {
> +			reg = <8>;
> +			silabs,format = <2>;
> +			silabs,common-mode = <11>;
> +			silabs,amplitude = <3>;
> +			silabs,synth-source = <0>;
> +			clock-frequency = <100000000>;
> +		};
> +	};
> +};
> -- 
> 2.17.1
> 
