Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B2C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB2A22314
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576713345;
	bh=zzopRiTPMCxiWVybiJHDiNfTH61sV+ErSnPbGBAT7ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VSoRl5FnaA7luLXCjAJXYjQKjDTy2Wnl0ReUlUk59n1XwMC07LMZb0VWVUjYzwjRy
	 FIca+/r/f5ZnQzkPhXAteOsi0OsjMTYGT+lZRIyEn0E5fJ+poSxwvK877UXiI3zJ+N
	 /YIhKPF6Ul4vCDkd4L6Kf7289zddIfl1e5QtLRRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLRXzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:55:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39424 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfLRXzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:55:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so4645667oty.6;
        Wed, 18 Dec 2019 15:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJ9qxY4LI6XeQxc2KHrHxexDGoJoWaVGO4ER5mSWmaI=;
        b=jqU3qgYc6A4EaSO33f1iE3TTE80uLlsj09Veh04zlEGM1E44mLRnNm+W6UfRkCv86x
         jBV2+TCSsgM0UAnq4mvKTPGX4UIxpvDPiR1RLkBag0s2uLf5Opbwn+NLz3dU6QzQvdQe
         uCKJZW9YJ0lVlwmY05dhw4jJ9EGnAZ7UJ+4VybhDp/UJeRTmqFLbFLFPOGDINtA7V7bi
         O5Ac+k2mN2Dy73L4ylUExArMJjIloGEkWWP+JFk794veOVEmBvDNZ6JNAqbU5QsMm2qe
         HXZIF3MHQ9oJKmDusIC810AfsfXK9wAiTStKsdlrvnICwsxBb6OnD0D4JY7kku9k4mhs
         SPTw==
X-Gm-Message-State: APjAAAX9X7LekhLwmGQRPkMXEXRVC/AR4mFS27UIby9tqlAGhV1RnEm7
        bUYlwFeFY+cdOBCyiZm/NP/oRKNvmA==
X-Google-Smtp-Source: APXvYqyKXJqhNqKyRPGAs2JVV5SiXMGR8LphNu4Udo9MvYFaBLQ15ECTHXk1NIpRYcegBFFN+UOE9A==
X-Received: by 2002:a9d:7cd9:: with SMTP id r25mr5163459otn.326.1576713343017;
        Wed, 18 Dec 2019 15:55:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r205sm1387626oih.54.2019.12.18.15.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 15:55:42 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:55:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: misc: Add dt bindings for traffic
 generator
Message-ID: <20191218235541.GA31319@bogus>
References: <8b3a446fc60cdd7d085203ce00c3f6bfba642437.1575871828.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b3a446fc60cdd7d085203ce00c3f6bfba642437.1575871828.git.shubhrajyoti.datta@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 11:41:26AM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add dt bindings for xilinx traffic generator IP.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  .../bindings/misc/xlnx,axi-traffic-gen.txt         | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,axi-traffic-gen.txt

Please convert to a DT schema.

> 
> diff --git a/Documentation/devicetree/bindings/misc/xlnx,axi-traffic-gen.txt b/Documentation/devicetree/bindings/misc/xlnx,axi-traffic-gen.txt
> new file mode 100644
> index 0000000..6edb8f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/xlnx,axi-traffic-gen.txt
> @@ -0,0 +1,25 @@
> +* Xilinx AXI Traffic generator IP
> +
> +Required properties:
> +- compatible: "xlnx,axi-traffic-gen"
> +- interrupts: Should contain AXI Traffic Generator interrupts.

How many and what are they.

> +- interrupt-parent: Must be core interrupt controller.

Drop this. It could be in a parent node.

> +- reg: Should contain AXI Traffic Generator registers location and length.
> +- interrupt-names: Should contain both the intr names of device - error
> +		   and completion.

Needs exact strings.

> +- xlnx,device-id: Device instance Id.
> +
> +Optional properties:
> +- clocks: Input clock specifier. Refer to common clock bindings.
> +
> +Example:
> +++++++++
> +axi_traffic_gen_1: axi-traffic-gen@76000000 {
> +	compatible = "xlnx,axi-traffic-gen-1.0", "xlnx,axi-traffic-gen";

Doesn't match the above. I'd drop the 2nd string.

> +	clocks = <&clkc 15>;
> +	interrupts = <0 2 2 2>;
> +	interrupt-parent = <&axi_intc_1>;
> +	interrupt-names = "err-out", "irq-out";
> +	reg = <0x76000000 0x800000>;
> +	xlnx,device-id = <0x0>;
> +} ;
> -- 
> 2.1.1
> 
