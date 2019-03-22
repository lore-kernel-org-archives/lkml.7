Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB08C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BF920685
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbfCVM26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:28:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389942AbfCVM2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:28:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A90B374;
        Fri, 22 Mar 2019 05:28:55 -0700 (PDT)
Received: from [10.37.13.63] (unknown [10.37.13.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 244153F614;
        Fri, 22 Mar 2019 05:28:53 -0700 (PDT)
Subject: Re: [PATCH -next] coresight: catu: Make catu_helper_ops and catu_ops
 static
To:     yuehaibing@huawei.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190321151852.10216-1-yuehaibing@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <607f4a17-34ca-86ae-e0c4-c5bfb9fc11c2@arm.com>
Date:   Fri, 22 Mar 2019 12:31:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190321151852.10216-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2019 03:18 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> drivers/hwtracing/coresight/coresight-catu.c:488:35: warning:
>   symbol 'catu_helper_ops' was not declared. Should it be static?
> drivers/hwtracing/coresight/coresight-catu.c:493:28: warning:
>   symbol 'catu_ops' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/hwtracing/coresight/coresight-catu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 170fbb6..057627a 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -485,12 +485,12 @@ static int catu_disable(struct coresight_device *csdev, void *__unused)
>   	return rc;
>   }
>   
> -const struct coresight_ops_helper catu_helper_ops = {
> +static const struct coresight_ops_helper catu_helper_ops = {
>   	.enable = catu_enable,
>   	.disable = catu_disable,
>   };
>   
> -const struct coresight_ops catu_ops = {
> +static const struct coresight_ops catu_ops = {
>   	.helper_ops = &catu_helper_ops,
>   };
>   
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
