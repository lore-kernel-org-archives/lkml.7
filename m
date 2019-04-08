Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75436C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBE420883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDHKoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:44:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfDHKoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:44:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86D2C15AD;
        Mon,  8 Apr 2019 03:44:36 -0700 (PDT)
Received: from [10.37.12.66] (unknown [10.37.12.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 742903F718;
        Mon,  8 Apr 2019 03:44:34 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] coresight: replicator: Add new device id for
 static replicator
To:     leo.yan@linaro.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        shiwanglai@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190406112145.15184-1-leo.yan@linaro.org>
 <20190406112145.15184-3-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6b862aa8-1b50-61bf-6894-978ecd1a964b@arm.com>
Date:   Mon, 8 Apr 2019 11:46:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190406112145.15184-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2019 12:21 PM, Leo Yan wrote:
> This patch adds a device id for the new static replicator compatible
> string; it changes the driver name from "coresight-replicator" to
> "coresight-static-replicator" as well.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-replicator.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 4e0da85efd2d..e6a03642bbdb 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -285,13 +285,14 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
>   
>   static const struct of_device_id static_replicator_match[] = {
>   	{.compatible = "arm,coresight-replicator"},
> +	{.compatible = "arm,coresight-static-replicator"},
>   	{}

As mentioned in the previous patch, please could you add a warning if
you encounter the old binding, mentioning that it is OBSOLETE.
pr_warn_once() is sufficient.

Otherwise, looks good.

Suzuki
