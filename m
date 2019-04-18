Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D5CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B04C20651
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389501AbfDRPP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:15:57 -0400
Received: from foss.arm.com ([217.140.101.70]:35548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfDRPP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:15:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6555815AB;
        Thu, 18 Apr 2019 08:15:56 -0700 (PDT)
Received: from [10.37.12.22] (unknown [10.37.12.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E0093F5AF;
        Thu, 18 Apr 2019 08:15:51 -0700 (PDT)
Subject: Re: [RESEND][PATCH v2 27/36] drivers: Add a generic helper to match
 device by fwnode handle
To:     rafael@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org
References: <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
 <1555411164-26399-1-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0i2-11rgH5Y+83U041Eyp=SA56oPqDmS2g24SyYYJH3jg@mail.gmail.com>
 <ebb13205-2548-1c30-fd65-bdfe4c7d9c08@arm.com>
 <CAJZ5v0jXioEAELmHqMhR0wJQkzLQpp1WA-zuWHdFkSWjiX0kVw@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1379e9d4-c020-6180-69e8-f15a9e0983bc@arm.com>
Date:   Thu, 18 Apr 2019 16:18:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jXioEAELmHqMhR0wJQkzLQpp1WA-zuWHdFkSWjiX0kVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2019 03:39 PM, Rafael J. Wysocki wrote:
> On Tue, Apr 16, 2019 at 12:53 PM Suzuki K Poulose
> <suzuki.poulose@arm.com> wrote:
>>
>> On 04/16/2019 11:48 AM, Rafael J. Wysocki wrote:
>>> On Tue, Apr 16, 2019 at 12:39 PM Suzuki K Poulose
>>> <suzuki.poulose@arm.com> wrote:
>>>>
>>>> Make the device_fwnode_match() a generic helper to match device
>>>> by fwnode handle for use with bus_find_device(). This will be
>>>> also used by coresight.
>>>>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>>> Cc: linux-acpi@vger.kernel.org
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>
>>>> Resending with linux-acpi in Cc, as requested by Rafael.
>>>
>>> Do any other patches in your series depend on this one?
>>
>> Yes, I do. But they are in the middle of a big series of changes and
>> I don't expect this series to go into 5.2. So, if you plan to pull this
>> please go ahead.
> 
> I would prefer the new exported function to return bool.  With that
> changed, I can apply the patch I think.
> 


That will need changes to all the other callers of bus_find_device()
to fix their match(). I guess that is a bit of an invasive change, so
I would rather do it in the "consolidation" series with
class_find_device().

Hope you're fine with that.

Suzuki
