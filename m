Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2397C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D21214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfB1Gtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:49:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39506 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1Gte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:49:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id g80so16109142ljg.6;
        Wed, 27 Feb 2019 22:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9SEvbt26GPXckLEI57p2CYdvBjjgs/4kevRD1pygy3M=;
        b=F06n/TMKR6ygoXhHpo6QWrF0ELxwJWDNgeM8D1da7zj5ZUF92D5TmKyEwiSpz5iXAX
         vufE4mLg0wrgrAGndMNmTNd5hwBrf4tAGsrbSVNpd18bFgTsnUEr7db3wg4FfY6U3iMe
         iQ6cbOjJ3oJldus7wMKU6lA+499PaWyNrGmghbTi6/kAjAQBAum/pTBnR42dnptHf8gx
         Jx4uaJSGzmyK627gmuwXeT85+dynnUoRcjKIP4rHW5e6oquoVMRMCzS1CADjoTu3HFEo
         yi1GmQvaPliXphZTH1KnOYNaP2ZxZQgPhM175uYDFsh+resveo4dDWZUQlQANHm8De4n
         w6lA==
X-Gm-Message-State: AHQUAubUymWPHw8KXzas0BCYAkZXJY/F4G6xiMQ6HmFD3OcYUfGHlCfN
        oqTz6Mct9flXmGzV6IB45YU=
X-Google-Smtp-Source: AHgI3IYI5kI99ZoJJV//cQtkAxyfn1eQWvpIE3u5Qc2vsW3KfuRlmHrVN5p16mwg0GXyW97ilVsnzw==
X-Received: by 2002:a2e:934a:: with SMTP id m10mr3658426ljh.164.1551336571836;
        Wed, 27 Feb 2019 22:49:31 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g24sm3231411ljj.87.2019.02.27.22.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 22:49:30 -0800 (PST)
Date:   Thu, 28 Feb 2019 08:49:23 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mazziesaccount@gmail.com, lee.jones@linaro.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 07/13] devicetree: bindings: Document first ROHM
 BD70528 bindings
Message-ID: <20190228064923.GA3773@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <80de7a2b537ae3f414b0281736652256f38cf94c.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190223003041.GA16670@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223003041.GA16670@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob, All

Sorry for long delay - I was ill for a few days. Back at the business
now =)

Rob, maybe dropping the RFC tag has messed your book keeping? This
is the latest version:
https://lore.kernel.org/lkml/90c3b820baf072a7cc3a21aa50c661774a045158.1550148989.git.matti.vaittinen@fi.rohmeurope.com/
and I thought it already had the Reviewed-by tag from you :)

On Fri, Feb 22, 2019 at 06:30:41PM -0600, Rob Herring wrote:
> On Tue, Jan 22, 2019 at 11:45:38AM +0200, Matti Vaittinen wrote:
> > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > drivers) and 4 GPIO pins which can be configured for I/O or
> > as interrupt sources withe configurable trigger levels.
> 
> 'dt-bindings: mfd: ...' for the subject.

I see at least the patch subject comment is still valid though. Do you
want me to change it and resubmit the series?

> 
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 104 +++++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > new file mode 100644
> > index 000000000000..21801440a53a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > @@ -0,0 +1,104 @@
> > +* ROHM BD70528 Power Management Integrated Circuit bindings
> > +
> > +BD70528MWV is an ultra-low Iq general purpose single-chip power management IC
> > +for battery-powered portable devices. The IC integrates 3 ultra-low current
> > +consumption buck converters, 3 LDOs and 2 LED Drivers. Also included are 4
> > +GPIOs, a real-time clock (RTC), a 32kHz clock gate, high-accuracy VREF
> > +for use with an external ADC, flexible dual-input power path, 10 bits SAR ADC
> > +for battery temperature monitor and 1S battery charger with scalable charge
> > +currents.

Br,
	Matti Vaittinen


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
