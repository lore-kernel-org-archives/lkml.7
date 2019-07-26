Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31557C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0235C22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564172039;
	bh=+/A4dgElAXWYRirdWb+FjaDHwVspulcnedQs4Q2vlms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=C2Kv9QxHJZWszgphvfp536ci0OLbuGUJAfBYXagw8fXxENMmj6T2jponW0iCa/wAu
	 p/Jv8kc2cD+VgSAWg33OJJ+cw2JyLzFvXFFJD5/PLF88CSbMrHYlGssyeN8+B28eo2
	 gV56oFzZ7FGK4aGAB48J3fsWBLAIpM8ETgszJE6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfGZUN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:13:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfGZUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e3oSKq3EpjEAYXDpbNj7NYW0Ueq2WVo9JqMr9TvbgH8=; b=MU94sAmDOWnYNnw9AhYQL4Bfo
        mp+BG+rYA1nBcYvdEG2Lq/+g8pSBA4xrsu7Y+6i4iiSTji0+HxkZU+tnb+vz66zp+a713D3JQSg/Q
        MgdHAAcMf/wTqfQSK3sp7Qltf/K7EUn++4ipa5xL4RS8llyQX5ZdciDJGWE2jVrYg90H07DRlpP6q
        w+nGpvmfI3R0oRO+9ZSMbH4depM0i5KR8sub9e1mu/5OPfJyDR8i42ZTNAfXavhLijUrqD8QSseVJ
        YZUdg0US1OY0HQJY6xlyZNeQO2u6sFRPs3RuMPTzBG39q3mwjwwoHftWHT22K0/0gBBNT60bR2mXX
        lXeTSEEXQ==;
Received: from [179.95.31.157] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr6bE-0001wX-JU; Fri, 26 Jul 2019 20:13:57 +0000
Date:   Fri, 26 Jul 2019 17:13:52 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?xYF1a2Fzeg==?= Stelmach <l.stelmach@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/7] Fix broken references to files under
 Documentation/*
Message-ID: <20190726171352.5eaa4d83@coco.lan>
In-Reply-To: <04794d40-0b39-0223-c91e-03b46cb6e2db@wdc.com>
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
        <04794d40-0b39-0223-c91e-03b46cb6e2db@wdc.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Jul 2019 12:55:36 -0700
Atish Patra <atish.patra@wdc.com> escreveu:

> On 7/26/19 4:47 AM, Mauro Carvalho Chehab wrote:
> > Solves most of the pending broken references upstream, except for two of
> > them:
> > 
> > 	$ ./scripts/documentation-file-ref-check
> > 	Documentation/riscv/boot-image-header.txt: Documentation/riscv/booting.txt
> > 	MAINTAINERS: Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
> > 
> > As written at boot-image-header.txt, it is waiting for the addition of
> > a future file:
> > 
> > 	"The complete booting guide will be available at
> > 	  Documentation/riscv/booting.txt."
> >   
> 
> Yeah. We don't have complete booting guide defined in RISC-V land.
> Documentation/riscv/booting.txt will be available once we have that.
> 
> In the mean time, do we need to convert boot-image-header.txt to 
> boot-image-header.rst and fix the reference to 
> Documentation/riscv/booting.rst as well ?

Well, in the mean time, every time someone builds the Kernel with
COMPILE_TEST enabled, a warning will be produced.

So, my suggestion would be to write it on a different way, like:

	"A complete booting guide is being written and should be
	 available on future versions."

Or:
	TODO:
	   Write a complete booting guide.

And update this once the guide is finished. This should be enough
to prevent the warning.

With regards to converting it to ReST, that's recommended. I suspect
we could be able to finish the entire doc conversion in a couple
Kernel versions. 

Also, it should be really trivial to convert this one to ReST.

Thanks,
Mauro
