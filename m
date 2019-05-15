Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B8BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 22:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA1320843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 22:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfEOW3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 18:29:52 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:42184 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbfEOW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 18:29:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 992CE837F24C;
        Wed, 15 May 2019 22:29:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lace66_38b74b7a2e71a
X-Filterd-Recvd-Size: 1692
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 May 2019 22:29:49 +0000 (UTC)
Message-ID: <391f21cf5f04c61b75e739f67c8a308864b4e68c.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update UBI/UBIFS git tree location
From:   Joe Perches <joe@perches.com>
To:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 15:29:48 -0700
In-Reply-To: <20190515200423.17809-1-richard@nod.at>
References: <20190515200423.17809-1-richard@nod.at>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 22:04 +0200, Richard Weinberger wrote:
> Linus asked to use kernel.org.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c38f21aee78..ba428cd613b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15879,7 +15879,7 @@ M:	Richard Weinberger <richard@nod.at>
>  M:	Artem Bityutskiy <dedekind1@gmail.com>
>  M:	Adrian Hunter <adrian.hunter@intel.com>
>  L:	linux-mtd@lists.infradead.org
> -T:	git git://git.infradead.org/ubifs-2.6.git
> +T:	git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git

Please keep the initial separate git

T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git

>  W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
>  S:	Supported
>  F:	Documentation/filesystems/ubifs.txt

