Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52522C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317B62190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfGYNfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:35:47 -0400
Received: from foss.arm.com ([217.140.110.172]:57464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbfGYNfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:35:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ADF328;
        Thu, 25 Jul 2019 06:35:44 -0700 (PDT)
Received: from [10.37.10.14] (unknown [10.37.10.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95DF03F71F;
        Thu, 25 Jul 2019 06:35:43 -0700 (PDT)
Subject: Re: [PATCH v2 23/28] drivers: Introduce
 driver_find_device_by_of_node() helper
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, thor.thayer@linux.intel.com
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-24-git-send-email-suzuki.poulose@arm.com>
 <20190725105103.GB6164@dell>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fc40ac7f-3df3-ce30-a4ba-1698f976d239@arm.com>
Date:   Thu, 25 Jul 2019 14:38:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190725105103.GB6164@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee

On 07/25/2019 11:51 AM, Lee Jones wrote:
> On Fri, 14 Jun 2019, Suzuki K Poulose wrote:
> 
>> Add a wrapper to driver_find_device() to search for a device
>> by the of_node pointer, reusing the generic match function.
>> Also convert the existing users to make use of the new helper.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Thor Thayer <thor.thayer@linux.intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/amba/tegra-ahb.c    | 11 +----------
>>   drivers/mfd/altera-sysmgr.c | 14 ++------------
>>   include/linux/device.h      | 13 +++++++++++++
>>   3 files changed, 16 insertions(+), 22 deletions(-)
> 
> Looks good to me.  For the MFD part.
> 
> For my own reference:
>    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Thanks ! Btw, v3 has been posted based on 5.3-rc1. You are
in Cc for that.

> 
> What is the merge plan?
> 

With v3, it looks more sensible to merge the patch via Greg's tree.

Suzuki

