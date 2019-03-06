Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9205CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6613820663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfCFDsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 22:48:03 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:41149 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCFDsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 22:48:02 -0500
Received: by mail-ed1-f51.google.com with SMTP id x7so9102396eds.8;
        Tue, 05 Mar 2019 19:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjKFaSdzzfujjrZ/azeSFO1fNnMMkInD1JytlQvP+AI=;
        b=JCh8SuZjgPSV8jFiV0HNlE4+kifUdn6lu7O8CqkooTRklM6xHA9/v7CnTymEpynuMJ
         /lrkW8sx9w0aKzOUGtGi1gm7eQ9sUlc6cm3Vbf3UzURUgg5OcbIog7ZAilo2ZSZLQnq1
         fpidtYe6CgIWlRxpWsVRj5YdRSvu3EZoTXiRXiI3aSYgLj3znvhfKBMsSyaGT61nGw1r
         ECoXWPjEib2c764gDaX6ZazXCdtW6TOvDJY+MbT746Jgg/AtqUdi7Q2P8lqyZJde+sDZ
         p5T3xzAOCHuy9/bCn7nJ5HHv2juI+5Ua9shB+983/wW4F/4zOxvVlSzbmLDnG4kTIijW
         amJQ==
X-Gm-Message-State: APjAAAXfP84yKocylfPZVIWwActBxzRIAzW5DzPBBZ4MJ63gPfD0lPAD
        vxz8MPV/nQNv/AjNHWO6Rzu4U1VUnrQ=
X-Google-Smtp-Source: APXvYqwR+VZQ1EMbFoKYdc3akv3ZVC+akSIfKOT5jaA5/3GHGmN1/FIjSn5Xe8CBUSLfl5vBKWeZMQ==
X-Received: by 2002:a17:906:c286:: with SMTP id r6mr2399774ejz.7.1551844080193;
        Tue, 05 Mar 2019 19:48:00 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id h27sm102828eja.73.2019.03.05.19.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 19:47:59 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id z84so4483937wmg.4;
        Tue, 05 Mar 2019 19:47:59 -0800 (PST)
X-Received: by 2002:a1c:2543:: with SMTP id l64mr959526wml.116.1551844078917;
 Tue, 05 Mar 2019 19:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20190222112151.GA23266@lst.de>
In-Reply-To: <20190222112151.GA23266@lst.de>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 6 Mar 2019 11:47:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v66GQUzp1oz-J_Boea_S_mWAkBaiZ=A5uSqEb3pNNvaCzA@mail.gmail.com>
Message-ID: <CAGb2v66GQUzp1oz-J_Boea_S_mWAkBaiZ=A5uSqEb3pNNvaCzA@mail.gmail.com>
Subject: Re: device tree binding for poly-phased regulators
To:     Torsten Duwe <duwe@lst.de>
Cc:     Carlo Caione <carlo@caione.org>,
        Olliver Schinagl <oliver@schinagl.nl>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 7:21 PM Torsten Duwe <duwe@lst.de> wrote:
>
> Hi!
>
> Documentation/devicetree/bindings/mfd/axp20x.txt nicely describes the
> capabilities of the X-powers PMICs; however, it seems polyphasing is
> left to comments only.
>
> May I suggest to add a property "poly-phased", just to get the discussion
> started? It could be a simple property in the current case for the axp803
> and axp806 ("poly-phased with you-know-which") or a phandle in the future.

These PMICs are customized in a way that the outputs are poly-phased by
default. They are customized to match a specific SoC, and that is about
the only use for them. As such, there's really no way to test whether a
poly-phase property and implementation works or not. If you get it wrong
you risk frying your device.

A poly-phase property in genernal would be nice, however I don't think
this is the right device to start with.

> BTW the axp803 datasheet is quite terse in that respect: is there one
> "master" reulator whose settings are copied or does a driver have to keep
> them in sync.

The datasheet says, when outputs are poly-phased, only the settings of the
first phase applies, i.e. the other settings are ignored, not even copied.

ChenYu
