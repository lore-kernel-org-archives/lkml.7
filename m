Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C3C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7185D214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555583213;
	bh=IqtCNhrWuYi29RyPn/i3oVF+AOyq3uFtTixaxFEnnew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jdjoxIs2hNfHsrHh4DX6eNnL4rnmouYvOWnK11IGqryx44ukN70aIV2O0QZyyyTRy
	 Vn/47UVSYH/fH7KKThZDLTq6kbwjWHX9ePwdKMTSLwiwatiVvoN9XEc+Y7eK6Tx7Q4
	 VGhTZGEE2V5MWm4ImmUZWso+i8UpJWSPr/57Oo/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbfDRK0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:26:52 -0400
Received: from casper.infradead.org ([85.118.1.10]:39332 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbfDRK0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qu+RzLTb64gsY5utEH0wiBrIlnmTtCM+eDP/PfoTHTA=; b=pi7FqQSjJTaxGx0eb5RA96F/MY
        NECzp1nCqptmqU4+6LWZYtXIvGIxoxPIMPYi2OOftq7HW6+i+/11uHEHu5prXvdgDClzcNHKqOudD
        SErzc7e1cOYOHx1r/74J2sOS7iaP9qm36eTdrOOJ7+maVDCzxCJqRbP/0COJ+RInWOFMFINDT1H4h
        0TI7sO3RH6RhnhPTF9cyXt/8TLvbaB+mbw2+S4x0EJ/rVnp7CgLnoQ18O98pYVVpfvni9wpIlZhJm
        BMYz/Uo6gdbMdx4h3WHyRGpe30Z7A+DWQDToO8EzaXd+smsuMxHvH0g4oHrDVWbnK9zM4SYQSC5Bm
        H0yyZCDg==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH4Fj-0004dU-FY; Thu, 18 Apr 2019 10:26:47 +0000
Date:   Thu, 18 Apr 2019 07:26:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 18/57] docs: kbuild: convert it to ReST output
Message-ID: <20190418072626.3727c56a@coco.lan>
In-Reply-To: <CAK7LNAQUGkW=Mnz-EtUkm=7uBpGLZNgO+3MUTmkWOggo+_eHjw@mail.gmail.com>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <5cfeb21a8841c1e029e8396bdaa7cd55ac0b08a2.1555382110.git.mchehab+samsung@kernel.org>
        <CAK7LNAQUGkW=Mnz-EtUkm=7uBpGLZNgO+3MUTmkWOggo+_eHjw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 18 Apr 2019 18:25:45 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> escreveu:

> On Tue, Apr 16, 2019 at 12:01 PM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > The kbuild documentation clearly shows that the documents
> > there are written at different times: some use markdown,
> > some use their own peculiar logic to split sections.
> >
> > Convert everything to ReST without affecting too much
> > the author's style and avoiding adding uneeded markups.  
> 
> Sorry for my ignorance, but shouldn't ReST use
> the extension '.rst' instead of '.txt' ?

Yes. I have a patch with the rename step, but the problem is that doing
such renames on 57 different subdirs and then adding all of them to the
existing index.rst files (in order to add into a bookset) would cause
huge merge conflicts - and keeping them renamed without adding into
an index would cause a *lot* new warnings when building them.

So, IMO, the best would be to have the fixup stuff merged first, and
then do the renames/merges at once, after subsystem maintainers
pick the patches from this rst fixup series.

If you want to see the renaming patch, it is at:
	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=all_with_indexes-v3&id=9cfeb3eb6d48d1aeff9d2ddd84880ab1dc782b00

(I'll probably split it later into per-subdir renames)

The results of this patch, plus the rename one, is at:

	https://www.infradead.org/~mchehab/rst_conversion/kbuild/index.html

> 
> 
> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/kbuild/headers_install.txt      |   5 +-
> >  Documentation/kbuild/kbuild.txt               | 119 ++--
> >  Documentation/kbuild/kconfig-language.txt     | 232 ++++----
> >  .../kbuild/kconfig-macro-language.txt         |  37 +-
> >  Documentation/kbuild/kconfig.txt              | 136 +++--
> >  Documentation/kbuild/makefiles.txt            | 518 +++++++++++-------
> >  Documentation/kbuild/modules.txt              | 166 +++---
> >  7 files changed, 720 insertions(+), 493 deletions(-)
> >  
> 



Thanks,
Mauro
