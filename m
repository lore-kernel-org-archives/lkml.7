Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37336C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F306820B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564980150;
	bh=l8heV+yBr7W4zVRj4lEIIIi2/Clbco4UH053jKdIlVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nCJcP85mmNAdLzM7nCiW+ooC5EDlr25bw0XPCaF9sA3L9MRAose1s9je+W4xjwPck
	 kdG/8v6XB+ShD3jmb3iqSd0sXUztSHYzSdnSS6Tx+taZhWYFTEum+0cEkaugrWuSEt
	 vA01QNQpWvS+x1tZ0PMI0cr1IrfkBT9U6nPROaLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfHEEm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 00:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfHEEm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 00:42:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A902086D;
        Mon,  5 Aug 2019 04:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564980148;
        bh=l8heV+yBr7W4zVRj4lEIIIi2/Clbco4UH053jKdIlVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCa8+hFDCbW4J2P0sJ8WcHTEUECZxCS8PKeFRiqpvHeV7uGNdtpbM4iTJ9u7keYXl
         PhdICaSagJBt9sqR6rjXAfc2Lg8A91fW1/IuHRlmuIEIDC6qzTOHNvD08wIeSANvyc
         YLYnzQE0IoeN85gLXr48k6y6NIvsuMg2ddH8MW14=
Date:   Mon, 5 Aug 2019 06:42:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fernando Valle <phervalle@gmail.com>
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers:staging:isdn:hysdn brace same line if
Message-ID: <20190805044225.GA14087@kroah.com>
References: <20190802195105.27788-1-phervalle@gmail.com>
 <20190803063528.GC10186@kroah.com>
 <CACRBQB+wx3=3vQrvnxjcoiZaZjP7EOF+f0NYa4p-XKTHW79RiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRBQB+wx3=3vQrvnxjcoiZaZjP7EOF+f0NYa4p-XKTHW79RiA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Sun, Aug 04, 2019 at 10:04:40PM -0300, Fernando Valle wrote:
> Sorry Greg, it was my first submission.
> I followed the kernel newbies tutorial and some other found on the internet.

The best description of how to pick a subject line is in the section
entitled "The canonical patch format" in the kernel file,
Documentation/SubmittingPatches.  Please read that whole file as it
contains everything you need to know about writing good changelog texts
and everything else.

> So, the correct form of the subject would be -> "staging:isdn:hysdn open
> braces in correct location" !?

That's better than what you currently have, but I know you can do much
better than that :)

good luck!

greg k-h
