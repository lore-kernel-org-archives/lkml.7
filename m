Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41485C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E24C2465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q6scEtJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfLTCrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:47:41 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49600 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTCrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:47:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBK2leWt010171;
        Thu, 19 Dec 2019 20:47:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576810060;
        bh=HXApxIRNsh32DrkR8Mxs4Ae0SPX+t5QFqt8IIpf+fAM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q6scEtJH71fKjgdpgRf6JqEl6c0X2ynYJb+QesXnmnEKxkbZUh6Bf4X78Kl8DNOVU
         B2rwfcAP4UicxMIiXy1EJt/t5F12cu7Ay1+p2L70vvhPeu6OApA6OaA8haT+4NV26C
         1yYflY0R8Hm2128smvKR61fqz7pV/b1A/uA/29/M=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBK2leCh056071
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Dec 2019 20:47:40 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 20:47:37 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 20:47:37 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBK2lbun124782;
        Thu, 19 Dec 2019 20:47:37 -0600
Subject: Re: [PATCHv3 09/15] remoteproc/omap: Remove the
 omap_rproc_reserve_cma declaration
To:     Tero Kristo <t-kristo@ti.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>, <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <linux-omap@vger.kernel.org>
References: <20191213125537.11509-1-t-kristo@ti.com>
 <20191213125537.11509-10-t-kristo@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <75420692-ecbc-f7cd-f7bc-9df0849d91dc@ti.com>
Date:   Thu, 19 Dec 2019 20:47:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191213125537.11509-10-t-kristo@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

On 12/13/19 6:55 AM, Tero Kristo wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The omap_rproc_reserve_cma() function is not defined at the moment.
> This prototype was to be used to define a function to declare a
> remoteproc device-specific CMA pool.
> 
> The remoteproc devices will be defined through DT going forward. A
> device specific CMA pool will be defined under the reserved-memory
> node, and will be associated with the appropriate remoteproc device
> node. This function prototype will no longer be needed and has
> therefore been cleaned up.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

With the structure removed, you can actually drop the file altogether.

regards
Suman

> ---
>  include/linux/platform_data/remoteproc-omap.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/include/linux/platform_data/remoteproc-omap.h b/include/linux/platform_data/remoteproc-omap.h
> index 6bea01e199fe..49c78805916f 100644
> --- a/include/linux/platform_data/remoteproc-omap.h
> +++ b/include/linux/platform_data/remoteproc-omap.h
> @@ -21,16 +21,4 @@ struct omap_rproc_pdata {
>  	int (*device_shutdown)(struct platform_device *pdev);
>  };
>  
> -#if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
> -
> -void __init omap_rproc_reserve_cma(void);
> -
> -#else
> -
> -static inline void __init omap_rproc_reserve_cma(void)
> -{
> -}
> -
> -#endif
> -
>  #endif /* _PLAT_REMOTEPROC_H */
> 

