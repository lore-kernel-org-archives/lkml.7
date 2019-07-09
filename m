Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB6FC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E39A21707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfGIDTS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:19:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32831 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfGIDTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 23:19:16 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1hkgew-00059K-BR
        for linux-kernel@vger.kernel.org; Tue, 09 Jul 2019 03:19:14 +0000
Received: by mail-wr1-f71.google.com with SMTP id q2so9013551wrr.18
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 20:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1QqfQjHI6M6xLQMvNpyZB6ztRCUN973WhV6VSHgEn54=;
        b=p3wj3TENjWnBUUpKN+iKVsXj8Xu2Iu0S5jzUU79yBSX+WS0E5dhLEQs/ZTaH2OHmpU
         BLwml/dGYSVDqLObc4LLICfXFszodQ1tl2SeTsWfR43yYTnTrdsy+NWRYNvlLGX3EIDe
         zEc82FEI3wt2y3CxS+HaeCa5t2RLYDKL5VdGfyGOKrua1UUZymALh0jNeRQhAwBLNOve
         TLkCcVsNc7vvNiOf41mUvsWyUcojPcAN0gUWx9G7Aeh79UqH64JJaNg6dBNGSQaCQfnB
         ueTgtSbVQ6JV98SvvM36v76pxWTWHOJ3uJw2hpgahqPtUG3FYWrxGFu3V7rtK6WEgqCx
         0rgA==
X-Gm-Message-State: APjAAAUYQDakpxorYSlVGpk3yvRLQe+HIZYOJpLNsrBYP6gN8NEgLsmT
        kRSYJd7/l0nSwZKEdH6h0nBETtuoMUJ8B67sRDSdipfIun5gVXQGfaO0AsOg56TrdUVOT9cxkiS
        WxgLeUptwmRLE+/j4oseyB1NS3RIW9b5H76KYBP9dpWZnur9UlBTOFkkO+Q==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr18052544wmc.110.1562642353853;
        Mon, 08 Jul 2019 20:19:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzeoDMt0MH/23K6Nq80Yvr7C5VC5zRBuvbMf4w56eRexL9FbXcS7tJELrmIiEFI5hpNDUj8erQcw7cihFoBgcA=
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr18052532wmc.110.1562642353629;
 Mon, 08 Jul 2019 20:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190708063751.16234-1-acelan.kao@canonical.com> <53f82481-ed41-abc5-2e4e-ac1026617219@gmail.com>
In-Reply-To: <53f82481-ed41-abc5-2e4e-ac1026617219@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Tue, 9 Jul 2019 11:19:01 +0800
Message-ID: <CAFv23Q=mA9t0j2F4fKdOkgG6sao0m7rR_9-d9OvAmSerZf_=ew@mail.gmail.com>
Subject: Re: [PATCH] r8169: add enable_aspm parameter
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiner Kallweit <hkallweit1@gmail.com> 於 2019年7月9日 週二 上午2:27寫道：
>
> On 08.07.2019 08:37, AceLan Kao wrote:
> > We have many commits in the driver which enable and then disable ASPM
> > function over and over again.
> >    commit b75bb8a5b755 ("r8169: disable ASPM again")
> >    commit 0866cd15029b ("r8169: enable ASPM on RTL8106E")
> >    commit 94235460f9ea ("r8169: Align ASPM/CLKREQ setting function with vendor driver")
> >    commit aa1e7d2c31ef ("r8169: enable ASPM on RTL8168E-VL")
> >    commit f37658da21aa ("r8169: align ASPM entry latency setting with vendor driver")
> >    commit a99790bf5c7f ("r8169: Reinstate ASPM Support")
> >    commit 671646c151d4 ("r8169: Don't disable ASPM in the driver")
> >    commit 4521e1a94279 ("Revert "r8169: enable internal ASPM and clock request settings".")
> >    commit d64ec841517a ("r8169: enable internal ASPM and clock request settings")
> >
> > This function is very important for production, and if we can't come out
> > a solution to make both happy, I'd suggest we add a parameter in the
> > driver to toggle it.
> >
> The usage of a module parameter to control ASPM is discouraged.
> There have been more such attempts in the past that have been declined.
>
> Pending with the PCI maintainers is a series adding ASPM control
> via sysfs, see here: https://www.spinics.net/lists/linux-pci/msg83228.html
Cool, I'll try your patches and reply on that thread.

>
> Also more details than just stating "it's important for production"
> would have been appreciated in the commit message, e.g. which
> power-savings you can achieve with ASPM on which systems.
I should use more specific wordings rather than "important for
production", thanks.
