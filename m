Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04634C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03CD218AF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDLQ4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:56:47 -0400
Received: from muru.com ([72.249.23.125]:45664 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbfDLQ4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:56:47 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9C58C80F3;
        Fri, 12 Apr 2019 16:57:01 +0000 (UTC)
Date:   Fri, 12 Apr 2019 09:56:43 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     robh+dt@kernel.org, s-anna@ti.com, nm@ti.com, lokeshvutla@ti.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-binding: arm: omap: Add information for AM5748
Message-ID: <20190412165643.GZ2839@atomide.com>
References: <20190405132806.20772-1-rogerq@ti.com>
 <20190405132806.20772-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405132806.20772-2-rogerq@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190405 13:28]:
> Add DT binding details for AM5748 SoC and AM5748 IDK.

Seems trivial enough for me to pick up with no acks.
Adding into omap-for-v5.2/dt.

Regards,

Tony

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 2ecc712bf707..1c1e48fd94b5 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -92,6 +92,9 @@ SoCs:
>  - DRA718
>    compatible = "ti,dra718", "ti,dra722", "ti,dra72", "ti,dra7"
>  
> +- AM5748
> +  compatible = "ti,am5748", "ti,dra762", "ti,dra7"
> +
>  - AM5728
>    compatible = "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
>  
> @@ -184,6 +187,9 @@ Boards:
>  - AM57XX SBC-AM57x
>    compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
>  
> +- AM5748 IDK
> +  compatible = "ti,am5748-idk", "ti,am5748", "ti,dra762", "ti,dra7";
> +
>  - AM5728 IDK
>    compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
>  
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
