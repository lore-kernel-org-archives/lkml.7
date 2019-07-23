Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E76DC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5138121670
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qpdlQrXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbfGWNAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:00:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51742 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390003AbfGWNA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:00:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6ND0Fm1009552;
        Tue, 23 Jul 2019 08:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563886815;
        bh=v2FDDSUbtY7+5lQxj8CvY2KwoTuATkdmytGBYizH/w8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qpdlQrXMzdmnxTxhAKPn3SppE/9DFnfOXvdFo39d2gDDC9a9QwynknJhG0kIpGg2e
         wdE3oFSIhVYZWsvBP2Bjf8IFhJiGCzCtSzqXYhsEZbMF0kcuTynsTHvFShQ9TzVsgu
         yVFWHc/zesbn5qIcteIfXDYnXkRnSUZ4/dbQ+fb0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6ND0FFT123355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jul 2019 08:00:15 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Jul 2019 08:00:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Jul 2019 08:00:15 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6ND0AM9021383;
        Tue, 23 Jul 2019 08:00:13 -0500
Subject: Re: [PATCH 3/9] dt-bindings: interrupt-controller: arm, gic-v3:
 Describe ESPI range support
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190723104437.154403-1-maz@kernel.org>
 <20190723104437.154403-4-maz@kernel.org>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <04e80def-c8e3-a403-036e-2a64db935ed4@ti.com>
Date:   Tue, 23 Jul 2019 18:29:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190723104437.154403-4-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/07/19 4:14 PM, Marc Zyngier wrote:
> GICv3.1 introduces support for new interrupt ranges, one of them being
> the Extended SPI range (ESPI). The DT binding is extended to deal with
> it as a new interrupt class.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> index c34df35a25fc..98a3ecda8e07 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> @@ -44,11 +44,12 @@ properties:
>        be at least 4.
>  
>        The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
> -      interrupts. Other values are reserved for future use.
> +      interrupts, 2 for interrupts in the Extended SPI range. Other values
> +      are reserved for future use.

Any reason why hardware did not consider extending SPIs from 1020:2043? This way
only EPPI would have been introduced. Just a thought.

Either ways, just to be consistent with hardware numbering can ESPI range be 3
and EPPI range be 2?

Thanks and regards,
Lokesh

>  
>        The 2nd cell contains the interrupt number for the interrupt type.
>        SPI interrupts are in the range [0-987]. PPI interrupts are in the
> -      range [0-15].
> +      range [0-15]. Extented SPI interrupts are in the range [0-1023].
>  
>        The 3rd cell is the flags, encoded as follows:
>        bits[3:0] trigger type and level flags.
> 
