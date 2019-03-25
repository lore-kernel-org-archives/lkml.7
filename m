Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB19620879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfCYIUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:20:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43410 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbfCYIUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:20:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id g7so5318185lfh.10;
        Mon, 25 Mar 2019 01:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BJddPsDT6Xxkykv78AYxD44iyP8eDarxxuSjlGhekj0=;
        b=sX2w8cbt+/4zj55uDOoqbxMueD+wBnY85B4vvgtFg8xSzOFHiBxQbQs0YRIDXjv/iV
         yblvVVU0Az2Bj/uPFiDxaYlWTkgHU2Jeeo60TF+aUrb5XKopdnJFMe+CXPB1+avlkuyV
         5hcDEngIS4163WhqssUcJZmHXUoeLclR6UA0BqaYCQkFP87NcFDXbZYVY9TqMLlK2YBE
         c7hInT7uHfoIHahbEtHxWlVPPjFx7lkM+pxTHiiApR1vH2CchsZmH4H2RSZOb0hO5gQl
         G/ySrFNMCGWyGUo5n3hEK9ekAFh/uko0N6GTeQpklUuKFOgXjn27No1KsIt0cUN/k6GI
         JwHA==
X-Gm-Message-State: APjAAAXqnIidG8+/+NmfUxwxGhnbX0Y+UF8XW01rB7+eG76TqJDIeKLs
        uuNswPuk1eI6oqHXjmLyDUU=
X-Google-Smtp-Source: APXvYqzupmHvDS2mzH1gn0X9n9IAldskGkrJ07jy9HeNaAg01FAal5yaacl7O0E2pAXFhAPXq8UPNg==
X-Received: by 2002:ac2:447a:: with SMTP id y26mr12505568lfl.169.1553502017628;
        Mon, 25 Mar 2019 01:20:17 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id e18sm3011607ljb.12.2019.03.25.01.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 01:20:16 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:20:13 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Message-ID: <20190325082013.GC6208@localhost.localdomain>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
 <20190228081055.GL4118@dell>
 <20190228082248.GC3773@localhost.localdomain>
 <20190325073640.GB6208@localhost.localdomain>
 <20190325080206.GZ4731@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325080206.GZ4731@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 08:02:06AM +0000, Lee Jones wrote:
> On Mon, 25 Mar 2019, Matti Vaittinen wrote:
> 
> > Hello again Lee & all,
> > 
> > On Thu, Feb 28, 2019 at 10:22:48AM +0200, Matti Vaittinen wrote:
> > > On Thu, Feb 28, 2019 at 08:10:55AM +0000, Lee Jones wrote:
> > > > On Thu, 28 Feb 2019, Matti Vaittinen wrote:
> > > > 
> > > > > Hello Lee and Mark,
> > > > > 
> > > > > On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> > > > > > Patch series introducing support for ROHM BD70528 PMIC
> > 
> > I see the 5.1-rc1 and 5.1-rc2 are out. Those contain the regmap-irq
> > changes the BD70528 MFD driver depends on. Would you like me to rebase
> > the series to some other tree (which tree/branch? I don't see updated
> > for-mfd-next branch in kernel.org yet) and resend it? Original patch
> > series was created on top of the regulator tree.
> 
> If you could rebase and resend, that would be great.
> 
> You should (very nearly) always base on an upstream tag, so v5.1-rc2
> would be best in this case.

So always use tag from "kernel/git/torvalds/linux.git" tree? Thanks for
this guidance :) I'll try getting this rebased and resent today or
tomorrow.

Br,
	Matti Vaittinen

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
