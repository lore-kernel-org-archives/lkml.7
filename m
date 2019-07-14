Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25DC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 22:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908F620838
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 22:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfGNWKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 18:10:10 -0400
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:56762 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728719AbfGNWKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 18:10:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 69D428368EE2;
        Sun, 14 Jul 2019 22:10:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: leaf79_1e302ccefaa00
X-Filterd-Recvd-Size: 1840
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun, 14 Jul 2019 22:10:07 +0000 (UTC)
Message-ID: <8dbfa2d12bb0c76a19f46128af083921c8feb562.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add new entry for pidfd api
From:   Joe Perches <joe@perches.com>
To:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org
Date:   Sun, 14 Jul 2019 15:10:06 -0700
In-Reply-To: <20190714193344.29100-1-christian@brauner.io>
References: <20190714193344.29100-1-christian@brauner.io>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-14 at 21:33 +0200, Christian Brauner wrote:
> Add me as a maintainer for pidfd stuff. This way we can easily see when
> changes come in and people know who to yell at.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
> []
> @@ -12567,6 +12567,18 @@ F:	arch/arm/boot/dts/picoxcell*
>  F:	arch/arm/mach-picoxcell/
>  F:	drivers/crypto/picoxcell*
>  
> +PIDFD API
> +M:	Christian Brauner <christian@brauner.io>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
> +F:	samples/pidfd/
> +F:	tools/testing/selftests/pidfd/
> +K:	(?i)pidfd
> +K:	(?i)clone3

These seem fairly specific without false positives.

> +K:	\b(clone_args|kernel_clone_args)\b
> +N:	pidfd

This one I'd suggest using 2 F: patterns instead
as the patterns are more comprehensive and do not
use git history when looked up with get_maintainer

F:	samples/pidfd/
F:	tools/testing/selftests/pidfd/


