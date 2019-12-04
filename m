Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA38C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AC62081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="egpHlOjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfLDOuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:50:07 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:43522 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfLDOuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:50:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id D696C27E038D;
        Wed,  4 Dec 2019 15:50:04 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GHp3kFRHdo8v; Wed,  4 Dec 2019 15:50:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 49CCC27E06C1;
        Wed,  4 Dec 2019 15:50:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 49CCC27E06C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1575471004;
        bh=G1xS4lzb93btQMoC78SsVAL1pqlu8ZwF3KrrU9MEnLY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=egpHlOjA4ZD9x8M81b9ZhPeGsLSo87EMBZG3bPHgtOi0cXmfDMyGXZo5uAB2sP4xR
         xuxSmunXiB0svgX2olu8YslpDMKXg4tmBqciX6jzDxOP1Zdh5oMfMTBCLFHhOebuMO
         sR8+yRZMKi+9Uu5Lr0Fl95DaozOzUP1YODj+XpzY=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5ERnW-BBT-5E; Wed,  4 Dec 2019 15:50:04 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 2997327E038D;
        Wed,  4 Dec 2019 15:50:04 +0100 (CET)
Date:   Wed, 4 Dec 2019 15:50:03 +0100 (CET)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        "open list, GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Message-ID: <1988869450.95325741.1575471003953.JavaMail.zimbra@kalray.eu>
In-Reply-To: <CAHp75VdQ6VooLVAfA1z98-bBcfQuR7AomaO8F19AGRjeBtByEQ@mail.gmail.com>
References: <20191204101042.4275-5-cleger@kalray.eu> <CAHp75VdQ6VooLVAfA1z98-bBcfQuR7AomaO8F19AGRjeBtByEQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: dw: add pinctrl support for dwapb gpio
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - GC75 (Linux)/8.8.12_GA_3794)
Thread-Topic: pinctrl: dw: add pinctrl support for dwapb gpio driver
Thread-Index: kLqdeho0ftjbHsWUPu8lopfDUQvsSA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- On 4 Dec, 2019, at 13:43, Andy Shevchenko andy.shevchenko@gmail.com wrote:

> On Wed, Dec 4, 2019 at 12:12 PM Clement Leger <cleger@kalray.eu> wrote:
>>
>> Synopsys designware gpio controller also has pinmuxing functionnality.
> 
> DesignWare
> pin muxing
> functionality
> 
> (Please, run a spell checker)
> 
>> Pinmuxing allows to choose between software and hardware mode. When
> 
> Pin muxing
> 
>> using hardware mode, an external signal controls the pin output.
>>
>> This patch adds support for pinctrl framework in the gpio driver. This
> 
> GPIO
> 
>> support is conditionned by the snps,has-pinctrl device tree property.
> 
> conditioned
> 
>> Indeed, the functionnality can be detected only if the gpio IP has been
> 
> functionality
> 
>> configured using paremeters encoding which is not always present. If
> 
> parameters
> 
>> property is present, then the pinctrl will be registered and will
> 
>> allow switching to the "hw" functionnality and hence enable the
> 
> functionality
> 
>> alternate function.

Sorry, I will do some spellchecking before resending the serie.

> 
>> +static const struct pinctrl_pin_desc dwapb_pins[] = {
> ...
>> +       DWAPB_PINCTRL_PIN(31)
> 
> Keep comma in such cases.
> 
>> +};
> 
> Can't you split adding pin control data to a separate patch?

Yes even if the first one will not be buildable.

> 
>> +/* One pin per group */
>> +static const char * const dwapb_gpio_groups[] = {
> ...
>> +       "pin31"
> 
> Keep comma here.
> 
>> +};
> 
> Can't we generate these lists dynamically?

Indeed, these list could be dynamically generated. However, since they
can be shared between all pinctrl instances of this driver I thought
it was better to keep them common and simply restrict the number
of pins at pinctrl registration. But as I said, I can generate them if
you want.

> 
>> +       dev_info(gpio->dev, "Setting func %s on pin %d",
>> +               dwapb_gpio_functions[selector], group);
> 
> Noise!

I will remove that.

> 
>> +       ret = pinctrl_enable(port->pctl);
>> +       if (ret) {
>> +               dev_err(gpio->dev, "pinctrl enable failed\n");
>> +               return ret;
>> +       }
> 
> Not sure why it's needed at all.

I saw a comment over "pinctrl_register" in pinctrl.h saying:

/* Please use pinctrl_register_and_init() and pinctrl_enable() instead */

So I switched to pinctrl_register_and_init + pinctrl_enable.

> 
>> +       range = &port->range;
>> +       range->name = dev_name(gpio->dev);
>> +       range->id = port->idx;
>> +       range->pin_base = 0;
>> +       range->base = port->gc.base;
>> +       range->npins = pp->ngpio;
>> +       range->gc = &port->gc;
>> +
>> +       pinctrl_add_gpio_range(port->pctl, range);
> 
> Can you use new callback for this?

Do you mean the gpiochip add_pin_ranges callback ?
If so, I will look at it.

> 
>> -               .name   = "gpio-dwapb",
>> +               .name   = "pinctrl-dwapb",
> 
> This will break existing users.

Ok, I will revert that.

Thanks,

> 
> --
> With Best Regards,
> Andy Shevchenko
