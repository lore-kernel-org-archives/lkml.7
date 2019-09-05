Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3060EC41514
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1170A20693
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbfIEKVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:21:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44194 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfIEKVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:21:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id u40so2089482qth.11;
        Thu, 05 Sep 2019 03:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9ASHhPKpQsIU9mZBi7LyeVQlq2CQJ2Nfa0cGg2cxjU=;
        b=gqfY4PmwVDxruCWQzhbyPxIwP/7yT85hzCcnRhXJc4Cwlw2UGO3c+PpUqxkV91858F
         jznwKHR3baPoA5Ybq0KpWV8bGVFH/sS72nGK0EvwxxaD6RVgz9eb/AZpKKGMLnB1lCZd
         /hMYiwps1WJLujsUMGNJlxe4SozjmbqKea1IDKuyLlp0cu17G6ahhF2ElwhOnamutE5k
         r+s0Nh+Z1ikv35v50oRuWhLlgUBSJV6IHshQRbfxOEBYrZHg4aohLzcNqloDacm4EBsa
         kZhwBeBozcXudXmX6AqYOswh696bLcpeIMO5sxon7/JKinIjRTKBb2uaoOU/bEZe7h6J
         QmaQ==
X-Gm-Message-State: APjAAAXX4xUqtWO/CfGA6QUsIe0agIcNfLounfjyDhqsWNdnNh8zLO3d
        4tUrZvCESQQGw0Kmo4huXFkO4NUZeMOz0Z4tTkY=
X-Google-Smtp-Source: APXvYqw66BDokdBxyKl2ZBebLXBdM0Uc+EDEJXEwWO/OOdpU9zSB4XfPNlLYUumfYtGYq8zDk75S62/byvrXBZWShig=
X-Received: by 2002:ac8:32ec:: with SMTP id a41mr2625217qtb.18.1567678872786;
 Thu, 05 Sep 2019 03:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190830220743.439670-14-lkundrak@v3.sk> <201909021510.0g4L7Wva%lkp@intel.com>
In-Reply-To: <201909021510.0g4L7Wva%lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Sep 2019 12:20:56 +0200
Message-ID: <CAK8P3a1kpRcmTW0hH7-9vd4SiJjEuTMRPb6Kb06LSiRj0AGd8A@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] ARM: mmp: move cputype.h to include/linux/soc/
To:     kbuild test robot <lkp@intel.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Cc : Rob Herring" <robh+dt@kernel.org>, kbuild-all@01.org,
        "To : Olof Johansson" <olof@lixom.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 10:16 AM kbuild test robot <lkp@intel.com> wrote:

>
> vim +5 include/linux/soc/mmp/cputype.h
>
> 49cbe78637eb05 arch/arm/mach-mmp/include/mach/cputype.h Eric Miao 2009-01-20  4
> 49cbe78637eb05 arch/arm/mach-mmp/include/mach/cputype.h Eric Miao 2009-01-20 @5  #include <asm/cputype.h>
> 49cbe78637eb05 arch/arm/mach-mmp/include/mach/cputype.h Eric Miao 2009-01-20  6
>

You can probably do something like

#ifdef CONFIG_ARM
#include <asm/cputype.h>
#else
static inline read_cpuid_id(void) { return 0; }
#endif

Then again, ideally drivers don't even have to know about this,
but would distinguish between devices based on the
compatible string for the particular device.

       Arnd
