Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A0CC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DC9215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbfJDGzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 02:55:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbfJDGzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 02:55:13 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03AFE796E9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 06:55:13 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id 34so3314445edf.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 23:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4U37jEc90EXnYOSX1+H6azBux9N8gT6w0H08lGse2Eo=;
        b=EFeUeF78t9PXPPphfHaf5awm7rqGdTh8WGFQoSN4I/QaZqfEfuxZOQoDNUyIKIHLX4
         0Nwo25RifOYukfwgoZqoZaOdQhxyQHkY3nduGCvgWad4/ybu3+EzqT8GQpeGyVuD2pPQ
         /gdOpnhG9/rBkEuGAZH/QlnitGA88o4Lw5uAlFGB905NrDwSThKvkTUWYk3cSaGd47Ar
         +WPJyC1iMYOpLzZf1crHHjC8gZ7O3mD/WRMnNqJPubg6k45nbamMnUJQ+ltmAkDXGudc
         I5i0ecO4eXLn/i3btPkANhqgt2sRWmlZDZZnU/KxC0K/Cv+uKOBnQqyJ5D7zH74Qu/BX
         iomA==
X-Gm-Message-State: APjAAAU+x9TbEhbryKupeN0/GqLYgqg0dkVKb/1fdd9FiFDyaHSfYoGe
        GYTM6oRni5L56vgZbRN7H/f79/Zz5vx6FoNIvyz8GG8U0+B+gixpcEZTfi1mV4UOinzWXo6BABN
        /bD6C+o2izZp3xRU7uv/R30kw
X-Received: by 2002:a17:906:b316:: with SMTP id n22mr10940142ejz.54.1570172111484;
        Thu, 03 Oct 2019 23:55:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy3MLx4jX2SCgCROyCiGAR/SFOiQTeykJVQQaTlHenHkdtJyTKG+la5+gXjaA0uvaPKSzWO1w==
X-Received: by 2002:a17:906:b316:: with SMTP id n22mr10940132ejz.54.1570172111312;
        Thu, 03 Oct 2019 23:55:11 -0700 (PDT)
Received: from localhost.localdomain ([109.38.128.176])
        by smtp.gmail.com with ESMTPSA id h7sm921135edn.73.2019.10.03.23.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 23:55:10 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the hid tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191004102844.4864a9af@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <baab26c0-ed4c-abf8-0158-b1f8ca2a865d@redhat.com>
Date:   Fri, 4 Oct 2019 08:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004102844.4864a9af@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Jiri,

On 10/4/19 2:28 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hid tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ld: drivers/hid/hid-lg-g15.o: in function `.lg_g15_probe':
> hid-lg-g15.c:(.text+0x1a1c): undefined reference to `.devm_led_classdev_register_ext'
> ld: hid-lg-g15.c:(.text+0x1c68): undefined reference to `.devm_led_classdev_register_ext'
> 
> Caused by commit
> 
>    3a0275384c27 ("HID: Add driver for Logitech gaming keyboards (G15, G15 v2)")
> 
> For this build, CONFIG_HID_LOGITECH=y and CONFIG_LEDS_CLASS=m.

My bad, thank you for reporting this. I will try to come up with a fix for this
today.

Regards,

Hans
