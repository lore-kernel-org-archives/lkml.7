Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794F3C46460
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B694206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556899854;
	bh=IHAD1xkHOGtFOzVEp9fxb0mJPCYNZhC4tbr+OPKAX9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H6+pW1nOzFk3K2czF9m7wqPRZciaqRsEckwywaXLeHQf7iRkOuVjY9ROlmC89+lrY
	 u/d9De7p7Ht9J8hHHiQZa+ogzrJCZEG0zOZ3eWQGrpWSaVhlaSqqZYeEhFX7oTEl7T
	 mAGuQ7pzng6j2XCAeaclx9gJ/oiulYKVMC7k4xY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfECQKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfECQKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:10:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54A920651;
        Fri,  3 May 2019 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556899852;
        bh=IHAD1xkHOGtFOzVEp9fxb0mJPCYNZhC4tbr+OPKAX9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOb3GdpG+6i+sMdwWfccrbzNf9OGSU91S0dzpyTDqZTo0XsFq+AjGbWVpdRr/3XoX
         Ou2/hfVFeCq+Lwl3vswfE9hMtkhxuN+AME9hm4KXO7gsBNfU7vzkNEiFxTBBplLh7h
         q3ecOly9zxd/ue3+LR/bVnmNU46PiUk3qe9uAH9I=
Date:   Fri, 3 May 2019 18:10:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] GNSS updates for 5.2-rc1
Message-ID: <20190503161041.GA654@kroah.com>
References: <20190503155805.GA12685@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503155805.GA12685@localhost>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 05:58:05PM +0200, Johan Hovold wrote:
> The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:
> 
>   Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-5.2-rc1

Now pulled and pushed out, thanks.

greg k-h
