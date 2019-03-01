Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092902083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551456728;
	bh=eo6e6oCDe18KJj3hUQXvshdr9GCcwfwJGLK6PXFL984=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sxkWB7L9EISRsnWFvMg9b5KAdXpE14srMgBmswaYfhX/da/CyE8G5RXJFf3MrceHm
	 w0NPUTYhyBJQgLi3tliTtt/mo9rrONyHQahgnV1DvnAroomXR8M8RelM9OVLf2RJ7q
	 yutzECUTQJQDocK5x4CDi5M7fxfQ6w0LrOeaYqWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbfCAQMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:12:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbfCAQMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:12:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D89520857;
        Fri,  1 Mar 2019 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551456725;
        bh=eo6e6oCDe18KJj3hUQXvshdr9GCcwfwJGLK6PXFL984=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wm2nKp1lNI+JYDzL/jpaT9D3+1cI/idNfk2zbbT9Iy3wK5VE1qigS9b2tqkDdAsmC
         tQ/MMCcOsbuKeXMDz+Wy0PRndv/CRmQfltMQHMlfkUTnDowind91AA+BveNhRHsx7R
         KEh/3QG3qs3arWzqJS4rNShsuGBQkB3DQXhv016U=
Date:   Fri, 1 Mar 2019 17:12:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Olof Johansson <olof@lixom.net>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: habanalabs user-space thunk library available in GitHub
Message-ID: <20190301161203.GA19096@kroah.com>
References: <CAFCwf10UPHaBKhc7p1MrhhNAwZ3Jh3J3we2OPkGxPbAj+eaMRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10UPHaBKhc7p1MrhhNAwZ3Jh3J3we2OPkGxPbAj+eaMRQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 05:50:09PM +0200, Oded Gabbay wrote:
> Hi Greg and Olof,
> I wanted to let you know that I put the sources of our new userspace
> thunk library in GitHub, as we discussed a few weeks ago during the
> review of the driver.
> The link is: https://github.com/HabanaAI/hl-thunk

That is wonderful to see, thanks so much for doing this and posting the
link.

greg k-h
