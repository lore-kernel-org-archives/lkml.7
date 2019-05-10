Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50416C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3322175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfEJORm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 10:17:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:48510 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfEJORl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:17:41 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 451612C5;
        Fri, 10 May 2019 14:17:41 +0000 (UTC)
Date:   Fri, 10 May 2019 08:17:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Corey Minyard <minyard@acm.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Move kref.txt to core-api/kref.rst
Message-ID: <20190510081740.1896c318@lwn.net>
In-Reply-To: <20190510004104.GA12809@eros.localdomain>
References: <20190510001747.8767-1-tobin@kernel.org>
        <20190510004104.GA12809@eros.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019 10:41:04 +1000
"Tobin C. Harding" <tobin@kernel.org> wrote:

> > I'm always hesitant to do docs patches that seem obvious - is there
> > some reason that this was not done previously?

Let's just say there's a lot of obvious stuff to do in Documentation/ that
nobody has gotten around to doing yet...

> > I did this one in preparation for converting kobject.txt, my intent is
> > to put kboject.rst in core-api/ also?  
> 
> Oh, I should have started on kobject.rst before sending this.  It builds
> without errors also.  The 'conversion' is no more than renaming the
> file.
> 
> If this patch is acceptable I can re-spin it as part of a series that
> does kobject as well so you don't get merge conflicts in core-api/index

That sounds like a fine idea to me.

Thanks,

jon
