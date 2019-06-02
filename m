Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70EEC28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 12:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C059627907
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 12:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cdnEGsT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFBMEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 08:04:36 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:47093 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFBMEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 08:04:35 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x52C4NIL020729;
        Sun, 2 Jun 2019 21:04:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x52C4NIL020729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559477063;
        bh=L8BBfjhdI+/yIFupjgT2A38Yv2uz8WkuxBjhJ/5EnGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cdnEGsT+uup1Yz3LLoeyTKz+J5iI4amTooWH7XE9dzrsQEFhGxo+Hpi4kYWgAfsIG
         0k4t46U4SI6zcE1vPweR1NPUBn0pFxV+hR8gbsrlHf8akZo99G8CTsIN/RqBhPuwbV
         7TIU+84lCHT3yGZiPNTLl2cl48ARRjt5di+2qjUa61vDUnSNYjNPM9MlaCL4l3bk4Q
         4YsvWvxPIclY4jd7ngSMQA4S7hk9AzcjqnbEb63JQFTDLjuSNnSQ9rcE6FhfEeMFO5
         JCt0pdG7dDqqu4rAW/egou+nx5SpHsftSIYkf3vFOqyPrFFHGzk7akmlecIM3l9Pxp
         vuRmituLpllwg==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id d7so2375731vkf.1;
        Sun, 02 Jun 2019 05:04:23 -0700 (PDT)
X-Gm-Message-State: APjAAAWbCDa8yTsoTukVhVRLz6Av67uLMYRht8YPXRIF1CVf+iJWl+5x
        8bF99K7qQGDR84AdYQapBcbjoFIX84ML43cBER0=
X-Google-Smtp-Source: APXvYqz/KyN+HSG2O3lEN56GOsrGKze9CFETpPyxwX0dVsWKUOWbnBtm24pePPyozckbAw4Ks7fsX78sNDzlA2AraDU=
X-Received: by 2002:a1f:ac05:: with SMTP id v5mr7391064vke.34.1559477062262;
 Sun, 02 Jun 2019 05:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190602063905.GA14513@kroah.com>
In-Reply-To: <20190602063905.GA14513@kroah.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 2 Jun 2019 21:03:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQf7difmgLo3OmEHCEvODaU3zoXLA8mKcyVL7NdCcZD=w@mail.gmail.com>
Message-ID: <CAK7LNAQf7difmgLo3OmEHCEvODaU3zoXLA8mKcyVL7NdCcZD=w@mail.gmail.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 2
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 2, 2019 at 4:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> The following changes since commit 2f4c53349961c8ca480193e47da4d44fdb8335a8:
>
>   Merge tag 'spdx-5.2-rc3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2019-05-31 08:34:32 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-2
>
> for you to fetch changes up to 8e82fe2ab65a80b1526b285c661ab88cc5891e3a:
>
>   treewide: fix typos of SPDX-License-Identifier (2019-06-01 18:29:58 +0200)
>
> ----------------------------------------------------------------
> SPDX fixes for 5.2-rc3, round 2
>
> Here are just two small patches, that fix up some found SPDX identifier
> issues.
>
> The first patch fixes an error in a previous SPDX fixup patch, that
> causes build errors when doing 'make clean' on the tree (the fact that
> almost no one noticed it reflects the fact that kernel developers don't
> like doing that option very often...)

This paragraph is not precise.

Not only "make clean", but also the normal build is broken.
In fact, ARCH=arm allmodconfig is broken.


$ make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- allmodconfig
  [ snip ]
$ make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
  [ snip ]
drivers/crypto/ux500/cryp/Makefile:5: *** missing separator.  Stop.
make[3]: *** [scripts/Makefile.build;489: drivers/crypto/ux500/cryp] Error 2
make[2]: *** [scripts/Makefile.build;489: drivers/crypto/ux500] Error 2
make[1]: *** [scripts/Makefile.build;489: drivers/crypto] Error 2
make[1]: *** Waiting for unfinished jobs....



The 0-day bot should check allmodconfig for all arches,
but surprisingly it was not caught before the merge.



> The second patch fixes up a number of places in the tree where people
> mistyped the string "SPDX-License-Identifier".  Given that people can
> not even type their own name all the time without mistakes, this was
> bound to happen, and odds are, we will have to add some type of check
> for this to checkpatch.pl to catch this happening in the future.

checkpatch.pl already warns
"Missing or malformed SPDX-License-Identifier tag"
unless correctly typed "SPDX-License-Identifier" is found in the file.

No more check is needed for this, I think.

Not all developers run scripts/checkpatch.pl before patch submission.
Not all maintainers run scripts/checkpatch.pl before commit.

Thanks.


> Both of these have passed testing by 0-day.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ----------------------------------------------------------------
> Alex Xu (Hello71) (1):
>       crypto: ux500 - fix license comment syntax error
>
> Masahiro Yamada (1):
>       treewide: fix typos of SPDX-License-Identifier
>
>  arch/arm/kernel/bugs.c                | 2 +-
>  drivers/crypto/ux500/cryp/Makefile    | 2 +-
>  drivers/phy/st/phy-stm32-usbphyc.c    | 2 +-
>  drivers/pinctrl/sh-pfc/pfc-r8a77980.c | 2 +-
>  lib/test_stackinit.c                  | 2 +-
>  sound/soc/codecs/max9759.c            | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)



-- 
Best Regards
Masahiro Yamada
