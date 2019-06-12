Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7033DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4760B20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbfFLUBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:01:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43933 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbfFLUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:01:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id i8so16669917oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 13:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0O8kud1OZKkvtHeAHVJbfPeAphq/Q2FLAtf0UYYJ3/U=;
        b=jfvmGr6vXnwPJXt2O/LJ+JA/LZ9J7HqtQsp80r4ZrIQ3/S50EA+IwkiTBriCXwFyKg
         MOFOGjaHZ/rDyA4dr+TqkDyKpGhurM6wkW23Ghi9L4gTt33Ov5swAa2pMYU9T4Nqxtv5
         DqH304gbQO4Vt8Y54k1QkC42oQgs6zAY0osLuDATW1olzV3nasxDoAbi9MKjnyEjk+v7
         UaeL80WnvyhOg0qPR6ULLu1EAZZ9s5b05Kls/6hcWIZVzeHS9orTunrnT79tXNWbNRxC
         LntV3JrgK0/snHU0b+yacZr5vDlghoFK2iggtONksdaLiNKxd7ITfnRGFSYcCfzc30XU
         qKvw==
X-Gm-Message-State: APjAAAXWigCGwG9njgUW7o+dYs1+OwcaKpmZyWKgMuoFY+HL+bApB9yH
        e+MnYwK9I3xR4vrtasPgCxaLQ0Ru
X-Google-Smtp-Source: APXvYqzJVTYaWENbmZQvZgwch+ObRfP7lb9GuIMIds4iW518UgnGBKfuWXySpXfrM5XGqnpA5SJXCA==
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr33759232otn.71.1560369702116;
        Wed, 12 Jun 2019 13:01:42 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id x128sm222264oig.54.2019.06.12.13.01.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:01:41 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id p4so13448958oti.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 13:01:40 -0700 (PDT)
X-Received: by 2002:a05:6830:1192:: with SMTP id u18mr35659756otq.74.1560369700348;
 Wed, 12 Jun 2019 13:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190422183056.16375-1-leoyang.li@nxp.com> <20190510030525.GC15856@dragon>
In-Reply-To: <20190510030525.GC15856@dragon>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 12 Jun 2019 15:01:29 -0500
X-Gmail-Original-Message-ID: <CADRPPNT2G20j2pvSEyqX=_WNDPrcNR+xCR_XZukbnSW19wFLNA@mail.gmail.com>
Message-ID: <CADRPPNT2G20j2pvSEyqX=_WNDPrcNR+xCR_XZukbnSW19wFLNA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable FSL_EDMA driver
To:     Shawn Guo <shawnguo@kernel.org>, madalin.bucur@nxp.com,
        Rob Herring <robh+dt@kernel.org>, aisheng.dong@nxp.com
Cc:     Vinod Koul <vkoul@kernel.org>, Grant Likely <grant.likely@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 10:15 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Apr 22, 2019 at 01:30:56PM -0500, Li Yang wrote:
> > Enables the FSL EDMA driver by default.  This also works around an issue
> > that imx-i2c driver keeps deferring the probe because of the DMA is not
> > ready.  And currently the DMA engine framework can not correctly tell
> > if the DMA channels will truly become available later (it will never be
> > available if the DMA driver is not enabled).
> >
> > This will cause indefinite messages like below:
> > [    3.335829] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
> > [    3.344455] ina2xx 0-0040: power monitor ina220 (Rshunt = 1000 uOhm)
> > [    3.350917] lm90 0-004c: 0-004c supply vcc not found, using dummy regulator
> > [    3.362089] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
> > [    3.370741] ina2xx 0-0040: power monitor ina220 (Rshunt = 1000 uOhm)
> > [    3.377205] lm90 0-004c: 0-004c supply vcc not found, using dummy regulator
> > [    3.388455] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
> > .....
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
>
> Applied, thanks.

Hi Shawn,

Is it possible to move this patch to the -fix series so that it can
reach the mainline earlier?  It is having a boot failure in mainline
for platforms using this device without this workaround.

I see Rob added a new API driver_deferred_probe_check_state() last
year.  Probably we should update the imx-i2c driver to use the new API
for optional dependencies to avoid this kind of situation completely?

Regards,
Leo
