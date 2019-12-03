Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98821C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74585206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfLCKBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:01:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40556 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:01:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so2368290oto.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 02:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wiAub3vzlftP2graQzrpLrtRhdsOZaHnDMFjil2lmw=;
        b=Bt2TwjVMNJ19KGD/Go0rNU4KwDtE1xhrGXjej2+VSE6JSO35EOXJnhhTfDRbUn6QdQ
         yQLJRNxOfcUPX4eVA4bXyrvbmPQm9wRqApWt1c69sAKObkcSEQI7E7JAZzU4qY3hGrdH
         gD7CMNQTZJywxgnwYMts7rLv3Rsd8L8DuG2xZZME1tVVxy/n8tjDR7IwCXikf0K6p4Mh
         k0eRbRXG9AdKcABLF9gNKt3rRPiBWj07Fj+bapsvW1HUayfaGGZ0r8VliUGxP0zZCyQh
         +ZvhFMwskWZIbUZN/CWruvtCd4z061uGX3roCRtLnEcsbWNfL9x4wkC8BlKpnP17xLGr
         fa+g==
X-Gm-Message-State: APjAAAUrvy8GxXusbExbs1P9n70WeTzUS3sU3U3M0wQ+iN4FK9SWfJLu
        axlxCweaAysGmvHwXyXwTBcXxg0nkbak+eS82yc=
X-Google-Smtp-Source: APXvYqzTkVEN+mWRsQthMuxVu6alFZya5fNOxqC07BvWRSXuqRqfLaXbokC+m6d0aUQK0kmbbnfSOQi8ZGDzyA607q0=
X-Received: by 2002:a9d:5d10:: with SMTP id b16mr2534384oti.250.1575367265909;
 Tue, 03 Dec 2019 02:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20191202211844.19629-1-enric.balletbo@collabora.com>
 <20191202211844.19629-2-enric.balletbo@collabora.com> <CAJKOXPdJSLoEX7+34imGuZ6CEE5unajL=byb+h9VT3Bejc353Q@mail.gmail.com>
 <3355589d-0b0d-f30f-624c-0f781ee9cd8d@collabora.com> <CAJKOXPcrTp7baiPMYaaf_44w+b8GUBWs=X3YTgNZtxJVx0zbgw@mail.gmail.com>
In-Reply-To: <CAJKOXPcrTp7baiPMYaaf_44w+b8GUBWs=X3YTgNZtxJVx0zbgw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 11:00:54 +0100
Message-ID: <CAMuHMdXdWASPa3yr04N5w9jTt3=jC_H20yVpcG1J1_Sx0PRtgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86_64_defconfig: Normalize x86_64 defconfig
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        fabien.lahoudere@collabora.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Dec 3, 2019 at 10:26 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, 3 Dec 2019 at 17:05, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> > On 3/12/19 3:15, Krzysztof Kozlowski wrote:
> > > On Tue, 3 Dec 2019 at 05:18, Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > >>
> > >> make savedefconfig result in some difference, lets normalize the
> > >> defconfig
> > >>
> > >
> > > No, for two reasons:
> > > 1. If running savedefconfig at all, split reordering items from
> > > removal of non needed options. This way we can see exactly what is
> > > being removed. This patch moves things around so it is not possible to
> > > understand what exactly you're doing here...
> >
> > Ok, makes sense, I can do it, but if you don't really care of having the
> > defconfig sync with the savedefconfig output for the below reasons or others,
> > that's fine with me.
> >
> > The reason I send the patch is because I think that, at least on some arm
> > defconfigs, they try to have the defconfig sync with the savedefconfig output,
> > the idea is to try to make patching the file easier, but I know this is usually
> > a pain.
>
> Till I saw DEBUG_FS removal and Steven's answer, I was all in in such
> patches from time to time. However now I think it's risky and instead
> manual cleanup of non-visible symbols is better.

IMHO, it's the maintainer's responsibility to refresh the defconfig(s)
regularly, from known good config(s).

I.e. you start from a known good .config, run "make oldconfig", verify
the changes by comparing the .config before/after, and run "make
savedefconfig" afterwards.

You do not run blindly "make <my>_defconfig && make savedefconfig", as
that means you'll miss out on new options you may want, and will loose
old options that are no longer selected by other options.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
