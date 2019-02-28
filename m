Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2521218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbfB1RCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:02:24 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42951 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfB1RCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:02:23 -0500
Received: by mail-vk1-f196.google.com with SMTP id j195so4910727vkj.9;
        Thu, 28 Feb 2019 09:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POVTPlfVJwZaOxs4m9qyzvl+1kGmgNX22BYhGnBCjuM=;
        b=XNDSNzTFRFf5AIgxgu27g/eWteKZ1ZtweWLlXtxOAI0ZNc6rS0rEfmW8/Nuq4xsgXP
         cv97fAvxpAUFJ1Nw1iHvM7D9jLjq7hxf/5EbHBJgjs+4IO8J9yE8V3yzkHGTNC+G50qS
         To94FF9L04zSCR38k8czt4fg1uimaA9LsF+0pemHQyEj12rfdTya5a9kywCl0GwsDIrP
         +sd2hplIhqM5/Jm7lAy8oup/0rlM/Ea1/9ql2Xfr9HwzuByACmNUmw/s8b9Mze7EZJ8h
         gj/qsE8Atg8kyGrYQpzG0EHXl2IWB9F2tGEKqxTIH7hql1EQs/fz/Pg4xLo863mdTj8g
         bDjg==
X-Gm-Message-State: APjAAAUCo5V5/2VzLNx2wDem7mpv6W67gEru2dxO+zNUsBuijtZHlz2C
        QA3b1XufArutqdHJ0G82FBXzZSOMheEr9GbtSJs=
X-Google-Smtp-Source: APXvYqw3ZbJrTWe7z62y+LBRUE1+qfgT3CnTePAFlYTzdbjG8wvefk0GDuYHgcvEnIM//k3VsgA3M9yVd35Dkwue4WA=
X-Received: by 2002:a1f:711:: with SMTP id 17mr266313vkh.65.1551373342603;
 Thu, 28 Feb 2019 09:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20190228105731.1092-1-geert+renesas@glider.be> <20190228165122.GT4072@linux.ibm.com>
In-Reply-To: <20190228165122.GT4072@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Feb 2019 18:02:09 +0100
Message-ID: <CAMuHMdW42VTYBB-jZ21cbt6_ypy_TFYhCHyGML74C0aBrxq80w@mail.gmail.com>
Subject: Re: [PATCH] Documentation/locking/lockdep: Drop last two chars of
 sample states
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Feb 28, 2019 at 5:51 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> On Thu, Feb 28, 2019 at 11:57:31AM +0100, Geert Uytterhoeven wrote:
> > Since the removal of FS_RECLAIM annotations, lockdep states contain six
> > characters, not four.
>
> Does the above want to instead say "four characters, not six"?

Yes it does. Thanks for noticing!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
