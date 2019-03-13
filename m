Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4C4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692B62146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCMUvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:51:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45374 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMUvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:51:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id t82so2603647oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O009ZFg1i+gNYh+2Z88bEKarH375verjGPvyoRxXQQ8=;
        b=GGR3VzMom1C7PJEFpbdWHlTDKdJRGyfljnX/Xyz2K5ZUxt91+5cqH/u8kctTw7A585
         EfrmdCGC2XCyKqaO8QEeA5ENxaAuEdm4UKIeyk1mhQx/XAz2APsgC4IVM1OQHYMPPc+S
         gT+pVlre8gQOiW+SroUdAaa+uDiLkCo8aSNEmCwoBhFNam6u0Lku0HwCUk0aIbPzVDdW
         9QO4JKffj91IzCvY/LeMv/JGn5XVmzTKzSXUUPAVg3N8fodOmR5ZAJr/4JFLbpl7bZZw
         I+TjHcXobKXw+VvHRUtX5KW+o5XGCCYZQrg7at0dZI7pULu9DuiY1Nc7p1xEZMbO953o
         syjw==
X-Gm-Message-State: APjAAAUU9TULXf+HW7PEc3r11xmnASPhmjeEln5QxSOEJg3y5JyM1SnL
        6Mo9LtLo06mu6R5NG9W1vDZjhNQL41t/a50cC99UDA==
X-Google-Smtp-Source: APXvYqwG40U05f7MwLlNb5Re8jruRXoJy9J5trRENNcfVlxWKjhoaApC/P1qH/nFXP2YwKNRMmigstxUwI3O8FC2GH4=
X-Received: by 2002:aca:4e13:: with SMTP id c19mr88170oib.96.1552510294260;
 Wed, 13 Mar 2019 13:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190114204241.21712-1-malat@debian.org> <CA+7wUsxi7jMURYQrBp9cTnGCs_akLZV7cmLuk8UgkkaL6Wzd7A@mail.gmail.com>
 <7788fe13-5f8a-2ac7-6e1a-a56daf9952d2@embeddedor.com>
In-Reply-To: <7788fe13-5f8a-2ac7-6e1a-a56daf9952d2@embeddedor.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 13 Mar 2019 21:51:23 +0100
Message-ID: <CA+7wUsxT7uOFgSyEkJF+rY1cQMMrfO9CAdJwvtqWMNnf-RE7iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] firewire: annotate implicit fall through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 9:39 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Mathieu,
>
> On 3/13/19 3:28 PM, Mathieu Malaterre wrote:
> > ping ?
> >
>
> I have sent the following patch to address all these warnings in
> firewire:
>
> https://lore.kernel.org/patchwork/patch/1040737/
>
> and, as this is being ignored, I'll add it to my tree for 5.2.

Good ! I was only starring at -next

Thanks

> Thanks
> --
> Gustavo
>
> > On Mon, Jan 14, 2019 at 9:42 PM Mathieu Malaterre <malat@debian.org> wrote:
> >>
> >> There is a plan to build the kernel with -Wimplicit-fallthrough and
> >> this place in the code produced a warning (W=1).
> >>
> >> In this particular case rewrote the comment to start with the string "fall
> >> through", so as to match the regular expression expected by GCC.
> >>
> >> This commit remove the following warning:
> >>
> >>   drivers/firewire/core-iso.c:308:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>
> >> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >> ---
> >>  drivers/firewire/core-iso.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> >> index 35e784cffc23..d2d50bda5a5f 100644
> >> --- a/drivers/firewire/core-iso.c
> >> +++ b/drivers/firewire/core-iso.c
> >> @@ -308,7 +308,7 @@ static int manage_channel(struct fw_card *card, int irm_id, int generation,
> >>                         if ((data[0] & bit) == (data[1] & bit))
> >>                                 continue;
> >>
> >> -                       /* 1394-1995 IRM, fall through to retry. */
> >> +                       /* fall through - 1394-1995 IRM to retry. */
> >>                 default:
> >>                         if (retry) {
> >>                                 retry--;
> >> --
> >> 2.19.2
> >>
