Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6DFC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FCB206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEFVLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:11:25 -0400
Received: from muru.com ([72.249.23.125]:48076 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfEFVLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:11:25 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7E3B580DB;
        Mon,  6 May 2019 21:11:41 +0000 (UTC)
Date:   Mon, 6 May 2019 14:11:20 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Remove MODULE_ALIAS() calls that take undefined macro
Message-ID: <20190506211120.GR8007@atomide.com>
References: <1557163697-17882-1-git-send-email-yamada.masahiro@socionext.com>
 <6d8e2880-0cc0-a7d8-1d42-4401e15e3ac9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d8e2880-0cc0-a7d8-1d42-4401e15e3ac9@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Lezcano <daniel.lezcano@linaro.org> [190506 17:40]:
> On 06/05/2019 19:28, Masahiro Yamada wrote:
> > These files do not define (USBHS_)DRIVER_NAME. Yet, they can be
> > successfully compiled because they are never built as a module by
> > anyone, i.e, the MODULE_ALIAS() calls are always no-op.
> > 
> > A problem showed up when a patch "moduleparam: Save information about
> > built-in modules in separate file" is applied. With this new feature,
> > MODULE_*() are populated even if the callers are built-in.
> > 
> > To avoid the build errors, the lines referencing to the undefined
> > macro must be removed.
> > 
> > The complete fix is to remove all MODULE_* and #include <linux/module.h>
> > like many "make ... explicitly non-modular" commits did.
> > 
> > For now, I am touching the offending lines.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks, please feel free to merge together with your series:

Acked-by: Tony Lindgren <tony@atomide.com>

Or if you want me to queue it separately, please let me know.

Regards,

Tony
