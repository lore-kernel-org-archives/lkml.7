Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E2FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CB62184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AFdABBqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCTJFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:05:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40080 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfCTJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:05:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2K94vYI013686;
        Wed, 20 Mar 2019 04:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553072697;
        bh=shW+6H/NgxAuCRg88FkfQrh0o12N9Q7cgurPj2bR63g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AFdABBqRSQFzUDfFbrVRyo1hobFVOWtut+SeiungJRb9A18xEs5pMC/9nXRI+bTTa
         /EAHjQVSrZpmT0zr/fwp6G6Y3BBaOojUqLjHkoUmQzHMa1mmZqvViISyn7VZgvR4iD
         4j0vys/zSFyU2btaVTdaLsOa2FdbTqIFpq4RwB68=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2K94v5A061094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Mar 2019 04:04:57 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 20
 Mar 2019 04:04:57 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Wed, 20 Mar 2019 04:04:57 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2K94pqd013387;
        Wed, 20 Mar 2019 04:04:53 -0500
Subject: Re: [PATCH 2/2] pwm: Kconfig: Enable ehrpwm driver to be compiled for
 ARCH_K3
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20190312091629.31701-1-vigneshr@ti.com>
 <20190312091629.31701-3-vigneshr@ti.com>
 <20190312093012.g4rnis37nltzbygz@pengutronix.de>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <a998ec1e-d734-b350-8b3f-99a5bb52b62a@ti.com>
Date:   Wed, 20 Mar 2019 14:35:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312093012.g4rnis37nltzbygz@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/03/19 3:00 PM, Uwe Kleine-König wrote:
> On Tue, Mar 12, 2019 at 02:46:29PM +0530, Vignesh Raghavendra wrote:
>> K3 devices have the same EHRPWM IP as OMAP SoCs. Enable driver to be built
>> for K3 devices. Also, drop reference to AM33xx in help text, as IP is
>> found on multiple TI SoCs.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  drivers/pwm/Kconfig | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 54f8238aac0d..c054bd1dba36 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -467,10 +467,9 @@ config  PWM_TIECAP
>>  
>>  config  PWM_TIEHRPWM
>>  	tristate "EHRPWM PWM support"
>> -	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX
>> +	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3
>>  	help
>> -	  PWM driver support for the EHRPWM controller found on AM33XX
>> -	  TI SOC
>> +	  PWM driver support for the EHRPWM controller found on TI SOCs
> 
> It would be great to be able to compile this driver with COMPILE_TEST.
> From a quick look the following would be appropriate:
> 
> 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3 || COMPILE_TEST
> 	depends on HAVE_CLK && HAS_IOMEM
>  

Thanks for the suggestion! I will send a separate patch on top of this
series to enable COMPILE TEST for this driver and other TI PWM drivers.

> Best regards
> Uwe
> 

-- 
Regards
Vignesh
