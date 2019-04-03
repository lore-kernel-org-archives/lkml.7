Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42251C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26B320830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDCJYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:24:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52789 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDCJYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:24:45 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hBc8Q-00071h-Tt
        for linux-kernel@vger.kernel.org; Wed, 03 Apr 2019 09:24:43 +0000
Received: by mail-pf1-f197.google.com with SMTP id f7so5700467pfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fUu8+Y1D19Hlnn1vkrUlFdjkPAfLGAlBu/x122RHS/w=;
        b=Tc47x9uQ1eIimqBa59IWaPkQkWpgePhpoVlSfxu/aKeJpXhVZnB9EJ7gW9ZKhZ1wgF
         79RFT/VMkihxFIALNDp9tbpjIVh0j+tWu0SKkdL3PWXlJAX+EJ/X+HbdQWlrD41YDSIj
         SQPgXudRcZggKB3Q69cyifvWp8plgnLbEkik5uVL6Mi6PcETAR7N4pX0p+Uuq7WpRGae
         7xzBT45ILWJl+6dV59VbZlzdQ3fmEbvKvPERXnh28h29gV6HL8uQRlL2j3eeFWBztcLk
         dc421wfRkhJDHGlJ1OYS/n8cqhkLC9upmSBdH/Y3T3rMNvB6ke/acnS7WELx8OFOLl2C
         K+Sg==
X-Gm-Message-State: APjAAAU56fsxouBLse/pyVff8ns5S67Rj5cn0GQrPQz6f+wWoe7r+yBw
        KX6z2Uyqlyp3X0+Y4k+PeQd5Lk7ugCluMWabtYQOCT0FT+SoWp0mUMmKSVvn+bviZ/zoOoBBDLF
        7ToPa7Lb9ypzh9UDo08WE6lBkSpqpcA8y3XtnCfa8Uw==
X-Received: by 2002:a63:2e87:: with SMTP id u129mr50079326pgu.321.1554283481599;
        Wed, 03 Apr 2019 02:24:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyFOq/HhG98bF+hCzVPO+hQzeZOoYmgXPtds5hQ6MTlELzZWyDzWggOgJfSR8PcrAAIY8Ap9g==
X-Received: by 2002:a63:2e87:: with SMTP id u129mr50079301pgu.321.1554283481312;
        Wed, 03 Apr 2019 02:24:41 -0700 (PDT)
Received: from 2001-b011-380f-14b9-c43a-ef62-354d-4c21.dynamic-ip6.hinet.net (2001-b011-380f-14b9-c43a-ef62-354d-4c21.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:c43a:ef62:354d:4c21])
        by smtp.gmail.com with ESMTPSA id k26sm19834802pfo.111.2019.04.03.02.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:24:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <16218e1c23bb4cb6b0b739d561a707bc@ausx13mpc120.AMER.DELL.COM>
Date:   Wed, 3 Apr 2019 17:24:37 +0800
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        benjamin.tissoires@redhat.com, hotwater438@tutanota.com,
        jikos@kernel.org, swboyd@chromium.org, bigeasy@linutronix.de,
        dtor@chromium.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <3E46D2D1-EADC-4F77-8091-A36E648C4908@canonical.com>
References: <LaQHUFs--3-1@tutanota.com>
 <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
 <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
 <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com>
 <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
 <CAHp75VdTMn_v8ag11jo6aYtuiWL4bhvSzCnhaUBtuqSQxxnT_w@mail.gmail.com>
 <d813fe02035b481b8f3a55aa4dffbb22@ausx13mpc120.AMER.DELL.COM>
 <6105BFF6-41B1-4DB8-A78D-20BC2E35C014@canonical.com>
 <16218e1c23bb4cb6b0b739d561a707bc@ausx13mpc120.AMER.DELL.COM>
To:     Mario.Limonciello@dell.com
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 22:08, <Mario.Limonciello@dell.com> <Mario.Limonciello@dell.com> wrote:

