Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27841C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4DF2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bV6UWKcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfCMKkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:40:53 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17984 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:40:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c88de270000>; Wed, 13 Mar 2019 03:40:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 03:40:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Mar 2019 03:40:51 -0700
Received: from [10.24.44.156] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 10:40:48 +0000
Subject: Re: [PATCH v2 2/2] dmaengine: tegra210-adma: update system sleep
 callbacks
To:     Jon Hunter <jonathanh@nvidia.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <treding@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1552455794-24946-1-git-send-email-spujar@nvidia.com>
 <1552455794-24946-2-git-send-email-spujar@nvidia.com>
 <c4d0a061-e435-8a60-0dfc-f8e66c0a9f0b@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <51f5a49e-f105-604c-130c-fd3d0a07bbc5@nvidia.com>
Date:   Wed, 13 Mar 2019 16:10:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <c4d0a061-e435-8a60-0dfc-f8e66c0a9f0b@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552473639; bh=k/Q0fIalrD+4kE9Y0GRl0fLzm4kjpBcRFJ66rllrjiU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=bV6UWKcE/a8mK6moubiMKY0BHtne9gFFzj85UFNbYgg5iWzMAUImC5KxaATv1pZXa
         Lf82BNnm8KXk3vMmIFVP1R18KLKYTXGYfQaP0OIRoQ0wm+YTdn+D2kl6H5Rm/FVDxW
         Me56mAJTPzq7TWCO+0Oq1D4EnN4dJRbmLNMzFwbU5gjEWxRE27Msnn1Cwdh0xD64FT
         4g8C+DZa52d5xYuujT0iG2ecwRh7HhDg6aE3jn+HE1ENAtKxKHtMDixzMBjx1EtLb+
         cDkQ7xUR2Z5/R1iknT/64M+brdZ8ViBNblxCPBm+JuUpnK62tkjodHTcDPpeqAL7L9
         IIXz8IAlItfjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/13/2019 3:58 PM, Jon Hunter wrote:
> On 13/03/2019 05:43, Sameer Pujar wrote:
>> If the driver is active till late suspend, where runtime PM cannot run,
>> force suspend is essential in such case to put the device in low power
>> state. Thus pm_runtime_force_suspend and pm_runtime_force_resume are
>> used as system sleep callbacks during system wide PM transitions.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   drivers/dma/tegra210-adma.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>> index 650cd9c..be29171 100644
>> --- a/drivers/dma/tegra210-adma.c
>> +++ b/drivers/dma/tegra210-adma.c
>> @@ -796,17 +796,11 @@ static int tegra_adma_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> -#ifdef CONFIG_PM_SLEEP
>> -static int tegra_adma_pm_suspend(struct device *dev)
>> -{
>> -	return pm_runtime_suspended(dev) == false;
>> -}
>> -#endif
>> -
>>   static const struct dev_pm_ops tegra_adma_dev_pm_ops = {
>>   	SET_RUNTIME_PM_OPS(tegra_adma_runtime_suspend,
>>   			   tegra_adma_runtime_resume, NULL)
>> -	SET_SYSTEM_SLEEP_PM_OPS(tegra_adma_pm_suspend, NULL)
>> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +				pm_runtime_force_resume)
>>   };
> Looking at our downstream kernel we use LATE_SYSTEM_SLEEP for these. Any
> reason why you changed this?
I think, I just wanted to replace function calls for system sleep here 
and probably did
not see exactly what we have in downstream kernel at that point. Looking 
at the commit
log in downstream, it might qualify for separate patch.
Let me know if you think, its better to add here.
>
> Cheers
> Jon
>
