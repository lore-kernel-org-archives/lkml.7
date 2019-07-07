Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD6EC48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F98206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGGNbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 09:31:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:33816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfGGNbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 09:31:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6553CAFDB;
        Sun,  7 Jul 2019 13:31:17 +0000 (UTC)
Subject: Re: [PATCH 5/6] dt-bindings: arm: Document RTD1296
To:     Aleix Roca Nonell <kernelrocks@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707132339.GF13340@arks.localdomain>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <27a3468f-e7b4-e334-5956-8db87d04ff8c@suse.de>
Date:   Sun, 7 Jul 2019 15:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707132339.GF13340@arks.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.07.19 um 15:23 schrieb Aleix Roca Nonell:
> Add bindings for Relatek RTD1296 SoC. And the Bannana Pi BPI-W2 board.

"Realtek", "Banana"

> 
> Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/realtek.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
> index 95839e19ae92..78da1004d38c 100644
> --- a/Documentation/devicetree/bindings/arm/realtek.txt
> +++ b/Documentation/devicetree/bindings/arm/realtek.txt
> @@ -20,3 +20,16 @@ Root node property compatible must contain, depending on board:
>  Example:
>  
>      compatible = "zidoo,x9s", "realtek,rtd1295";
> +
> +
> +RTD1296 SoC
> +===========
> +
> +Required root node properties:
> +
> + - compatible :  must contain "realtek,rtd1296"

I'm pretty sure that I had such a patch on the list already, so this is
lacking my authorship.

Also, Rob has been working to convert these to YAML, so we should
probably complete that first and then add RTD1296 properly.

> +
> +
> +Root node property compatible must contain, depending on board:
> +
> + - Bannana Pi BPI-W2: "bananapi,bpi-w2"

"Banana"

Regards,
Andreas


-- 
SUSE Linux GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
