Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F96C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B60233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfHVNXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:23:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35959 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfHVNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:23:09 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i0n3T-0007PH-Sz
        for linux-kernel@vger.kernel.org; Thu, 22 Aug 2019 13:23:08 +0000
Received: by mail-pl1-f198.google.com with SMTP id y5so3615067plt.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ARl7y420+012H6FiVBnjFHFRBlY5yJV7LGxsW8IuvSI=;
        b=Or+L4vwV676O00zi6ASZy1gbuWTeZXkoixQTzmcjBMxHA+zIN6vnIOeq7A11XjHGam
         cM+w7OBi0Co8Gb1Tx27JmKKgFSKyAOlD+SribiMubiIWbs+eXdG/Oxtf6tyC4wucWS5r
         8ldvp8Xn+h2zUjWaYtKxbdgyTOl9hI7LbxtUPHtVfjJ3nrVw/EU1PWR4qqxUN18prCaU
         NtFRdk5qG+H9Ybb9YPyiqbUJIdKhwrwoy7Z5J8/xeqkiSjLZSQE3OWcikIlcK9/azhRD
         uiE9yCS9fRFBzrLfjXoq9TkLPaVRF3oU/B5RsKIop9A9+KanMdzBKgskqQzFCxgiIEjC
         QVMA==
X-Gm-Message-State: APjAAAVecT7knHdrog1hocGXh4uzIMpZWyra8gDs64ltjjwzedSAsfHj
        F7Q/U8vxYhc46Fj3WHe0QHVYF7tKragovm+e+yws05Tnj26nYNHLdq6/rCob7tBiG34DsxazJnR
        ndd2K2IQxuckN1gmNkL7vCPyO67qcCVuq2EGwfQyEuw==
X-Received: by 2002:a17:902:4581:: with SMTP id n1mr9351166pld.310.1566480186626;
        Thu, 22 Aug 2019 06:23:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzv7ty2hhyaXcteC+Xl7ZYtHxlCbdcTFINbhX9shCZ97tvwtUYh1pq7vKZaVZxPd3Z1kjiIlw==
X-Received: by 2002:a17:902:4581:: with SMTP id n1mr9351140pld.310.1566480186342;
        Thu, 22 Aug 2019 06:23:06 -0700 (PDT)
Received: from 2001-b011-380f-3c42-a909-253e-f960-c1e8.dynamic-ip6.hinet.net (2001-b011-380f-3c42-a909-253e-f960-c1e8.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:a909:253e:f960:c1e8])
        by smtp.gmail.com with ESMTPSA id c70sm36693904pfb.163.2019.08.22.06.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 06:23:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] HID: quirks: Disable runtime suspend on Microsoft Corp.
 Basic Optical Mouse v2.0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1566470325.8347.35.camel@suse.com>
Date:   Thu, 22 Aug 2019 21:23:03 +0800
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <D6E31CB0-BC2B-4B52-AF18-4BE990D3FDA5@canonical.com>
References: <20190822091744.3451-1-kai.heng.feng@canonical.com>
 <1566467151.8347.23.camel@suse.com>
 <AD8A4135-0275-45B3-BEB9-031737A2C756@canonical.com>
 <1566470325.8347.35.camel@suse.com>
To:     Oliver Neukum <oneukum@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 18:38, Oliver Neukum <oneukum@suse.com> wrote:

> Am Donnerstag, den 22.08.2019, 18:04 +0800 schrieb Kai-Heng Feng:
>> Hi Oliver,
>>
>> at 17:45, Oliver Neukum <oneukum@suse.com> wrote:
>>
>>> Am Donnerstag, den 22.08.2019, 17:17 +0800 schrieb Kai-Heng Feng:
>>>> The optical sensor of the mouse gets turned off when it's runtime
>>>> suspended, so moving the mouse can't wake the mouse up, despite that
>>>> USB remote wakeup is successfully set.
>>>>
>>>> Introduce a new quirk to prevent the mouse from getting runtime
>>>> suspended.
>>>
>>> Hi,
>>>
>>> I am afraid this is a bad approach in principle. The device
>>> behaves according to spec.
>>
>> Can you please point out which spec it is? Is it USB 2.0 spec?
>
> Well, sort of. The USB spec merely states how to enter and exit
> a suspended state and that device state must not be lost.
> It does not tell you what a suspended device must be able to do.

But shouldn’t remote wakeup signaling wakes the device up and let it exit  
suspend state?
Or it’s okay to let the device be suspended when remote wakeup is needed  
but broken?

>
>>> And it behaves like most hardware.
>>
>> So seems like most hardware are broken.
>> Maybe a more appropriate solution is to disable RPM for all USB mice.
>
> That is a decision a distro certainly can make. However, the kernel
> does not, by default, call usb_enable_autosuspend() for HID devices
> for this very reason. It is enabled by default only for hubs,
> BT dongles and UVC cameras (and some minor devices)
>
> In other words, if on your system it is on, you need to look
> at udev, not the kernel.

So if a device is broken when “power/control” is flipped by user, we should  
deal it at userspace? That doesn’t sound right to me.

>
>>> If you do not want runtime PM for such devices, do not switch
>>> it on.
>>
>> A device should work regardless of runtime PM status.
>
> Well, no. Runtime PM is a trade off. You lose something if you use
> it. If it worked just as well as full power, you would never use
> full power, would you?

I am not asking the suspended state to work as full power, but to prevent a  
device enters suspend state because of broken remote wakeup.

>
> Whether the loss of functionality or performance is worth the energy
> savings is a policy decision. Hence it belongs into udev.
> Ideally the kernel would tell user space what will work in a
> suspended state. Unfortunately HID does not provide support for that.

I really don’t think “loss of functionally” belongs to policy decision. But  
that’s just my opinion.

>
> This is a deficiency of user space. The kernel has an ioctl()
> to let user space tell it, whether a device is fully needed.
> X does not use them.

Ok, I’ll take a look at other device drivers that use it.

>
>>> The refcounting needs to be done correctly.
>>
>> Will do.
>
> Well, I am afraid your patch breaks it and if you do not break
> it, the patch is reduced to nothing.

Maybe just calling usb_autopm_put_interface() in usbhid_close() to balance  
the refcount?

>
>>> This patch does something that udev should do and in a
>>> questionable manner.
>>
>> IMO if the device doesn’t support runtime suspend, then it needs to be
>> disabled in kernel but not workaround in userspace.
>
> You switch it on from user space. Of course the kernel default
> must be safe, as you said. It already is.

I’d also like to hear maintainers' opinion on this issue.

Kai-Heng

>
> 	Regards
> 		Oliver


