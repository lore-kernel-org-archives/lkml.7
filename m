Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069FCC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03CA20675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGoUtIoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391081AbfEXL1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:27:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34511 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390699AbfEXL1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:27:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id t64so6738743qkh.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjYcnQFmVjebl5i0cXPxIGxnyaXnU2JY+brSml/1DDA=;
        b=wGoUtIoO0xz1EQhdjt87mJBjfAHd7Ze0qgWrdLO3iyLU463hhfssDEWbk1Ei9Z18zD
         MzH1H0jYXc1FdtERUsP1TKuCRpAT1DJC+kGD7/6qUtElGHuy418CvUscrLkU/4gqu1TZ
         j05FNLrxUQCBUTfGoaPwzMuxLUedlu2x/ExF1zPVYt+Ce26ouQwv6MO3sZA8TRdeCURJ
         /AaGaj1MziyxFXmubqdVhkewE0SkemPgilorVvo10rANGoC294M0WlmnuMEI9OXQGmqu
         +ShnV6T6oumzk3r3twukFvr8i3d/6MGzzQ0MHXz5ssSfVnMySSixwiCRxCJQsh/5Ij09
         QExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjYcnQFmVjebl5i0cXPxIGxnyaXnU2JY+brSml/1DDA=;
        b=nwVjH5Ok2RCTnn9UfZ2+i/dohPTAV35wyFKgr7BhLCt1N204zg24GCEU30M1ZMghLd
         wCzDpBGdty0j9ltLG9umsKYYgdRxRaFa2CUM6NEn0QuPSHLyRwQvesVb86W+EV+EiL47
         UF94LApfFVEFVnioUjV+BbYqM6JW9zCP0cnH+gw03ZLQb4AEGHBmB922Mo6Z4NyZzcje
         DmS3bFzwE2pHLaCdEo/XxIca+ifYf7ovXXD5vHQKxzAslpir8W8ubwhuFryJTrtOx3vy
         VwsF9cIySG9IwymcbiZXJPfyxcFdGb5tXI0YE8z1tfkMzRA4YfVpaYVdyrS6CrZmRTEM
         l7PQ==
X-Gm-Message-State: APjAAAX8vXaEgTHqAqalL1gU2rsSVwyYCcZzE8fxIQPhfh90M7JFd8VE
        U0pLsbElrqq4bJXwk6h3UEr3BX1Bk96xxte8va8hMg==
X-Google-Smtp-Source: APXvYqxf7/9bFgNldoDEakk0wvrkUDY2w+3N/zeuVyi+hiSEB2HQNspS+Lvdr8CIJFtRT4V11GagahDvrbloBFIO5qU=
X-Received: by 2002:ad4:45ab:: with SMTP id y11mr82554975qvu.137.1558697263652;
 Fri, 24 May 2019 04:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190510090339.17211-1-luca@lucaceresoli.net>
In-Reply-To: <20190510090339.17211-1-luca@lucaceresoli.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:27:31 +0200
Message-ID: <CACRpkda5afsF+2WwMg4_L7uDexFR0UExgmHQ-+JajXmPCpzU3g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: remove duplicated lines
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 11:03 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:

> The 'default (active high)' lines are repeated twice. Avoid people stare at
> their screens looking for differences.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Patch applied with Bartosz's ACK.

Yours,
Linus Walleij
