Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90353C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D14E218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfEaHRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:17:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45964 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaHRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:17:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so8542869lja.12;
        Fri, 31 May 2019 00:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGiZ/wQoDMtJOiZoXlGnm6UoE5Il4f6IVwE5GZnZITE=;
        b=TVCiKKhqf3tACT55RkFutOKEYJw8oMVpM1UpQGkdp9j1ub8DRAX0BWFcbkLgHcu8D2
         ku8ik0cept4oz12zAGXJvgtE8dKBi0cA0t8WaGF92G5Qjnn4oF5RY/7szDglBAqnVsw3
         tFpdJ6qpQV3QOiS0ssOXlhFHgJ+vH+xQ79sOyuNShHGzpGvBcRWuielv/Oi6bmxYFxLW
         mjkDdgbLeZ7E/LZXRLbZQMR6huIc5fTl7H9Uf2sBfLDZNqR6mMCESptPlft7+5IZKkor
         m15P0as+zqNreEMpzm405lurekmfqeeYRSNRrSRVa/xQ8E+93qayMBvn8kBeBqBnAC10
         Ix4Q==
X-Gm-Message-State: APjAAAUoQ7mX7ksI9z2mZBlHr250ew9oryev3Sq7B4Xs2+X6f11AIUYk
        4i+yT8PSwegNnCaeRKNjBItHWgJwB/kMAhajpuw=
X-Google-Smtp-Source: APXvYqwMUSuJIvwfuh1joeSN5lwxpbJvgY1FX8lo+O4GhyRjUdzEppIHYKz4FJKtzNI+sRrfB730QQZ/FGdyElUq2iA=
X-Received: by 2002:a2e:8555:: with SMTP id u21mr4643020ljj.133.1559287039079;
 Fri, 31 May 2019 00:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190531014808.GA30932@kroah.com>
In-Reply-To: <20190531014808.GA30932@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 May 2019 09:17:06 +0200
Message-ID: <CAMuHMdV=95sKB+h_pf45DiYeiJzrk1L=014Tj8Y04_hPyRMBNQ@mail.gmail.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 1
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

Hi Greg, Thomas,

On Fri, May 31, 2019 at 3:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:
>
>   Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-1
>
> for you to fetch changes up to 96ac6d435100450f0565708d9b885ea2a7400e0a:
>
>   treewide: Add SPDX license identifier - Kbuild (2019-05-30 11:32:33 -0700)
>
> ----------------------------------------------------------------
> SPDX update for 5.2-rc3, round 1
>
> Here is another set of reviewed patches that adds SPDX tags to different
> kernel files, based on a set of rules that are being used to parse the
> comments to try to determine that the license of the file is
> "GPL-2.0-or-later" or "GPL-2.0-only".  Only the "obvious" versions of
> these matches are included here, a number of "non-obvious" variants of
> text have been found but those have been postponed for later review and
> analysis.
>
> There is also a patch in here to add the proper SPDX header to a bunch
> of Kbuild files that we have missed in the past due to new files being
> added and forgetting that Kbuild uses two different file names for
> Makefiles.  This issue was reported by the Kbuild maintainer.
>
> These patches have been out for review on the linux-spdx@vger mailing
> list, and while they were created by automatic tools, they were
> hand-verified by a bunch of different people, all whom names are on the
> patches are reviewers.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I'm sorry, but as long[*] as this does not conform to
Documentation/process/license-rules.rst, I have to provide my:
NAked-by: Geert Uytterhoeven <geert@linux-m68k.org>

[*] The obvious solution is to update Documentation/process/license-rules.rst,
    as people have asked before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
