Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F3BC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5913120449
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfGWIOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:14:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33402 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfGWIOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:14:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so36847514qtt.0;
        Tue, 23 Jul 2019 01:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skYBl35shSGoNfXvFNjST5a0PlFbqC2rw/e6qnwlEnU=;
        b=BBxPfcxZpYx1xrBh5o8M6vn2XwcSTrAZvwZX2CsmdoPvTdISZtKicI/FDBjS2x/iqi
         78Wr3F/x7KYyZ9MiN25aZJXCif17B3j6YMHuoYdMxz33EwTKUnhEecGl3fZbDyMULZgD
         AYplt0Y9kgOHNArqXxZ/HYgdzG/2m3jQyDEQWPAF/g3dXgMtQB9+eK1LqeWYLeh9DBn3
         0rclQImLkoRFpm353vFvjkxTbx0BW6zVETy5EsQuX5zK/T+psZGq0NpCphNF6TfBWzBU
         R+fbyJsezTmIiT2M4JaeCf4O5jetuPEyAj+y7Kh3Pj+xnzM5G2Lu6CYCv6BaBNitqVSR
         qApA==
X-Gm-Message-State: APjAAAVl78ZVDyrqpHbb4u5EZ1A1cSDRjwJBk6Mo3u/UnltY8PcAa7r+
        WQfHO7bktZqs4By/JJJpO3uBCdFxrcmCEnUmTYg/Vx1S
X-Google-Smtp-Source: APXvYqwd3utO0/VkjUrAvzdHwmGbWhr/XfGqmph13D+t4YymU477gohq0pq6xSoX3HkZqCfxgtF9ju1werdaQ/L8b1I=
X-Received: by 2002:ac8:f99:: with SMTP id b25mr45438710qtk.142.1563869672586;
 Tue, 23 Jul 2019 01:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190722191552.252805-1-arnd@arndb.de> <20190722191552.252805-3-arnd@arndb.de>
 <415f511480774ca58e068d6c005c917b@hilscher.com>
In-Reply-To: <415f511480774ca58e068d6c005c917b@hilscher.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Jul 2019 10:14:16 +0200
Message-ID: <CAK8P3a2juz8UEc9b87JdhxYtvog89ap3REhpC8tMkyLzWo-nqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] uio: remove netx driver
To:     Michael Trensch <MTrensch@hilscher.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 7:45 AM Michael Trensch <MTrensch@hilscher.com> wrote:
>
> The "uio_netx" driver is not used in conjunction with the removed netX SoC support.
> It is used to handle netX-Based PCI(e) cards (https://www.hilscher.com/products/product-groups/pc-cards/) plugged into a PC or any kind of embedded hardware.
>
> So a removal of this driver would render those extension cards unusable in future.

Ok, thanks for the quick reply, let's pretend I never sent that patch then.

      Arnd
