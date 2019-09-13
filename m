Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F1DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A0A20830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfIMVUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:20:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37878 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbfIMVUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:20:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so16105583pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9P/XjVbI97/jTRRG3gmFq66lGI4E5K6bWBMtKJXZDto=;
        b=jOoyPEKWjbet+gBera2P92KJv6JMNMBnex1/tgwXFB4G1e5sIzNzJeJzvr/+lOo7k/
         msICywoBTqm/JsZjDoiqY3pKCCwCQYfwB0XHnQsrQeHaC0K77ks/ky4075ztQ3x1GxK2
         reEJwyAcdzNnxDj4BqEfQ1jQMcaJotBtXnqQzIilewen3j7HEUYdqXpa25RcmRO66cjD
         hd4MYi1Z3Buu3/hCd+9Q8EjOOO36vzDunMiorPBQE5NiQ8P7jciJD/roGLgtTAB7vuD1
         CRnRm87X9N7IuAq4qgsGwvmkj6dd1WKX8M/b6m7OAtPMpuEZ5c3iDuGYsTRyOSHAnDdf
         fzTg==
X-Gm-Message-State: APjAAAUPlnYt5ddLvoKGhztxKHvKpYBlHxu2MBUmXNhSKJ5o6Pxa1/z1
        g4FlhiToNgU16WVLS+PdCvuiXg==
X-Google-Smtp-Source: APXvYqxGX38OpJukmSdJgfGgVppHv0oE3pZZWx0OtjxeuAEjhQlb/mU/6Zxreniznz8l4dOfPg2gHQ==
X-Received: by 2002:a17:90a:37d1:: with SMTP id v75mr7640029pjb.33.1568409654241;
        Fri, 13 Sep 2019 14:20:54 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id s73sm2940942pjb.15.2019.09.13.14.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 14:20:53 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:20:53 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Sep 2019 14:18:36 PDT (-0700)
Subject:     Re: [PATCH] riscv: dts: Add DT support for SiFive FU540 PWM driver
In-Reply-To: <CAJ2_jOGO-isv52rnwRusV7jtyCY_JWYWAj9opN3Zg6ZbZr-8-w@mail.gmail.com>
CC:     robh+dt@kernel.org, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, bmeng.cn@gmail.com, sagar.kadam@sifive.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     yash.shah@sifive.com
Message-ID: <mhng-c8b87e96-987e-4577-acc2-1e22c9b81b10@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 02:52:07 PDT (-0700), yash.shah@sifive.com wrote:
> Hi,
>
> Any comments on this patch?

I don't see "sifive,pwm0" in the DT bindings documentation, and it doesn't 
match our standard way of doing these things (which would have at least 
"sifive,fu540-c000-pwm").

>
> - Yash
>
> On Wed, Aug 21, 2019 at 2:53 PM Yash Shah <yash.shah@sifive.com> wrote:
>>
>> Add the PWM DT node in SiFive FU540 soc-specific DT file.
>> Enable the PWM nodes in HiFive Unleashed board-specific DT file.
>>
>> Signed-off-by: Yash Shah <yash.shah@sifive.com>
>> ---
>>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 19 +++++++++++++++++++
>>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++++++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> index 42b5ec2..bb422db 100644
>> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
>> @@ -230,6 +230,25 @@
>>                         #size-cells = <0>;
>>                         status = "disabled";
>>                 };
>> +               pwm0: pwm@10020000 {
>> +                       compatible = "sifive,pwm0";
>> +                       reg = <0x0 0x10020000 0x0 0x1000>;
>> +                       interrupt-parent = <&plic0>;
>> +                       interrupts = <42 43 44 45>;
>> +                       clocks = <&prci PRCI_CLK_TLCLK>;
>> +                       #pwm-cells = <3>;
>> +                       status = "disabled";
>> +               };
>> +               pwm1: pwm@10021000 {
>> +                       compatible = "sifive,pwm0";
>> +                       reg = <0x0 0x10021000 0x0 0x1000>;
>> +                       interrupt-parent = <&plic0>;
>> +                       interrupts = <46 47 48 49>;
>> +                       reg-names = "control";
>> +                       clocks = <&prci PRCI_CLK_TLCLK>;
>> +                       #pwm-cells = <3>;
>> +                       status = "disabled";
>> +               };
>>
>>         };
>>  };
>> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>> index 93d68cb..104d334 100644
>> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
>> @@ -85,3 +85,11 @@
>>                 reg = <0>;
>>         };
>>  };
>> +
>> +&pwm0 {
>> +       status = "okay";
>> +};
>> +
>> +&pwm1 {
>> +       status = "okay";
>> +};
>> --
>> 1.9.1
>>
