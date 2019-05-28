Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19118C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2392075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="beeOLpTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfE1Ixp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:53:45 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42615 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE1Ixo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:53:44 -0400
Received: by mail-vs1-f65.google.com with SMTP id z11so12285022vsq.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JK8sXLOpeE59ctJhIGQXI4PJ5csZ63YIoouIc8eVvlQ=;
        b=beeOLpTn6dEhGK2x2cOMzIlqsqMvmIskU+3zj2td/JAHweIkHwsGSOCuZ2BNtShVfW
         ojZm7JltVswNRjQrAyyhfogLUUUc/ypyLH+b6mvmTaYJf3yHfg452kPBxC3xwy44Ykkx
         XAUSRhvsanhr7cF/pVFTLi/ZejG8/qqlZp/qAceW8f0EC/SC2EFuAdGW0PbA+ncE5FLh
         rGkfa69HeX3u9vEOqx+OR51Eta3WKyGDU1kSbvz9qM6gL83lg97Iy0iUJ17NZMrf11p8
         a4XoSPbOLSAtI2oaV/Ro21bq29xyMTNT0bUfv9JW0b6dcvLgdj160wj3r/8L99ZaWbRr
         UwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK8sXLOpeE59ctJhIGQXI4PJ5csZ63YIoouIc8eVvlQ=;
        b=O8yPhdaSyKdFTXpamcfXVm9JwtJk9s+8QGqiKjP5PbFIZYuRBCb0TeY50Vghx0OUVq
         dw6wi69DgBuKwe4Om3ni8N4DXwflcu2WBtWPyOLtbPVSSeg1ehVkAmEUoftCzwsYL9+J
         nMyAnujS/UjzLeZUVlKLOk2mXXtWXG6Z+1UbZNTuacfXFmqXBPq4vUB9NSNpsUkCcUdG
         923Zc7z52tVX2D1TJ/Z9uKt5vMFsv8OF+ySZA0B6UgtL0NMy9bEjFa2G/z90+NTnGZ9o
         kC8rWJc6LXyJ25zUg9a1PlWGj5SBEF+3afNX2YuPb/6zzvo1x4jMFSop6+yhu+TK7LQc
         Xltg==
X-Gm-Message-State: APjAAAUajI7mNJmS32WSecxAf62CssZZWIwBCWIP/7w40PYMwm9YfIjt
        SItN3HiC1URZk/zRM7OBSyiez+Fw9Hu/x49URdv/ytza
X-Google-Smtp-Source: APXvYqyV42QW96AtdeRCcdHraepjNDakDyDlAXtMCzOqU39H7gTnczCehB508e06zRvxSR8sret8bHhLSi04YwV/s5I=
X-Received: by 2002:a67:d815:: with SMTP id e21mr45786479vsj.35.1559033623410;
 Tue, 28 May 2019 01:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143647.2503-1-narmstrong@baylibre.com>
In-Reply-To: <20190520143647.2503-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 10:53:07 +0200
Message-ID: <CAPDyKFoOHnYiYogjogRr=7PBjqHOseDDS6L0eirTo7Y+F449ow@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: meson: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 at 16:36, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Update the SPDX Licence identifier for the Amlogic MMC drivers.
>
> Neil Armstrong (2):
>   mmc: meson-gx-mmc: update with SPDX Licence identifier
>   mmc: meson-mx-sdio: update with SPDX Licence identifier
>
>  drivers/mmc/host/meson-gx-mmc.c  | 15 +--------------
>  drivers/mmc/host/meson-mx-sdio.c |  6 +-----
>  2 files changed, 2 insertions(+), 19 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
