Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6451C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AF9214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfCMKai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:30:38 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37182 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfCMKah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:30:37 -0400
Received: by mail-vk1-f193.google.com with SMTP id p190so343234vke.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 03:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L63IB3dQbTFBoQi0/kjmSd57eMb/CHsGZuM8AxJp8ag=;
        b=tgPW4tjCYDNPvuvrvQ62id2rdsoyGWPqfvMQON3pi1UjmPGWte2CzK2tU7CA4/7YZa
         VIxm+wbrUksYuORlnOSKqEo4ZWJ8dDg2I02zh2UdDTbbfCgw5/bI/YhKpSuOdKM3m9DA
         z/VHT3VZoy1oogYArFArCho60k0YloT0/76CQEgsoGVPQSJt3h9DE/Y4JrG60548Z1VT
         VHqY5dbYBpyQrIqZ2AgdiEcw5it4VgPGg4OX6gAydLnn0P6pJY2U8kuX0atCmCz5KkCw
         eiiPh/gobsCLrq9e0qRIMC1V/CyTefyjTuTJGI8wieTkO0gfjlt9m3Qt2MKcCXNvj6oC
         GTkQ==
X-Gm-Message-State: APjAAAUYr7/hgjga9RlRtw66D0v+KlXjsL1donGE97srBs6Pnym81kUB
        qaVWV5GAsQsZArh72PeXmSrTZXU+hdtiIeT87XM=
X-Google-Smtp-Source: APXvYqx5WV7lFchsGl4m5GDDtn50kBl7awV4rpkaItNuoTerQrUSP50LWrqGQakoEz6xrii7ns9ZuIX3ZCTWrDy1rs0=
X-Received: by 2002:a1f:711:: with SMTP id 17mr23175307vkh.65.1552473036515;
 Wed, 13 Mar 2019 03:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190313101439.7092-1-brgl@bgdev.pl>
In-Reply-To: <20190313101439.7092-1-brgl@bgdev.pl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Mar 2019 11:30:24 +0100
Message-ID: <CAMuHMdWMd36X025PF2JODUH1658HECSK=d_imQE-4N0vY=Gvtw@mail.gmail.com>
Subject: Re: [PATCH] um: define set_pte_at() as a static inline function, not
 a macro
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:16 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> When defined as macro, the mm argument is unused and subsequently the
> variable passed as mm is considered unused by the compiler. This fixes
> a build warning.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
