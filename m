Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83877C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8732070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575293814;
	bh=RlHLPhkhzXBxGTsWuazvDJndoSr34QpFVAq31nRUxkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rcJaktKAEyj7Th2oVaE8ZoBSojtDxXQxo9tCZ7EvUOXAX3u4XUtwJMs/EbJ7JUBUo
	 HKcdBHwFfEp9BDcMT3tHKMD95/0TIyDXYc45J9GKX7Ls1DaEMKP5KcKHvho4+rYlml
	 g5vPij4gqc5xxB2sY22CpGuV/E5mDyjzczZsb5oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfLBNgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfLBNgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:36:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68B92070B;
        Mon,  2 Dec 2019 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575293812;
        bh=RlHLPhkhzXBxGTsWuazvDJndoSr34QpFVAq31nRUxkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrpGjbqqar8bglo6gvTyBHiw6bT9eqan/THRhzA8vr2vYFGVkW5KLz+3szlGvOA7d
         OMxMfS4SnQhSIGyshNWJQYjCYNxkf0OrZMxUGyyIjnp6IblIc9X8NhHNOjHKdfbjUM
         kuDNSnF0RMgShXsMtnZK7DiGTXCNwhrh2bQJbusE=
Date:   Mon, 2 Dec 2019 14:36:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 5.4.1
Message-ID: <20191202133649.GA276195@kroah.com>
References: <20191201094246.GA3799322@kroah.com>
 <20191201193649.GA9163@debian>
 <20191202075848.GA3892895@kroah.com>
 <CAG=yYwn3nYn2CmV7BWOJdBWicYPuK2DwBgz6p=bDC9nWOt6vqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYwn3nYn2CmV7BWOJdBWicYPuK2DwBgz6p=bDC9nWOt6vqA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 06:32:30PM +0530, Jeffrin Thalakkottoor wrote:
> On Mon, Dec 2, 2019 at 1:28 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > You tested the performance of what?
> i tested the performance of  5.4.0 and 5.4.1

By running what specific test(s)?

thanks,

greg k-h
