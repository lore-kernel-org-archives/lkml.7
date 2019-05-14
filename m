Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C76BC04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE6E2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ouyZ1usH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfENAle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 20:41:34 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:21151 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfENAle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:41:34 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x4E0fTrr015702;
        Tue, 14 May 2019 09:41:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x4E0fTrr015702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557794490;
        bh=V4tT2sZ502gog+je0fZn2q8cpRmeSuV55T6cUSsZqvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ouyZ1usHVWTNRk5TC1X9saQ8TZU7A5S1NPufvF/TIqKtgDykraMsRyCaSDGXGL3Pt
         fdMyNeOdq12JU61DojRm6P9bdJ1R54sfoG/LIRueCGB+gTWpjOPAN9x90ThOdNdHBj
         Bv7WPckSs83pr9I4Y+4clt6xMkcQjPKFFXnOlyQK6Plw6xIi1R0IKPlIf5kLr2SYZf
         77m3aqBSihq+j/J0oIvoDY7E93rh1uDI1rXEuFMt3EYZqrlqFC4FxNrw2BwQ1QhRF6
         v7y2WmBnvqz5uIL941lzyV5+TNm65tWzNWKSVVDGctmMS5VUoiKUOkf5FqGoIP476Q
         z0W+1VUgv8NTw==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id n7so5537505uap.12;
        Mon, 13 May 2019 17:41:30 -0700 (PDT)
X-Gm-Message-State: APjAAAXXK3IGvpsw1rkTxyTC1W/gv/ZPk9NspLnldYpttjgdiWKBY2F4
        0Qhq5QkZzqqTSq2bnZvKuZ1xhWC9v/xFxgvCKDY=
X-Google-Smtp-Source: APXvYqwheGi9XYvQQuG+/sJRMiXjOVL7u39r4ISBPozSci+wtPzSFpVBofY2nul2pgqgVOCOChWs2d6AhMstUy6c7EU=
X-Received: by 2002:a9f:2d99:: with SMTP id v25mr11157499uaj.25.1557794489159;
 Mon, 13 May 2019 17:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190514100910.6996d2f5@canb.auug.org.au>
In-Reply-To: <20190514100910.6996d2f5@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 May 2019 09:40:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_aJ4-abaNXe5VwvAYa2TOprjFL-vcUc730EDwHq80kw@mail.gmail.com>
Message-ID: <CAK7LNAT_aJ4-abaNXe5VwvAYa2TOprjFL-vcUc730EDwHq80kw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the ecryptfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Tyler Hicks <tyhicks@canonical.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, May 14, 2019 at 9:16 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> I don't know why this suddenly appeared after mergeing the ecryptfs tree
> since nothin has changed in that tree for some time (and nothing in that
> tree seems relevant).
>
> After merging the ecryptfs tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> scripts/Makefile.modpost:112: target '.tmp_versions/asix.mod' doesn't match the target pattern
> scripts/Makefile.modpost:113: warning: overriding recipe for target '.tmp_versions/asix.mod'
> scripts/Makefile.modpost:100: warning: ignoring old recipe for target '.tmp_versions/asix.mod'
> scripts/Makefile.modpost:127: target '.tmp_versions/asix.mod' doesn't match the target pattern
> scripts/Makefile.modpost:128: warning: overriding recipe for target '.tmp_versions/asix.mod'
> scripts/Makefile.modpost:113: warning: ignoring old recipe for target '.tmp_versions/asix.mod'
> make[2]: Circular .tmp_versions/asix.mod <- __modpost dependency dropped.
> Binary file .tmp_versions/asix.mod matches: No such file or directory
> make[2]: *** [scripts/Makefile.modpost:91: __modpost] Error 1
> make[1]: *** [Makefile:1290: modules] Error 2
>
> The only clue I can see is that asix.o gets built in two separate
> directories (drivers/net/{phy,usb}).


Module name should be unique.

If both are compiled as a module,
they have the same module names:

drivers/net/phy/asix.ko
drivers/net/usb/asix.ko


If you see .tmp_version directory,
you will see asix.mod

Perhaps, one overwrote the other,
or it already got broken somehow.

Thanks.




> I have the following files in the object directory:
>
> ./.tmp_versions/asix.mod
> ./drivers/net/usb/asix.ko
> ./drivers/net/usb/asix.mod.o
> ./drivers/net/usb/asix.o
> ./drivers/net/usb/asix_common.o
> ./drivers/net/usb/asix_devices.o
> ./drivers/net/usb/.asix.ko.cmd
> ./drivers/net/usb/.asix.mod.o.cmd
> ./drivers/net/usb/.asix.o.cmd
> ./drivers/net/usb/asix.mod.c
> ./drivers/net/usb/.asix_common.o.cmd
> ./drivers/net/usb/.asix_devices.o.cmd
> ./drivers/net/phy/asix.ko
> ./drivers/net/phy/asix.o
> ./drivers/net/phy/.asix.ko.cmd
> ./drivers/net/phy/.asix.mod.o.cmd
> ./drivers/net/phy/asix.mod.o
> ./drivers/net/phy/asix.mod.c
> ./drivers/net/phy/.asix.o.cmd
>
> ./.tmp_versions/asix.mod
>
> Looks like this:
>
> ------------------------------------------
> drivers/net/phy/asix.ko
> drivers/net/phy/asix.o
>
>
> ------------------------------------------
>
> What you can't see above are the 256 NUL bytes at the end of the file
> (followed by a NL).
>
> This is from a -j 80 build.  Surely there is a race condition here if the
> file in .tmp_versions is only named for the base name of the module and
> we have 2 modules with the same base name.
>
> I removed that file and redid the build and it succeeded.
>
> Mind you, I have no itdea why this file was begin rebuilt, the merge
> only touched these files:
>
> fs/ecryptfs/crypto.c
> fs/ecryptfs/keystore.c
>
> Puzzled ... :-(
>
> --
> Cheers,
> Stephen Rothwell



-- 
Best Regards
Masahiro Yamada
