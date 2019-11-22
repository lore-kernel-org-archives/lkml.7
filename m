Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFDBC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202862068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKVRCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:02:53 -0500
Received: from ms.lwn.net ([45.79.88.28]:41338 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:02:52 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2D6F837B;
        Fri, 22 Nov 2019 17:02:52 +0000 (UTC)
Date:   Fri, 22 Nov 2019 10:02:51 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation: Remove bootmem_debug from
 kernel-parameters.txt
Message-ID: <20191122100251.378d67a0@lwn.net>
In-Reply-To: <157443061745.20995.9432492850513217966.stgit@devnote2>
References: <157443061745.20995.9432492850513217966.stgit@devnote2>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 22:50:17 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Remove bootmem_debug kernel paramenter because it has been
> replaced by memblock=debug.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a84a83f8881e..02eae837272e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -437,8 +437,6 @@
>  			no delay (0).
>  			Format: integer
>  
> -	bootmem_debug	[KNL] Enable bootmem allocator debug messages.
> -
>  	bert_disable	[ACPI]
>  			Disable BERT OS support on buggy BIOSes.

Applied, thanks.

jon
