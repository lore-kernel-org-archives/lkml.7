Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BA1C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38A820828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J1JAqDO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfF0Oc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:32:28 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51326 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfF0Oc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:32:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5REWAE7064972;
        Thu, 27 Jun 2019 09:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561645930;
        bh=Pdb2niascgRQ5Fb/5i1cIddIfEEE5n8a0ANOeYZHq5k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=J1JAqDO0zB1wxT4LmmPkCiXU0LgdhayBVgJkcE4djJAjs9LqOqNUkKaLtejVYCrg6
         oqSiUUiusYB9leJWWdbgfoBnsO3eW2axDI1iya9HNuQVHhdgLy7v17BWhV6vnpL636
         XKRipUtgCrWCktKEjlNLGaeOHmFgodvKjBJRx2/Y=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5REWA17018257
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jun 2019 09:32:10 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 27
 Jun 2019 09:32:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 27 Jun 2019 09:32:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5REWAuH077836;
        Thu, 27 Jun 2019 09:32:10 -0500
Date:   Thu, 27 Jun 2019 09:32:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Keerthy <j-keerthy@ti.com>
CC:     <t-kristo@ti.com>, <will.deacon@arm.com>,
        <catalin.marinas@arm.com>, <shawnguo@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lokeshvutla@ti.com>
Subject: Re: [PATCH v2] arm64: Kconfig.platforms: Enable GPIO_DAVINCI for
 ARCH_K3
Message-ID: <20190627143208.eeca4xyygml7s4n3@kahuna>
References: <20190627110920.15099-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190627110920.15099-1-j-keerthy@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:39-20190627, Keerthy wrote:
> Enable GPIO_DAVINCI and related configs for TI K3 AM6 platforms.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Enabling configs in Kconfig.platforms file instead of defconfig.
>   * Removed GPIO_DEBUG config.
> 
>  arch/arm64/Kconfig.platforms | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 4778c775de1b..6e43a0995ed4 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -97,6 +97,8 @@ config ARCH_K3
>  	select TI_SCI_PROTOCOL
>  	select TI_SCI_INTR_IRQCHIP
>  	select TI_SCI_INTA_IRQCHIP
> +	select GPIO_SYSFS
> +	select GPIO_DAVINCI


Could you help explain the logic of doing this? commit message is
basically the diff in English. To me, this does NOT make sense.

I understand GPIO_DAVINCI is the driver compatible, but we cant do this for
every single SoC driver that is NOT absolutely mandatory for basic
functionality.

Also keep in mind the impact to arm64/configs/defconfig -> every single
SoC in the arm64 world will be now rebuild with GPIO_SYSFS.. why force
that?

-- 
Regards,
Nishanth Menon
