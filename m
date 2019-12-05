Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7302F21823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfLEId4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:33:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:38160 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfLEId4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:33:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C314AACA5;
        Thu,  5 Dec 2019 08:33:54 +0000 (UTC)
Subject: Re: [PATCH 1/2] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek PymParticle EVB
To:     James Tai <james.tai@realtek.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191205082555.22633-1-james.tai@realtek.com>
 <20191205082555.22633-2-james.tai@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <ca3edb07-b2d4-7305-9a34-c4d55f30d778@suse.de>
Date:   Thu, 5 Dec 2019 09:33:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205082555.22633-2-james.tai@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 05.12.19 um 09:25 schrieb James Tai:
> Define compatible strings for Realtek RTD1319 SoC and Realtek PymParticle
> EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
> index 2444eff2c3d5..f018d683a544 100644
> --- a/Documentation/devicetree/bindings/arm/realtek.yaml
> +++ b/Documentation/devicetree/bindings/arm/realtek.yaml
> @@ -39,4 +39,10 @@ properties:
>            - enum:
>                - realtek,mjolnir # Realtek Mjolnir EVB
>            - const: realtek,rtd1619
> +
> +     # RTD1319 SoC based boards
> +     - items:
> +          - enum:
> +              - realtek,pymparticle # Realtek PymParticle EVB
> +          - const: realtek,rtd1319
>  ...

I think it would be better to order this alphabetically before RTD1395.

Otherwise looking good.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
