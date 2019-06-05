Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C600C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BCB206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y2L7xC0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFEGRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:17:30 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58912 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFEGR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:17:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x556HQY6070720;
        Wed, 5 Jun 2019 01:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559715446;
        bh=pE+vAWiG4NGnFWLuFqy3RtWa8WXPpXxgHeHo1YIAJlc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=y2L7xC0K4A+6Ur0hloFWRGCH1EROQDf7rfoIGcd9RMBEHJhaa9PWkjZoSPXLFRWEO
         OcVpTNWuhhBRkRdbqNNnE/u4b4tU/D6mLFZeJftN8xVgsF8OWPGDLAezkSDTdbICQN
         SApJRoQbdSaZb6Stio0QsodELVHiD3qVR10JV3rc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x556HQgX058247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 01:17:26 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 01:17:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 01:17:25 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x556HMls068204;
        Wed, 5 Jun 2019 01:17:23 -0500
Subject: Re: [RFC PATCH 1/3] arm64: dts: ti: am6-wakeup: Add gpio node
To:     Keerthy <j-keerthy@ti.com>, <t-kristo@ti.com>, <nm@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190605060846.25314-1-j-keerthy@ti.com>
 <20190605060846.25314-2-j-keerthy@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <e6ec3894-4e3d-e721-c1bc-791263b2d309@ti.com>
Date:   Wed, 5 Jun 2019 11:46:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190605060846.25314-2-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/19 11:38 AM, Keerthy wrote:
> Add gpio0 node under wakeup domain. This has 56 gpios
> and all are capable of generating banked interrupts.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index f1ca171abdf8..8c6c99e7c6ed 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -74,4 +74,19 @@
>  		ti,sci-dst-id = <56>;
>  		ti,sci-rm-range-girq = <0x4>;
>  	};
> +
> +	wkup_gpio0: wkup_gpio0@42110000 {
> +		compatible = "ti,k2g-gpio", "ti,keystone-gpio";

This is not k2g. Can you either create a am6 specific compatible or just use
ti,keystone-gpio.

Thanks and regards,
Lokesh

> +		reg = <0x42110000 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&intr_wkup_gpio>;
> +		interrupts = <59 128>, <59 129>, <59 130>, <59 131>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <56>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		clocks = <&k3_clks 59 0>;
> +		clock-names = "gpio";
> +	};
>  };
> 
