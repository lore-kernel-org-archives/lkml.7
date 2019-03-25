Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E28E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfCYOmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:42:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33070 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYOmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:42:12 -0400
Received: from [167.98.27.226] (helo=[10.35.5.150])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h8Qni-0004gR-Bm; Mon, 25 Mar 2019 14:42:10 +0000
Subject: Re: [PATCH] Documentation: acpi: Add an example for PRP0001
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
 <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
 <20190325115118.GP9224@smile.fi.intel.com>
 <20190325130413.GT9224@smile.fi.intel.com>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <d67bb260-863c-1131-1323-711c3d2e227d@codethink.co.uk>
Date:   Mon, 25 Mar 2019 14:42:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325130413.GT9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for looking at this.

On 25/03/2019 13:04, Andy Shevchenko wrote:
> On Mon, Mar 25, 2019 at 01:51:18PM +0200, Andy Shevchenko wrote:
>> On Mon, Mar 25, 2019 at 10:31:13AM +0100, Rafael J. Wysocki wrote:
>>> On Fri, Mar 22, 2019 at 2:47 PM Thomas Preston
>>> <thomas.preston@codethink.co.uk> wrote:
>>>>
>>>> Add an example for the magic PRP0001 device ID which allows matching
>>>> ACPI devices against drivers using OF Device Tree compatible property.
>>>> It wasn't clear to me that PRP0001 could be used in _CID.
>>>
>>> Mika, Andy, can you have a look at this, please?
>>
>> Good to me,
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Though one thing I would like to add (not directly related to the patch
>> per se), i.e. it would be nice to keep such examples under meta-acpi [1]
>> umbrella as a database for such excerpts.
>>
>> Thomas, can you do that?
>>
>> [1]: https://github.com/westeri/meta-acpi

I will :)

>>
>>>> +               Name (_HID, "TITMP75") /* _HID will appear in sysfs */
> 
> Sorry for not noticing earlier.
> 
> Is this an official ID for the chip? We discourage people to invent ACPI IDs on
> their own.
> 
> 

The device is a TI tmp75b temperature sensor [0]. The HID is completely
made up, I'm afraid. It doesn't exist in the registry.

[0] http://www.ti.com/lit/ds/symlink/tmp75b.pdf
