Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E3AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD20222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782432;
	bh=EgbNXCKO32bDznwIxG/zUcXXSse1WyN1wD/XW0tsgKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PpxFW47T9ZQgTbseAKRiuU+2H7lLdq934KW72cSp3y3Icg4wzinrBVo23lUJtzpY6
	 lJrO2GkfO52giDLFEYNF/4ondY6ffJCPepuFvrc7LibS9mb4ldiEbTE1u7xxOSnoGp
	 7Pxu7O40jwkqqrWyorvE7caauUUfYNErcFwnDUhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfLSTHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:07:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41860 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfLSSnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:43:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so8339997otc.8;
        Thu, 19 Dec 2019 10:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ATCr26B2OQVBaMy930gvC8+YwzqQLoxjbV1kq1l7KCk=;
        b=CjcHXC7bZXk5AsbMcdwa+6cfASsiCGVz+wR56vMtBUcxd5jDPbYMhnK4oYaexzOTug
         u4tPYpYd/NxUejUhl6V7DD2j/rnc9CjQfNcFAWc4DBZdm9V3DWI+h0I3aHq1myFSFS+Q
         8ybcBFLJBnTCDB+UTlzxm7b+10RKjTQ1PgQnXPLnPITiKn2/zZkuYp1hnOOVWKzCah2B
         ssY7r1rMqo+YB98MYw6hQF8ir91mb6C92kPJbgAwLQ8LkUtqYirtdsiJVI8v97ZB2Cny
         OdpTnwj6ZdsRbOc19lj+G07GCvVQ711SdE7AjTqev9emjZquJkqr6Q5ZVug8Hxeogqma
         sUoA==
X-Gm-Message-State: APjAAAXB2965kvh0ogAd3ywbMTXMzOc2chjy2Dto3hLAktctn5Mx8Cop
        ycUUAzUva8gjldq+f1tmWbD5vYRMlQ==
X-Google-Smtp-Source: APXvYqzHVHy4Y8bxjQIOFjcCok4NiCDbPD19EFZ7LpJjtchr7wNNUALhEQj3m9Oz59bjfHKnScEnxw==
X-Received: by 2002:a9d:6d06:: with SMTP id o6mr10381223otp.239.1576781002486;
        Thu, 19 Dec 2019 10:43:22 -0800 (PST)
Received: from localhost ([2607:fb90:bdf:98e:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id r205sm2279361oih.54.2019.12.19.10.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 10:43:21 -0800 (PST)
Date:   Thu, 19 Dec 2019 12:43:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v2 2/2] devicetree: bindings: Add the binding doc for
 xilinx APM
Message-ID: <20191219184318.GA13328@bogus>
References: <1575901405-3084-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <1575901405-3084-2-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575901405-3084-2-git-send-email-shubhrajyoti.datta@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 07:53:25PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add the devicetree binding for xilinx APM.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2:
> patch added
> 
>  .../devicetree/bindings/perf/xilinx_apm.txt        | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/xilinx_apm.txt

As Michal said, DT schema please.
> 
> diff --git a/Documentation/devicetree/bindings/perf/xilinx_apm.txt b/Documentation/devicetree/bindings/perf/xilinx_apm.txt
> new file mode 100644
> index 0000000..a11c82e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/xilinx_apm.txt
> @@ -0,0 +1,44 @@
> +* Xilinx AXI Performance monitor IP
> +
> +Required properties:
> +- compatible: "xlnx,axi-perf-monitor"

Version?

> +- interrupts: Should contain APM interrupts.
> +- interrupt-parent: Must be core interrupt controller.

Drop this.

> +- reg: Should contain APM registers location and length.
> +- xlnx,enable-profile: Enables the profile mode.
> +- xlnx,enable-trace: Enables trace mode.
> +- xlnx,num-monitor-slots: Maximum number of slots in APM.
> +- xlnx,enable-event-count: Enable event count.
> +- xlnx,enable-event-log: Enable event logging.
> +- xlnx,have-sampled-metric-cnt:Sampled metric counters enabled in APM.
> +- xlnx,num-of-counters: Number of counters in APM
> +- xlnx,metric-count-width: Metric Counter width (32/64)
> +- xlnx,metrics-sample-count-width: Sampled metric counter width
> +- xlnx,global-count-width: Global Clock counter width

All these synthesis time config and not discoverable?

Tell h/w designers to add feature registers so all this is 
discoverable. </rant>

> +- clocks: Input clock specifier.
> +
> +Optional properties:
> +- xlnx,id-filter-32bit: APM is in 32-bit mode
> +
> +Example:
> +++++++++
> +
> +apm: apm@44a00000 {
> +    compatible = "xlnx,axi-perf-monitor";
> +    interrupt-parent = <&axi_intc_1>;
> +    interrupts = <1 2>;
> +    reg = <0x44a00000 0x1000>;
> +    clocks = <&clkc 15>;
> +    xlnx,enable-profile = <0>;
> +    xlnx,enable-trace = <0>;
> +    xlnx,num-monitor-slots = <4>;
> +    xlnx,enable-event-count = <1>;
> +    xlnx,enable-event-log = <1>;
> +    xlnx,have-sampled-metric-cnt = <1>;
> +    xlnx,num-of-counters = <8>;
> +    xlnx,metric-count-width = <32>;
> +    xlnx,metrics-sample-count-width = <32>;
> +    xlnx,global-count-width = <32>;
> +    xlnx,metric-count-scale = <1>;
> +    xlnx,id-filter-32bit;
> +};
> -- 
> 2.1.1
> 
