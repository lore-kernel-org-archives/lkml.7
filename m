Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A457FC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9512053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfEFPF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:05:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36982 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEFPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:05:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id w37so15661216edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EG9y7f+OaOLQCxmo5YAdYV2d8wQYYdrdIyT2YfdhqrA=;
        b=F+4/Jl6/lvGeT+SS7vPjh+1b/nWrFBsxvd5B0DDbfxbrSS/DXDDTUUdplsPBDkiU9b
         eHfG880v3EXk5/Puc8CtNV/4iCqMvwle6VBUsAsEed+STfBUZBk+KFcnonnwNgU/J1k4
         UQ/NUbdxENW3ZMoOQ6AMDUfK3bzFY2WhDwiaE02NZfgWUbosa6HvaUgDzB/AkSCODn0/
         xMIQXIKa9HvlFwSNs2wh8Zm+OSvKzPbNyWdIDqQO80GKSowsoevKXiXQ9BL+4OKipJOj
         Yp4FRY5CewaBdha6ZLVG0TsyOkCmss6twrF9fuK4y3lAprCz5RdXzJY6/7DdcMCBOcMJ
         w/kw==
X-Gm-Message-State: APjAAAUG1IaxOoO47HdCHj0aXKLeru1tQR0gwMV9x1X09Wnu988gRfam
        PaEDpRDOeHpubL5Nx3ojLPmHUQ==
X-Google-Smtp-Source: APXvYqwG7U8NKXeMCYsnsKEeNFfADW0dBrFnKXzISgYtUcSEK+XfEplGea/2X6qLq5ujIDfyCx/gVw==
X-Received: by 2002:a50:9007:: with SMTP id b7mr25564744eda.194.1557155144500;
        Mon, 06 May 2019 08:05:44 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b42sm2996983edd.83.2019.05.06.08.05.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:05:43 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to
 critclk_systems DMI table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Semyon Verchenko <semverchenko@factor-ts.ru>
References: <20190429150135.15070-1-hdegoede@redhat.com>
 <CAHp75VeE=88mCcgVx3Y3PQJPQ819Z7=3s=jRGz1y=t09phk=rA@mail.gmail.com>
 <085c5b6e-d220-ebd1-38d2-def7efca24b8@redhat.com>
 <CAHp75Vfe9uK_b_V+uG29wb1L6J7u1hpbU+P4beXso9KNPM+8Rg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <568ba27d-a6a5-b158-bab1-f22cd8ccb34e@redhat.com>
Date:   Mon, 6 May 2019 17:05:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfe9uK_b_V+uG29wb1L6J7u1hpbU+P4beXso9KNPM+8Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-05-19 16:59, Andy Shevchenko wrote:
> On Mon, May 6, 2019 at 5:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 06-05-19 14:38, Andy Shevchenko wrote:
>>> On Mon, Apr 29, 2019 at 6:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> The Lex 3I380D industrial PC has 4 ethernet controllers on board
>>>> which need pmc_plt_clk0 - 3 to function, add it to the critclk_systems
>>>> DMI table, so that drivers/clk/x86/clk-pmc-atom.c will mark the clocks
>>>> as CLK_CRITICAL and they will not get turned off.
>>>>
>>>
>>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> supposedly to go via CLK tree.
>>>
>>> P.S. If you want it through PDx86, I need immutable branch / tag from CLK.
>>
>> Stephen added the patches this depends on to his fixes branch, so they
>> are in the 5.1 / Torvald's master branch, since we are now in the 5.2 merge
>> window, you should be able to cleanly apply this directly.
> 
> We don't do back merges, so, our base is v5.1-rc1. Does it mean the
> commit in question is in v5.1-rc1?
> AFAICS it was appeared in v5.1-rc5.

Ah, I see, my bad.

Stephen can you pick up this patch and the
"[PATCH 1/1] Add several Beckhoff Automation boards to critclk_systems DMI table"
patch then?

Regards,

Hans

