Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2A0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4D321E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfKDLGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:06:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36882 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfKDLGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:06:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id d5so1972555otp.4;
        Mon, 04 Nov 2019 03:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETdYQqKxbujIixaJfu7S3lGMivGjpLGpc/OtjAqnGG8=;
        b=egehcCU2nKAD9Wrjt65VVN+2bkaHg2Su7gFgxdiygM4MrALcieOhg9VmMQ+pKpy1M7
         BbuQd90b5FMVPpqjQRxVHP5ugqb4VxSryq8yPjcuZDAnVbI8GN1+hZHj9cMUaRDvwwrV
         MHLFGUpcUDSMA2JGS+ghPtHzckfDGWr2aYi+d1uzqE7Klp08fewiHPsz3JX9BokGY6cd
         PInPOTEYb8h6Nl+OW16BGOycnuIJP6N8ayGKQPXAEyyGApvB6jWhEeRfesimF+zDoqPg
         Qhcrl+OVzqlr/w6ixWNKV1GgTSVtDyPZNLiSilhErfy/2j6Ayuda2M9QTemXDoJwtlX2
         Repw==
X-Gm-Message-State: APjAAAUBd7UOyDTYhbDbPuNqVfIOo/sWnlAWIZg6718u50/VXPYYxTvq
        3XXwRfVdBQzj76krbkDQr3sJBITwF7CfzIgygRs=
X-Google-Smtp-Source: APXvYqygLQ2AogODbL/7VtIebfrmJFCbEEfMOz9WdEdP8U3aOM5vso61oGKu+A507Pm58HIaVwHAz28GIKiQ2AueE1M=
X-Received: by 2002:a9d:191e:: with SMTP id j30mr8641683ota.297.1572865577253;
 Mon, 04 Nov 2019 03:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20191001073539.4488-1-geert@linux-m68k.org> <7fa02d50-6092-5f59-5018-c5b425a30726@enpas.org>
In-Reply-To: <7fa02d50-6092-5f59-5018-c5b425a30726@enpas.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Nov 2019 12:06:05 +0100
Message-ID: <CAMuHMdX3+-JO68LGE-NuT9axRUj3=bbtpDZ8E3v5UNoj5ctLHg@mail.gmail.com>
Subject: Re: [PATCH] m68k: defconfig: Update defconfigs for v5.4-rc1
To:     Max Staudt <max@enpas.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Mon, Oct 7, 2019 at 4:12 PM Max Staudt <max@enpas.org> wrote:
> (CC linux-ide)
>
> As for the Amiga defconfig, how about moving from IDE drivers to ATA?
>
> The old IDE stack is slated for removal in less than 2 years, and people should probably move over to libata instead.
>
> How about the following changes?
> Is there any Amiga IDE controller left without a libata equivalent?
>
> CONFIG_IDE=n
> CONFIG_IDE_GD_ATAPI=n
> CONFIG_BLK_DEV_IDECD=n
> CONFIG_BLK_DEV_GAYLE=n
> CONFIG_BLK_DEV_BUDDHA=n
>
> CONFIG_ATA=y
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_PATA_GAYLE=y
> CONFIG_PATA_BUDDHA=y

Amiga is fine.

Mac and Q40 are not, apparently.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
