Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EDAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5A2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570744120;
	bh=hifUZxsX5VGlTXfZ+bhT293TXm5jAM0AyRmySJehGKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HB+neyGlcCxX7L70C7EyFy8KqAq6CQkmLWgLl4RtAjRHPL85zjiIrWy8VZ9F6NopZ
	 K0Fsw9fYcCU2Oc+4GxOf/QhDTINU6N+nPt+q4iPrJ917oRRr9tGYzzD/yv6y7OF/ig
	 4Uf7akGfIYk5dhMGdVRplJAJ5Ge2Mef6ZIFRcqYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfJJVsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:48:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34703 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:48:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id m19so6268940otp.1;
        Thu, 10 Oct 2019 14:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYfTmULpptQFnm79PdIINv8ysFiQ3dFmgzNIv1T7qTk=;
        b=GpYBHSkyDqs+WUwqL2ULVAWjEHztVMp/iIXlvL5mB8OS5U/cOEjANjsY/lWsTqzaxZ
         QPhXuyK4s7MAmxf+qfG1cmpsGE9hjOjq43LInV8f5w0cmFdFB85Dn2L3+CWyb9V0rJ+9
         bxUVTqr2LsT21dy8Q2s12q9P8ZW52L2YQiZq2JMT8xBHIvryIVTYKVsDJje1d5jJilDZ
         2njDBamYIivOsb2iGeYfxNXdoVuM6xBI2hTyQ+7EsBmBAYTbScdIpLS/xyigH76rkPLK
         sKYbAwNM30wCVxjBo3PkgcgaVQ+wY1RK5YDYfnqPuPyc8+0OhAUIx2Rv5Bt8B4Dr9189
         KYoA==
X-Gm-Message-State: APjAAAWZhIWAzWAcgCCHKfQsBizk0DfeG6bTn6haZBBi6DdsD4lp0gWz
        rNttzXHAgtwltBKA0hw3UQ==
X-Google-Smtp-Source: APXvYqxECu31goFts3ashMmwgeYTiD3iatbSbg6PFYYV5QA+CSiUobjI4SjbAkfq5ICCGt0uV6Nyfg==
X-Received: by 2002:a9d:61cd:: with SMTP id h13mr176279otk.264.1570744117843;
        Thu, 10 Oct 2019 14:48:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 67sm2107233otq.34.2019.10.10.14.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:48:36 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:48:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, michal.simek@xilinx.com
Subject: Re: [RFC PATCHv2 1/3] dt-bindings: misc: Add dt bindings for flex
 noc Performance Monitor
Message-ID: <20191010214835.GA4523@bogus>
References: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:46:24AM +0530, Shubhrajyoti Datta wrote:
> Add dt bindings for flexnoc Performance Monitor.
> The flexnoc counters for read and write response and requests are
> supported.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  .../devicetree/bindings/misc/xlnx,flexnoc.txt      | 24 ++++++++++++++++++++++

bindings/perf/

Please convert this to a schema. See 
Documentation/devicetree/writing-schema.rst.

>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt b/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt
> new file mode 100644
> index 0000000..6b533bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt
> @@ -0,0 +1,24 @@
> +* Xilinx Flexnoc Performance Monitor driver

Bindings are for h/w blocks, not drivers.

> +
> +The FlexNoc Performance Monitor has counters for monitoring
> +the read and the write transaction counter.
> +
> +Required properties:
> +- compatible: "xlnx,flexnoc-pm-2.7"
> +- reg : Address and length of register sets for each device in
> +       "reg-names"
> +- reg-names : The names of the register addresses corresponding to the
> +               registers filled in "reg"
> +               - funnel: base address of the funnel registers
> +               - baselpd: base address of the LPD PM registers
> +               - basefpd: base address FPD PM registers

Is this really all one h/w block.

FlexNoC is an interconnect, right? Is there more to it than just 
perfmon?

> +
> +Example:
> +++++++++
> +performance-monitor@f0920000 {
> +               compatible = "xlnx,flexnoc-pm-2.7";
> +               reg-names = "funnel", "baselpd", "basefpd";
> +               reg = <0x0 0xf0920000 0x0 0x1000>,
> +                       <0x0 0xf0980000 0x0 0x9000>,
> +                       <0x0 0xf0b80000 0x0 0x9000>;
> +};
> --
> 2.1.1
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

We can't accept confidential emails.

Rob
