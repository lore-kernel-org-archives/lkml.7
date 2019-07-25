Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E80C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C5122BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbfGYPuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:50:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42954 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389567AbfGYPu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:50:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id v15so50689968eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 08:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NPzRI+wHt7J9VSEK+V9e/axuse6c4lCMrXpMW5Fy2u4=;
        b=eIdcFfNPjZL8M4O3yc15+0rdop9Jm0TWojPnzcKdiRNl+ZCI7ViUYSVy93v7g8OHSU
         qgMImb8IQZmQf3QaLeoGfzxuFz2yjzZDMLQW2gqtSg867/wE92W8iGnETBV3m3ckGFHR
         iI734q9h3eF5do3GG6stzjeSR16l4suVw7N+nKgAuv/cXz97A6vuLxr3afLgk9bPrcZY
         e0vwCvMD8MX5lddwhEbW4rQH+FA+YK9d8ZG5QtYsZIaaRG+5TyVh09ap2tutPUhleIFj
         XPuvce54TXJ8B/Q/hPbyufV+jFa8Ai7ItMWfU6wiKU6U5nHHb2x4xkGLs0UnzYzAYKWq
         rjAQ==
X-Gm-Message-State: APjAAAX8xVrB2F7hViHl/zsqDR7lBKBcnEJG3fgo6ptPtMxTN0nMVqH3
        AbU2bOzpluxiL5429qNzfoiuQw==
X-Google-Smtp-Source: APXvYqyJU8oVrk49qxZH287prK1CTBmO3Yowj/vCqJS3SxCAHQCfdEXMkcGgABpZqhmIOx0MikzSeQ==
X-Received: by 2002:a17:906:edd7:: with SMTP id sb23mr68347517ejb.309.1564069827634;
        Thu, 25 Jul 2019 08:50:27 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id gz5sm9840869ejb.21.2019.07.25.08.50.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:50:27 -0700 (PDT)
Subject: Re: [Regression] 5.3-rc1: hid_llogitech_dj does not work
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
References: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com>
 <2480108.bWkXKoXas6@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1dddedba-ca02-1014-36e0-ba4e3631f28b@redhat.com>
Date:   Thu, 25 Jul 2019 17:50:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2480108.bWkXKoXas6@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 25-07-19 12:07, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> This is similar to a problem I reported some time ago:
> 
> https://lore.kernel.org/lkml/2268131.Lc39eCoc3j@kreacher/
> 
> and the device affected by it is the same.
> 
> The symptom is simply that the mouse just doesn't work (no reaction).  If I do
> "rmmod hid_llogitech_dj", it says "Killed", but the module does go away and
> the mouse starts to work (through the generic code I suppose), but then
> the machine hangs on attempts to suspend (nasty).
> 
> Reverting all of the hid_llogitech_dj changes between 5.2 and 5.3-rc1:
> 
> dbcbabf7da92 HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices
> 39d21e7e0043 HID: logitech-dj: make const array template static
> 423dfbc362b7 HID: logitech-dj: Add usb-id for the 27MHz MX3000 receiver
> 
> helps here, but the first two don't really look like they can make any difference,
> so I guess I'm an unlucky owner of a MX3000 that doesn't quite work as expected.
> 
> Any help will be appreciated. :-)

Actually we received another bug report about this and the reporter there
has come up with a patch with points to

dbcbabf7da92 HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices

Being the culprit, can you try just reverting that one?

I will take a closer look at this soonish.

Thank & Regards,

Hans
