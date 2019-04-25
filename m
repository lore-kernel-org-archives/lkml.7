Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76113C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D022F20651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfDYQR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:17:27 -0400
Received: from foss.arm.com ([217.140.101.70]:47758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfDYQR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:17:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 945FC80D;
        Thu, 25 Apr 2019 09:17:26 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F154D3F557;
        Thu, 25 Apr 2019 09:17:24 -0700 (PDT)
Subject: Re: [PATCH v2 31/36] coresight: stm: ACPI support for parsing
 stimulus base
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-32-git-send-email-suzuki.poulose@arm.com>
 <20190423175913.GD21070@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <bc8290d9-f1e7-6824-7d08-2427cdd56a13@arm.com>
Date:   Thu, 25 Apr 2019 17:17:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423175913.GD21070@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/2019 18:59, Mathieu Poirier wrote:
> On Mon, Apr 15, 2019 at 05:04:14PM +0100, Suzuki K Poulose wrote:
>> The stimulus base for STM device must be listed as the second memory
>> resource, followed by the programming base address as described in
>> "Section 2.3 Resources" in ACPI for CoreSightTM 1.0 Platform Design
>> documen (DEN0067).
> 
> Thank you for adding more information.
> 
>>
>> Add support for parsing the information for ACPI.


> 
> I would copy the description in the changelog just before the
> list_for_each_entry() loop.
> 


>>   static int stm_get_stimulus_area(struct device *dev, struct resource *res)
>>   {
>>   	if (dev->of_node)
> 
> I noticed the direct access of ->of_node in patch 16 and thought it was a little
> odd that is_of_node() wasn't used.
> 
>>   		return of_stm_get_stimulus_area(dev, res);
>> +	else if (is_acpi_node(dev->fwnode))
>> +		return acpi_stm_get_stimulus_area(dev, res);
>>   	return -ENOENT;
> 
> With the above:

Both addressed.

> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks !
Suzuki
