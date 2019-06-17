Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E59C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3092229B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfFQIZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:25:17 -0400
Received: from foss.arm.com ([217.140.110.172]:41058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfFQIZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:25:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12D628;
        Mon, 17 Jun 2019 01:25:16 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2FB13F246;
        Mon, 17 Jun 2019 01:25:15 -0700 (PDT)
Subject: Re: [PATCH -next] coresight: replicator: Add terminate entry for
 acpi_device_id tables
To:     weiyongjun1@huawei.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190615104440.94149-1-weiyongjun1@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <06c751dc-0a23-b33b-1ff1-a98d6503408c@arm.com>
Date:   Mon, 17 Jun 2019 09:25:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190615104440.94149-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Thanks for the fix, please find my comment below.

On 15/06/2019 11:44, Wei Yongjun wrote:
> Make sure acpi_device_id tables have terminate entry.
> 
> Fixes: 8f35caae1e1f ("coresight: acpi: Support for platform devices")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/hwtracing/coresight/coresight-replicator.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 542952759941..0c73dc1073c0 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -300,6 +300,7 @@ static const struct of_device_id static_replicator_match[] = {
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id static_replicator_acpi_ids[] = {
>   	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
> +	{"", 0},

nit: I would leave it {}, instead of creating an empty string.

With that :

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
