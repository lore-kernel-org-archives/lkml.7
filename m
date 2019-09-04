Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D113C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEE522DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfIDJcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:32:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43759 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDJcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:32:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id l22so11353343qtp.10;
        Wed, 04 Sep 2019 02:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHxSEahLKpYZl+gQl13hSzG6JV/+EQf24IFbG+fM+74=;
        b=kx8qx8PWUEE5Tk1TxXypVX5H3ixZ/YhyGW/Sz60uiXcUp81jytUEdzHn45ivhy1Xyy
         t1V6XlUDViYVh7FwGV6hV0YLIsPud1MLJiaMSHmAkwI2SYcKLotsSCYgTf0by1/cfkF+
         6jg5//oJul5RiTNZdecAUVoVC0L3pwq5SvpV9jyXfqFDKLNig05qMbyLnt/M1MYqHMwG
         E5ILopdS8U4tM6qiL2mvowdrRGR162IB/S3JuZWJ3aP5e5Sd75/WGCrG4M6R8xe07ulo
         MeQ6+2NHmUv7m857WJNHgD7BWpO5uJCPQXQlDyGJpKS1ZhMumDmYBNgX9skkPXXO0Yq9
         ktqw==
X-Gm-Message-State: APjAAAXbli5jJLeR28G0GXDfHQwV+E8iULDvogaVdYwjHrt16exBhPFY
        hbSc2cLMyg3uDKIH7tRJPPG7udPv2ifAT1+vrU4=
X-Google-Smtp-Source: APXvYqyROzVp8NdMUxBQN9T5fX/ExDvgw/NQj8JGADtVQ7H8Be+Kls547ULRLSLpK/YQ3XTPDmVl3Tk9bz7DYzm3A48=
X-Received: by 2002:ac8:32ec:: with SMTP id a41mr7276548qtb.18.1567589529989;
 Wed, 04 Sep 2019 02:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190816163042.6604-1-krzk@kernel.org> <CAJKOXPcgZ2_ofZyAeTSxALkALaP-SFNfvNmNPYSPyLzuhpGZ0w@mail.gmail.com>
 <20190822183519.GA23735@kozik-lap> <CAK8P3a1_Qw=OB31yOCrpPs8Ys+=9tt4Pnyd=3+2JGzRXJV1KAw@mail.gmail.com>
 <CAJKOXPfRMXkm_pT560Ry5k-zFWpkRDmFHSs2Fb3RL7d4h=ka9g@mail.gmail.com>
In-Reply-To: <CAJKOXPfRMXkm_pT560Ry5k-zFWpkRDmFHSs2Fb3RL7d4h=ka9g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Sep 2019 11:31:53 +0200
Message-ID: <CAK8P3a35Cm5=QOz3O3hhczRzkT54vyeka3iJBcknFB4cVgN5-A@mail.gmail.com>
Subject: Re: [GIT PULL 1/3] soc: samsung: Exynos for v5.4
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 10:37 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, 3 Sep 2019 at 19:21, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Aug 22, 2019 at 8:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > I have drafted a related patch recently, regarding the related
> > arch/arm/plat-samsung/cpu.c file. This is part of a longer series
> > I'm working on, see https://pastebin.com/ZqeU3Mth for the
> > current version of this patch.
>
> You can then also adjust the include path in arch/arm/mach-exynos/Makefile.

Yes, that is part of the following patch, along with replacing all the
'depends on PLAT_SAMSUNG' in Kconfig with 'depends on PLAT_SAMSUNG ||
ARCH_EXYNOS'.

> > The observation is that mach-exynos
> > is almost completely independent of plat-samsung these days, and my
> > patch removes the last obstacle from separating the two. I have
> > another set of patches to do the same for mach-s5pv210 (which shares
> > half of its pm.c with plat-samsung, but nothing else).
>
> Great!

FYI, the other parts of the series include:

- Changing all s3c24xx drivers to no longer use mach/*.h or plat/*.h header
  files, as preparation for multiplatform support. This is work in progress,
  but mostly done, with cpufreq and ASoC as the notable exceptions.
- Merging mach-s3c24xx, mach-s3c64xx and plat-samsung into a common
  mach-s3c directory. This seems to work fine and looks nicer than having
  three tightly connected directories, but the downside is that all path
  names change and the directory becomes fairly large.
  I think we can actually do the same thing for all remaining plat-*
directories.
- eventually making all ARMv5 platforms link into a single kernel, like we do
  with ARMv6 and ARMv7 (more to be done there, but s3c24xx and pxa are
  the harder bits here).

      Arnd