>> -----Original Message-----
>> From: Kai Heng Feng <kai.heng.feng@canonical.com>
>> Sent: Monday, April 1, 2019 11:18 PM
>> To: Limonciello, Mario
>> Cc: Andy Shevchenko; hdegoede@redhat.com; benjamin.tissoires@redhat.com;
>> hotwater438@tutanota.com; jikos@kernel.org; swboyd@chromium.org;
>> bigeasy@linutronix.de; dtor@chromium.org; linux-input@vger.kernel.org;  
>> linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
>>
>>
>> [EXTERNAL EMAIL]
>>
>>
>>
>>> On Apr 2, 2019, at 5:37 AM, <Mario.Limonciello@dell.com>
>>> <Mario.Limonciello@dell.com> wrote:
>>>
>>>> -----Original Message-----
>>>> From: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>> Sent: Thursday, March 21, 2019 4:48 AM
>>>> To: Kai-Heng Feng; Limonciello, Mario
>>>> Cc: Hans de Goede; Benjamin Tissoires; hotwater438@tutanota.com; Jiri
>>>> Kosina;
>>>> Stephen Boyd; Sebastian Andrzej Siewior; Dmitry Torokhov; open list:HID
>>>> CORE
>>>> LAYER; lkml
>>>> Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
>>>>
>>>>
>>>> [EXTERNAL EMAIL]
>>>>
>>>> +Cc: Mario
>>>>
>>>> Mario, do you have any insights about the issue with touchpad on Dell
>>>> system described below?
>>>
>>> My apologies, this got lost while I was on vacation.
>>>
>>>> On Thu, Mar 21, 2019 at 6:08 AM Kai-Heng Feng
>>>> <kai.heng.feng@canonical.com> wrote:
>>>>> at 01:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>>>
>>>>>> On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
>>>>>> <kai.heng.feng@canonical.com> wrote:
>>>>>>> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:
>>>>>>
>>>>>>>> Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
>>>>>>>> is also used on Elan devices, I suspect that these Elan devices
>>>>>>>> likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
>>>>>>>> and then they probably will no longer need the bogus IRQ flag,
>>>>>>>> if you know about bugreports with an acpidump for any of the devices
>>>>>>>> needing the bogus IRQ quirk, then I (or you) can check how the IRQ  
>>>>>>>> is
>>>>>>>> declared there, I suspect it will be declared as level-low, just  
>>>>>>>> like
>>>>>>>> with the laptop this patch was written for. And it probably need to
>>>>>>>> be edge-falling instead of level-low just like this case.
>>>>>>>
>>>>>>> First, I’ve already tried using IRQF_TRIGGER_FALLING, unfortunately  
>>>>>>> it
>>>>>>> doesn’t solve the issue for me.
>>>>>>>
>>>>>>> I talked to Elan once, and they confirm the correct IRQ trigger is
>>>>>>> level
>>>>>>> low. So forcing falling trigger may break other platforms.
>>>>>>
>>>>>> As far as I understood Vladislav the quirk he got from Elan as well.
>>>>>
>>>>> Ok, then this is really weird.
>>>>>
>>>>>>> Recently we found that Elan touchpad doesn’t like GpioInt() from its
>>>>>>> _CRS.
>>>>>>> Once the Interrupt() is used instead, the issue goes away.
>>>>>>
>>>>>> IIRC i2c core tries to get interrupt from Interrupt() resource and
>>>>>> then falls back to GpioInt().
>>>>>> See i2c_acpi_get_info() and i2c_device_probe().
>>>>>
>>>>> Here’s its ASL:
>>>>>
>>>>>     Scope (\_SB.PCI0.I2C4)
>>>>>     {
>>>>>         Device (TPD0)
>>>>>         {
>>>>>             Name (_ADR, One)  // _ADR: Address
>>>>>             Name (_HID, "DELL08AE")  // _HID: Hardware ID
>>>>>             Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID:
>>>> Compatible ID
>>>>>            Name (_UID, One)  // _UID: Unique ID
>>>>>             Name (_S0W, 0x04)  // _S0W: S0 Device Wake State
>>>>>             Name (SBFB, ResourceTemplate ()
>>>>>             {
>>>>>                 I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
>>>>>                     AddressingMode7Bit, "\\_SB.PCI0.I2C4",
>>>>>                     0x00, ResourceConsumer, , Exclusive,
>>>>>                     )
>>>>>             })
>>>>>             Name (SBFG, ResourceTemplate ()
>>>>>             {
>>>>>                 GpioInt (Level, ActiveLow, ExclusiveAndWake, PullUp, 0x0000,
>>>>>                     "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>>>>>                     )
>>>>>                     {   // Pin list
>>>>>                         0x0012
>>>>>                     }
>>>>>             })
>>>>>             Name (SBFI, ResourceTemplate ()
>>>>>             {
>>>>>                 Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, )
>>>>>                 {
>>>>>                     0x0000003C,
>>>>>                 }
>>>>>             })
>>>>>             Method (_INI, 0, NotSerialized)  // _INI: Initialize
>>>>>             {
>>>>>             }
>>>>>             Method (_STA, 0, NotSerialized)  // _STA: Status
>>>>>             {
>>>>>                 If ((TCPD == One))
>>>>>                 {
>>>>>                     Return (0x0F)
>>>>>                 }
>>>>>
>>>>>                 Return (Zero)
>>>>>             }
>>>>>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>>>>             {
>>>>>                 If ((OSYS < 0x07DC))
>>>>>                 {
>>>>>                     Return (SBFI) /* \_SB_.PCI0.I2C4.TPD0.SBFI */
>>>>>                 }
>>>>>
>>>>>                 Return (ConcatenateResTemplate (SBFB, SBFG))
>>>>>             }
>>>>>             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
>>>>>             {
>>>>>                 If ((Arg0 == ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /*
>> HID
>>>> I2C Device */))
>>>>>                {
>>>>>                     If ((Arg2 == Zero))
>>>>>                     {
>>>>>                         If ((Arg1 == One))
>>>>>                         {
>>>>>                             Return (Buffer (One)
>>>>>                             {
>>>>>                                  0x03                                             // .
>>>>>                             })
>>>>>                         }
>>>>>                         Else
>>>>>                         {
>>>>>                             Return (Buffer (One)
>>>>>                             {
>>>>>                                  0x00                                             // .
>>>>>                             })
>>>>>                         }
>>>>>                     }
>>>>>                     ElseIf ((Arg2 == One))
>>>>>                     {
>>>>>                         Return (0x20)
>>>>>                     }
>>>>>                     Else
>>>>>                     {
>>>>>                         Return (Buffer (One)
>>>>>                         {
>>>>>                              0x00                                             // .
>>>>>                         })
>>>>>                     }
>>>>>                 }
>>>>>                 ElseIf ((Arg0 == ToUUID ("ef87eb82-f951-46da-84ec-14871ac6f84b")))
>>>>>                 {
>>>>>                     If ((Arg2 == Zero))
>>>>>                     {
>>>>>                         If ((Arg1 == One))
>>>>>                         {
>>>>>                             Return (Buffer (One)
>>>>>                             {
>>>>>                                  0x03                                             // .
>>>>>                             })
>>>>>                         }
>>>>>                     }
>>>>>
>>>>>                     If ((Arg2 == One))
>>>>>                     {
>>>>>                         Return (ConcatenateResTemplate (SBFB, SBFG))
>>>>>                     }
>>>>>
>>>>>                     Return (Buffer (One)
>>>>>                     {
>>>>>                          0x00                                             // .
>>>>>                     })
>>>>>                 }
>>>>>                 }
>>>>>                 Else
>>>>>                 {
>>>>>                     Return (Buffer (One)
>>>>>                     {
>>>>>                          0x00                                             // .
>>>>>                     })
>>>>>                 }
>>>>>             }
>>>>>         }
>>>>>     }
>>>>>
>>>>> Change SBFG to SBFI in its _CRS can workaround the issue.
>>>>> Is ASL in this form possible to do the flow you described?
>>>>>
>>>>> Kai-Heng
>>>>>
>>>>>>> But I am not sure how to patch its DSDT/SSDT in i2c-hid.
>>>
>>> Is this pre-production HW?  If so, maybe this is a case that we should  
>>> talk
>>> about custom OSI string to run the ASL differently.
>>
>> Some are already shipped.
>>
>>
>>> The other option would be to create a new ASL method in FW and from Linux
>>> side a quirk that calls this new ASL method.
>>
>> Since this patch is for ASUS Laptop, I think a more generic solution from
>> driver layer is preferred.
>
> I thought this ASL was from Dell laptop.  The HID make it looks like it  
> at least.

Yes this ASL is from a Dell system.

>>>>>            Name (_HID, "DELL08AE")  // _HID: Hardware ID
>
> In general more generic solution from driver layer is preferred I agree.   
> You might
> need to check with ACPI guys to see if they have some ideas on situations  
> that
> GpioInt fail.

I’ve filed a bug here but we don’t find any proper solution:
https://bugzilla.kernel.org/show_bug.cgi?id=201311

Kai-Heng

