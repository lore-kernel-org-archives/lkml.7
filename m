Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE07C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AD02070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfC0Lun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:50:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53348 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfC0Lun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:50:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4DBA374;
        Wed, 27 Mar 2019 04:50:42 -0700 (PDT)
Received: from [192.168.0.21] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E8A93F557;
        Wed, 27 Mar 2019 04:50:40 -0700 (PDT)
Subject: Re: [PATCH 10/25] coresight: tpiu: Clean up device specific data
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-11-git-send-email-suzuki.poulose@arm.com>
 <20190326215440.GB1658@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <db4dfb7b-49db-ca9b-58ca-8b40a9157949@arm.com>
Date:   Wed, 27 Mar 2019 11:52:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190326215440.GB1658@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2019 09:54 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:27PM +0000, Suzuki K Poulose wrote:
>> Switch to using the coresight device instead of the parent
>> amba device.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpiu.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
>> index b2f72a1..9763721 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
>> @@ -48,15 +48,13 @@
>>   
>>   /**
>>    * @base:	memory mapped base address for this component.
>> - * @dev:	the device entity associated to this component.
>> + * @dev:	the coresight device entity associated to this component.
>>    * @atclk:	optional clock for the core parts of the TPIU.
>> - * @csdev:	component vitals needed by the framework.
>>    */
>>   struct tpiu_drvdata {
>>   	void __iomem		*base;
>>   	struct device		*dev;
>>   	struct clk		*atclk;
>> -	struct coresight_device	*csdev;
> 
> Here again I would get rid of @dev rather than @csdev to be consistent with what
> was done previously.

Sure, will do.

Cheers
Suzuki
