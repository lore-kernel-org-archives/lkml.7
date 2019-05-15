Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31D2C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B469820862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557933275;
	bh=wAXhv4H3xhTROOTCsRyszjk2olnSUxpBZuWpsvCIapY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d0vFzuNFBtKVPsX9zyrPab9aPBQFZqQlu2wBk7CYxhjsQm3+JTcZ3J+IhwtzhGtth
	 S3FQSU0DY2ZUtV6tT6jFl+3JXFAaxwxomXrc3P7xXvfm0ByXcQTHWJUKGMy9rOgFPF
	 CKpvwz+7G7XBKBPQVvM3Sm3ek4Rx2N9bDl7lJRfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfEOPOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfEOPOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:14:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A49720862;
        Wed, 15 May 2019 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557933271;
        bh=wAXhv4H3xhTROOTCsRyszjk2olnSUxpBZuWpsvCIapY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=roUMvtwTq5trbCZEn1OhK4E8LzDyV6EeNPzfZGkP9fGGV4RNDZCaeYq8XigQMpZC3
         AN4jYTTfg7g2HCqSqBtT9JbQDgQJVFJiQgZa0NDDpsxm+VMDp7vwz8fkqS4vLjk1j3
         NAILRbyIcAbV+GK02RVeUxGa8XOHR7mhKte+ZDZ0=
Date:   Wed, 15 May 2019 17:14:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     parna.naveenkumar@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] bsr: do not use assignment in if condition
Message-ID: <20190515151426.GE23599@kroah.com>
References: <20190515150952.28570-1-parna.naveenkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515150952.28570-1-parna.naveenkumar@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 08:39:52PM +0530, parna.naveenkumar@gmail.com wrote:
> From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> 
> checkpatch.pl does not like assignment in if condition
> 
> Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> ---
>  drivers/char/bsr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

If you do a v2, you always have to show below the --- line what changed
from the previous version.

v3?  :)

thanks,

greg k-h
