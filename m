Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AD6C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB2920657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552200727;
	bh=0VhJOFdoBohE11C5kjwwTObTQqV5EAS6VglQkxUU3DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xQnnysyICrMpycDXhQFJDIw63eeDo3/jDAbFkt1Yk8/9W9cjwfxNUmFLZ9R0UbQNf
	 Bw0so02tzqfqaIOo0f/N+jQn7cJU8JLseYxDXId4pfJEIHMXaqd27X79ftAYf2YDKY
	 qgW9PG+dIH4tDhejCpETAzfXIScRJlSqt674SO40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCJGwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 01:52:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfCJGwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 01:52:05 -0500
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACC0A20657;
        Sun, 10 Mar 2019 06:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552200725;
        bh=0VhJOFdoBohE11C5kjwwTObTQqV5EAS6VglQkxUU3DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTPVWuehyoMVpT6omTOvQW9tY76DwsAAH3VtmBCysDn6z8lEyjUilcsPoPioL9Ak9
         B+YXQpPgI8g81Xac5575H9O1MM8cxnToDAOr8fw7n54PtFd+tAJrCipZORnsW0Cscc
         zEYmUFIZYDt2+NxuU4WIC4Bz7p+9cI4AIdL1qPXk=
Date:   Sun, 10 Mar 2019 07:52:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 5.0.1
Message-ID: <20190310065203.GB24816@kroah.com>
References: <20190310065110.GA24816@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310065110.GA24816@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 07:51:10AM +0100, Greg KH wrote:
> I'm announcing the release of the 5.0.1 kernel.
> 
> All users of the 5.0.1 kernel series must upgrade.
> 
> The updated 5.0.1.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.0.1.y
> and can be browsed at the normal kernel.org git web browser:
> 	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
> ------------
> 
>  Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ugh, something went obviously wrong here with my scripts, that's not
good...

greg k-h
