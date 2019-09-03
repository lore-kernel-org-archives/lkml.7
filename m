Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEEC2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfICM1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:27:34 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35196 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfICM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:27:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id d26so8077815qkk.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 05:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhRwLyjUlW+c2hC8fBDr52ubKPgjR7IWnK8ss/n1sqc=;
        b=LvYFP+0bzpv6FMzy/f6sUBjmP0k+BIXx+Ib9XdoPmYb/BEK8ORujseZLj+YpncJKCI
         gfa1W305tBecC2VIj4PiKiLb8lc5GJS/DRYFoVb8zRp5MXa1iwI3ofrQYzuFeGYLQlnc
         I9kK5I0ROiHLa6Tnt9kOc73E7P6YPmgpY4MgizyZKks3jimqThD6jo9sbWaYe6MeLwGo
         XOD6+ki1WfqQguxpERIy3ebSvGoUaW/dGl9vP2CXRHHuZf7NhdNY+evmwYt06fdjiGCL
         LdkUyHmKyCa/VTYN56q0RJZAw6K1nc2lssbhlGlOoP8oOe3FNRzaaBJ5frSqaXHdTVXu
         1PXg==
X-Gm-Message-State: APjAAAU5jA0RlFdYAyFYlijW0kLvt27fGmAWMt8YcIQoLbABOeSJSy8f
        aagw7vwlS26CLeekFaf67mT4eJrp0S/c79by6Yo=
X-Google-Smtp-Source: APXvYqzwVU2KcZM6MzMS/hjDxWHhc2k8jQTbk38dxVSSZJ8yySnydBQRREAwEmKpByufxBClRZAA0HL2G5RvXLyBaXM=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr34016279qki.352.1567513653740;
 Tue, 03 Sep 2019 05:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190825203222.GA22800@piout.net>
In-Reply-To: <20190825203222.GA22800@piout.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Sep 2019 14:27:17 +0200
Message-ID: <CAK8P3a0jKyOXD=5SokdMCOjOqN2Zmja3gC2eebgvk_fmxQ6dLA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: at91: SoC for 5.4
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 10:32 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> AT91 SoC for 5.4
>
>  - MAINTAINERS updates
>  - a generated headers parallel build fix
>
> ----------------------------------------------------------------
> Masahiro Yamada (1):
>       ARM: at91: move platform-specific asm-offset.h to arch/arm/mach-at91
>
> Nicolas Ferre (3):
>       MAINTAINERS: at91: Collect all pinctrl/gpio drivers in same entry
>       MAINTAINERS: at91: remove the TC entry
>       mailmap: map old company name to new one @microchip.com

Pulled into arm/soc, thanks!

     Arnd
