Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A852C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2592067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKLPzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:55:19 -0500
Received: from ms.lwn.net ([45.79.88.28]:41668 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfKLPzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:55:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6A4B07DE;
        Tue, 12 Nov 2019 15:55:18 +0000 (UTC)
Date:   Tue, 12 Nov 2019 08:55:16 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC PATCH] Documentation: filesystems: convert fuse to RST
Message-ID: <20191112085516.15ed4b1a@lwn.net>
In-Reply-To: <20191108164619.30401-1-dwlsalmeida@gmail.com>
References: <20191108164619.30401-1-dwlsalmeida@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Nov 2019 13:46:19 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> Converts fuse.txt to reStructuredText format, improving the presentation
> without changing much of the underlying content.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

This generally looks like a good conversion, thanks!  That said, I have a
few small comments...

 - You should copy the FUSE maintainer on this change.  You can find the
   relevant information in the MAINTAINERS file or with
   get_maintainer.pl.

 - Speaking of MAINTAINERS, you also need to fix the reference to
   fuse.txt there when you rename the file.

 - You are reasonably well restrained in your use of markup, but it would
   be good to pull back just a bit more.  Just FUSE everywhere rather than
   ``FUSE`` in some places.  Less **emphasis**.  Remember that the
   readability of the plain-text file is important.

 - This file contains information that is useful to system
   administrators, so I think that a move to admin-guide would be
   warranted.

Thanks,

jon
