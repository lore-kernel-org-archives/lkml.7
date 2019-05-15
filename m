Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E825FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBE320843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfEONGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:06:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43626 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEONGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:06:51 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hQtcO-0006f5-T2
        for linux-kernel@vger.kernel.org; Wed, 15 May 2019 13:06:49 +0000
Received: by mail-pg1-f200.google.com with SMTP id g38so1820859pgl.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b+v1+ZH7bfJgPvcJJLIMxLKe7U6ykNODw87a1WEv3H0=;
        b=L5OT6JBhEE7gzxoqymW6k/B63g8teXmVAPuPFuvQcuR34PUh5ONUaS1qFSivOrtcGg
         Mu1dO5+8Xj3A5VFKaP+BvqU1Si45hbr3Ir5vEk1oKD80tD47a7dPTlmAWes9Km/L0Kah
         Y/d5MKf7frZ+bykSJivT+vcwJLmb5eOly0HrPtVc+iNYm9bzO024mOa9OmjzfA93eN5X
         pxh+ryIY4Xs9VKtsYzkNTX2gvYdYeTe82OCOT49csTIBeJfmdKZz00qn9H2peKm4PLj+
         KsxtgsebuBFUY5vvmCIPPC5FajjlXX66pY0fi3b4Ryhf66U3k9vGLdP7neb/XWGarY+y
         8lRg==
X-Gm-Message-State: APjAAAWRviM1af+XJzO+j4rlEblW4t44w6xjQcUmNOPTJGCJfnBwzEgh
        37VNzQpqULGwyFaHN9ehLf6Tj68p8k2qqxZbOrq+2XYeLgw1HY32BJDzE0vHNUJbwPcmpXcnkNm
        +RbeLS2weAMz0QdpxNgUwoog5mdXHTrqAs7te5u/HOg==
X-Received: by 2002:a63:a08:: with SMTP id 8mr43468710pgk.46.1557925607630;
        Wed, 15 May 2019 06:06:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJFexLP2zSmm/iUBvGJGsaJCiEp7WyO3ZYTOn/y7t+cMmaPFBnMblW+CcRKRX93p5aPbAfOw==
X-Received: by 2002:a63:a08:: with SMTP id 8mr43468675pgk.46.1557925607234;
        Wed, 15 May 2019 06:06:47 -0700 (PDT)
Received: from 2001-b011-380f-14b9-2dec-a462-2693-8ecd.dynamic-ip6.hinet.net (2001-b011-380f-14b9-2dec-a462-2693-8ecd.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:2dec:a462:2693:8ecd])
        by smtp.gmail.com with ESMTPSA id v40sm2515992pgn.17.2019.05.15.06.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 06:06:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] staging: Add rtl8821ce PCIe WiFi driver
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190515123319.GA435@kroah.com>
Date:   Wed, 15 May 2019 21:06:44 +0800
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Transfer-Encoding: 8bit
Message-Id: <63833AA2-AC8B-4EEA-AF36-EF2A9BFD4F9F@canonical.com>
References: <20190515112401.15373-1-kai.heng.feng@canonical.com>
 <20190515114022.GA18824@kroah.com>
 <6D5557B8-8140-48A8-BED7-9587936902D8@canonical.com>
 <20190515123319.GA435@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 20:33, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, May 15, 2019 at 07:54:58PM +0800, Kai-Heng Feng wrote:
>> at 19:40, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>>> On Wed, May 15, 2019 at 07:24:01PM +0800, Kai-Heng Feng wrote:
>>>> The rtl8821ce can be found on many HP and Lenovo laptops.
>>>> Users have been using out-of-tree module for a while,
>>>>
>>>> The new Realtek WiFi driver, rtw88, will support rtl8821ce in 2020 or
>>>> later.
>>>
>>> Where is that driver, and why is it going to take so long to get merged?
>>
>> rtw88 is in 5.2 now, but it doesn’t support 8821ce yet.
>>
>> They plan to add the support in 2020.
>
> Who is "they" and what is needed to support this device and why wait a
> full year?

“They” refers to Realtek.
It’s their plan so I can’t really answer that on behalf of Realtek.

>
>>>> 296 files changed, 206166 insertions(+)
>>>
>>> Ugh, why do we keep having to add the whole mess for every single one of
>>> these devices?
>>
>> Because Realtek devices are unfortunately ubiquitous so the support is
>> better come from kernel.
>
> That's not the issue here.  The issue is that we keep adding the same
> huge driver files to the kernel tree, over and over, with no real change
> at all.  We have seen almost all of these files in other realtek
> drivers, right?

Yes. They use one single driver to support different SoCs, different  
architectures and even different OSes.
That’s why it’s a mess.

> Why not use the ones we already have?

It’s virtually impossible because Realtek’s mega wifi driver uses tons of  
#ifdefs, only one chip can be selected to be supported at compile time.

>
> But better yet, why not add proper support for this hardware and not use
> a staging driver?

Realtek plans to add the support in 2020, if everything goes well.
Meanwhile, many users of HP and Lenovo laptops are using out-of-tree  
driver, some of them are stuck to older kernels because they don’t know how  
to fix the driver. So I strongly think having this in kernel is beneficial  
to many users, even it’s only for a year.

Kai-Heng

>
> thanks,
>
> greg k-h


