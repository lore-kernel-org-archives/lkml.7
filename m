Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A8AC606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0471217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404714AbfGHTr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:47:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:53154 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfGHTr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:47:57 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3A87A2B8;
        Mon,  8 Jul 2019 19:47:57 +0000 (UTC)
Date:   Mon, 8 Jul 2019 13:47:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: filesystems:
 Convert jfs.txt to reStructedText format.
Message-ID: <20190708134756.1025c940@lwn.net>
In-Reply-To: <20190706232236.GA24717@t-1000>
References: <20190706232236.GA24717@t-1000>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jul 2019 16:22:39 -0700
Shobhit Kukreti <shobhitkukreti@gmail.com> wrote:

> This converts the plain text documentation of jfs.txt to reStructuredText format.
> Added to documentation build process and verified with make htmldocs
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>

Thanks for working to make the kernel documentation better.  That said, I
do have a request...


> ---
>  Documentation/filesystems/index.rst |  1 +
>  Documentation/filesystems/jfs.rst   | 74 +++++++++++++++++++++++++++++++++++++
>  Documentation/filesystems/jfs.txt   | 52 --------------------------
>  3 files changed, 75 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/filesystems/jfs.rst
>  delete mode 100644 Documentation/filesystems/jfs.txt
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 1131c34..d700330 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -41,3 +41,4 @@ Documentation for individual filesystem types can be found here.
>     :maxdepth: 2
>  
>     binderfs.rst
> +   jfs
> diff --git a/Documentation/filesystems/jfs.rst b/Documentation/filesystems/jfs.rst
> new file mode 100644
> index 0000000..bfb6110
> --- /dev/null
> +++ b/Documentation/filesystems/jfs.rst
> @@ -0,0 +1,74 @@
> +===========================================
> +IBM's Journaled File System (JFS) for Linux
> +===========================================
> +
> +JFS Homepage:  http://jfs.sourceforge.net/
> +
> +Following Mount Options are Supported
> +
> +(*) == default
> + .. tabularcolumns:: |p{1.3cm}|p{1.3cm}|p{8.0cm}|
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::   
> +  :header-rows:  0
> +  :stub-columns: 0

Please don't use flat-table unless you really need to.  It makes the
documents harder to read in plain-text form, which is something we want to
avoid whenever possible.  A simple definition list seems more appropriate
for this information.

(I should really update the documentation to discourage use of flat-table).

Note that the merge window is open, so expect me to be even slower than
usual to respond to things for the next couple of weeks.

Thanks,

jon
