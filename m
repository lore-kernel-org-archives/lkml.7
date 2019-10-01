Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FCFC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 06:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1721221783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 06:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569910816;
	bh=vXsqJvVNHhs9ZLzXUR1PZKtGxKt4GdylKtpsRhqclB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a5MtfSBCBtFHS5WmiV3JOjxpN4pjoLSYGz4MtIKHKt4thP0G2RbjDOChLVIbsiYlP
	 bO4hnsKZx5Q8mh4+jWuJG54ZQPOmffj1ahaanC74WmFgzOYXorN8F50YpF++iVw5HD
	 Q6mHknZHvWK6fWWNoRjiigR7rf4vmuGxtQxKn9yM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfJAGUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 02:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfJAGUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 02:20:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09DFE215EA;
        Tue,  1 Oct 2019 06:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569910814;
        bh=vXsqJvVNHhs9ZLzXUR1PZKtGxKt4GdylKtpsRhqclB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQhyxeiiM9kQZQeLrGdrnM24rMMNdsbUE2UcM9ci+O0iNNM4tFXO7YuERuYqwpWNu
         PaNP5Tn9aWuT2SyDKepYAi0F9iFiyiMos10IycVHhUqdOwFREFTLzqHjUdj/n6beYJ
         IzLjIQy04a+kfDv2LX1kxuFC3n8BoFBK9Xa5cVjc=
Date:   Tue, 1 Oct 2019 08:20:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Jiri Slaby <jslaby@suse.com>, speakup@linux-speakup.org,
        John Covici <covici@ccs.covici.com>,
        Chris Brannon <chris@the-brannons.com>
Subject: Re: [PATCH] staging: speakup: document sysfs attributes
Message-ID: <20191001062012.GA2836150@kroah.com>
References: <20190921102214.2983-1-okash.khawaja@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190921102214.2983-1-okash.khawaja@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 11:22:14AM +0100, Okash Khawaja wrote:
> Speakup exposes a set of sysfs attributes under
> /sys/accessibility/speakup/ for user-space to interact with and
> configure speakup's kernel modules. This patch describes those
> attributes. Some attributes either lack a description or contain
> incomplete description. They are marked wit TODO.
> 
> Authored-by: Gregory Nowak <greg@gregn.net>
> Submitted-by: Okash Khawaja <okash.khawaja@gmail.com>

I just realized by neither of these are valid signed-off-by lines, so I
can't take it :(

Please resend this and sign-off on it properly, as documented in the
kernel documentation files.

thanks,

greg k-h
