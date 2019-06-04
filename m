Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02C8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8A924A21
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfFDKzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:55:39 -0400
Received: from foss.arm.com ([217.140.101.70]:40278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfFDKzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:55:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C760380D;
        Tue,  4 Jun 2019 03:55:38 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CF5F3F5AF;
        Tue,  4 Jun 2019 03:55:38 -0700 (PDT)
Subject: Re: [RFC PATCH 46/57] driver: Add variants of driver_find_device()
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
 <20190603191041.GD6487@kroah.com>
 <97a6b41f-7b30-54fc-a633-e59895467902@arm.com>
Message-ID: <0ed1eb1e-df7f-d531-19ee-8b29ee37ae6d@arm.com>
Date:   Tue, 4 Jun 2019 11:55:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <97a6b41f-7b30-54fc-a633-e59895467902@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/2019 09:45, Suzuki K Poulose wrote:
> 
> 
> On 03/06/2019 20:10, Greg KH wrote:
>> On Mon, Jun 03, 2019 at 04:50:12PM +0100, Suzuki K Poulose wrote:
>>> Add a wrappers to lookup a device by name for a given driver, by various
>>> generic properties of a device. This can avoid the proliferation of custom
>>> match functions throughout the drivers.
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>    include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 44 insertions(+)
>>
>> You should put the "here are the new functions that everyone can use"
>> much earlier in the patch series, otherwise it's hard to dig out.
> 
> Sure, I will add it in the respective commits.
> 
>>
>> And if you send just those as an individual series, and they look good,
>> I can queue them up now so that everyone else can take the individual
>> patches through their respective trees.
> 
> I see. I think I may be able to do that.

The API change patch (i.e, "drivers: Unify the match prototype for 
bus_find_device with class_find_device" ) is tricky and prevents us from doing
this. So, that patch has to come via your tree as it must be a one shot change.
And that would make the individual subsystem patches conflict with your tree.
Also, it would break the builds until the individual subsystem trees are merged
with your tree with the new API.

So I am not quite sure what the best approach here would be.

Cheers
Suzuki
