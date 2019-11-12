Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4387AC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1DB20674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W4W0lNyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKLOd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:33:57 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39794 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLOd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:33:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACEXsM0101071;
        Tue, 12 Nov 2019 08:33:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573569234;
        bh=KJ28q3/ntxcdDwesCt3alIEjIisaOx4/xiHcvs2Dq0Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=W4W0lNygbyNTDB41vHoj/Kg/vUTiTPePzAUQFZfKaC510NPT0de/JuRgZMk1ASaTv
         5Wey/JDmqN5OmR1RbjBXlOx0UVgJGJcN4/W48eYcszoTkMvV/NABZLxmtPPbcPStU7
         PDHBC2j2sOsrIPaz1yYZ/As4/K4rXHiwNSIuU1Fc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACEXs9M034320
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:33:54 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:33:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:33:36 -0600
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with SMTP id xACEXs1c054050;
        Tue, 12 Nov 2019 08:33:54 -0600
Date:   Tue, 12 Nov 2019 08:36:56 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 01/20] dt-bindings: media: cal: update binding to use
 syscon
Message-ID: <20191112143656.kvyam2iagosmkhpu@ti.com>
References: <20191112143152.23176-1-bparrot@ti.com>
 <20191112143152.23176-2-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191112143152.23176-2-bparrot@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rob

Benoit Parrot <bparrot@ti.com> wrote on Tue [2019-Nov-12 08:31:33 -0600]:
> Update Device Tree bindings for the CAL driver to use syscon to access
> the phy config register instead of trying to map it directly.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  Documentation/devicetree/bindings/media/ti-cal.txt | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/ti-cal.txt b/Documentation/devicetree/bindings/media/ti-cal.txt
> index ae9b52f37576..93096d924786 100644
> --- a/Documentation/devicetree/bindings/media/ti-cal.txt
> +++ b/Documentation/devicetree/bindings/media/ti-cal.txt
> @@ -10,9 +10,14 @@ Required properties:
>  - compatible: must be "ti,dra72-cal"
>  - reg:	CAL Top level, Receiver Core #0, Receiver Core #1 and Camera RX
>  	control address space
> -- reg-names: cal_top, cal_rx_core0, cal_rx_core1, and camerrx_control
> +- reg-names: cal_top, cal_rx_core0, cal_rx_core1 and camerrx_control
>  	     registers
>  - interrupts: should contain IRQ line for the CAL;
> +- ti,camerrx-control: phandle to the device control module and offset to
> +		      the control_camerarx_core register.
> +		      This node is meant to replace the "camerrx_control"
> +		      reg entry above but "camerrx_control" is still
> +		      handled for backward compatibility.
>  
>  CAL supports 2 camera port nodes on MIPI bus. Each CSI2 camera port nodes
>  should contain a 'port' child node with child 'endpoint' node. Please
> @@ -25,13 +30,12 @@ Example:
>  		ti,hwmods = "cal";
>  		reg = <0x4845B000 0x400>,
>  		      <0x4845B800 0x40>,
> -		      <0x4845B900 0x40>,
> -		      <0x4A002e94 0x4>;
> +		      <0x4845B900 0x40>;
>  		reg-names = "cal_top",
>  			    "cal_rx_core0",
> -			    "cal_rx_core1",
> -			    "camerrx_control";
> +			    "cal_rx_core1";
>  		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +		ti,camerrx-control = <&scm_conf 0xE94>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -- 
> 2.17.1
> 
