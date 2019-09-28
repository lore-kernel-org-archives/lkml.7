Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F02C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 07:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834F8207FA
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 07:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfI1HYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 03:24:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:35738 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfI1HYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 03:24:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6CB712B4;
        Sat, 28 Sep 2019 07:24:04 +0000 (UTC)
Date:   Sat, 28 Sep 2019 01:23:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Remove dead url and added active url .
Message-ID: <20190928012359.38874015@lwn.net>
In-Reply-To: <20190927144411.GA167835@ArchLinux>
References: <20190927144411.GA167835@ArchLinux>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019 20:14:11 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
> index 1f920d445a8b..15781bf10b8d 100644
> --- a/Documentation/process/email-clients.rst
> +++ b/Documentation/process/email-clients.rst
>  
> +The Mutt docs have lots more information:
> +
> + https://gitlab.com/muttmua/mutt/wikis/UseCases/Gmail
> +
> +  https://gitlab.com/muttmua/mutt/wikis/MuttGuide

So you clearly didn't generate this patch against any upstream tree; I
can't apply this.

Also, it seems clear that you didn't try to build the docs afterward.

Please give this one more try, with a bit more care, and we'll get it
merged.

Thanks,

jon
