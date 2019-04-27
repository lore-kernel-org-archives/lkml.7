Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854A1C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EBA208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556352588;
	bh=uQUgmbeLP/ozM/MrSx7rXZl4pOfPYhosGPNjQApHDSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0tuReC0AWEz1ToEfWWc/iiK3C79axQmE9JibCLBP+GaQPpUiRJJymGWwZ4i1jZd47
	 Ayb8drVUojahA//ees5w99O/lwU91Y5wq26VAo0iQVC9PAFC73wYz+59F2rbjirEp0
	 rW9NIRNozQi7/Ec7ryfqhO+RMI73jGHY3IijNJno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfD0IJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfD0IJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:09:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68CF9206E0;
        Sat, 27 Apr 2019 08:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556352585;
        bh=uQUgmbeLP/ozM/MrSx7rXZl4pOfPYhosGPNjQApHDSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jvy6yKJ8YAHdRrsifNLmnrTb+HR+3ng4g/maDmjYGqHr5jTMb5pSiz2B9tTsUAZGQ
         2zwhNoYOxaB0X0o25ap2wIw98D2BDfW0Qpqc52nyEkCJ57g2pDzdYxbmhVhfGHLp4y
         jCoL6xQ/L5JKsAufVWinlLdzIBb/p6DLBVy9VviM=
Date:   Sat, 27 Apr 2019 10:09:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Fix type field in format string
Message-ID: <20190427080942.GA8218@kroah.com>
References: <20190427080013.GA3624@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427080013.GA3624@haolee.io>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 04:00:15PM +0800, Hao Lee wrote:
> The variable type and the type field is inconsistent.

In what way?  Please be very specific when you resend this.

thanks,

greg k-h
