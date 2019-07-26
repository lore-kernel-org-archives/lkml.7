Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA8C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DF422BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564174876;
	bh=cWHYm/JDDPt4tdJDlt7DOV6ctRnogE6kecA/B5xrvQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FzqXCHsYx0YO8udFP8kP05wW0vyjviqFkYMyxtWsOdDvw5rGZpS0+TfSQnzqX5nHD
	 5/StH4n2Qv4BO2XsQho8It/85hape33xUi8wIMuoi8K7E/xLh80eroN2UNXv01w69f
	 ObcHszlieUmxEmqWU055URiS1ipqF9/SxANHghz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfGZVBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:01:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfGZVBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aNoL2vQ7lvohfRAa2Mq89OMQ1NUC1ac/81Wd7wPLWjk=; b=elyNl1IaSwQ1L/rwEV/SzDqoW
        71SAjz/QVlzTH+LYWo4ZcF+lQ4FH63ESYwzRguY/i1omXuBRkMED2LDdVEC24I2linQ7KWiXR5yDG
        K+4SforvylszlcN/3WBZk3t3JjSYxXt1VhtPE9jrQJfL1+6hqMJz2S5QxvZGXtHUhYGUNIE8QL86s
        c9767oPdohCa/qOGF09OjNfrloAULnvhjVuWMmzrr26aSfYQaGgEwR5w8ApJ4kDIa27+XhlaLCct5
        hO56R5+SDvuHHw6pQuhNoO9MwT3qwGozmR2w80MHz/NiWfEcx+xIouDj5CGRIAk7uQwEgLXMyk1XF
        dztEgrj4g==;
Received: from [179.95.31.157] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr7Kz-000662-K2; Fri, 26 Jul 2019 21:01:13 +0000
Date:   Fri, 26 Jul 2019 18:01:09 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?xYF1a2Fzeg==?= Stelmach <l.stelmach@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/7] Fix broken references to files under
 Documentation/*
Message-ID: <20190726180109.56d1db35@coco.lan>
In-Reply-To: <57eaa99a-d644-7b79-7177-a45d3ef1e71a@wdc.com>
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
        <04794d40-0b39-0223-c91e-03b46cb6e2db@wdc.com>
        <20190726171352.5eaa4d83@coco.lan>
        <57eaa99a-d644-7b79-7177-a45d3ef1e71a@wdc.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Jul 2019 13:18:30 -0700
Atish Patra <atish.patra@wdc.com> escreveu:

> On 7/26/19 1:14 PM, Mauro Carvalho Chehab wrote:
> > Em Fri, 26 Jul 2019 12:55:36 -0700
> > Atish Patra <atish.patra@wdc.com> escreveu:
> >   
> >> On 7/26/19 4:47 AM, Mauro Carvalho Chehab wrote:  
> >>> Solves most of the pending broken references upstream, except for two of
> >>> them:
> >>>
> >>> 	$ ./scripts/documentation-file-ref-check
> >>> 	Documentation/riscv/boot-image-header.txt: Documentation/riscv/booting.txt
> >>> 	MAINTAINERS: Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
> >>>
> >>> As written at boot-image-header.txt, it is waiting for the addition of
> >>> a future file:
> >>>
> >>> 	"The complete booting guide will be available at
> >>> 	  Documentation/riscv/booting.txt."
> >>>      
> >>
> >> Yeah. We don't have complete booting guide defined in RISC-V land.
> >> Documentation/riscv/booting.txt will be available once we have that.
> >>
> >> In the mean time, do we need to convert boot-image-header.txt to
> >> boot-image-header.rst and fix the reference to
> >> Documentation/riscv/booting.rst as well ?  
> > 
> > Well, in the mean time, every time someone builds the Kernel with
> > COMPILE_TEST enabled, a warning will be produced.
> > 
> > So, my suggestion would be to write it on a different way, like:
> > 
> > 	"A complete booting guide is being written and should be
> > 	 available on future versions."
> > 
> > Or:
> > 	TODO:
> > 	   Write a complete booting guide.
> > 
> > And update this once the guide is finished. This should be enough
> > to prevent the warning.
> >   
> 
> Sounds good to me.
> 
> > With regards to converting it to ReST, that's recommended. I suspect
> > we could be able to finish the entire doc conversion in a couple
> > Kernel versions.
> >   
> Sure.
> 
> > Also, it should be really trivial to convert this one to ReST.
> >   
> 
> Yes. Let me know if you prefer to update it along with your series or I 
> will send the patch.

I suspect it would be quicker if I write it. I'm sending it in a
few.

Thanks,
Mauro
