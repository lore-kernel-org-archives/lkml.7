Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C93AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7B0218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfCUEIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:08:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60862 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfCUEIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 00:08:32 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h6p0H-00024L-GR
        for linux-kernel@vger.kernel.org; Thu, 21 Mar 2019 04:08:29 +0000
Received: by mail-pf1-f197.google.com with SMTP id g83so4529690pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 21:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uZtEHA5mtt/GkvcqcZRZAWfpETpu7GIqcdU1Ei4ROFA=;
        b=BDReSNhf9LvzhbokhQvisTHV6GGIyRlLT1D/LYofiDYmOxz1E5cUiU+aSOcyCPAfIr
         OSL2rdgfmmjorDKjw0e8T6D9Jy09lCs8uUTagebY15eZnbUnFS3Fku4lKaGAd/hbBxPW
         VP7lk1k/zvFZO0v08ZPIiU4OEyeFnbjCqDDHJJsyQorUeDBEPWz6m6H9xBF6lAve8jrJ
         B3aR3kHi2Tm2OpMxpaYNVV9yMaf6kAJ0hGk7yJrIzS6/bFYESStc59Yl7EheHDMu8r+J
         ajn4zWZP7SJE0zDH0Nlzi+haacVY0ZSxRg7CjifWz2chPWxhLzDBCmgP8jSvv/X8Olsb
         orIg==
X-Gm-Message-State: APjAAAXcmeXttG1heJm32DIRrr3e7Q+Ui5fjfFuv0E7CMSNrBKuTtIeG
        kGnTx0MwHREgXjYWcrqEd/njfAUJo+zzQYhFXA/NzZX4iEDnTmReamtmVejglOG+o2et7AJ0/sO
        F8GH3Q+yiFmZDelNHOYuq3NXfh+CiSUjUv0gJ+7yyeg==
X-Received: by 2002:a63:ed0b:: with SMTP id d11mr1434874pgi.435.1553141308134;
        Wed, 20 Mar 2019 21:08:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw2/Um8OGlSfeb1WXnugxTsbZReObmc0Cs4k4NRuBZQyckJWV0+T4O12dNbdUTcBwBaTGk51A==
X-Received: by 2002:a63:ed0b:: with SMTP id d11mr1434854pgi.435.1553141307761;
        Wed, 20 Mar 2019 21:08:27 -0700 (PDT)
Received: from 2001-b011-380f-14b9-6840-8cc6-de88-20d8.dynamic-ip6.hinet.net (2001-b011-380f-14b9-6840-8cc6-de88-20d8.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:6840:8cc6:de88:20d8])
        by smtp.gmail.com with ESMTPSA id r10sm4178495pfn.188.2019.03.20.21.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 21:08:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com>
Date:   Thu, 21 Mar 2019 12:08:24 +0800
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Torokhov <dtor@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
References: <LaQHUFs--3-1@tutanota.com>
 <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
 <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
 <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 01:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:
>
>>> Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
>>> is also used on Elan devices, I suspect that these Elan devices
>>> likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
>>> and then they probably will no longer need the bogus IRQ flag,
>>> if you know about bugreports with an acpidump for any of the devices
>>> needing the bogus IRQ quirk, then I (or you) can check how the IRQ is
>>> declared there, I suspect it will be declared as level-low, just like
>>> with the laptop this patch was written for. And it probably need to
>>> be edge-falling instead of level-low just like this case.
>>
>> First, I’ve already tried using IRQF_TRIGGER_FALLING, unfortunately it
>> doesn’t solve the issue for me.
>>
>> I talked to Elan once, and they confirm the correct IRQ trigger is level
>> low. So forcing falling trigger may break other platforms.
>
> As far as I understood Vladislav the quirk he got from Elan as well.

Ok, then this is really weird.

>
>> Recently we found that Elan touchpad doesn’t like GpioInt() from its _CRS.
>> Once the Interrupt() is used instead, the issue goes away.
>
> IIRC i2c core tries to get interrupt from Interrupt() resource and
> then falls back to GpioInt().
> See i2c_acpi_get_info() and i2c_device_probe().

Here’s its ASL:

     Scope (\_SB.PCI0.I2C4)
     {
         Device (TPD0)
         {
             Name (_ADR, One)  // _ADR: Address
             Name (_HID, "DELL08AE")  // _HID: Hardware ID
             Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
             Name (_UID, One)  // _UID: Unique ID
             Name (_S0W, 0x04)  // _S0W: S0 Device Wake State
             Name (SBFB, ResourceTemplate ()
             {
                 I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
                     AddressingMode7Bit, "\\_SB.PCI0.I2C4",
                     0x00, ResourceConsumer, , Exclusive,
                     )
             })
             Name (SBFG, ResourceTemplate ()
             {
                 GpioInt (Level, ActiveLow, ExclusiveAndWake, PullUp, 0x0000,
                     "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                     )
                     {   // Pin list
                         0x0012
                     }
             })
             Name (SBFI, ResourceTemplate ()
             {
                 Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, )
                 {
                     0x0000003C,
                 }
             })
             Method (_INI, 0, NotSerialized)  // _INI: Initialize
             {
             }
             Method (_STA, 0, NotSerialized)  // _STA: Status
             {
                 If ((TCPD == One))
                 {
                     Return (0x0F)
                 }

                 Return (Zero)
             }
             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
             {
                 If ((OSYS < 0x07DC))
                 {
                     Return (SBFI) /* \_SB_.PCI0.I2C4.TPD0.SBFI */
                 }

                 Return (ConcatenateResTemplate (SBFB, SBFG))
             }
             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
             {
                 If ((Arg0 == ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
                 {
                     If ((Arg2 == Zero))
                     {
                         If ((Arg1 == One))
                         {
                             Return (Buffer (One)
                             {
                                  0x03                                             // .
                             })
                         }
                         Else
                         {
                             Return (Buffer (One)
                             {
                                  0x00                                             // .
                             })
                         }
                     }
                     ElseIf ((Arg2 == One))
                     {
                         Return (0x20)
                     }
                     Else
                     {
                         Return (Buffer (One)
                         {
                              0x00                                             // .
                         })
                     }
                 }
                 ElseIf ((Arg0 == ToUUID ("ef87eb82-f951-46da-84ec-14871ac6f84b")))
                 {
                     If ((Arg2 == Zero))
                     {
                         If ((Arg1 == One))
                         {
                             Return (Buffer (One)
                             {
                                  0x03                                             // .
                             })
                         }
                     }

                     If ((Arg2 == One))
                     {
                         Return (ConcatenateResTemplate (SBFB, SBFG))
                     }

                     Return (Buffer (One)
                     {
                          0x00                                             // .
                     })
                 }
                 }
                 Else
                 {
                     Return (Buffer (One)
                     {
                          0x00                                             // .
                     })
                 }
             }
         }
     }

Change SBFG to SBFI in its _CRS can workaround the issue.
Is ASL in this form possible to do the flow you described?

Kai-Heng

>
>> But I am not sure how to patch its DSDT/SSDT in i2c-hid.
>
> -- 
> With Best Regards,
> Andy Shevchenko


