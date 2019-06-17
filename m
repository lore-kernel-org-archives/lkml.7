Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD45C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9736F2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfFQNsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:48:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:42882 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQNsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:48:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 13F10300;
        Mon, 17 Jun 2019 13:48:32 +0000 (UTC)
Date:   Mon, 17 Jun 2019 07:48:29 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
Message-ID: <20190617074829.70cbaa48@lwn.net>
In-Reply-To: <20190617125438.GA18554@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
        <87o930uvur.fsf@intel.com>
        <20190614140603.GB7234@kroah.com>
        <20190614122755.1c7b4898@coco.lan>
        <874l4ov16m.fsf@intel.com>
        <20190617125438.GA18554@kroah.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 14:54:38 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > I think it's just sad to see the documentation system slowly drift
> > further away from the ideals we had, and towards the old ways we worked
> > so hard to fix.  
> 
> What are those ideals?
> 
> I thought the goal was to be able to write documentation in a as much
> as a normal text file as possible and have automation turn those files
> into "pretty" documentation that we can all use.

That was indeed one of the goals.  Another was to replace the incredible
pile of fragile duct tape that the docs build system had become with
something more robust, understandable, and maintainable.  We did that, to
an extent at least, and life is better.

Jani worries that we have been regressing toward duct-tape mode, and I
suspect he may be right.  I'm certainly as guilty as anybody of tossing
stuff in because it's expedient right now.  It is right to ask whether we
should continue in that direction.

Can we slow down just a bit on the ABI files?  It may be that Mauro's
solution is the best one, but I would really like to think a bit about
how all this stuff fits together, and life isn't really even giving me
time to tie my shoes these days.  I don't think that this is screamingly
urgent right now.

Thanks,

jon
