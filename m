Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605DBC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAE72080C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfFQN5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:57:18 -0400
Received: from ms.lwn.net ([45.79.88.28]:42952 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQN5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:57:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A0DDC891;
        Mon, 17 Jun 2019 13:57:16 +0000 (UTC)
Date:   Mon, 17 Jun 2019 07:56:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] docs: sphinx/kernel_abi.py: fix UTF-8 support
Message-ID: <20190617075608.696cf037@lwn.net>
In-Reply-To: <20190617061659.22596fc3@coco.lan>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <62c8ffe86df40c90299e80619a1cb5d50971c2c6.1560477540.git.mchehab+samsung@kernel.org>
        <20190614161837.GA25206@kroah.com>
        <20190614132530.7a013757@coco.lan>
        <28aca947-4e88-7186-7f07-9a3ccb379649@darmarit.de>
        <20190617061659.22596fc3@coco.lan>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 06:16:59 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> > No need to change, the emacs notation is also OK, see your link
> > 
> >    """or (using formats recognized by popular editors):"""
> > 
> >    https://www.python.org/dev/peps/pep-0263/#defining-the-encoding
> > 
> > I prefer emacs notation, this is also evaluated by many other editors / tools.  
> 
> The usage of emacs notation is something that we don't like at the
> Linux Kernel. With ~4K developers per release, if we add tags to
> every single editor people use, it would be really messy, as one
> developer would be adding a tag and the next one replacing it by its
> some other favorite editor's tag.

So "we" like a language-specific notation instead?  That seems a little
strange to me.  Lots of things understand the Emacs notation, it doesn't
seem like something that needs to be actively avoided here.

Thanks,

jon
