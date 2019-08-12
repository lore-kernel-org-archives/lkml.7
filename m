Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2927C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7794A206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfHLSAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:00:31 -0400
Received: from verein.lst.de ([213.95.11.211]:50207 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfHLSAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:00:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 53B5E68B20; Mon, 12 Aug 2019 20:00:27 +0200 (CEST)
Date:   Mon, 12 Aug 2019 20:00:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: can we use mandatory-y for non-uapi headers?
Message-ID: <20190812180026.GA15574@lst.de>
References: <20190810075226.GA24085@lst.de> <CAK7LNAQfQWNMMLS1-3mE41Ffy3MV9i3VpbWtmKQdUqZjyk8Yqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQfQWNMMLS1-3mE41Ffy3MV9i3VpbWtmKQdUqZjyk8Yqg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:41:20AM +0900, Masahiro Yamada wrote:
> > what is the reason that the documentation says mandatory-y should only
> > be used for uapi headers?
> 
> Where is it documented?
> 
> Documentation/kbuild/makefiles.rst section 7.4 describes
> mandatory-y is essentially used by include/(uapi/)asm-generic/Kbuild
> 
> include/(uapi/)asm-generic/Kbuild means:
> 
> include/uapi/asm-generic/Kbuild
> include/asm-generic/Kbuild

Ok, maybe it was just me misreading the documentation.  In that
case I'll start submitting patches to use it more.
