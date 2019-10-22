Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A6BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BC021783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfJVNTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:19:22 -0400
Received: from ms.lwn.net ([45.79.88.28]:46634 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbfJVNTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:19:22 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 998FA37B;
        Tue, 22 Oct 2019 13:19:21 +0000 (UTC)
Date:   Tue, 22 Oct 2019 07:19:20 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     willy@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/core-api: memory-allocation: mention size helpers
Message-ID: <20191022071920.4efff72b@lwn.net>
In-Reply-To: <20191021212751.21300-1-chris.packham@alliedtelesis.co.nz>
References: <20191021212751.21300-1-chris.packham@alliedtelesis.co.nz>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 10:27:47 +1300
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Mention struct_size(), array_size() and array3_size() in the same place
> as kmalloc() and friends.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/core-api/memory-allocation.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
> index e59779aa7615..6a131767becd 100644
> --- a/Documentation/core-api/memory-allocation.rst
> +++ b/Documentation/core-api/memory-allocation.rst
> @@ -91,7 +91,9 @@ The most straightforward way to allocate memory is to use a function
>  from the :c:func:`kmalloc` family. And, to be on the safe side it's
>  best to use routines that set memory to zero, like
>  :c:func:`kzalloc`. If you need to allocate memory for an array, there
> -are :c:func:`kmalloc_array` and :c:func:`kcalloc` helpers.
> +are :c:func:`kmalloc_array` and :c:func:`kcalloc` helpers. The helpers
> +:c:func:`struct_size`, :c:func:`array_size` and :c:func:`array3_size` can be
> +used to safely calculate object sizes without overflowing.

Quick comment: we don't need :c:func: anymore; the markup happens anyway.
So rather than adding more of them, could I ask you to please take out the
ones that are there now?

Thanks,

jon
