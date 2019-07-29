Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DE6C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2406E20693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfG2H7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:59:25 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:41743 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfG2H7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:59:24 -0400
Received: by mail-lj1-f181.google.com with SMTP id d24so57623022ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 00:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0X7I7dffw1LhnC4nVMW+8AwSH2HYvA+5a9p+PbDV/Y=;
        b=Nas8riKaV3xLiD0o4ofuXxboO3JqjVoBPp5N9a0U3KM2ZU7sXVpZZDpKWJsLivA+7A
         R3qXXmhqUxa0qnlY68HEqMJ6TGqOawcrkhJQNv0v0FOR+oyE9Yzycg1xaUXfXxcJICYo
         d1YwkIjVz4gQOg3V3fP/VvYXtxUphOAwherXDKc3JQzvKGvLS8KqYqBF0CzBfxG67yDC
         ZxH91aP5jvijZxM1GR0ibgb7XacAJ9Bo8z4w6nHolk9j6yDPeb7XsepJFEDF2QdympPR
         gaU+Ph+eNB/R6q72gyZpjUtD9LzmvdrG6a8FGY9tZ+c8D+93k165hS9/J/PyBO4YQhtL
         LSEQ==
X-Gm-Message-State: APjAAAVFwiwbn2+eNgB5pRp5W3i2+ZpaudYCuBZJCzOovOlMVm6iTjTl
        NborSROBVBqFoAMM38oneYmwGu6trqE8nCaN/perEg==
X-Google-Smtp-Source: APXvYqw7/YBCA9dzyYL9QUBcjLEFOBq8sQ4hNsuED2wZFCVGwW+UaBuvGY/RNusnwUxtFEAT3PdLAci/FZVk4o03W9A=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr57841858ljj.108.1564387162794;
 Mon, 29 Jul 2019 00:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
 <20190729044403.GA27065@OpenSuse>
In-Reply-To: <20190729044403.GA27065@OpenSuse>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 29 Jul 2019 09:58:46 +0200
Message-ID: <CAGnkfhz=RgsPVqk964=hg1kJc=FJJ0WA7ysbhN6B3aNZgbD2aQ@mail.gmail.com>
Subject: Re: build error
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 6:44 AM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>
> Matteo,
>
> it's look like gcc is not in your normal PATH. Could you please locate
> that fellow and realign it ,where is suppose to be.
>
> Or if I understood right (I doubt that is why asking) that you might put
> explicitly the architecture to target build with make also, that might
> help.
>
> Please do let me know, if I derailed grossly ...am not sure.. :)
>
> Thanks,
> Bhaskar
>
> On 22:08 Sun 28 Jul 2019, Matteo Croce wrote:
> >Hi,
> >
> >I get this build error with 5.3-rc2"
> >
> ># make
> >arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.  Stop.
> >
> >I didn't bisect the tree, but I guess that this kconfig can be related
> >
> ># grep CROSS_COMPILE_COMPAT .config
> >CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
> >
> >Does someone have any idea? Am I missing something?
> >
> >Thanks,
> >--
> >Matteo Croce
> >per aspera ad upstream

I've  "fixed" the error by unsetting CONFIG_COMPAT
There should be something broken in the CROSS_COMPILE_COMPAT handling

-- 
Matteo Croce
per aspera ad upstream
