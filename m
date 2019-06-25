Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239CDC4646B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08B72077C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfFYBti convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 21:49:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:38509 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729450AbfFYBti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 21:49:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 18:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="172192735"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.93])
  by orsmga002.jf.intel.com with SMTP; 24 Jun 2019 18:49:35 -0700
Received: by ubuntu (sSMTP sendmail emulation); Tue, 25 Jun 2019 09:49:34 +0800
Message-ID: <1561427374.3131.2.camel@intel.com>
Subject: Re: [PATCH] nios2: remove pointless second entry for
 CONFIG_TRACE_IRQFLAGS_SUPPORT
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Jun 2019 09:49:34 +0800
In-Reply-To: <CAK7LNATViOYXJVLuJ8VnCruyMAPbYOkTc_0ZuW+gqi5H9x9-cA@mail.gmail.com>
References: <1557666733-19527-1-git-send-email-yamada.masahiro@socionext.com>
         <CAK7LNATViOYXJVLuJ8VnCruyMAPbYOkTc_0ZuW+gqi5H9x9-cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-23 at 23:13 +0900, Masahiro Yamada wrote:
> On Sun, May 12, 2019 at 10:16 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > 
> > 
> > Strangely enough, NIOS2 defines TRACE_IRQFLAGS_SUPPORT twice
> > with different values, which is pointless and confusing.
> > 
> > [1] arch/nios2/Kconfig
> > 
> >   config TRACE_IRQFLAGS_SUPPORT
> >           def_bool n
> > 
> > [2] arch/nios2/Kconfig.debug
> > 
> >   config TRACE_IRQFLAGS_SUPPORT
> >           def_bool y
> > 
> > [1] is included before [2]. In the Kconfig syntax, the first one
> > is effective. So, TRACE_IRQFLAGS_SUPPORT is always 'n'.
> > 
> > The second define in arch/nios2/Kconfig.debug is dead code.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> Ping.
> 
> 
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
Will integrate to next kernel version.
Thanks.

> > 
> >  arch/nios2/Kconfig.debug | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
> > index f1da8a7..a8bc06e 100644
> > --- a/arch/nios2/Kconfig.debug
> > +++ b/arch/nios2/Kconfig.debug
> > @@ -1,8 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > 
> > -config TRACE_IRQFLAGS_SUPPORT
> > -       def_bool y
> > -
> >  config EARLY_PRINTK
> >         bool "Activate early kernel debugging"
> >         default y
> > --
> > 2.7.4
> > 
> 
> --
> Best Regards
> Masahiro Yamada
> 
> ________________________________

Regards
Ley Foon
