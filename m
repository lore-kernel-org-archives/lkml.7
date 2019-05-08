Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE374C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A4C20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEHJU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:20:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32885 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfEHJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:20:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so21440258edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 02:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q1/Ami51IditDxTB6HqWlJbnPuZ7kZ+MUhIVVJBzKrY=;
        b=MRxTpIRIp8BUC5zcS1rXH3qTe1y1uiAPHm4SPdCd4xc0q62wR+3WWhCvEcfQJAbkbI
         byyioo17rQeSzSnwcTOcb4EPLTWEhjA0qd3B5SF0A992fwKpXzWgTrBqpBh2aC+/2lyr
         buyW9NCqHzGKSGClu41AmByVwOLKL1uVejXnakB0Cd33X4ALhpm/G+7sLYH5UeCpDc8v
         cf4/9BCs6ltPcZ/e2IC7pYQ8Wqba3e9/5BACuAJL5YsGZ/bDkE23sv9JonZK/D3obvxR
         z9kstiRmw3+UA3qSN7elwQp7LQ4ppSYfJ7P3DoH5qm+RRZCoTLwER7XTaJrg25X4D00M
         64bg==
X-Gm-Message-State: APjAAAVwdbrVOqkMljaatoNlHoty6Czyn44VAe/AErRm1N/cViSOen+f
        Crmk6I98gDRebMLChLa8KQbUVQYXEc4=
X-Google-Smtp-Source: APXvYqxkn8yeB+GGdQTJpOKRUXz0WQyk93FDhXeo+tfTW/c79Jd2tLZGpC5uCOPTF3Zn+FlYrqeivA==
X-Received: by 2002:a17:906:708d:: with SMTP id b13mr28454778ejk.120.1557307253935;
        Wed, 08 May 2019 02:20:53 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x49sm3153396edm.25.2019.05.08.02.20.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 02:20:53 -0700 (PDT)
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
 <568ba27d-a6a5-b158-bab1-f22cd8ccb34e@redhat.com>
 <155726027056.14659.1724431433952718602@swboyd.mtv.corp.google.com>
 <10c8864c-6ee7-4dfd-6274-b1996e767653@redhat.com>
 <CAHp75VdnxRQi3X6J9hLGUjGsOYTkjoPN5MakJc=mUSumoC+wag@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e9c92d24-9044-c37d-3f18-4884d97047d5@redhat.com>
Date:   Wed, 8 May 2019 11:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdnxRQi3X6J9hLGUjGsOYTkjoPN5MakJc=mUSumoC+wag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08-05-19 10:42, Andy Shevchenko wrote:
> On Wed, May 8, 2019 at 10:48 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 07-05-19 22:17, Stephen Boyd wrote:
>>> Quoting Hans de Goede (2019-05-06 08:05:42)
> 
>>> I guess this is urgent?
>>
>> Somewhat, getting this into e.g. rc2 would be fine too, waiting till 5.3
>> would be bad.
> 
> So, I can do it as a fixes for rc2, just ping me after merge window.

Ok, will do.

Regards,

Hans

