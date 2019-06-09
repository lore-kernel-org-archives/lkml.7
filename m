Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995E1C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E00C208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560083394;
	bh=V2I7JzBy6GpkLeFVFEd49U4hCJqclC8mWxGbOiPSGro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wPVznzbPzlK/HuShJoKXkrV5l0LqbGQy4EJRUzfYGpkWkSLIPj8lh7rdI/N/+0GLO
	 rUe3hUV94UMDOOgERtRVVtQBo07hESVjYqrfS07TNoRnM35ycweph68nNHcmM0+PnP
	 Q85rN1MhiQOHsp3k7N5lv7QVvM9EisQnReIjrnZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfFIM3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:29:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFIM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IuqsoxISFrOZKKS3BhELU3uFgb2g53uAyNxYwZgCHEU=; b=DyEjWJ7vQLo8VkwXgyJHdBfxK
        GXjBapuN3ZK4cyYsNPgwtUt1PuGj2p1y4RKHqrLUVRgytFyHZPaeutkBpamadM5HQ2WZbx+0w0eBT
        hP1ZPe18WIxTRmIr7mzU6BkDpUDmqKwWWHXDMGhJn29QS+iAa5SRaoVvxOIsEg2gYqhhtGmA12xcI
        3zsWJF7ZJ5C8SGXK2oQOuJrUQMFxQEqomlUY/lV8HR3Hb/1GoZ2NRafLYwtlBlj4QMywNtmHRvBoG
        SK4ufeZwOR6U8cJAB8e51GrzYN93/+3zpxzJIANm0n5cAqgkmLQLuv/KIsysCMJwlFNegGmuTOcn8
        3H35bjE5A==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=recife.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZwxI-0002Wx-RD; Sun, 09 Jun 2019 12:29:49 +0000
Date:   Sun, 9 Jun 2019 09:29:40 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Convert files to ReST - part 1
Message-ID: <20190609092940.5e34e3b0@recife.lan>
In-Reply-To: <20190609091642.GA3705@osiris>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
        <20190609091642.GA3705@osiris>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 9 Jun 2019 11:16:43 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> escreveu:

> On Sat, Jun 08, 2019 at 11:26:50PM -0300, Mauro Carvalho Chehab wrote:
> > This is the first part of a series I wrote sometime ago where I manually
> > convert lots of files to be properly parsed by Sphinx as ReST files.
> > 
> > As it touches on lot of stuff, this series is based on today's docs-next
> > + linux-next, at tag next-20190607.
> > 
> > I have right now about 85 patches with this undergoing work. That's
> > because I opted to do ~1 patch per converted directory.
> > 
> > That sounds too much to be send on a single round. So, I'm opting to split
> > it on 3 parts. Those patches should probably be good to be merged
> > either by subsystem maintainers or via the docs tree.
> > 
> > I opted to mark new files not included yet to the main index.rst (directly or
> > indirectly ) with the :orphan: tag, in order to avoid adding warnings to the
> > build system. This should be removed after we find a "home" for all
> > the converted files within the new document tree arrangement.
> > 
> > Both this series and  the next parts are on my devel git tree,
> > at:
> > 
> > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=convert_rst_renames_v4
> > 
> > The final output in html (after all patches I currently have, including 
> > the upcoming series) can be seen at:
> > 
> > 	https://www.infradead.org/~mchehab/rst_conversion/  
> 
> Will there be a web page (e.g. kernel.org), which contains always the
> latest upstream version?

Yes:

	https://www.kernel.org/doc/html/latest/

I guess this one is based on Linus tree.

Jon also maintains a version at:

	https://static.lwn.net/kerneldoc/

I guess that one is based on docs-next branch from the Docs tree.

Btw, if you want to build it for yourself, you could use:

	make htmldocs

If your system doesn't have all dependencies, it will give the
hints about how to install them.

> 
> >   docs: Debugging390.txt: convert table to ascii artwork
> >   docs: s390: convert docs to ReST and rename to *.rst
> >   s390: include/asm/debug.h add kerneldoc markups  
> 
> I can pick these up for s390. Or do you want to send the whole series
> in one go upstream?

Yeah, feel free to pick them via the s390 tree.

Regards,
Mauro

Thanks,
Mauro


Thanks,
Mauro
