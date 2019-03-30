Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E8DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66892184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfC3HvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:51:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60364 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfC3HvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:51:17 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0AD90274F9B;
        Sat, 30 Mar 2019 07:51:15 +0000 (GMT)
Date:   Sat, 30 Mar 2019 08:51:11 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-i3c@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: Bad file pattern in MAINTAINERS section 'I3C SUBSYSTEM'
Message-ID: <20190330085111.71a04fd9@collabora.com>
In-Reply-To: <20190325212519.26558-1-joe@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
        <20190325212519.26558-1-joe@perches.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

On Mon, 25 Mar 2019 14:25:19 -0700
Joe Perches <joe@perches.com> wrote:

> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
> 
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.

This is a leftover of previous versions of the patch series where
things were added to include/dt-bindings/i3c/.

> 
> The commits that added and if found renamed or removed the file pattern
> are shown below.
> 
> Please fix this defect appropriately.

I'll fix that. Thanks for reporting the problem.

Boris

> 
> 1: ---------------------------------------------------------------------------
> 
> linux-next MAINTAINERS section:
> 
> 	7333	I3C SUBSYSTEM
> 	7334	M:	Boris Brezillon <bbrezillon@kernel.org>
> 	7335	L:	linux-i3c@lists.infradead.org
> 	7336	C:	irc://chat.freenode.net/linux-i3c
> 	7337	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
> 	7338	S:	Maintained
> 	7339	F:	Documentation/ABI/testing/sysfs-bus-i3c
> 	7340	F:	Documentation/devicetree/bindings/i3c/
> 	7341	F:	Documentation/driver-api/i3c
> 	7342	F:	drivers/i3c/
> 	7343	F:	include/linux/i3c/
> -->	7344	F:	include/dt-bindings/i3c/  
> 
> 2: ---------------------------------------------------------------------------
> 
> The most recent commit that added or modified file pattern 'include/dt-bindings/i3c/':
> 
> commit 4f26d06669619b960aa7246378dcdf1690c97384
> Author: Boris Brezillon <boris.brezillon@bootlin.com>
> Date:   Fri Mar 23 11:38:16 2018 +0100
> 
>     MAINTAINERS: Add myself as the I3C subsystem maintainer
>     
>     Create an entry for the I3C subsystem and mark it as maintained by me.
>     There's no official git repository, patchwork instance, mailing list or
>     website yet, but this will be added after the subsystem has been
>     accepted.
>     
>     Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> 3: ---------------------------------------------------------------------------
> 
> No commit with file pattern 'include/dt-bindings/i3c/' was found
> 
> _______________________________________________
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

