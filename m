Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8636FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6127C20872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfI0Hic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:38:32 -0400
Received: from ms.lwn.net ([45.79.88.28]:56496 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfI0Hic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:38:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6F3AF300;
        Fri, 27 Sep 2019 07:38:31 +0000 (UTC)
Date:   Fri, 27 Sep 2019 01:38:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reap out the dead mutt config links
Message-ID: <20190927013827.65860ac2@lwn.net>
In-Reply-To: <20190927054004.GA17257@Gentoo>
References: <20190927054004.GA17257@Gentoo>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019 11:10:13 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/process/email-clients.rst | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
> index 5273d06c8ff6..1f920d445a8b 100644
> --- a/Documentation/process/email-clients.rst
> +++ b/Documentation/process/email-clients.rst
>  
> -The Mutt docs have lots more information:
> -
> -    http://dev.mutt.org/trac/wiki/UseCases/Gmail
> -
> -    http://dev.mutt.org/doc/manual.html
>  
I'm all for the removal of dead links.  But...can you please resubmit the
patch with a proper changelog saying why this change is being made?

For extra credit, you could try instead to replace them with current
links, assuming such things exist.

Thanks,

jon
