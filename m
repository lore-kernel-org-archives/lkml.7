Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D26C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7042075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfDPKxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:53:45 -0400
Received: from foss.arm.com ([217.140.101.70]:52212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfDPKxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:53:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E267380D;
        Tue, 16 Apr 2019 03:53:44 -0700 (PDT)
Received: from [10.37.12.114] (unknown [10.37.12.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A957F3F68F;
        Tue, 16 Apr 2019 03:53:40 -0700 (PDT)
Subject: Re: [RESEND][PATCH v2 27/36] drivers: Add a generic helper to match
 device by fwnode handle
To:     rafael@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org
References: <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
 <1555411164-26399-1-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0i2-11rgH5Y+83U041Eyp=SA56oPqDmS2g24SyYYJH3jg@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ebb13205-2548-1c30-fd65-bdfe4c7d9c08@arm.com>
Date:   Tue, 16 Apr 2019 11:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i2-11rgH5Y+83U041Eyp=SA56oPqDmS2g24SyYYJH3jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2019 11:48 AM, Rafael J. Wysocki wrote:
> On Tue, Apr 16, 2019 at 12:39 PM Suzuki K Poulose
> <suzuki.poulose@arm.com> wrote:
>>
>> Make the device_fwnode_match() a generic helper to match device
>> by fwnode handle for use with bus_find_device(). This will be
>> also used by coresight.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>
>> Resending with linux-acpi in Cc, as requested by Rafael.
> 
> Do any other patches in your series depend on this one?

Yes, I do. But they are in the middle of a big series of changes and
I don't expect this series to go into 5.2. So, if you plan to pull this
please go ahead.

Suzuki
