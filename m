Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13901C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67E320679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391764AbfHBNjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:39:00 -0400
Received: from ms.lwn.net ([45.79.88.28]:49608 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfHBNi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:38:59 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0B9BC7DA;
        Fri,  2 Aug 2019 13:38:59 +0000 (UTC)
Date:   Fri, 2 Aug 2019 07:38:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/checkpatch: Prefer str_has_prefix over
 strncmp
Message-ID: <20190802073858.19a86f82@lwn.net>
In-Reply-To: <20190802062537.11510-1-hslester96@gmail.com>
References: <20190802062537.11510-1-hslester96@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Aug 2019 14:25:37 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Add strncmp() to Documentation/process/deprecated.rst since
> using strncmp() to check whether a string starts with a
> prefix is error-prone.
> The safe replacement is str_has_prefix().

Is that the *only* use of strncmp()?

> Also add check to the newly introduced deprecated_string_apis
> in checkpatch.pl.
> 
> This patch depends on patch:
> "Documentation/checkpatch: Prefer stracpy/strscpy over
> strcpy/strlcpy/strncpy."
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  Documentation/process/deprecated.rst | 8 ++++++++
>  scripts/checkpatch.pl                | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 56280e108d5a..22d3f0dbcf61 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -109,6 +109,14 @@ the given limit of bytes to copy. This is inefficient and can lead to
>  linear read overflows if a source string is not NUL-terminated. The
>  safe replacement is stracpy() or strscpy().
>  
> +strncmp()
> +---------
> +:c:func:`strncmp` is often used to test if a string starts with a prefix

Please don't use :c:func: anymore; just say strncmp() and the right things
will happen.

Thanks,

jon
