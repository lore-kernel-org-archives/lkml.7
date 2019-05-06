Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E44CC04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5B72054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfEFOxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:53:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42073 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfEFOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:47:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so15603212eda.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 07:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E22Q7b+otbzAAMs8gR9PNwar2GIb4bL0tKudiTh9g9Y=;
        b=OyJKvBfMhGPPT6gRuL+u5ergEi7wqHFCxkhWg1eoguoZgq+UBMUbdmTiOsXcQGLFAW
         A6fMAUARlIk2A6DnDpMqmQOQJglX6gdYg7NpbNGp4DH2fxUsAls1gQNnWo4w08AmgyqM
         F1+MPRbyIqLti0aizBM6EjvJmf8BUKLXvNl3CDZe53dWAu/U4hIseZWTa1Z69ucNVis6
         Nv+/pC76TuzcMGNHd0ZXXvBQr3sP+3ypTbpPwzWYn7hTSquc1iGMqP9p8eHkdtShRTYi
         +0s+0a3jwrBFjx80bEr7QcGPt6kIt9Ka+VhHdfvV4il3cSQwOzJegejgIhANiqLIgSTT
         yDog==
X-Gm-Message-State: APjAAAUFPS5op4Q1aMO94OJP83PgJd6496NtfuY8CW270o5QC+Tu4val
        gCO9YkSnvUAadShKMmKITtx9Ew==
X-Google-Smtp-Source: APXvYqzWFeuYt9YTzTBy6cyaFIq2Xi0lCEr/Bz3MASuxVJMN07b99so49IFM6kpmPAjwK1zy5sWNKA==
X-Received: by 2002:a50:93a6:: with SMTP id o35mr25962616eda.245.1557154048677;
        Mon, 06 May 2019 07:47:28 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e4sm1587963ejm.50.2019.05.06.07.47.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 07:47:27 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to
 critclk_systems DMI table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Semyon Verchenko <semverchenko@factor-ts.ru>
References: <20190429150135.15070-1-hdegoede@redhat.com>
 <CAHp75VeE=88mCcgVx3Y3PQJPQ819Z7=3s=jRGz1y=t09phk=rA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <085c5b6e-d220-ebd1-38d2-def7efca24b8@redhat.com>
Date:   Mon, 6 May 2019 16:47:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeE=88mCcgVx3Y3PQJPQ819Z7=3s=jRGz1y=t09phk=rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-05-19 14:38, Andy Shevchenko wrote:
> On Mon, Apr 29, 2019 at 6:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The Lex 3I380D industrial PC has 4 ethernet controllers on board
>> which need pmc_plt_clk0 - 3 to function, add it to the critclk_systems
>> DMI table, so that drivers/clk/x86/clk-pmc-atom.c will mark the clocks
>> as CLK_CRITICAL and they will not get turned off.
>>
> 
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> supposedly to go via CLK tree.
> 
> P.S. If you want it through PDx86, I need immutable branch / tag from CLK.

Stephen added the patches this depends on to his fixes branch, so they
are in the 5.1 / Torvald's master branch, since we are now in the 5.2 merge
window, you should be able to cleanly apply this directly.

Regards,

Hans


> 
>> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
>> Reported-and-tested-by: Semyon Verchenko <semverchenko@factor-ts.ru>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/x86/pmc_atom.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
>> index 3a635ea09b8a..2910845b7cdd 100644
>> --- a/drivers/platform/x86/pmc_atom.c
>> +++ b/drivers/platform/x86/pmc_atom.c
>> @@ -407,12 +407,21 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc)
>>    */
>>   static const struct dmi_system_id critclk_systems[] = {
>>          {
>> +               /* pmc_plt_clk0 is used for an external HSIC USB HUB */
>>                  .ident = "MPL CEC1x",
>>                  .matches = {
>>                          DMI_MATCH(DMI_SYS_VENDOR, "MPL AG"),
>>                          DMI_MATCH(DMI_PRODUCT_NAME, "CEC10 Family"),
>>                  },
>>          },
>> +       {
>> +               /* pmc_plt_clk0 - 3 are used for the 4 ethernet controllers */
>> +               .ident = "Lex 3I380D",
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "Lex BayTrail"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "3I380D"),
>> +               },
>> +       },
>>          { /*sentinel*/ }
>>   };
>>
>> --
>> 2.21.0
>>
> 
> 
