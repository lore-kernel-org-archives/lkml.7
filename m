Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102D2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21702206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567716628;
	bh=BS5DK9GBdZOzJUMu/R6EbA8/+V27Y9jP64qS0hGDPkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZXkMXns2ScfnAIoz+/WJndPkK0Pf+L1HyOTfvU4lHhHHQ3/9LXPWnXVzaeu3AdajJ
	 OKogMp2BBYrh0n84rc9LF+3H2Q48egvq2hHLpwlgtAbFWtSuqkGxICwTAreAsiSXCv
	 WY8h90Dd58BXox7x5DZXbsXnppOXviltOtfR40uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404126AbfIEUu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404044AbfIEUuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:50:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09B26206CD;
        Thu,  5 Sep 2019 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567716620;
        bh=BS5DK9GBdZOzJUMu/R6EbA8/+V27Y9jP64qS0hGDPkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lD4VubIrzE/48xBJAIjwzyGN4/bKumoNZppPFl9EkYr/HPs0YWnFNdzjzwiVSxaLO
         ogOhUKz8KSUOa7rjxbP96XIWct20hXalZGL0GV8RNB4Iti7SBg10sD37aoAymGGG+L
         xkVPVVbW/uZhreNy2JttY/Bvku0g1sTv+R1ntWE4=
Date:   Thu, 5 Sep 2019 22:50:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.4
Message-ID: <20190905205017.GA25089@kroah.com>
References: <20190905121934.GA31853@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905121934.GA31853@ogabbay-VM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:19:34PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the pull request for habanalabs driver for kernel 5.4.
> 
> It contains one major change, the creation of an additional char device
> per PCI device. In addition, there are some small changes and
> improvements.
> 
> Please see the tag message for details on what this pull request contains.
> 
> Thanks,
> Oded
> 
> The following changes since commit 25ec8710d9c2cd4d0446ac60a72d388000d543e6:
> 
>   w1: add DS2501, DS2502, DS2505 EPROM device driver (2019-09-04 14:34:31 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-09-05

Is that a signed tag?  It doesn't seem to me like it is, have you always
sent unsigned tags?

thanks,

greg k-h
