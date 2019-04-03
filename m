Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7699BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508AE20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDCJEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:04:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39462 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDCJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:04:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id m13so11108515lfb.6;
        Wed, 03 Apr 2019 02:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvh8D9pqYZ7qDKwQ/mIum3pVVgIu4bmSWSk7/XWJxNc=;
        b=WRvcgda/DfhYFi40Sq9q7RiViIapFaYOXp9Wdq3XuZDULD6BdvMeQYXljTKE5/8d9w
         apHNH0KRmU5ExbTJxnYB7efLph6XOMzJvHAOqnN+w6Ouo+Ayli4hoA7NsQjzDBiqjaRk
         NP8Zh/VhWs2ldG4WoyHZ2fBe8eyBkT6EP6+1IL0gW5ACvB8hMvKk7onBIjkIIszHqFlH
         tE2dH+g3Vx3hdPbDCOMGUHp8Hx2Du5GOE08yFtekJ7BAlNvwhGCLlG64+hFWrK4rXOUU
         sxomtrebidwYDzwaIPPFtNB73hvD7757I2Cj1U+t5P9J+dPvRHOw8jzF6czILNKIJz/d
         2tyA==
X-Gm-Message-State: APjAAAULkqybtfROocorWzcDbZSZHEYzFx1+eqEh6dTu72B7AGHTxCOm
        qlKvKtWb7mxqJgjJQHRG8fQ=
X-Google-Smtp-Source: APXvYqzU0fUqMBL8w2QcSyeInGNqfOMwSdoWEeL8Jio4DxpxmYEcSrrT/evMdYpEte58h35Awx0RVQ==
X-Received: by 2002:ac2:5479:: with SMTP id e25mr2584442lfn.121.1554282249501;
        Wed, 03 Apr 2019 02:04:09 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id i24sm2844879lfl.73.2019.04.03.02.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 02:04:08 -0700 (PDT)
Date:   Wed, 3 Apr 2019 12:04:06 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH v11 4/8] dt-bindings: mfd: Document first ROHM BD70528
 bindings
Message-ID: <20190403090406.GB3493@localhost.localdomain>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <c674ef76ca0a3298e6b13ade4ab29775edf36a76.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <20190403073426.GN4187@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403073426.GN4187@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And thanks again for fixing the language. Appreciated!

On Wed, Apr 03, 2019 at 08:34:26AM +0100, Lee Jones wrote:
> On Mon, 25 Mar 2019, Matti Vaittinen wrote:
> 
> > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > drivers) and 4 GPIO pins which can be configured for I/O or
> > as interrupt sources withe configurable trigger levels.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  .../bindings/mfd/rohm,bd70528-pmic.txt        | 102 ++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > new file mode 100644
> > index 000000000000..120462c17904
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > @@ -0,0 +1,102 @@
> > +* ROHM BD70528 Power Management Integrated Circuit bindings
> > +
> > +BD70528MWV is an ultra-low quiescet current general purpose single-chip
> 
> What does 'quiescet' mean?

I guess you knew what I meant =) Quiescent - I'll fix the typo.

> "general purpose, single-chip,"

Rules for using commas are far beyond my skills. I was bad in it at
Finnish classes. Not to even mention English. Actually, the teacher
suggested us to rather leave out the commas than trying to place them
correctly in English sentences. Guess the rules are not that simple =)

So I'll just add them as you suggested =)

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
