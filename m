Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 18:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C612148D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 18:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V9HcOfem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCWSEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 14:04:16 -0400
Received: from pb-sasl-trial21.pobox.com ([173.228.157.51]:63167 "EHLO
        pb-sasl-trial21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfCWSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 14:04:16 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Mar 2019 14:04:14 EDT
Received: from pb-sasl-trial21.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id C78B632FAA;
        Sat, 23 Mar 2019 13:55:10 -0400 (EDT)
        (envelope-from nicolas.pitre@linaro.org)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=DIkJurCus6SFb+cIyUoFy++M3GI=; b=V9HcOf
        em98Sfs6qYemwA5C3xLyvmmLhGwS0U9phvICndbGmfJC8XTbJ+pK1tbQXumn4OIT
        ak8MyTAUmueJkpybwpoftVtWN8fVl9uaW79LNoKVIAIKd6KFtn+/5FMBR+Yxn01S
        doc2cnnvPus8mXriuEjpS07b2Fu83Fuj/45V4=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id B56D832FA9;
        Sat, 23 Mar 2019 13:55:10 -0400 (EDT)
        (envelope-from nicolas.pitre@linaro.org)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A916B53623;
        Sat, 23 Mar 2019 13:55:07 -0400 (EDT)
        (envelope-from nicolas.pitre@linaro.org)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id BB0C02DA01C2;
        Sat, 23 Mar 2019 13:55:05 -0400 (EDT)
Date:   Sat, 23 Mar 2019 13:55:05 -0400 (EDT)
From:   nicolas.pitre@linaro.org
To:     Stefan Agner <stefan@agner.ch>
cc:     linux@armlinux.org.uk, arnd@arndb.de, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        kgene@kernel.org, krzk@kernel.org, robh@kernel.org,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        tony@atomide.com, marc.w.gonzalez@free.fr, mans@mansr.com,
        ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: mvebu: drop unnecessary label
In-Reply-To: <2046aa3ca5ae2f31188020d4f2df50de228a5d84.1553356359.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1903231354270.1971@knanqh.ubzr>
References: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch> <2046aa3ca5ae2f31188020d4f2df50de228a5d84.1553356359.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: CB8EEA0C-4D94-11E9-B4A6-EE24A11ADF13-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2019, Stefan Agner wrote:

> The label mvebu_boot_wa_start is not necessary and causes a build
> issue when building with LLVM's integrated assembler:
>     AS      arch/arm/mach-mvebu/pmsu_ll.o
>   arch/arm/mach-mvebu/pmsu_ll.S:59:1: error: invalid symbol redefinition
>   mvebu_boot_wa_start:
>   ^
> 
> Drop the label.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  arch/arm/mach-mvebu/pmsu_ll.S | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
> index 88651221dbdd..c1fb713e9306 100644
> --- a/arch/arm/mach-mvebu/pmsu_ll.S
> +++ b/arch/arm/mach-mvebu/pmsu_ll.S
> @@ -56,7 +56,6 @@ ENDPROC(armada_38x_cpu_resume)
>  
>  /* The following code will be executed from SRAM */
>  ENTRY(mvebu_boot_wa_start)
> -mvebu_boot_wa_start:
>  ARM_BE8(setend	be)
>  	adr	r0, 1f
>  	ldr	r0, [r0]		@ load the address of the
> -- 
> 2.21.0
> 
> 
