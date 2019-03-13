Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A69EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B4C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfCMU2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:28:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38772 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfCMU2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:28:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id m1so3029794otf.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRHo+Qx+bqiMtdNEIHck/pS93TyE205D50SsM/O6eVc=;
        b=QwX8iHv3uVixF/GjTEpc/x0bWeppM2TGDmyPolaEsBFFuQbNU6Q1rE0kCbKCtd9CrW
         JYgOmuaz3csQBsBQNz4+RPJ45jCSq4SzF0gbgq/qr3JzPiI+JLYVpWOu0DdqkY8KfsEm
         Fih7I+nyH+F1W/CZQQ98Ao+W9au0va4NuwTjagrxt7S+5nlPQN6iztcN/JOMRVfb+Lrf
         +WxUw7mrx0Ur597/67kmQVqsiWNu3M6NVgG2fXWlj/nlaW9OoWuuDvXaAp3jZwr3mAKl
         pnq+EdRPLbIIRKUqJThQTTfN05eV8cOpJqaOVnumGCABfDa31xZ/SUj8rbc23wTYP+/K
         KdIg==
X-Gm-Message-State: APjAAAV8F9O1kDp1bK08/rSHO7LVP8NDiVMM+jTtmgGwFyLR3HdNmmW/
        TrYasW5toCxQNq+Q+XhyP05eV8GUPssxF3RwQf8=
X-Google-Smtp-Source: APXvYqyw6nvhEsMmj5VAYP2xAzA/a+5VN8gdNsYgKRRfsCrFfQK0k82tADaaTziKn7icMEjGfdezzwbGUcBKu2l6Yco=
X-Received: by 2002:a9d:7841:: with SMTP id c1mr29683616otm.354.1552508897906;
 Wed, 13 Mar 2019 13:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190114204241.21712-1-malat@debian.org>
In-Reply-To: <20190114204241.21712-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 13 Mar 2019 21:28:05 +0100
Message-ID: <CA+7wUsxi7jMURYQrBp9cTnGCs_akLZV7cmLuk8UgkkaL6Wzd7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] firewire: annotate implicit fall through
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?

On Mon, Jan 14, 2019 at 9:42 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
>
> In this particular case rewrote the comment to start with the string "fall
> through", so as to match the regular expression expected by GCC.
>
> This commit remove the following warning:
>
>   drivers/firewire/core-iso.c:308:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/firewire/core-iso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> index 35e784cffc23..d2d50bda5a5f 100644
> --- a/drivers/firewire/core-iso.c
> +++ b/drivers/firewire/core-iso.c
> @@ -308,7 +308,7 @@ static int manage_channel(struct fw_card *card, int irm_id, int generation,
>                         if ((data[0] & bit) == (data[1] & bit))
>                                 continue;
>
> -                       /* 1394-1995 IRM, fall through to retry. */
> +                       /* fall through - 1394-1995 IRM to retry. */
>                 default:
>                         if (retry) {
>                                 retry--;
> --
> 2.19.2
>
