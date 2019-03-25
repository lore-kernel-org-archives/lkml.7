Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F95C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D612082C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfCYPEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:04:54 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34005 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCYPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:04:54 -0400
Received: from [167.98.27.226] (helo=[10.35.5.150])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h8R9f-0005ZN-OW; Mon, 25 Mar 2019 15:04:51 +0000
Subject: Re: [PATCH] Documentation: acpi: Add an example for PRP0001
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
 <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
 <20190325115118.GP9224@smile.fi.intel.com>
 <20190325130413.GT9224@smile.fi.intel.com>
 <d67bb260-863c-1131-1323-711c3d2e227d@codethink.co.uk>
 <20190325150142.GE9224@smile.fi.intel.com>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <5b06cafb-f1c7-768a-22f5-bb69a877ea64@codethink.co.uk>
Date:   Mon, 25 Mar 2019 15:04:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325150142.GE9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 15:01, Andy Shevchenko wrote:
> On Mon, Mar 25, 2019 at 02:42:09PM +0000, Thomas Preston wrote:
>> On 25/03/2019 13:04, Andy Shevchenko wrote:
>>> On Mon, Mar 25, 2019 at 01:51:18PM +0200, Andy Shevchenko wrote:
>>>> On Mon, Mar 25, 2019 at 10:31:13AM +0100, Rafael J. Wysocki wrote:
> 
>>>> Though one thing I would like to add (not directly related to the patch
>>>> per se), i.e. it would be nice to keep such examples under meta-acpi [1]
>>>> umbrella as a database for such excerpts.
>>>>
>>>> Thomas, can you do that?
>>>>
>>>> [1]: https://github.com/westeri/meta-acpi
>>
>> I will :)
> 
> Thank you! I will take either GH PR, or you may send an email to maintainers,
> i.e. Mika and me (PR is preferable because it would be seen publicly)
> 

I will get around to this, later this week.

>>>>>> +               Name (_HID, "TITMP75") /* _HID will appear in sysfs */
>>>
>>> Sorry for not noticing earlier.
>>>
>>> Is this an official ID for the chip? We discourage people to invent ACPI IDs on
>>> their own.
> 
>> The device is a TI tmp75b temperature sensor [0]. The HID is completely
>> made up, I'm afraid. It doesn't exist in the registry.
> 
> Thanks for clarification. In that case I would rather recommend to use simple
> PRP0001 as a _HID.
> 

Alright, I will resend with this modification.

>> [0] http://www.ti.com/lit/ds/symlink/tmp75b.pdf
> 
