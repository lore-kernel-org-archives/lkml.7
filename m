Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B43C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF03217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558484779;
	bh=/Ze/r6k0Va3DEQw57MSfHRQ4omuKUg9R39vq8U8ACE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=N/ERfx94b/eyk2Lq2AydFb46neOLPXdn8TvxBCBlkOGIc3NKqbJc5fys+70xJKuAJ
	 NVFB6Hr1R7QzHbrLVV6tcIzpttLk91WPdIAbd1VQusTGqgcD5yCm1AQZ+i5jWHU4nE
	 N4rru6qSZVuq18Hw1Ifk9/NkQjlc6siNXhIsy1Ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfEVA0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:26:18 -0400
Received: from casper.infradead.org ([85.118.1.10]:48806 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEVA0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nmrlh7dsx/2/wVkH8Y7tX3TxMB04kEyN0EjxQinsvHU=; b=oZcvfj9Levzm+W/xpO0S+jN6uF
        WagOl2yhRkk149vA/C9+BGlOVshg4jimr5wpZUv0GTgM2xK/raj4evaCKSVxgSlep8s1ta1hmygP2
        VMzSHJxMd4bUJvGQzi4ghv1NZyLBH18HrbxZFLhPe1EEjm3rxQh+0HWWUGZBkYk+H0qRjmu70jhM/
        GZHyC/OKW+mGbsKQKDcAQHHN9/IOEUun+s1iXSC0qC/uxi1t6eZCm84OGzV0KbcX/Z8aMS5Ysz+nD
        DcK3IYi+O4dG3Fu8Ql/ozGygUO/vwiSmM2PIWc+6CJMsdO7BCsX0leAjbnutUzEhsoFPexJUYLhFM
        KbhU46zA==;
Received: from [179.182.168.126] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTF56-0006uP-QQ; Wed, 22 May 2019 00:26:09 +0000
Date:   Tue, 21 May 2019 21:26:00 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 00/10] Fix broken documentation references at v5.2-rc1
Message-ID: <20190521212600.39bc341c@coco.lan>
In-Reply-To: <51951662.QppCrsbGrr@harkonnen>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
        <51951662.QppCrsbGrr@harkonnen>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederico,

Em Wed, 22 May 2019 00:54:48 +0200
Federico Vaga <federico.vaga@vaga.pv.it> escreveu:

> On Monday, May 20, 2019 4:47:29 PM CEST Mauro Carvalho Chehab wrote:
> > There are several broken Documentation/* references within the Kernel
> > tree. There are some reasons for several of them:
> > 
> > 1. The acpi and x86 documentation files were renamed, but the
> >    references weren't updated;
> > 2. The DT files have been converted to JSON format, causing them
> >    to be renamed;
> > 3. Translated files point to future translation work still pending merge
> >    or require some action from someone that it is fluent at the
> >    translated language;  
> 
> Hi Mauro

My main goal with this patchset is to get as close as possible to zero
warnings, as this helps me on rebasing a documentation patch series
I wrote with renames hundreds of file from .txt to .rst.

In the case of (3), the scripts/documentation-file-ref-check was unable to
find some files pointed by Italian and Chinese translations. So, after
this series, it will keep pointing for broken links there.

> I am not sure to get what you mean in terms of actions but I think you are 
> referring to the "empty" files I added in the Italian translations. I added 
> those files to avoid broken links; the alternative would have been to not 
> write those links or to point directly to the main document, but in both 
> cases it easy to forget to update them later.
> I chose to have links to "empty" files so that the document does 
> not need to be updated later.
> 
> If you are not referring to those files than I am not understanding, can you 
> point to a clear example?

What I meant is that I can barely read Italian and have no glue on
Chinese. So, I can't really address those properly :-)
So, basically, it should be up to someone else fluent on such
languages to address those.

Btw, I understand why you pointed to some non-existing files: 
translating the Kernel's documents takes a lot of time[1].

[1] If I was doing a translation, I would probably have opted to keep 
pointing to the English doc and have a script to point me links to
non-translated docs, but your way also works. The only drawback is that
the script will keep pinpointing to translations with broken links,
while the translation is not complete.

Thanks,
Mauro
