Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80628C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3872183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfCTP4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:56:15 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43698 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCTP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:56:14 -0400
Received: by mail-vk1-f194.google.com with SMTP id e131so652686vkf.10;
        Wed, 20 Mar 2019 08:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Mdb+oQgc4x5axwACdaPzWbiRFbuV1WVXpmEIipZ8gA=;
        b=qXX6WWbgtjwvI8qnaXNiFBE/QWDjd9awj/5gfiAAWyw7Z5sEXvHzsjVbc36GBmJtMA
         cTZ91AC1j6J5qFo1KuoXoM+oPbuFpudRROsoSdwipVIgUJxJH+0kJtzCX1nkhH+gu2Zl
         aFECrDjnLZ4ZH9XdICKCebeNwTz6KhvTB4oES8xRjvMMj1Uh7RcYUdJSFy15LPMWJMGP
         XKrSXW4l81budBX13s1Xpb+6qgS88cnxEaqwOxrFqxRX+igglGM5/OWzAqQ2z3lwsJZ7
         Qf0umxVabU3AquxGorxU2a7ApcBubtyli2ll4kI+0mj5nNqyta0VFP+E3Wa41P3a1I2W
         hzhQ==
X-Gm-Message-State: APjAAAXGtZnGdyW2bwC0h7I0geuE630WXdA0gFz71C7H6CX1wukBFUbk
        es7cfsh/7yAUw5CoCD+jeTTM3kjeV5JDdr5W8HtB84Sv
X-Google-Smtp-Source: APXvYqz9Wmj5TDklQBDDckh16W9dImbO+OZgWEOBnP3chD1aK+e2/TjElG2GLK3NxRO9MVsHHBOPqQDttNttCNg3myE=
X-Received: by 2002:a1f:be81:: with SMTP id o123mr5216993vkf.83.1553097373061;
 Wed, 20 Mar 2019 08:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190320124428.14445-1-alexandre.belloni@bootlin.com> <20190320124428.14445-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20190320124428.14445-2-alexandre.belloni@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Mar 2019 16:56:01 +0100
Message-ID: <CAMuHMdUV6Vd8DqRLwQFwsCRWR=Jy_-LWvKjXXyRGKC0j5JgtgQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] rtc: ps3: convert to SPDX identifier
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 1:46 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Use SPDX-License-Identifier instead of a verbose license text.
>
> The original text refers to version 2 so also update MODULE_LICENSE() to
> "GPL v2" instead of "GPL".
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
