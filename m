Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3250C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8208720830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDCRhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:37:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41883 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDCRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:37:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id o129so10667856qke.8;
        Wed, 03 Apr 2019 10:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcaQcuzR5zvB04nlAMsUiU+5qry1OC0IVIjjYw3gIXM=;
        b=sRcIRce5OMs8gPqaNYjqdY9zSVQgNwnXnkfcKWGiWyxPu3ZLqmSDQ8RQksGdioMI5S
         DgqlSRZxSE1W04zlV+lui8iqXOE7EVoHQyKRAIrANnfKExJvhRsFS0vBDu0iQxij0i8R
         IoVxKKff5KJqo5RvURtHBLw3So6SasebN1+dpQFKTzPBfHdjKSnCab2G7ZFVllWb+34o
         srKOS5D+A1/EFHbThpQfYdYZrClqzBlDWJ/0s1qNXDc7aGnHqvN6VVI95XiYLu6N8IB2
         gh2p5aHmSJFDEXP/Ape7YxmocPI/XRYzToTqqtC+nB0f4wtTtS3k/1yqJLpOatKsv1Uv
         Q4jA==
X-Gm-Message-State: APjAAAWjAKUwBsghOlf2PbfMefZW6XHzf4308o++5rYy8hEUfolG7AGb
        +b0NLO1A6dbq9PlyeGmjPMPvc1wIpK7RTifBahQ=
X-Google-Smtp-Source: APXvYqxAq7B4nWCLtO+i0m6OR3WxNWaNH3qtdM036Zj9tv/6DO2ukZCHmB4moCPMVlT772IuR9rVmmbfQduvenksIzk=
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr1226540qkj.6.1554313035861;
 Wed, 03 Apr 2019 10:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-2-alexandre.belloni@bootlin.com> <20190403143645.GJ5238@ulmo>
In-Reply-To: <20190403143645.GJ5238@ulmo>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Apr 2019 00:36:58 +0700
Message-ID: <CAK8P3a24iWuCdxYmbZHDrFS+m4igPYXNQ0dPRMnx3ngxp00qvw@mail.gmail.com>
Subject: Re: [PATCH 01/12] ARM: at91: move SoC specific definitions to SoC folder
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 9:36 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Apr 03, 2019 at 04:11:09PM +0200, Alexandre Belloni wrote:
> > Move linux/atmel_tc.h to the SoC specific folder include/soc/at91.
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
