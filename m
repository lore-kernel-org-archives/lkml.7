Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D46C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824C720833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfDBESg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:18:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43939 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfDBESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:18:35 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hBAsa-0001I8-3G
        for linux-kernel@vger.kernel.org; Tue, 02 Apr 2019 04:18:32 +0000
Received: by mail-qt1-f197.google.com with SMTP id d49so12149159qtk.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rdBWdAtcXsSzEh2+7caXBNjyctDYx01lKtYUHbPuVFo=;
        b=ozjliSPEXJgpPAGiI+PyhGHgdBr2SVAMLl7U2Jmh0/Mw1RRSfGnTJo4Rah0nO4Tmcc
         mIzuvG5AfWB8jZVs3hWZqqyu+vZXFdg2qfLSdvN8ZAiMkhr6piOZRPbzp1J19V3WqEwa
         CQDhLU/NFFUx61IQDOzJF48u2q6l7mJR7OKKIueWY5jSYH9xHBcxPwt7q0ZJEB9o3NgI
         Y86Ne51lgmBTLSghzHAH+2rLkRlxEgIIDZ4UR7czAuEoXbaZpvJ2ZJ3WGB3HTAxxGb0q
         cQWLUy00U1fxE1RzBEzXgQ0WqU+wpAhcXEYEWuH1FrxSsNZiNFpEe5xIExJc42n8mjg/
         bn1g==
X-Gm-Message-State: APjAAAUV231weIiH9NvINkwTvFF8nEOFRWjiz1DaO+Ace1B820Gq5lF9
        5ToWcu/aArG3RoLSn25sR+R5gbgqK+meF66r134s1W7Id/HY0lX7HLG9oQjQqZeVuPQ0VKRKfNe
        G54EN76B5EMvqHuXrm7tqBO16h0mTwQsCdIqJWd2jgQ==
X-Received: by 2002:a0c:a424:: with SMTP id w33mr56279893qvw.5.1554178711186;
        Mon, 01 Apr 2019 21:18:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxo5CZyon5HygBGYdgwRLZvUQKVK1CQIXPktfxLAWVOe2amhfrWARfE+6ANKunvEEWbvpt6QA==
X-Received: by 2002:a0c:a424:: with SMTP id w33mr56279879qvw.5.1554178710867;
        Mon, 01 Apr 2019 21:18:30 -0700 (PDT)
Received: from [10.101.46.46] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id c207sm5905309qkg.14.2019.04.01.21.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 21:18:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <d813fe02035b481b8f3a55aa4dffbb22@ausx13mpc120.AMER.DELL.COM>
Date:   Tue, 2 Apr 2019 12:18:23 +0800
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>, hdegoede@redhat.com,
        benjamin.tissoires@redhat.com, hotwater438@tutanota.com,
        jikos@kernel.org, swboyd@chromium.org, bigeasy@linutronix.de,
        dtor@chromium.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <6105BFF6-41B1-4DB8-A78D-20BC2E35C014@canonical.com>
References: <LaQHUFs--3-1@tutanota.com>
 <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
 <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
 <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com>
 <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
 <CAHp75VdTMn_v8ag11jo6aYtuiWL4bhvSzCnhaUBtuqSQxxnT_w@mail.gmail.com>
 <d813fe02035b481b8f3a55aa4dffbb22@ausx13mpc120.AMER.DELL.COM>
