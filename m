Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1356DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEE521872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfJXU3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:29:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:43156 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfJXU3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:29:04 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F2DFC536;
        Thu, 24 Oct 2019 20:29:03 +0000 (UTC)
Date:   Thu, 24 Oct 2019 14:29:02 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     rppt@linux.ibm.com, willy@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] docs/core-api: memory-allocation: remove uses of
 c:func:
Message-ID: <20191024142902.6bd413f6@lwn.net>
In-Reply-To: <20191024195016.11054-3-chris.packham@alliedtelesis.co.nz>
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
        <20191024195016.11054-3-chris.packham@alliedtelesis.co.nz>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 08:50:15 +1300
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> These are no longer needed as the documentation build will automatically
> add the cross references.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     It should be noted that kvmalloc() and kmem_cache_destroy() lack a
>     kerneldoc header, a side-effect of this change is that the :c:func:
>     fallback of making them bold is lost. This is probably best fixed by
>     adding a kerneldoc header to their source.
>     
>     Changes in v2:
>     - new
> 
>  Documentation/core-api/memory-allocation.rst | 49 +++++++++-----------
>  1 file changed, 23 insertions(+), 26 deletions(-)

This one still doesn't apply; have you verified that you can apply the
whole series to docs-next?

Thanks,

jon
