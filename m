Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E7FC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DD920821
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfDURjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:39:05 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34561 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfDURjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:39:04 -0400
Received: by mail-vs1-f66.google.com with SMTP id t78so5184408vsc.1;
        Sun, 21 Apr 2019 10:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjCxxWhNbmyW5/I9rKG8Jy7LREvh7ilcm4i11Myowc8=;
        b=YfHV5occ0m+1iHd1QmUBrVVLpkaQBfM7ldTFK1RhV/TFDwCnU2FefJuBewKCJqvGX6
         ro7FuS4PDmsQIgtSaekuFFojDjQLttz2Ms0NOWV5aPAV1W8Ktaz+2A36at8PfhZB/aKh
         TJ4L6q8FvZtVQDg/oF1VShra/AOVYm3gt8KaeWDlk6AvbEjfwBYPzXKeupBs/q0kpvAu
         Wgh+kSAPP/a2WyaWOKWCAmeNHpq+v1LEZGsF3ah2ofPVR6rNgDZz8K7Owt3YYVShvT86
         Ma3P4RwS2ePZ+g+goQwwpHgIPntU4q9fz7Z4kkOGYYwdglVudYAYdkHHki5rV81TXYmG
         nR9w==
X-Gm-Message-State: APjAAAUpPG1Zq7tDpChfUMZBnyyzxp0SgP1xOVGnGv/S4hGDIkuIWW6v
        8MJ6Njr7UymBek1zfXqz83u3fYjJxdS2lXGrAmJ6d3ep
X-Google-Smtp-Source: APXvYqyR3eGBEh44QYBCzxfgmaskKwud6gHdYW/EwE0+6k9V9PHsUsUgJHOgrbdJpiVduXcv7DeTPMgRKbONIVlzpjU=
X-Received: by 2002:a67:f34f:: with SMTP id p15mr7418132vsm.11.1555868342535;
 Sun, 21 Apr 2019 10:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190421171258.12689-1-geert@linux-m68k.org>
In-Reply-To: <20190421171258.12689-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 21 Apr 2019 19:38:50 +0200
Message-ID: <CAMuHMdWGq26GWJidQB8cpQ6HYDCNKqHKEedHf20+ZotexXOEPA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.1-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 7:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.1-rc4[1] to v5.1-rc3[3], the summaries are:
>   - build errors: +1/-0

  + error: arch/sh/kernel/cpu/sh2/clock-sh7619.o: undefined reference
to `followparent_recalc':  => .data+0x70)

sh4/sh-all{mod,yes}config (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/15ade5d2e7775667cf191cf2f94327a4889f8b9d/ (all 236 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/79a3aaa7b82e3106be97842dedfd8429248896e6/ (all 236 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
