Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BB7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5220D2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfEORkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:40:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50546 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEORkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:40:07 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hQxsr-0007KM-GK
        for linux-kernel@vger.kernel.org; Wed, 15 May 2019 17:40:05 +0000
Received: by mail-pg1-f200.google.com with SMTP id o1so352580pgv.15
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 10:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mFpR4rTTfMsJJxbiWGfgKAelVVLvVLyIq7PoT3hLjvs=;
        b=Nl73wAuZ001dVsMXiFuPjvmemk0Gx1M+HdmrXGB9B8rUlqUlRLBfaxEfo9GaVyTVQ7
         SA3FOpTVPniaAm/nrpI+GEoWbFEWBvvaQJhmF7JK2hQdQtefXm1v3OobDo9n+ISAUgxu
         1X/a83ew3d4gytd5tBtEVrZZgrPkbrE9hYUlB64v8LSbCSLdxiezUKmYl3iszgPQdHV7
         Vb6t6PUfdXOPIj29TSusBPNWmBWgELCnhrDYQLXVIEyhx5mbGjwBcQd/aVUd4vR3eqXm
         BRwLffOEKHeJ3/kSoP7bnRhJE5MqQoHr7BovYZLvGjk3ENB6u+KBIzLVqeKxo5sXoxae
         YnXQ==
X-Gm-Message-State: APjAAAXQbz6OVJAVZkzsaSo+JPoWgYlO1MumzcrsWDz8gj9UGW3u2uE3
        G4FDfyrhuHOMSgHozo7+ws8Y+HaztEXf3FocAAFCeL+374i75EO29PfQ+P0Bkz2k2Gavj12Tmzb
        J+9gN6+csgm58fybm50+LAVA18JdHnbtfA5wO42Z82Q==
X-Received: by 2002:a63:1706:: with SMTP id x6mr45185327pgl.280.1557942003811;
        Wed, 15 May 2019 10:40:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxsUVkNTfD0Bk+OztecBhfR6QBmKx2bNzjxcA0XCAQqd4jt2var1pXK1zpOslEiQ0pYLuZwsA==
X-Received: by 2002:a63:1706:: with SMTP id x6mr45185298pgl.280.1557942003437;
        Wed, 15 May 2019 10:40:03 -0700 (PDT)
Received: from 2001-b011-380f-14b9-2dec-a462-2693-8ecd.dynamic-ip6.hinet.net (2001-b011-380f-14b9-2dec-a462-2693-8ecd.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:2dec:a462:2693:8ecd])
        by smtp.gmail.com with ESMTPSA id a13sm6270608pfj.169.2019.05.15.10.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 10:40:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] staging: Add rtl8821ce PCIe WiFi driver
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190515163945.GA5719@kroah.com>
Date:   Thu, 16 May 2019 01:40:00 +0800
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Transfer-Encoding: 8bit
Message-Id: <C6B4FA3D-A590-47F1-9F94-916862DD15CD@canonical.com>
References: <20190515112401.15373-1-kai.heng.feng@canonical.com>
 <20190515114022.GA18824@kroah.com>
 <6D5557B8-8140-48A8-BED7-9587936902D8@canonical.com>
 <20190515123319.GA435@kroah.com>
 <63833AA2-AC8B-4EEA-AF36-EF2A9BFD4F9F@canonical.com>
 <20190515163945.GA5719@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 00:39, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, May 15, 2019 at 09:06:44PM +0800, Kai-Heng Feng wrote:
>> at 20:33, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>>> On Wed, May 15, 2019 at 07:54:58PM +0800, Kai-Heng Feng wrote:
>>>> at 19:40, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>>> On Wed, May 15, 2019 at 07:24:01PM +0800, Kai-Heng Feng wrote:
>>>>>> The rtl8821ce can be found on many HP and Lenovo laptops.
>>>>>> Users have been using out-of-tree module for a while,
>>>>>>
>>>>>> The new Realtek WiFi driver, rtw88, will support rtl8821ce in 2020 or
>>>>>> later.
>>>>>
>>>>> Where is that driver, and why is it going to take so long to get  
>>>>> merged?
>>>>
>>>> rtw88 is in 5.2 now, but it doesn’t support 8821ce yet.
>>>>
>>>> They plan to add the support in 2020.
>>>
>>> Who is "they" and what is needed to support this device and why wait a
>>> full year?
>>
>> “They” refers to Realtek.
>> It’s their plan so I can’t really answer that on behalf of Realtek.
>
> Where did they say that?  Any reason their developers are not on this
> patch?
>
>>>>>> 296 files changed, 206166 insertions(+)
>>>>>
>>>>> Ugh, why do we keep having to add the whole mess for every single one  
>>>>> of
>>>>> these devices?
>>>>
>>>> Because Realtek devices are unfortunately ubiquitous so the support is
>>>> better come from kernel.
>>>
>>> That's not the issue here.  The issue is that we keep adding the same
>>> huge driver files to the kernel tree, over and over, with no real change
>>> at all.  We have seen almost all of these files in other realtek
>>> drivers, right?
>>
>> Yes. They use one single driver to support different SoCs, different
>> architectures and even different OSes.
>
> Well, they try to, it doesn't always work :(
>
>> That’s why it’s a mess.
>
> Oh we all know why this is a mess.  But they have been saying for
> _years_ they would clean up this mess.  So push back, I'm not going to
> take another 200k lines for a simple wifi driver, again.
>
> Along those lines, we should probably just delete the other old realtek
> drivers that don't seem to be going anywhere from staging as well,
> because those are just confusing people.
>
>>> Why not use the ones we already have?
>>
>> It’s virtually impossible because Realtek’s mega wifi driver uses tons of
>> #ifdefs, only one chip can be selected to be supported at compile time.
>
> That's not what I asked.
>
> I want to know why they can't just add support for their new devices to
> one of the many existing realtek drivers we already have.  That is the
> simpler way, and the correct way to do this.  We don't do this by adding
> 200k lines, again.
>
>>> But better yet, why not add proper support for this hardware and not use
>>> a staging driver?
>>
>> Realtek plans to add the support in 2020, if everything goes well.
>
> Device "goes well" please.  And when in 2020?  And why 2020?  Why not
> 2022?  2024?
>
>> Meanwhile, many users of HP and Lenovo laptops are using out-of-tree  
>> driver,
>> some of them are stuck to older kernels because they don’t know how to fix
>> the driver. So I strongly think having this in kernel is beneficial to  
>> many
>> users, even it’s only for a year.
>
> So who is going to be responsible for "fixing the driver" for all new
> kernel api updates?  I'm tired of seeing new developers get lost in the
> maze of yet-another realtek wifi driver.  We've been putting up with
> this crud for years, and it has not gotten any better if you want to add
> another 200k lines for some unknown amount of time with the hope that a
> driver might magically show up one day.

I have no idea why they haven’t made everything upstream, and I do hope  
they did a better job, so I don’t need to cleanup their driver and send it  
upstream :(

So basically I can’t answer any of your questions. As Larry suggested,  
their driver should be hosted separately and maybe by downstream distro.

Kai-Heng

>
> thanks,
>
> greg k-h


