Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E74C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F94120848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558112885;
	bh=GTG+1jP/TVoKJCDtPyVDCCcYy1RrBeov1C+3tNwcaUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fnCDDyqmj2mqD2ybbjnDlKcTp9SA0n3qGH8wEO5IgmLVOOGf0MHyCYqQyNR2hXQxz
	 5WMm5Jqe2uYQjmtLjGb+t5733vG3gKBevUwU5yiNm4SIy5fZL1nBZ3BModxCmTQ/4a
	 SEAL7xJUyhLqM12SKdZb7XwJohiKgEsxaGkmH+0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfEQRIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfEQRIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:08:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09AD220848;
        Fri, 17 May 2019 17:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558112883;
        bh=GTG+1jP/TVoKJCDtPyVDCCcYy1RrBeov1C+3tNwcaUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZS8Xf9xuuvN2a09MEk01c+N1MzAfzmhC181+vlqrCItANmRCv8B7tblhsFKp+88sw
         fm5TuzNp6wJVxdtmVmjQxQPhwWNXygJAmAed20s9ZyeWoJvDC64qwS+cEhdqoGA0sm
         Kvfe95tKWFerkxJkEDbyjycAbydpwFw1rufLq8j4=
Date:   Fri, 17 May 2019 19:08:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oscar Gomez Fuente <oscargomezf@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        thesven73@gmail.com
Subject: Re: [PATCH] staging: fieldbus: solve warning incorrect type
 dev_core.c
Message-ID: <20190517170801.GA20089@kroah.com>
References: <1558111991-30751-1-git-send-email-oscargomezf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558111991-30751-1-git-send-email-oscargomezf@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 06:53:11PM +0200, Oscar Gomez Fuente wrote:
> Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>
> ---
>  drivers/staging/fieldbus/dev_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I don't take patches without any changelog text, sorry.

Please fix and resend.

thanks,

greg k-h
