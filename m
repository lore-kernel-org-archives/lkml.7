Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8C8C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6981922CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfH3TuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:50:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43945 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfH3TuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:50:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so7182296qkd.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcTquQFFNGFyj6h+17eIWTlSkXkkEaK67MosbLaZNLM=;
        b=g5cc3enn3T6IPfPfpKxInUaBRXrQrGEkZoKgW7s6dYRATFItDb65EbAvCm5vYxV6/B
         39dbP5u+CsetXIsLu4gBepEyDF9ktTtQg7RLvkOhifx1nHCknY5WPz2+wTKItcWq3Zph
         V8woi/QGbq+R2MCxBwvRyP1CWFaL078wpsewIRCzXYGHlg/a6QFUSuVEOcdbAUkjJhpk
         m8/YhMugxfNSczFGPJZqQoFgsDqMDOWM+B286a11FYJ/3jnp533QFXGX3eHUlry8SRVa
         7p7aIMHxZeyQZaxHW8spowPB30pLXReLqNLoBbVHZRxuMQPHYVnKgXjfr4OjXxBNzgC0
         Ihiw==
X-Gm-Message-State: APjAAAVxQzGMPBaR3H7ty4ymrsWTEzAU1ftQTVOPCQFSmN1pyHpiDPH1
        /Wjd+YPah2GU54UDpiEOuziCICZgkr8kdCMOmvwMldtg
X-Google-Smtp-Source: APXvYqx3T/FOkpjDHlUezeUg22GGBATaTHwRQhubWC6nsK7rYOTeQDDa8J8pHf5RD4fsEgtp4yuRwL8Pjaqgo8O86vU=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr17083647qkb.394.1567194622102;
 Fri, 30 Aug 2019 12:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YSQ.7.76.1908202301490.19480@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1908202301490.19480@knanqh.ubzr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Aug 2019 21:50:06 +0200
Message-ID: <CAK8P3a2Y_vBOm+KPsM7njfGPkE+VX4_Kn5WAkppJFPUUkqMZig@mail.gmail.com>
Subject: Re: [PATCH] __div64_const32(): improve the generic C version
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 5:05 AM Nicolas Pitre <nico@fluxnic.net> wrote:
>
> Let's rework that code to avoid large immediate values and convert some
> 64-bit variables to 32-bit ones when possible. This allows gcc to
> produce smaller and better code. This even produces optimal code on
> RISC-V.
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
>

Applied, thanks!

      Arnd
