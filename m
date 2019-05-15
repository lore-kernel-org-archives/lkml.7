Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F49C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E8E2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEOLzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:55:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42115 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbfEOLzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:55:06 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hQsUy-00022A-KT
        for linux-kernel@vger.kernel.org; Wed, 15 May 2019 11:55:04 +0000
Received: by mail-pl1-f200.google.com with SMTP id a90so1589519plc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 04:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2s5ZrDz9Fge3DDsd7znyW59tgDsyXymNM0mQ5XeWf1I=;
        b=Gi87Qx92ohm4LhR6h4NHC6iiNPBLGUHPGUho1V8N7CJBePjRNcb6foz0p2smmDkb42
         tvISmUann0KyLUTF1YJ+PEqHWiP4zCiO7aquTd/sqVKWnkToP+vLc/CgPVctcESyYML/
         vhksGL8Kor1fy41jciwQrE4jXdI8kVyp5G0bz/EHxufk/JT9OF9YBUhy3JZliIGYx14B
         RECBzDKnPp8Ojg+nJoAGOBFvL6HEY7KJ//nyr3RUabUtMXbmi04RvTi8CpqAwq7zSoXa
         TlgdPhi/lKSgmfclPn9/WXKceRghlF71nBldoJ0MVke07hYLtlABvRNRGQNQaKc60DVP
         BG+g==
X-Gm-Message-State: APjAAAUUSd5j5kTBllCO1VzEjL4kLmRnSV4GIStVjB7gR2d/IqT1pEWd
        t05okIIXTbsS8FugasJq4Y6LsB374mhBWwVm1ikdD5+S5+ABQGPIfzeSpYICVLd3xgiKEan7yxv
        HD8/rS7J7zG0SnVlR3cw/8JQ0TgGRgodXk2PviOxEHQ==
X-Received: by 2002:a65:5a47:: with SMTP id z7mr28393356pgs.214.1557921302868;
        Wed, 15 May 2019 04:55:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTEKiAvgcqQfU7pw3kQOWbuKuSjQAvwSUOT4BOjaZHzgdEaAxeZ7WuseQslsHjwHoTFCwYeg==
X-Received: by 2002:a65:5a47:: with SMTP id z7mr28393319pgs.214.1557921302366;
        Wed, 15 May 2019 04:55:02 -0700 (PDT)
Received: from 2001-b011-380f-14b9-2dec-a462-2693-8ecd.dynamic-ip6.hinet.net (2001-b011-380f-14b9-2dec-a462-2693-8ecd.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:2dec:a462:2693:8ecd])
        by smtp.gmail.com with ESMTPSA id q193sm3818827pfc.52.2019.05.15.04.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 04:55:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] staging: Add rtl8821ce PCIe WiFi driver
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190515114022.GA18824@kroah.com>
Date:   Wed, 15 May 2019 19:54:58 +0800
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Transfer-Encoding: 8bit
Message-Id: <6D5557B8-8140-48A8-BED7-9587936902D8@canonical.com>
References: <20190515112401.15373-1-kai.heng.feng@canonical.com>
 <20190515114022.GA18824@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 19:40, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, May 15, 2019 at 07:24:01PM +0800, Kai-Heng Feng wrote:
>> The rtl8821ce can be found on many HP and Lenovo laptops.
>> Users have been using out-of-tree module for a while,
>>
>> The new Realtek WiFi driver, rtw88, will support rtl8821ce in 2020 or
>> later.
>
> Where is that driver, and why is it going to take so long to get merged?

rtw88 is in 5.2 now, but it doesn’t support 8821ce yet.

They plan to add the support in 2020.

>
>> 296 files changed, 206166 insertions(+)
>
> Ugh, why do we keep having to add the whole mess for every single one of
> these devices?

Because Realtek devices are unfortunately ubiquitous so the support is  
better come from kernel.

>
> Why can't we just have a real driver now?

It doesn’t support rtl8821ce yet.

Kai-Heng

>
> thanks,
>
> greg k-h


