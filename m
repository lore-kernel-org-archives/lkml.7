Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14ADC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E868205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbfHVKEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:04:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbfHVKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:04:51 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i0jxZ-0001B6-Bp
        for linux-kernel@vger.kernel.org; Thu, 22 Aug 2019 10:04:49 +0000
Received: by mail-pf1-f200.google.com with SMTP id s10so3690333pfd.16
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 03:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7QLOAuwHN+I+TKEp/LNwzuCO+9AkVGl1b9nx/0p5kuk=;
        b=uQZPf5IeZAYG9KqaJKd3iZxGOaXxyESb1J6srobixVXAVBDmBYM6jEGTeeqL7Z2IG1
         KCgt4cNWMkHjR2fYexI9WSXCPuXQDtYuUGgbZPg0FJbgf7E0+WLugTLQpW6N4MVh6j3L
         gIJcLwzCu1oQiPrSpZyi6uO972hkTPYXFjzsVp4OXYbs/Jerf84HBqptVV0epLI5BDLt
         x+WXBxYwBxckxiHrmtRfSyNjQ8hAWX6R72nsVIvt4fW0hZWtWDsAGFBmPJZsJzhOAWnu
         dMm4MAGfcEXryZcEkhGyx+nqx86tnz2wj9p50JB5CqxqrbxryMS72sYH9iGbDlnV7zws
         184g==
X-Gm-Message-State: APjAAAVuZ/gmD3e9j9maFwZfttQ1RiBEHf+FOvfdGNI3ZsNZfwjoflDr
        +STDeoYbPfZ9c/K23TKinOEoycm554DnSgJzvIlO0RDh65ej32QmbMEYQfBIAr++bwCG5MBC0A/
        Pr78sLqAjhVEHpbzRUVwk1cSlsE1V+JKy3AVXNbprWw==
X-Received: by 2002:a17:902:566:: with SMTP id 93mr39019849plf.172.1566468288137;
        Thu, 22 Aug 2019 03:04:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyM/H3K/jYHZPzEv+deHfXGwA84mv2QFm/ujKOZ7p/92rcvrpXWL0dcsbBUsZCdX48Zuga8jw==
X-Received: by 2002:a17:902:566:: with SMTP id 93mr39019822plf.172.1566468287815;
        Thu, 22 Aug 2019 03:04:47 -0700 (PDT)
Received: from 2001-b011-380f-3c42-a909-253e-f960-c1e8.dynamic-ip6.hinet.net (2001-b011-380f-3c42-a909-253e-f960-c1e8.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:a909:253e:f960:c1e8])
        by smtp.gmail.com with ESMTPSA id p8sm35446301pfq.129.2019.08.22.03.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 03:04:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] HID: quirks: Disable runtime suspend on Microsoft Corp.
 Basic Optical Mouse v2.0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1566467151.8347.23.camel@suse.com>
Date:   Thu, 22 Aug 2019 18:04:44 +0800
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <AD8A4135-0275-45B3-BEB9-031737A2C756@canonical.com>
References: <20190822091744.3451-1-kai.heng.feng@canonical.com>
 <1566467151.8347.23.camel@suse.com>
To:     Oliver Neukum <oneukum@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

at 17:45, Oliver Neukum <oneukum@suse.com> wrote:

> Am Donnerstag, den 22.08.2019, 17:17 +0800 schrieb Kai-Heng Feng:
>> The optical sensor of the mouse gets turned off when it's runtime
>> suspended, so moving the mouse can't wake the mouse up, despite that
>> USB remote wakeup is successfully set.
>>
>> Introduce a new quirk to prevent the mouse from getting runtime
>> suspended.
>
> Hi,
>
> I am afraid this is a bad approach in principle. The device
> behaves according to spec.

Can you please point out which spec it is? Is it USB 2.0 spec?

> And it behaves like most hardware.

So seems like most hardware are broken.
Maybe a more appropriate solution is to disable RPM for all USB mice.

> If you do not want runtime PM for such devices, do not switch
> it on.

A device should work regardless of runtime PM status.

> The refcounting needs to be done correctly.

Will do.

>
> This patch does something that udev should do and in a
> questionable manner.

IMO if the device doesn’t support runtime suspend, then it needs to be  
disabled in kernel but not workaround in userspace.

Kai-Heng

>
> 	Regards
> 		Oliver


