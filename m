Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5D6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C675720656
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfK0HNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:13:07 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38138 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfK0HNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:13:07 -0500
Received: by mail-oi1-f181.google.com with SMTP id a14so19180455oid.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 23:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+iy+I2ql514V3Li/xFx77FCnKZwhQ5z9HPShasnZfo=;
        b=FKIvXRj/JLMkeMstrbQjwyHmz/Ezo7lNzTW1ZAV49BhmsnAcVHJYL3Ncwxf42s/vVU
         PLVskTUDQfxNPBGC4p7WebGOq7BwNewmcVIBt7Ad1Rtf+PbPFniGEWyf4upZnwhb9eat
         ri1Z6hC8BDB6xui/Q4BYheEu31lWSqxHvuuuM4sTASeVh/s/IFV3XA7VaPFzaPZ1FKi8
         r0O/pXf5gQ6rgVVWa1Qpl/eFadXhNJK23GaGrnQY6NF9iYwsXzFA4SNXplz9aVyP6mP0
         hRFV3uTAjAyXpCVo9jnksYgEctZwOwSLtC9D844QITTv4nmP7wb7tOrlxyy19L4dL8xn
         Wytw==
X-Gm-Message-State: APjAAAW+MH1IjZpQxWVRnCt6y9k5xMIizQpW5jjvZ345GbwCFSUM3YIL
        6eku7QhPLbeGrReClDzzX4HpBOjJ5+HTOnDhoCPyLg==
X-Google-Smtp-Source: APXvYqyZ2w8lOKLiT2FaBfylkCaKfdFRizjqdBv4MizQEgr6Ph9CvBqOrFucHbN3CAOeySC9FQyUe7DaaT4gxgMOhJY=
X-Received: by 2002:aca:fdd0:: with SMTP id b199mr2649178oii.153.1574838785251;
 Tue, 26 Nov 2019 23:13:05 -0800 (PST)
MIME-Version: 1.0
References: <021330b6-67a2-0b74-c129-5c725dd23810@infradead.org>
In-Reply-To: <021330b6-67a2-0b74-c129-5c725dd23810@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Nov 2019 08:12:54 +0100
Message-ID: <CAMuHMdVLusDDB5G1R7=-53sK1bd2+3=s42hr9xkgPtWyjOrozg@mail.gmail.com>
Subject: Re: m68k Kconfig warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Wed, Nov 27, 2019 at 2:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Just noticed this.  I don't know what the right fix is.
> Would you take care of it, please?
>
> on Linux 5.4, m68k allmodconfig:
>
> WARNING: unmet direct dependencies detected for NEED_MULTIPLE_NODES
>   Depends on [n]: DISCONTIGMEM [=n] || NUMA
>   Selected by [y]:
>   - SINGLE_MEMORY_CHUNK [=y] && MMU [=y]

This has been basically there forever, but working.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
