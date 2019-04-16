Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B479C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A8F20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BXxXRUqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfDPIt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:49:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38902 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfDPIt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:49:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3G8nt7o009648;
        Tue, 16 Apr 2019 03:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555404595;
        bh=5etahWAr/9s/z27GeNu1kwuHjU+38k2R2fFmYCJbK0k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BXxXRUqEPpA+HVJkvydeFL3knHmTjVxL5al07zYc5nM9bYcdjBAJQrShWwetm4jID
         QYbcwtoUDlAB92GwEHT56E6FQFfcox/HEJcdgxBBt26GtcVwN+nVFPfBtY7VBSUtd2
         y+4o9TXQiU0ClHtdFZ/Ru+u5eLShRpEsxMPIPCjU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3G8ntAk079221
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Apr 2019 03:49:55 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 16
 Apr 2019 03:49:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 16 Apr 2019 03:49:55 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3G8nrWF081782;
        Tue, 16 Apr 2019 03:49:54 -0500
Subject: Re: [PATCH] drivers: memory: This patch fix the following checkpatch
 warning.
To:     Mohan Kumar <mohankumar718@gmail.com>
CC:     <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1555404372-3582-1-git-send-email-mohankumar718@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <27678553-2f8b-cd8a-c3ed-dc897922dc42@ti.com>
Date:   Tue, 16 Apr 2019 11:49:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555404372-3582-1-git-send-email-mohankumar718@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mohan,

On 16/04/2019 11:46, Mohan Kumar wrote:
> Switch hardcoded function name with a reference to __func__ making the
> code more maintainable
> 
> WARNING: Prefer using '"%s...", __func__' to using function's name, in a
> string
> 
> Use pr_warn instead of printk
> 
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ...
> then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/memory/omap-gpmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index f629759..685f422 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -795,7 +795,7 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t,
>  #endif
>  
>  	gpmc_cs_bool_timings(cs, &t->bool_timings);
> -	gpmc_cs_show_timings(cs, "after gpmc_cs_set_timings");
> +	gpmc_cs_show_timings(cs, "%s", __func__);

This will not build. gpmc_cs_show_timings only takes 2 arguments.
>  
>  	return 0;
>  }
> @@ -1033,7 +1033,7 @@ void gpmc_cs_free(int cs)
>  
>  	spin_lock(&gpmc_mem_lock);
>  	if (cs >= gpmc_cs_num || cs < 0 || !gpmc_cs_reserved(cs)) {
> -		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
> +		pr_err("Trying to free non-reserved GPMC CS%d\n", cs);
>  		BUG();
>  		spin_unlock(&gpmc_mem_lock);
>  		return;
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
