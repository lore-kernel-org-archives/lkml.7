Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADDCC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F6C21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDHWSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:18:22 -0400
Received: from ms.lwn.net ([45.79.88.28]:38342 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfDHWSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:18:22 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 64ADF2CC;
        Mon,  8 Apr 2019 22:18:21 +0000 (UTC)
Date:   Mon, 8 Apr 2019 16:18:20 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Add all documentation files to an html/pdf
 produced book
Message-ID: <20190408161820.6a12657f@lwn.net>
In-Reply-To: <cover.1554742526.git.mchehab+samsung@kernel.org>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Apr 2019 13:58:16 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Despite having converted almost all files to ReST at the main Documentation/
> directory, they're still not included to any book. Also, after all those years
> after migrated to ReST as the official documentation format, there are still
> a lot of files using plain TXT files, with random internal formatting.
> 
> As it will likely require a lot more years to get everything converted,
> let's add index.rst files to Documentation/* subdirs, with a text_files.rst
> including all plain txt files as literal includes.
> 
> That ensures that the html output will contain the entire Linux Kernel
> documentation.

Hmm...

>  251 files changed, 5262 insertions(+), 47 deletions(-)

Somebody clearly thinks I haven't been involved in enough merge conflicts
recently :)

I understand the goal, but I have to wonder.  This feels a lot like giving
up on the problem and just sweeping the remaining junk into a pile
somewhere.  I feel like it would, if anything, reduce the incentive to
deal with these leftover documents properly.  

If this is *really* something we want to do, I would much rather proceed
in smaller steps and preferably with the cooperation of the maintainers
involved.  Imposing all of this at once just seems like a way to make it
highly dangerous for me to show my face a conferences...

Thoughts?

Thanks,

jon
