Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4AFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C04C2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfHMNkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:40:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40136 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfHMNkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:40:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so79656139qke.7;
        Tue, 13 Aug 2019 06:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uXix37ClKT+tvsFUNGWguiFM+/73+Mp/B4lwLf0u84=;
        b=lKAMgBdZ08iFl0gdw98nun7PNJOGh4H08rCrtDbIHX76VCUacTv0otKd2l8ynhMB98
         WMaLHvjR0i5yB2NJ2vztMnmmDhDyJcUAC55yEdUGo+zdzWFD6nV7hLYv/gqj/troVLL/
         lnzOjXe5xTCuH/VnOPM21nQQA7zcPeOM8V0FX/8n0AoGd8f3+Ca1VXYNhwIaQnamKfj4
         TaUwnd4uKNxtsx/AKf5FDKXPv+A3CLxUWRJIFHYIgQ+9S3IKaX7zX7z5lAcCVxQDrAxl
         32TTNydaKkq6vtLdB1nG1W75HcZ4iA2UpQqbDa+kPXYQaLkp/7MyRcc3Wf3gTHG6Yr3S
         Rynw==
X-Gm-Message-State: APjAAAVNtPqpi1hoVPXoYKPePOEpAUhtPRZpSWKa5cc9biVJDbJeyzR9
        +6JX/CCoOpZsWqDuUd/ugMCXk5TtM3IW6o84U70=
X-Google-Smtp-Source: APXvYqxf5nJUrTaAzvwJdLif3TENX3xr9UxDNpNQFLH3ZLixVu+bnz+O3k7KO8Y9aYEt+ldFlGPD+WFo1hr9qLomMq8=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr33868639qkc.394.1565703617234;
 Tue, 13 Aug 2019 06:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190809202749.742267-1-arnd@arndb.de> <CGME20190809202857epcas2p14ab10d8ce2e50647671ab8c0ded385a8@epcas2p1.samsung.com>
 <20190809202749.742267-10-arnd@arndb.de> <cc732000-a147-bec2-1082-7bf58ee8f309@samsung.com>
In-Reply-To: <cc732000-a147-bec2-1082-7bf58ee8f309@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Aug 2019 15:40:00 +0200
Message-ID: <CAK8P3a0=5rmWw1vvKX3evVbpk-3Z204QZ3x-DaMs_5e9Kg-YAQ@mail.gmail.com>
Subject: Re: [PATCH 09/16] fbdev: remove w90x900/nuc900 platform drivers
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     soc@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 3:30 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 8/9/19 10:27 PM, Arnd Bergmann wrote:
> > The ARM w90x900 platform is getting removed, so this driver is obsolete.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>
> BTW there is a very minor issue with internal bisectability of
> this patch series (non-issue in reality because it affects only
> configs with ARCH_W90X900=y and such are now gone, just FYI):
>
> arch/arm/mach-w90x900/dev.c (which stays in tree until patch #16
> ("ARM: remove w90x900 platform") uses include/linux/platform_data/
> files removed in patches #7 (spi), #9 (fbdev) and #10 (keyboard).

Ah right, I actually planned to change that originally but forgot.
As you say, it's not a huge issue except for building randconfig or
nuc900_defconfig.

       Arnd
