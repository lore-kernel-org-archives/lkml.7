Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A16C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 15:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9955C206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560009328;
	bh=nh6TdIhR5A7AsbyvajbHEcCEd+tJlehSFbCYV0YCs+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TiXLUuFgoGh44/LtiKD4TUaFeAHWStUw+o5Pr7ytyxiKF9GD8oBn5b6auoGbYwzH6
	 5JRdQuqRzwE889Pops0jjNPKSiauPkbjOG5KXbJj2m9ONDO7mZBayiGCb4/xWKBcIl
	 HmkXiUuS0FgLXq7EOIhHGXFpLVMoRxIcq0THbsTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfFHPz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 11:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfFHPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 11:55:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85252206BB;
        Sat,  8 Jun 2019 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560009327;
        bh=nh6TdIhR5A7AsbyvajbHEcCEd+tJlehSFbCYV0YCs+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvBVATR4R46czxUuX+2jZf3IGqL7gYwHqRfRGcZ6CB0xvN85wYVxvNoaEbeOZQKVx
         k7pSDFqDP5C8GFlToBYGSpE3UbPs+/Ic9klzQHxZ0KLLnwxjRr8k3ByO+DFNI5R9fD
         98NJ3GFNYdfqowQUufPz3wHCJNhhaPkT4KswRtF0=
Date:   Sat, 8 Jun 2019 17:55:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Soonwoo Hong <qpseh2m7@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix coding style
Message-ID: <20190608155524.GD7974@kroah.com>
References: <20190608134728.4655-1-qpseh2m7@gmail.com>
 <20190608155446.GC7974@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608155446.GC7974@kroah.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 05:54:46PM +0200, Greg KH wrote:
> On Sat, Jun 08, 2019 at 10:47:28PM +0900, Soonwoo Hong wrote:
> > Add a space before colon in ternary operator
> > 
> > Singed-off-by: Soonwoo Hong <qpseh2m7@gmail.com>
> > ---
> >  block/blk-mq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> $ ./scripts/get_maintainer.pl --file block/blk-mq.c
> Jens Axboe <axboe@kernel.dk> (maintainer:BLOCK LAYER)
> linux-block@vger.kernel.org (open list:BLOCK LAYER)
> linux-kernel@vger.kernel.org (open list)
> 

Also, doing coding style cleanups outside of drivers/staging/ is a tough
thing to do, please don't make it harder on yourself...

good luck!

greg k-h
