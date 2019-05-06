Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E32EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0652053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfEFOvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:51:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41405 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfEFOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:51:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so15618761edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 07:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WILAIYS5L39NX5qaghFqLvb4HjkqylYpmgnllvPlJjg=;
        b=NiIACnkwzxcX7l3PwUU/TshLH+JxnaVGNxqSInvTeh06UTcLR+90kCrDZv2TO8VhnU
         dJuqS4kK2gPS70YIgAlTpviLJJ3p2jo2a9dWpzf2VFO+RMatmVwaf6fJOIdwvsCp/uJh
         5SABF7qmumarpGjKplOChMovdkNGF+KhcAfh/EtGnbxLXreTTZPZI/PDXJSElY7Ip/j1
         jSCeJplCT2HNUy9jYamwVmMb1xbZQff1fiib3+DFbNvjMHR24gSX2Qd1rOgzhEZfc604
         KLJnQrpJBGmjYJvtB/QWUk+eoU+T4TiF7J2F2RV1DstDIZVfHM3uY6H3ioELXqnaa31+
         P88w==
X-Gm-Message-State: APjAAAXW1T4iOvG0NZV8/scMvgEagXN83nQnNFFqyRZdPTNHKR7Iq2Y7
        SC7dsfTQjwv1ZlHBA1bD0jNQJameI0E=
X-Google-Smtp-Source: APXvYqxtOyAlYjQxfUDU7l6TzpK8MooojS7/5sM8tPSiP4KeZYsMNp2wlWeIWPLe9qOpa7t38MBgpw==
X-Received: by 2002:a50:89b0:: with SMTP id g45mr26933010edg.200.1557154261729;
        Mon, 06 May 2019 07:51:01 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b23sm3155976ede.75.2019.05.06.07.51.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 07:51:00 -0700 (PDT)
Subject: Re: [PATCH 0/1] Add several Beckhoff Automation boards to
 critclk_systems DMI table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel-dev@beckhoff.com, Stephen Boyd <sboyd@kernel.org>
Cc:     Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190502130351.5341-1-linux-kernel-dev@beckhoff.com>
 <CAHp75Vc4xWbnGoaS8tRDV4_F-Qifh7K1hoFn0V-OObun2Sd0DA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <21677236-b7fc-c51b-958a-269b5e65af54@redhat.com>
Date:   Mon, 6 May 2019 16:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc4xWbnGoaS8tRDV4_F-Qifh7K1hoFn0V-OObun2Sd0DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-05-19 14:40, Andy Shevchenko wrote:
> On Thu, May 2, 2019 at 4:04 PM <linux-kernel-dev@beckhoff.com> wrote:
>>
>> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>
>> There are several Beckhoff Automation industrial PC boards which use
>> pmc_plt_clk* clocks for ethernet controllers. The patch adds affected boards
>> to critclk_systems DMI table so the clocks are marked as CLK_CRITICAL and
>> not turned off.
>> This should be applied on top of another patch as both change
>> the same table:
>> [PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to critclk_systems DMI table
> 
> Yes, that's why it either should go via CLK tree, or I need an
> immutable tag or branch from them.
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

As I just mentioned in your reply to the "[PATCH] platform/x86: pmc_atom:
Add Lex 3I380D industrial PC to critclk_systems DMI table":

"Stephen added the patches this depends on to his fixes branch, so they
are in the 5.1 / Torvald's master branch, since we are now in the 5.2 merge
window, you should be able to cleanly apply this directly."

So both that patch and this patch should be able to go through the d-p-x86 tree
unless I'm missing something?

Regards,

Hans

> 
>>
>> Steffen Dirkwinkel (1):
>>    platform/x86: pmc_atom: Add several Beckhoff Automation boards to
>>      critclk_systems DMI table
>>
>>   drivers/platform/x86/pmc_atom.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> --
>> 2.21.0
> 
> 
> 
