Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAF0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA9520675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555408704;
	bh=tSPETeyV0rgaJSl/1AiqwLTG04/Fcj4bVudYsRLZQ1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YELttkFNZefS1Y8RbJhD+kOx92liRDm6w0DlIhP5DyfhLUnGixLe6LlQxCaof9rMd
	 4kg1I50Zb4RTBy+jpz6ydki+4dY0SBg0iNbyRwXYbrdDANK8k8wTqxgTTWCclQ1gKi
	 8WNTr8H2g7ApieTzSnbvkUZjg/deh9N3vxEJ8/oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfDPJ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:58:23 -0400
Received: from casper.infradead.org ([85.118.1.10]:50600 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfDPJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sP/+g+YITf4kSwQg6jWKcy9Hzpj2iP/E6kmV831FVp0=; b=HAJzIt/mkFcFrqyUTqPhMz19+S
        qUNhAAim90wx23B6Td7Tt9/eHtw864EtZnJHTrzoCGCP8wrNgHa6rnSr6BtSLffYZdI/prapQ1qpY
        YsUETnZQrTAiWiDQRJDZqMYtvmJFUA6W9wUjlztcZ/wgS/TtHY+fxty4NceZTXlcAzhLXXMayZ88b
        mglYrvJNY7UzQPNuYp/20u6QwQMmEn9gKLLmlcXLMdSZRDO1dXleSMLJBkkk8kXV2feXL1ybLYJT9
        Oo6XiP2RruIYFJJModOKBkMA98EFcg68Y1cfxetbw6hf2kdGpqUS3Q03/q+tJs+WyN5VS6bugIgly
        OJuTmldw==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGKr5-0004L4-TH; Tue, 16 Apr 2019 09:58:20 +0000
Date:   Tue, 16 Apr 2019 06:58:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 09/57] docs: cpu-freq: convert files to ReST
Message-ID: <20190416065815.57fbdf2c@coco.lan>
In-Reply-To: <CAJZ5v0he8GHZ+EFJ911vgrO53NnEWDwm=_vZD4K9SVL0MahMTQ@mail.gmail.com>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <b2f9cc0d15d7e3058be01015be36f698debd8b14.1555382110.git.mchehab+samsung@kernel.org>
        <CAJZ5v0he8GHZ+EFJ911vgrO53NnEWDwm=_vZD4K9SVL0MahMTQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 16 Apr 2019 10:21:31 +0200
"Rafael J. Wysocki" <rafael@kernel.org> escreveu:

> On Tue, Apr 16, 2019 at 4:56 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > In order to be able to build html and pdf files, convert the
> > documentation to ReST format.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Please don't convert these files.
> 
> They need more work than just semi-automatic conversion

Except for one exception (at patch 32/57), the ReST conversion on this
patch set was manually made. I basically renamed the files to
.rst, checked the errors and fixed, trying to preserve the original
document style as much as possible, while providing a good visual
for the html output.

I suspect that trying to write a script for such kind of conversion
is not an easy task, as some documents within the Kernel tree have
their own personal style, (there was even one written in LaTeX at
the CDROM docs), and I suspect that a script would end by adding 
extra unwanted markups.

> and the material in them needs to go under driver-api.

Yeah, those documents make sense to be at the driver-api set. 

The rationale why I placed the patch with actually renames on a
separate patchset (already on my devel tree, but yet to be submitted)
is that, this way, it should be easy for maintainers to pick the 
conversion patch, apply on their trees, and, if they're not ready
yet, postpone the actual rename/move thing.

> This is quite hight in my TODO list.

OK. Feel free to use this patch as a starting point if you
want.

Regards,
Mauro
