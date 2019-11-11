Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA599C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BC72184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573482445;
	bh=z2p9D2FRii79yLy//fxI2k2wIJ3plgcObQVSeUtVZ/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IFNt7hAHtjMAlw0UvqJXPPfre+qY4zE0yq5aygbE5jal95Aniyls5wam9Ufg/ega5
	 9GmU4ReLNFYrx2Q82Es64nZAyN0GtrpZ2Mr2fH9mC7lQlZxho8PWNYBLH5DbocmoOr
	 lhdBRRnanqkASaAHqxO4X1Tef1c9Yf2xV/SFBpH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKKO1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:27:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfKKO1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:27:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13D921783;
        Mon, 11 Nov 2019 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573482443;
        bh=z2p9D2FRii79yLy//fxI2k2wIJ3plgcObQVSeUtVZ/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yg8AZDRfQU7SPDLCD5AGI1+uGxA2he9z3yK5+zTQ2hf3qnIBSUyawbrNiTBbDLvFj
         knWQBHKv4n7WthkDz3UhQFW5TS5kiOI6TuXT5puJuaFKtVjM/N9gWnVnrg9FoPyqSH
         Q5OZ7mLF8Hri89kptl4bmkKQM0BYYxlFY7Shkenc=
Date:   Mon, 11 Nov 2019 15:27:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cheng Chao <cs.os.kernel@gmail.com>
Cc:     jslaby@suse.com, nico@fluxnic.net, textshell@uchuujin.de,
        sam@ravnborg.org, daniel.vetter@ffwll.ch, mpatocka@redhat.com,
        ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: fill console_driver->driver_name
Message-ID: <20191111142720.GA587381@kroah.com>
References: <1573089948-5944-1-git-send-email-cs.os.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573089948-5944-1-git-send-email-cs.os.kernel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:25:48AM +0800, Cheng Chao wrote:
> cat /proc/tty/drivers
> ...
> unknown              /dev/tty        4 1-63 console
> 
> ----------------------------------
> after this patch:
> 
> cat /proc/tty/drivers
> ...
> console              /dev/tty        4 1-63 console

What is going to break with this change?  It's a user visable thing, why
does it need to be changed?

thanks,

greg k-h
