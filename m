Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A07C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23F620409
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfL3Tat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:30:49 -0500
Received: from ms.lwn.net ([45.79.88.28]:60598 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbfL3Tat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:30:49 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CA1B42B4;
        Mon, 30 Dec 2019 19:30:48 +0000 (UTC)
Date:   Mon, 30 Dec 2019 12:30:47 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 4/8] Documentation: convert nfsd-admin-interfaces to
 ReST
Message-ID: <20191230123047.72ebabff@lwn.net>
In-Reply-To: <8a7e8fa26c2997d9286174da78e2d85b46e0626a.1577681164.git.dwlsalmeida@gmail.com>
References: <cover.1577681164.git.dwlsalmeida@gmail.com>
        <8a7e8fa26c2997d9286174da78e2d85b46e0626a.1577681164.git.dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2019 01:55:58 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Convert nfsd-admin-interfaces to ReST and move it into admin-guide.
> Content remains mostly untouched.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  Documentation/admin-guide/nfs/index.rst       |  1 +
>  .../nfs/nfsd-admin-interfaces.rst}            | 19 +++++++++----------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>  rename Documentation/{filesystems/nfs/nfsd-admin-interfaces.txt => admin-guide/nfs/nfsd-admin-interfaces.rst} (70%)
> 
> diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
> index 498652a8b955..c73ba9c16b77 100644
> --- a/Documentation/admin-guide/nfs/index.rst
> +++ b/Documentation/admin-guide/nfs/index.rst
> @@ -8,4 +8,5 @@ NFS
>      nfs-client
>      nfsroot
>      nfs-rdma
> +    nfsd-admin-interfaces
>  
> diff --git a/Documentation/filesystems/nfs/nfsd-admin-interfaces.txt b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
> similarity index 70%
> rename from Documentation/filesystems/nfs/nfsd-admin-interfaces.txt
> rename to Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
> index 56a96fb08a73..7f8c64ad7632 100644
> --- a/Documentation/filesystems/nfs/nfsd-admin-interfaces.txt
> +++ b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
> @@ -1,5 +1,6 @@
> +==================================
>  Administrative interfaces for nfsd
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +==================================
>  
>  Note that normally these interfaces are used only by the utilities in
>  nfs-utils.
> @@ -13,18 +14,16 @@ nfsd/threads.
>  Before doing that, NFSD can be told which sockets to listen on by
>  writing to nfsd/portlist; that write may be:
>  
> -	- an ascii-encoded file descriptor, which should refer to a
> -	  bound (and listening, for tcp) socket, or
> -	- "transportname port", where transportname is currently either
> -	  "udp", "tcp", or "rdma".
> +	#. an ascii-encoded file descriptor, which should refer to a
> +	   bound (and listening, for tcp) socket, or
> +	#. "transportname port", where transportname is currently either
> +	   "udp", "tcp", or "rdma".

So here we actually had bullets, I think it would be best to leave them
that way.

Let's focus on getting the series up to this point ready, then we can look
at the later patches.

Thanks,

jon
