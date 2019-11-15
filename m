Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18519C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0110720715
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKOFQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 00:16:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58172 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfKOFP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 00:15:59 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 629D5291347;
        Fri, 15 Nov 2019 05:15:58 +0000 (GMT)
Date:   Fri, 15 Nov 2019 06:15:54 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Mark linux-i3c mailing list moderated
Message-ID: <20191115061554.532d29e9@collabora.com>
In-Reply-To: <20191024153756.31861-1-geert+renesas@glider.be>
References: <20191024153756.31861-1-geert+renesas@glider.be>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 17:37:56 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> The linux-i3c mailing list is moderated for non-subscribers.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Queued to i3c/next. It was actually queued 2 weeks ago but the
patchwork bot didn't send a notification for that one (one was sent for
your other patch) and I don't know why.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f361fba6c4070ae..937017266a2edf08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7746,7 +7746,7 @@ F:	drivers/i2c/i2c-stub.c
>  
>  I3C SUBSYSTEM
>  M:	Boris Brezillon <bbrezillon@kernel.org>
> -L:	linux-i3c@lists.infradead.org
> +L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
>  C:	irc://chat.freenode.net/linux-i3c
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
>  S:	Maintained

