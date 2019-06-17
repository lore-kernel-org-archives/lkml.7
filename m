Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F72EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE3B204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfFQMwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:52:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44252 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfFQMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:52:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so15986776edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9G3k+5MHjdrN7oT/kgsKHwlHgXkAJv/hvWAxlowiLCw=;
        b=GGyOYZqw5SYg5TJ6s0BRrnFIHHxVbjfe3x9qsDRZUUxQR0yAD+SfZuxj6SlWn5aicB
         arl7CVoIxJGfCyHZMNDjQB+vZ39cNS89EgP/EcgAjfLGdDpILS+mKKo1b11TH8Q5+fY0
         RR0x3A0MzDwt8fTCdtGtPCfNiEsPdI5zyqR6D5WDVH9QlzrCfiz62m9JLb3Xz2MDTvf2
         /Dz1QAoVOZaYsUALuMkfaSEBYEgV6lD6u7jb7XWPlGiKgyu89+7v3z97mtL4+ZBigQ18
         97KGB+yl0WIQZzZ0hYaiIqp5q+e4HGtp6XL3lklQtqPcr1AwOEsIcgxpE18u03G5ja6F
         MTzw==
X-Gm-Message-State: APjAAAUG4ZNRfpcZQYL1amwT/VM91kzVHj+HzGr+JXai220MCv3GaTLI
        vvTCAQCHTOh/SJYq29Lod8uhB7zqT6U=
X-Google-Smtp-Source: APXvYqzO9HzOGWOkwsf6pSEOP7Da/AcOFWkVNxCQ/OOPKykyBCdSD9I0+2Zn6ZciZsN8qK50BnGdPg==
X-Received: by 2002:a17:906:55d4:: with SMTP id z20mr3820849ejp.205.1560775971291;
        Mon, 17 Jun 2019 05:52:51 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x10sm3717423edd.73.2019.06.17.05.52.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 05:52:50 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Update Hi10 Air filter
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Christian Oder <me@myself5.de>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-input <linux-input@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190612124053.119182-1-me@myself5.de>
 <736848fd-1c45-0bd9-bfd1-747c716bd953@redhat.com>
 <CAHp75Vdzf7bMQq2WP59Pux6QXD4GTcPLjryEecAsHJiAEewjcA@mail.gmail.com>
 <CAHp75VeSPYakPF-xUcaVOmnMEpv-UZFSrERMSCBi53ov5oA=0g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2819fd39-ce88-c50f-1fbf-f527d71d63e4@redhat.com>
Date:   Mon, 17 Jun 2019 14:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeSPYakPF-xUcaVOmnMEpv-UZFSrERMSCBi53ov5oA=0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17-06-19 14:38, Andy Shevchenko wrote:
> On Mon, Jun 17, 2019 at 3:37 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Wed, Jun 12, 2019 at 3:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 12-06-19 14:40, Christian Oder wrote:
>>>> Turns out the Hi10 Air is built by multiple companies so using Hampoo
>>>> as a filter is not enough to cover all variants.
>>>>
>>>> This has been verified as working on the Hampoo and Morshow version.
>>>>
>>>> Signed-off-by: Christian Oder <me@myself5.de>
>>>
>>> Patch looks good to me:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
> 
>> By some reason patchwork doesn't have a trace of this.
> 
> I meant, Hans, your message, the patch itself is there.

Weird, no idea why this is happening.

Regards,

Hans