To:     Mario.Limonciello@dell.com
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 2, 2019, at 5:37 AM, <Mario.Limonciello@dell.com>  
> <Mario.Limonciello@dell.com> wrote:
>
>> -----Original Message-----
>> From: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Sent: Thursday, March 21, 2019 4:48 AM
>> To: Kai-Heng Feng; Limonciello, Mario
>> Cc: Hans de Goede; Benjamin Tissoires; hotwater438@tutanota.com; Jiri  
>> Kosina;
>> Stephen Boyd; Sebastian Andrzej Siewior; Dmitry Torokhov; open list:HID  
>> CORE
>> LAYER; lkml
>> Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
>>
>>
>> [EXTERNAL EMAIL]
>>
>> +Cc: Mario
>>
>> Mario, do you have any insights about the issue with touchpad on Dell
>> system described below?
>
> My apologies, this got lost while I was on vacation.
>
>>
>> On Thu, Mar 21, 2019 at 6:08 AM Kai-Heng Feng
>> <kai.heng.feng@canonical.com> wrote:
>>>
>>> at 01:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>
>>>> On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
>>>> <kai.heng.feng@canonical.com> wrote:
>>>>> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:
>>>>
>>>>>> Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
>>>>>> is also used on Elan devices, I suspect that these Elan devices
>>>>>> likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
>>>>>> and then they probably will no longer need the bogus IRQ flag,
>>>>>> if you know about bugreports with an acpidump for any of the devices
>>>>>> needing the bogus IRQ quirk, then I (or you) can check how the IRQ is
>>>>>> declared there, I suspect it will be declared as level-low, just like
>>>>>> with the laptop this patch was written for. And it probably need to
>>>>>> be edge-falling instead of level-low just like this case.
>>>>>
>>>>> First, I’ve already tried using IRQF_TRIGGER_FALLING, unfortunately it
>>>>> doesn’t solve the issue for me.
>>>>>
>>>>> I talked to Elan once, and they confirm the correct IRQ trigger is  
>>>>> level
>>>>> low. So forcing falling trigger may break other platforms.
>>>>
>>>> As far as I understood Vladislav the quirk he got from Elan as well.
>>>
>>> Ok, then this is really weird.
>>>
>>>>
>>>>> Recently we found that Elan touchpad doesn’t like GpioInt() from its  
>>>>> _CRS.
>>>>> Once the Interrupt() is used instead, the issue goes away.
>>>>
>>>> IIRC i2c core tries to get interrupt from Interrupt() resource and
>>>> then falls back to GpioInt().
>>>> See i2c_acpi_get_info() and i2c_device_probe().
>>>
>>> Here’s its ASL:
>>>
>>>     Scope (\_SB.PCI0.I2C4)
>>>     {
>>>         Device (TPD0)
>>>         {
>>>             Name (_ADR, One)  // _ADR: Address
>>>             Name (_HID, "DELL08AE")  // _HID: Hardware ID
>>>             Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID:
>> Compatible ID
>>>             Name (_UID, One)  // _UID: Unique ID
>>>             Name (_S0W, 0x04)  // _S0W: S0 Device Wake State
>>>             Name (SBFB, ResourceTemplate ()
>>>             {
>>>                 I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
>>>                     AddressingMode7Bit, "\\_SB.PCI0.I2C4",
>>>                     0x00, ResourceConsumer, , Exclusive,
>>>                     )
>>>             })
>>>             Name (SBFG, ResourceTemplate ()
>>>             {
>>>                 GpioInt (Level, ActiveLow, ExclusiveAndWake, PullUp, 0x0000,
>>>                     "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>>>                     )
>>>                     {   // Pin list
>>>                         0x0012
>>>                     }
>>>             })
>>>             Name (SBFI, ResourceTemplate ()
>>>             {
>>>                 Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, )
>>>                 {
>>>                     0x0000003C,
>>>                 }
>>>             })
>>>             Method (_INI, 0, NotSerialized)  // _INI: Initialize
>>>             {
>>>             }
>>>             Method (_STA, 0, NotSerialized)  // _STA: Status
>>>             {
>>>                 If ((TCPD == One))
>>>                 {
>>>                     Return (0x0F)
>>>                 }
>>>
>>>                 Return (Zero)
>>>             }
>>>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>>             {
>>>                 If ((OSYS < 0x07DC))
>>>                 {
>>>                     Return (SBFI) /* \_SB_.PCI0.I2C4.TPD0.SBFI */
>>>                 }
>>>
>>>                 Return (ConcatenateResTemplate (SBFB, SBFG))
>>>             }
>>>             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
>>>             {
>>>                 If ((Arg0 == ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID
>> I2C Device */))
>>>                 {
>>>                     If ((Arg2 == Zero))
>>>                     {
>>>                         If ((Arg1 == One))
>>>                         {
>>>                             Return (Buffer (One)
>>>                             {
>>>                                  0x03                                             // .
>>>                             })
>>>                         }
>>>                         Else
>>>                         {
>>>                             Return (Buffer (One)
>>>                             {
>>>                                  0x00                                             // .
>>>                             })
>>>                         }
>>>                     }
>>>                     ElseIf ((Arg2 == One))
>>>                     {
>>>                         Return (0x20)
>>>                     }
>>>                     Else
>>>                     {
>>>                         Return (Buffer (One)
>>>                         {
>>>                              0x00                                             // .
>>>                         })
>>>                     }
>>>                 }
>>>                 ElseIf ((Arg0 == ToUUID ("ef87eb82-f951-46da-84ec-14871ac6f84b")))
>>>                 {
>>>                     If ((Arg2 == Zero))
>>>                     {
>>>                         If ((Arg1 == One))
>>>                         {
>>>                             Return (Buffer (One)
>>>                             {
>>>                                  0x03                                             // .
>>>                             })
>>>                         }
>>>                     }
>>>
>>>                     If ((Arg2 == One))
>>>                     {
>>>                         Return (ConcatenateResTemplate (SBFB, SBFG))
>>>                     }
>>>
>>>                     Return (Buffer (One)
>>>                     {
>>>                          0x00                                             // .
>>>                     })
>>>                 }
>>>                 }
>>>                 Else
>>>                 {
>>>                     Return (Buffer (One)
>>>                     {
>>>                          0x00                                             // .
>>>                     })
>>>                 }
>>>             }
>>>         }
>>>     }
>>>
>>> Change SBFG to SBFI in its _CRS can workaround the issue.
>>> Is ASL in this form possible to do the flow you described?
>>>
>>> Kai-Heng
>>>
>>>>
>>>>> But I am not sure how to patch its DSDT/SSDT in i2c-hid.
>
> Is this pre-production HW?  If so, maybe this is a case that we should talk
> about custom OSI string to run the ASL differently.

Some are already shipped.


>
> The other option would be to create a new ASL method in FW and from Linux
> side a quirk that calls this new ASL method.
>

Since this patch is for ASUS Laptop, I think a more generic solution from  
driver layer is preferred.

Kai-Heng


