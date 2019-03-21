Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37457C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107D421873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfCUJ1K convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:27:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39696 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfCUJ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:27:10 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h6tye-0000kD-3G
        for linux-kernel@vger.kernel.org; Thu, 21 Mar 2019 09:27:08 +0000
Received: by mail-pf1-f197.google.com with SMTP id t5so5008494pfh.18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 02:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GFrkayYV4Pj2QaUhCp4yWa4vYn0FPj7bjcTgDXbrDhU=;
        b=m2EGRwH23HhRRxwZqMXGiqj6IbAKlW3S2O02DOHJc0R29SHiCe/x3dEE01kWO4R8fd
         i34mUErITadXDdWxMeF1HoRHe1WK8H/dazi3HA6LN/ZMvLCFE1oSAHMDZmFqwyuVeZwA
         uoAzO4J8GdPmCDOkk5wQdDNQfAjAJ/3oCEB5u7th/56r4Wens+yLCzuvrzYPXLrlDc1H
         tvFJy0xR7s3uImFEk+saeb0VwC/Urpo0HxiuBpxrFemHB0NrhHkJ+7XqsoBnr6rZLRJf
         WhchYBSAAKsiBoeGpmg3osO9X+MVKcIDlyQ5oMV4WKh8JT+auP3jxzFjPxjAAEVPS0/4
         Yylw==
X-Gm-Message-State: APjAAAW01R1U/9sHf61RbnA5bfFX7Nca1SMJ6CwCNMlD4hawln3vVS+w
        fUFKwmIa3Vogd38zn1UkePtcHFXgzHA8F7YZ0pAAGs/DxoMEriEb9ZEykBpe16RCIBnG6gdvlkK
        kWjRviodcs+GZgllMMeOQY8Kvtr/LIUN3bUSvtIovEA==
X-Received: by 2002:a65:63c8:: with SMTP id n8mr2405511pgv.158.1553160426697;
        Thu, 21 Mar 2019 02:27:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx9m7Fep5MZs56Ukn27tU3Ha0FZ1nxz2GpEm+plhF7ENPxaaiOXabMFdgVS2eQG3mmAxwjgqQ==
X-Received: by 2002:a65:63c8:: with SMTP id n8mr2405485pgv.158.1553160426420;
        Thu, 21 Mar 2019 02:27:06 -0700 (PDT)
Received: from [192.168.1.220] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id q18sm6461767pgv.9.2019.03.21.02.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 02:27:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAHp75VeavkzZDYK4CWAC62GciynQ3KYgmPpPRwsd3RcLFw4jxA@mail.gmail.com>
Date:   Thu, 21 Mar 2019 17:28:15 +0800
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Torokhov <dtor@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <DDBA2E60-2658-413B-969A-59DD1AFB0536@canonical.com>
References: <LaQHUFs--3-1@tutanota.com>
 <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
 <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
 <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com>
 <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
 <CAHp75VeavkzZDYK4CWAC62GciynQ3KYgmPpPRwsd3RcLFw4jxA@mail.gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 21, 2019, at 4:55 PM, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> On Thu, Mar 21, 2019 at 6:08 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> at 01:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:
> 
>>>> Recently we found that Elan touchpad doesn’t like GpioInt() from its _CRS.
>>>> Once the Interrupt() is used instead, the issue goes away.
>>> 
>>> IIRC i2c core tries to get interrupt from Interrupt() resource and
>>> then falls back to GpioInt().
>>> See i2c_acpi_get_info() and i2c_device_probe().
>> 
>> Here’s its ASL:
> 
>>             Name (SBFB, ResourceTemplate ()
>>             {
>>                 I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
>>                     AddressingMode7Bit, "\\_SB.PCI0.I2C4",
>>                     0x00, ResourceConsumer, , Exclusive,
>>                     )
>>             })
>>             Name (SBFG, ResourceTemplate ()
>>             {
>>                 GpioInt (Level, ActiveLow, ExclusiveAndWake, PullUp, 0x0000,
>>                     "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>>                     )
>>                     {   // Pin list
>>                         0x0012
>>                     }
>>             })
>>             Name (SBFI, ResourceTemplate ()
>>             {
>>                 Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, )
>>                 {
>>                     0x0000003C,
>>                 }
>>             })
> 
>>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>             {
> 
>>                 If ((OSYS < 0x07DC))
>>                 {
>>                     Return (SBFI) /* \_SB_.PCI0.I2C4.TPD0.SBFI */
>>                 }
> 
> This will return only Interrupt() resource
> 
>> 
>>                 Return (ConcatenateResTemplate (SBFB, SBFG))
> 
> This one I2cSerialBus() and GpioInt().
> 
>>             }
> 
> 
>>         }
>>     }
>> 
>> Change SBFG to SBFI in its _CRS can workaround the issue.
>> Is ASL in this form possible to do the flow you described?
> 
> Since it's enumerated in Linux as I2C device, it means it gets I2C and
> GPIO resources.
> So, no, it's not possible.
> 
> What are you describing might tell us about one of the following:
> - touchpad should be switched to PS/2 mode in order to get working
> - GPIO resource is not correct / bug in GPIO driver
> 
> I don't believe the first one is a case here.
> If GPIO resource is not correct and main OS has some quirks, we need
> to do similar in Linux.

How do I check quirks on Windows?

> Otherwise, debugging GPIO driver, starting from what exactly (pin
> number, pin settings, etc) gets i2c-hid module.

Ok, please let me know where should I start looking into.

> 
> Note, ACPICA and related stuff is done in order to be Windows compatible.
> If you have settings in BIOS that defines OS to boot, it should be
> chosen Windows.

Yes, it’s Windows.

Kai-Heng

> 
> -- 
> With Best Regards,
> Andy Shevchenko

