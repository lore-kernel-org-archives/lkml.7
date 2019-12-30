Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E16C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E83F20722
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfL3T2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:28:43 -0500
Received: from ms.lwn.net ([45.79.88.28]:60584 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfL3T2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:28:43 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8E62B536;
        Mon, 30 Dec 2019 19:28:42 +0000 (UTC)
Date:   Mon, 30 Dec 2019 12:28:41 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 3/8] Documentation: nfs-rdma: convert to ReST
Message-ID: <20191230122841.3a10db96@lwn.net>
In-Reply-To: <dd45de2519a3cc1fc07b6b29db77d6be113b0983.1577681164.git.dwlsalmeida@gmail.com>
References: <cover.1577681164.git.dwlsalmeida@gmail.com>
        <dd45de2519a3cc1fc07b6b29db77d6be113b0983.1577681164.git.dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2019 01:55:57 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Convert nfs-rdma to ReST and move it to admin-guide. Content
> remais mostly untouched.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

With this one, my main concern is that this document looks *way* out of
date, to the point that I wonder whether it is still useful or not.  It
would be good to find somebody who knows about this stuff to figure that
out.  Consider:

> +The NFS/RDMA client was first included in Linux 2.6.24. The NFS/RDMA server
> +was first included in the following release, Linux 2.6.25.

That was a while ago at this point.

> +Getting Help
> +============
> +
> +If you get stuck, you can ask questions on the
> +nfs-rdma-devel@lists.sourceforge.net mailing list.

What are the chances that this list still works and has relevant people to
it?  It might be worth sending a copy of this patch there and seeing what
results... 

> +- Install a Linux distribution and tools
> +
> +  The first kernel release to contain both the NFS/RDMA client and server was
> +  Linux 2.6.25  Therefore, a distribution compatible with this and subsequent
> +  Linux kernel release should be installed.

Hmmm..where might I find such a distribution...? :)

> +  The procedures described in this document have been tested with
> +  distributions from Red Hat's Fedora Project (http://fedora.redhat.com/).
> +
> +- Install nfs-utils-1.1.2 or greater on the client

I have nfs-utils 2.4.2 here.  So probably nobody needs to do this
installation at this point.

> +  Download the latest package from: http://www.kernel.org/pub/linux/utils/nfs

This directory, amusingly, has nothing after 1.0.7, so this advice is
actively wrong.

I could go on, but I think you get the point.  At a bare minimum we should
put a big warning at the top saying that this document is obsolete.  I
should create a standard warning, I guess; for now anything that gets the
point across should do.

Thanks,

jon
