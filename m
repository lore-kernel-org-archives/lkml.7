Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183D9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E9F2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDCN7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:59:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58561 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCN7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:59:04 -0400
Received: from [111.196.85.178] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1hBgPs-0005Jo-4t; Wed, 03 Apr 2019 13:59:00 +0000
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
To:     Christopher Heiny <Cheiny@synaptics.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Duggan <aduggan@synaptics.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
 <17cd420ea32a9787c56ba25e36e7661541c2f65f.camel@synaptics.com>
 <a0f21198-5715-8858-8368-51e43092181e@canonical.com>
 <acd07f4d-1602-46c5-c486-c917f1868b59@canonical.com>
 <f4f7265d9ad06726bb2ef12ab6b7529d2fb06165.camel@synaptics.com>
From:   Aaron Ma <aaron.ma@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=aaron.ma@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFffeLkBCACi4eE4dPsgWN6B9UDOVcAvb5QgU/hRG6yS0I1lGKQv4KA+bke0c5g8clbO
 9gIlIl2bityfA9NzBsDik4Iei3AxMbFyxv9keMwcOFQBIOZF0P3f05qjxftF8P+yp9QTV4hp
 BkFzsXzWRgXN3r8hU8wqZybepF4B1C83sm2kQ5A5N0AUGbZli9i2G+/VscG9sWfLy8T7f4YW
 MjmlijCjoV6k29vsmTWQPZ7EApNpvR5BnZQPmQWzkkr0lNXlsKcyLgefQtlwg6drK4fe4wz0
 ouBIHJEiXE1LWK1hUzkCUASra4WRwKk1Mv/NLLE/aJRqEvF2ukt3uVuM77RWfl7/H/v5ABEB
 AAG0IUFhcm9uIE1hIDxhYXJvbi5tYUBjYW5vbmljYWwuY29tPokBNwQTAQgAIQUCV994uQIb
 AwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDNxCzQfVU6ntJ9B/9aVy0+RkLqF9QpLmw+
 LAf1m3Fd+4ZarPTerqDqkLla3ekYhbrEtlI1mYuB5f+gtrIjmcW27gacHdslKB9YwaL8B4ZB
 GJKhcrntLg4YPzYUnXZkHHTv1hMw7fBYw82cBT+EbG0Djh6Po6Ihqyr3auHhfFcp1PZH4Mtq
 6hN5KaDZzF/go+tRF5e4bn61Nhdue7mrhFSlfkzLG2ehHWmRV+S91ksH81YDFnazK0sRINBx
 V1S8ts3WJ2f1AbgmnDlbK3c/AfI5YxnIHn/x2ZdXj1P/wn7DgZHmpMy5DMuk0gN34NLUPLA/
 cHeKoBAF8emugljiKecKBpMTLe8FrVOxbkrauQENBFffeLkBCACweKP3Wx+gK81+rOUpuQ00
 sCyKzdtMuXXJ7oL4GzYHbLfJq+F+UHpQbytVGTn3R5+Y61v41g2zTYZooaC+Hs1+ixf+buG2
 +2LZjPSELWPNzH9lsKNlCcEvu1XhyyHkBDbnFFHWlUlql3nSXMo//dOTG/XGKaEaZUxjCLUC
 8ehLc16DJDvdXsPwWhHrCH/4k92F6qQ14QigBMsl75jDTDJMEYgRYEBT1D/bwxdIeoN1BfIG
 mYgf059RrWax4SMiJtVDSUuDOpdwoEcZ0FWesRfbFrM+k/XKiIbjMZSvLunA4FIsOdWYOob4
 Hh0rsm1G+fBLYtT+bE26OWpQ/lSn4TdhABEBAAGJAR8EGAEIAAkFAlffeLkCGwwACgkQzcQs
 0H1VOp6p5Af/ap5EVuP1AhFdPD3pXLNrUUt72W3cuAOjXyss43qFC2YRjGfktrizsDjQU46g
 VKoD6EW9XUPgvYM+k8BJEoXDLhHWnCnMKlbHP3OImxzLRhF4kdlnLicz1zKRcessQatRpJgG
 NIiD+eFyh0CZcWBO1BB5rWikjO/idicHao2stFdaBmIeXvhT9Xp6XNFEmzOmfHps+kKpWshY
 9LDAU0ERBNsW4bekOCa/QxfqcbZYRjrVQvya0EhrPhq0bBpzkIL/7QSBMcdv6IajTlHnLARF
 nAIofCEKeEl7+ksiRapL5Nykcbt4dldE3sQWxIybC94SZ4inENKw6I8RNpigWm0R5w==
Message-ID: <9321df87-5bc5-0c75-2815-f8602ecf9d86@canonical.com>
Date:   Wed, 3 Apr 2019 21:58:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f4f7265d9ad06726bb2ef12ab6b7529d2fb06165.camel@synaptics.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/19 12:16 AM, Christopher Heiny wrote:
> On Thu, 2019-03-28 at 14:02 +0800, Aaron Ma wrote:
>> Hi Dmitry and Chiristopher:
>>
>> Do you have any suggestion about these 2 patches?
>>
>> Many users confirmed that they fixed issues of Trackpoint/Touchpad
>> after S3.
>>
>> Will you consider them be accepted?
> Hi Aaron,
> 
> Sorry - I thought I'd replied on the NO SLEEP portion of these patches,
> but looking back I don't find the draft or the sent email.  Sorry about
> that.  I'll summarize here what I wrote last month.
> 
> This isn't so much a "fix" as a "hacky workaround" for the issue.  From
> the descriptions in the bug you linked in your original patch
> submission, it appears that the root cause is somewhere in SMBus system
> (could be SMBus driver, SMBus hardware, or the devices on the SMBus
> (touch devices or other devices) - it's hard to tell with the info
> available), where the SMBus is failing to come online correctly coming
> out of S3 state.  Anyway, this patch doesn't fix the root cause, but
> merely works around it.

Users confirmed the 1st patch that clear irq status fixed their multiple
issues on Touchpad and Trackpoint.
I think it is a fix.

NO SLEEP patch was tried to give users a choice a fix touchpad issues
that I didn't reproduce.
If you don't like this export, we can drop it now as users confirmed 1st
patch works.

> 
> Setting the NO SLEEP bit will force the touch sensor to remain in a
> high power consumption state while the rest of the system is in S3. 
> While not a lot of power compared to things like the CPU, display, and
> others, it is still non-trivial and will result in shorter time-on-
> battery capability.

Verified on s2idle and S3 and system running idle mode. no difference on
power consumption of whole system with or without set 1 to nosleep.

> 
> If you have access to the power pin(s) for the touch sensor(s)/styk(s),
> it might be interesting to try turning power off on entering S3, and
> restoring it on exit.  That's very hacky, and has the side effect of
> slightly delaying touchpad readiness on exit from S3.  Plus you'll need
> to restore touch sensor configuration settings on exit.  But it
> definitely reduces power consumption.
> 
> 
> Separately, I am still concerned about the possibility of dropped touch
> events in the IRQ clearing.  I'm not convinced that the code is safe
> (as you mentioned in your reply to my earlier comment), so I'll have to
> study the implementation more carefully.

Sure, take your time, if you have any questions let me know please.

Thanks,
Aaron

> 
> 					Cheers,
> 						Chris
> 
> 
> 
>> Thanks,
>> Aaron
> 
