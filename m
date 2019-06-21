Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4CCC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA02E2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561140954;
	bh=m/351uf6f+xII+VVUN2ikTwwino/yqG6h04qzv8XvNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dpHvtWv5SSbzyTcEk5kWOwtf1c3qvuVFrJ33RCKg6+1A28eGA70lwZOzreN7aIz01
	 2WEbgP9LIRc1lv525I6s4z95J3pS5mT/Ma8Ix/LnT8uxe5ZN6Zu3XGnaJda63QLTPZ
	 1sJ7DqkyPExaj+a4gFo9npx9G77k50MbM6Yf8nYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFUSPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:15:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfFUSPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f2eFDUHxfpk3L5xJF7JT/XdkW1wgZp9A0zgcFsNmNKc=; b=harH6TPsjRc+zwJ3ZFspzNKAX
        sjb+vCO7wAzsaAg1gmsBs9unAc0ySDHWTA6VS0V58/wp6+fc9PtN1AP7KX+0BmSFlQTGiJMW3dunW
        OoHtSV9eFcvDbEoR/HRHyVnWXwp46aPaUBqflrsCvUwbsurlY9o0j3u6MMXP5MLBdZe9pGqv1FuUh
        1n4gEkxRDguwJ+wka8Eq8zd+Ro4XaQiF/4APVz0HMVntfL1PZ+RlFV/wUFDA8YvKHf74ncmJw7d0v
        CpucNXp/FfRSMdQPuHxHhMjzxcwSjPiYl83D0oaGaTpcrWMcuGQqRBw44u0OvRqccSBD4jkCA0NXK
        AflaE09Mw==;
Received: from [177.97.20.138] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heO4m-0002tw-Pn; Fri, 21 Jun 2019 18:15:53 +0000
Date:   Fri, 21 Jun 2019 15:15:48 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 00/22] Add ABI and features docs to the Kernel
 documentation
Message-ID: <20190621151548.074d9d60@coco.lan>
In-Reply-To: <20190621150445.GA11015@kroah.com>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
        <20190621150445.GA11015@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 21 Jun 2019 17:04:45 +0200
Greg KH <greg@kroah.com> escreveu:

> On Thu, Jun 20, 2019 at 02:22:52PM -0300, Mauro Carvalho Chehab wrote:
> > This is a rebased version of the scripts with parse
> > Documentation/ABI and Documentation/feature files
> > and produce a ReST output. Those scripts are added to the
> > Kernel building system, in order to output their contents
> > inside the Kernel documentation.
> > 
> > Please notice that, as discussed, I added support at get_abi.pl
> > to handle ABI files as if they're compatible with ReST. Right
> > now, this feature can't be enabled for normal builds, as it will
> > cause Sphinx crashes. After getting the offending ABI files fixed,
> > a single line change will be enough to make it default.
> > 
> > a version "0" was sent back on 2017.  
> 
> Ok, I added the first chunk of these patches to my tree, that add the
> get_abi.pl file to the tree.  I didn't touch the others that touched the
> documentation build or other scripts just yet, as I wanted to get others
> to agree with them before accepting them.
> 
> Or we can just wait until after 5.3-rc1 is out and then the rest can go
> through the documentation tree.

Ok.

Whatever works best for you and Jon.

I'm keeping a tree with the remaining patches on the top of
driver-core-next at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v4.2

I'll rebase it on the top of yours as new patches get merged there, or if
I develop more patches related to it (I may try to fix the ReST issues with
the files at ABI/testing if I have some spare time).

Note that it contains the RFC patches for parsing ABI files as-is,
with ReST markups on them, if needed.

If you want to pick the hole thing including the RFC ones, there's one patch 
there with probably needs to be either split and/or submitted to ABI file authors:

	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=abi_patches_v4.2&id=58f73907d21f1c93038196c42dab65be969f4104

Thanks,
Mauro
