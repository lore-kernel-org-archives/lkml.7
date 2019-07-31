Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8606BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFA52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564604545;
	bh=KPMWNIufb9bcKEwRHge6H1l+IJBy6fkHHcMascSqXbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GCv06zTfowLJTo4kMtAO3ujxBOsifdwaYY502C7enuhyGrQg+Wgi15/FW35j94Y6r
	 nwnKyVm8UYTa0oOO+WBt5d9ILaiZ0W3wM6XXycmI3boMNKr3BcS9soYUiuHlNhajzs
	 fFonlyE5kvHNCMLZcPT/0KrKyupFNIzylGUijROg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfGaUWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:22:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfGaUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8T3oN0ay0ADCvgHkGALYwHuH3kC20Zzu6Hu9EAzOso0=; b=tQET+ncriJIfJ3qECd3FP3DB7
        f1K9NE6SaKEtYb3U6XYUTwzTuwx/9/SrvpNAor2RcpO+4KWehM3PLWk5COhYu0Ha1mdugho8R1I0C
        GgTNMK3ek55qdqLAbREUagc3LZCdrmmu8jQECKWB6oyaUc0x1YIC7LbTTbFeNk+VqxIsrYsxY2Ntm
        d9wqGiEEGyL8ft8J4TKYugtG3XDLKXdKy0J6Xdsk+iY4EK0hv/xBHs5ufFcDA52xK1z/CdtR3z6Xp
        9yj90nqPFUbtuoB/eFLeMZA28CCxi2nUMmQK98e1pc1HWIUq2tR5gcg9hVzAmdfrVWwkx6zSTz/YZ
        Sykb1HzHw==;
Received: from [191.33.152.89] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsv79-0006JS-Hc; Wed, 31 Jul 2019 20:22:23 +0000
Date:   Wed, 31 Jul 2019 17:22:19 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] docs: fs: convert porting to ReST
Message-ID: <20190731172219.2f07d420@coco.lan>
In-Reply-To: <20190731141707.6f3d21d7@lwn.net>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
        <a2303fe9fa2103e7d1f8589e1f91a7d65497e8b7.1564603513.git.mchehab+samsung@kernel.org>
        <20190731141707.6f3d21d7@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 31 Jul 2019 14:17:07 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 31 Jul 2019 17:08:52 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > This file has its own proper style, except that, after a while,
> > the coding style gets violated and whitespaces are placed on
> > different ways.
> > 
> > As Sphinx and ReST are very sentitive to whitespace differences,
> > I had to opt if each entry after required/mandatory/... fields
> > should start with zero spaces or with a tab. I opted to start them
> > all from the zero position, in order to avoid needing to break lines
> > with more than 80 columns, with would make harder for review.
> > 
> > Most of the other changes at porting.rst were made to use an unified
> > notation with works nice as a text file while also produce a good html
> > output after being parsed.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/filesystems/porting.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> > index 66aa521e6376..f18506083ced 100644
> > --- a/Documentation/filesystems/porting.rst
> > +++ b/Documentation/filesystems/porting.rst
> > @@ -158,7 +158,7 @@ Callers of notify_change() need ->i_mutex now.
> >  New super_block field ``struct export_operations *s_export_op`` for
> >  explicit support for exporting, e.g. via NFS.  The structure is fully
> >  documented at its declaration in include/linux/fs.h, and in
> > -Documentation/filesystems/nfs/Exporting.
> > +Documentation/filesystems/nfs/exporting.rst.
> >  
> >  Briefly it allows for the definition of decode_fh and encode_fh operations
> >  to encode and decode filehandles, and allows the filesystem to use  
> 
> This patch doesn't match the changelog at all.  I think it's one leftover
> fix after the previous version of the patch was applied...?

Gah, sorry. Yeah, you're right: this is just a fixup patch.

> 
> jon



Thanks,
Mauro
