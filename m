Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080BAC7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 20:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA17E20657
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 20:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfG1U2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 16:28:52 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:39426 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1U2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 16:28:52 -0400
Received: by mail-lj1-f181.google.com with SMTP id v18so56439449ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 13:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PX6xwcsLnu3R6UXpghFRH0v4hIuqxQ4N0w1whL5uRzw=;
        b=DQn3TrSViVBccpSEBt2RZPxtWZii89olTIXd4YTeiOw8QUABvlVDm2sVebrE1Mi+Rz
         WJ9kV2g/ZogdrHfyV0dd+ujzXGf5YpWN7GJl5KTDizDXPXL5oR6KHMlfxNQ0AkJmYoI6
         vnF5YoEamVIsCfcFk9esF5XznQHSm2ygxan93b/2otaKQNVxaEwK+ukmbbXzEd6g0UvM
         9E9CReRTSXIkAlkT2dY+FtgydctThNYcWMQATBTHUwkXzCRGP6Pcu8aqPfTkMbHNJdY1
         V5uPUb3Rq3DgsJsOI3DtXMRtnillI7HBBo40OMV/muF4bfpcIT+q7W8VCfQxrSuDQmNT
         EpEg==
X-Gm-Message-State: APjAAAX05STCGuDzwF0+xGaKdWWKP14PTaOZuNEPFSqHN/tFHtA1YQRr
        SsBA2eLnbM1wDVRZ1AGkccBG0NjRwPjiYH1lmm7a2w==
X-Google-Smtp-Source: APXvYqy7S69A3suU/SmrmMQrjjECSRpKt2dwrYENNhIVchBwnv44WzW0qv4sxJD/Yf5AaC8x85H2NSyxTrBK9i4W2sI=
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr40166958ljk.106.1564345729792;
 Sun, 28 Jul 2019 13:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
 <57eeca23-3f03-cfd2-280e-4b19eb84b65d@petrovitsch.priv.at>
In-Reply-To: <57eeca23-3f03-cfd2-280e-4b19eb84b65d@petrovitsch.priv.at>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sun, 28 Jul 2019 22:28:13 +0200
Message-ID: <CAGnkfhwJ2_kRAqfyCB56NBLNjHVKV7Dxt=8BKShGsBf16v4+zw@mail.gmail.com>
Subject: Re: build error
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:16 PM Bernd Petrovitsch
<bernd@petrovitsch.priv.at> wrote:
>
> Hi all!
>
> On 28/07/2019 22:08, Matteo Croce wrote:
> [...]
> > I get this build error with 5.3-rc2"
> >
> > # make
> > arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.  Stop.
>
> - Install (some) gcc?!
> - Fix $PATH so that (some) gcc can be found?!
>

Hi,

I had no build error with 5.2, anyway:

# gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/aarch64-linux-gnu/8/lto-wrapper
Target: aarch64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Ubuntu/Linaro
8.3.0-6ubuntu1' --with-bugurl=file:///usr/share/doc/gcc-8/README.Bugs
--enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++ --prefix=/usr
--with-gcc-major-version-only --program-suffix=-8
--program-prefix=aarch64-linux-gnu- --enable-shared
--enable-linker-build-id --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --libdir=/usr/lib
--enable-nls --enable-bootstrap --enable-clocale=gnu
--enable-libstdcxx-debug --enable-libstdcxx-time=yes
--with-default-libstdcxx-abi=new --enable-gnu-unique-object
--disable-libquadmath --disable-libquadmath-support --enable-plugin
--enable-default-pie --with-system-zlib --disable-libphobos
--enable-multiarch --enable-fix-cortex-a53-843419 --disable-werror
--enable-checking=release --build=aarch64-linux-gnu
--host=aarch64-linux-gnu --target=aarch64-linux-gnu
Thread model: posix
gcc version 8.3.0 (Ubuntu/Linaro 8.3.0-6ubuntu1)

Bye,
-- 
Matteo Croce
per aspera ad upstream
