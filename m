Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF2BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32B720870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555415252;
	bh=k+CiCilHBlVW+ikanqU8gJdGu5/Z8oR06tein1fRjio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xcgrZ6vwMTUqXOd2T8MGsK37B8UcW/C76THyTVDHmYhnu6ccbF+yPq2z69Uu3gSaX
	 gAQDL7ShX/wqVHZpjbBsFiKGEr2IqjsurCmJ6Iux9B2ZyXQg7kmYHY9uT9oHMp1U/c
	 hkVBMOTV+xf0JIM8gaz5P1H225I9dYm9fls0yrDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfDPLrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:31 -0400
Received: from casper.infradead.org ([85.118.1.10]:58884 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbfDPLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m7ys/Ne1HhO/kvU1VCh2ZObtEJS5qve7R1i2J9k/ZJU=; b=Jq0qSmuE3SWe5uEbUlXyHfuKtH
        pBUt4se+XmV9ZdXTI12+X49lTp+inP9U9XFdU/ArvDA3i8Kq8+rRL5HX8SQmEE05aLIbIQVdoDW6r
        3dMF1WVvasODyPRRZaZRsH/N+2Kt+m1joJed8u0+83b+H4n9MLy1ztI/a1BtxJp7qERYCiYXGBk2s
        Lo0zvf4uxYjgVwNU7oNNKy5tgkrw8ZaUGOERpyLCbkTUc+QxLHlMd2uZ/HXq8w2iT4M71FBhSwgpz
        ntUMnm/QoR54pUHB55gQNAIgFDeQn+Go7GHThf+iASjd0H/y8upMS/ql1zOSKzQjyTV31xdUEj9VT
        SPocMp/g==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGMYe-0008Fj-TM; Tue, 16 Apr 2019 11:47:25 +0000
Date:   Tue, 16 Apr 2019 08:47:19 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 20/57] docs: livepatch: convert it to ReST format
Message-ID: <20190416084719.4284d31d@coco.lan>
In-Reply-To: <20190416084354.ol7umvh2lmii6jbk@pathway.suse.cz>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <f8eb5302d14147f5721cce816b1d3500184ce383.1555382110.git.mchehab+samsung@kernel.org>
        <20190416084354.ol7umvh2lmii6jbk@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 16 Apr 2019 10:43:54 +0200
Petr Mladek <pmladek@suse.com> escreveu:

> On Mon 2019-04-15 23:55:45, Mauro Carvalho Chehab wrote:
> > Convert livepatch documentation to ReST format. The changes
> > are mostly trivial, as the documents are already on a good
> > shape. Just a few markup changes are needed for Sphinx to
> > properly parse the docs.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Thanks a lot for the conversion. I tried html output and
> it looks very well.
> 
> Just a question. This patch does only the formatting.
> The documentation is not really generated because the file
> is not renamed to .rst. Also it is not referenced from
> any top level documents. Is it by intention?

Yes. The rationale is simple: renaming to .rst would require
to add them on an index file (or otherwise build would produce lots
of warnings). As this series is doing a lot of such conversions,
assuming that some of those patches will go through different
trees, that would cause lots of conflicts at the main index files.

So, it sounds better to apply the conversion first and then,
on a better moment (maybe late during the merge window), do the
rename and add to the index files.

> 
> 
> I am happy even for the conversion, so:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr



Thanks,
Mauro
