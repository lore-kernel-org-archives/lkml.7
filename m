Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDD820854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553541534;
	bh=t1gtsFHEgTU/oD40O8Ha2TWXZ5j935gYS/4GeNFUEKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VsGOW5OclH2rjh52n1uxoKNxTgxt6QBNvqAMUuZ5IjQWc+h3ytjnl0x/tx9B/I9lj
	 5kXgM1KF08EZqRd+JDxfxlkD53ggeSNB3qy3yoSRdzhIYT+k5HuFQ7bUjlRzBlX7GV
	 7NN8SJpkILiROcmd/mz+FLWTwKALzCh/sloauQAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfCYTSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:18:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41415 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfCYTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:18:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id 64so9118598otb.8;
        Mon, 25 Mar 2019 12:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g5CvqxDNtyxDMJKKpNvNu3Mj6AB31pjj+rmsKAz+eF4=;
        b=fK4MrCU30xjQ62nSHfWykmWl3vGAuJ2OQVtMlTinXt+tN9BJmfHZ+vlLV9ryjF1C8H
         3eDNQymmWGA91Tr1Q1z+p1wK0/yrCjLe4QPj8dCaUebZX2Aev/9FHPKrZdSzvP3WsRdN
         KIksqj/L8Erqhdim2+3F0poMJywYjTy3PX0KsEP2ChSsif9RNOILpCBb8+2NDdGH0qrd
         BxnUgWuRPmCM6qyBM2LL4N5MwFaNH9nwFrcwPcSML8hQiinoUv/Qr3PocVyvBYjw3QJh
         g7OE5dC0cBBtvCKAC/qVuHP6ApiBxg37IttTeQDe4KVTHU6bVsn2dg3qWT561TadmsO8
         8S5g==
X-Gm-Message-State: APjAAAVyHkTs/uLRmHiWFchhvo2hZuauv5MY1R6iJPdlU9bhJ8QeWzl2
        WyZfy6eXqbLY/zdHsTy8dw==
X-Google-Smtp-Source: APXvYqwQrrCmz6nCJsYXaQzIAaO56E/Ptnm+H/+Q9PUbeS2r7e1oYXtigpmpraFiuqvBO597o9Cx7Q==
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr18793969oti.18.1553541531542;
        Mon, 25 Mar 2019 12:18:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o17sm6600159otl.27.2019.03.25.12.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 12:18:50 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:18:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     atull@kernel.org, mdf@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
Subject: Re: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190315235422.GA29658@bogus>
References: <20190314140122.23372-1-nava.manne@xilinx.com>
 <20190314140122.23372-7-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314140122.23372-7-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 07:31:22PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v4:
> 		-Modified binding description as suggested by Moritz Fischer.
> Changes for v3:
>                 -Removed PCAP as a child node to the FW and Created
> 		 an independent node since PCAP driver is a consumer
> 		 not a provider.

Huh?

It was the fpga-regions that I suggested should perhaps be at the 
top-level. As long as pcap is a function exposed by the firmware it 
should be a child of it.

> 
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt           | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 000000000000..6d7f10775d9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,11 @@
> +Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
> +The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
> +Programmable Logic (PL). The configuration uses  the firmware interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	zynqmp_pcap: pcap {
> +		compatible = "xlnx,zynqmp-pcap-fpga";
> +	};
> -- 
> 2.18.0
> 
