Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779FCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DB92186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfDEMmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:42:13 -0400
Received: from foss.arm.com ([217.140.101.70]:47850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDEMmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:42:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1432A1688;
        Fri,  5 Apr 2019 05:42:12 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 666DD3F557;
        Fri,  5 Apr 2019 05:42:10 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] dt-bindings: vendor-prefixes: add AZW
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190405122446.2101-1-peron.clem@gmail.com>
 <20190405122446.2101-4-peron.clem@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3c59976a-6155-5eb2-b922-1fa53e78ebab@arm.com>
Date:   Fri, 5 Apr 2019 13:42:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405122446.2101-4-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2019 13:24, Clément Péron wrote:
> Shenzhen AZW Technology Co. Ltd. is a manufacturer specialized in Android
> smart TV boxes, Intel mini PCs and home cloud TV boxes with NAS.
> 
> Add the vendor prefix for AZW.

Yay, I've been hacking on a Beelink A1 so this will be one less patch to 
worry about if I ever get it finished enough to upstream :)

(I had picked "beelink" as a prefix, but I guess "azw" does seem more 
appropriate to cover their OEM stuff as well, so there's no good reason 
to treat the in-house brand specially)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>   Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 8b4ae37629b2..8313edbaf52e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -54,6 +54,7 @@ avic	Shanghai AVIC Optoelectronics Co., Ltd.
>   avnet	Avnet, Inc.
>   axentia	Axentia Technologies AB
>   axis	Axis Communications AB
> +azw     Shenzhen AZW Technology Co., Ltd.
>   bananapi BIPAI KEJI LIMITED
>   bhf	Beckhoff Automation GmbH & Co. KG
>   bitmain	Bitmain Technologies
> 
