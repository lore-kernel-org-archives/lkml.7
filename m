Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540CEC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2530A206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560372091;
	bh=EvDYuh0MsSLf0dwMmEqPk9dQAHWsoa6uefOJ9qFDvKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BgTKrBl8NrL0AVGNAoF/wZKqv3DkARol9dOmyuaxSMqcafkyx8AjyBzh4D4N2PlTT
	 FxyMS3dVnSazNhceeru761CjorFWQqde8jUUBLgzb+oCvLtl5V48QuvjSAMTxrUmEH
	 VrVVZh1PcsIVochaylSW5IVJOh9ZHAhie+SfcI+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbfFLUl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:41:29 -0400
Received: from casper.infradead.org ([85.118.1.10]:53322 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388336AbfFLUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sI6gwiLkCC9ffzJ87+8NB0VxnCIPAyu/GIglnrwK0WM=; b=FP23l7y8EJ6iZDJ5fph+HSAolj
        trkiU2x7HtkKhSRGUZyZpIiKm15P0rgkbNNalIYFxFuCbDnfS1nokePZq2tTbs0fffUHrAyc3pS+c
        6o69mFfbo/DUz7YUDpimkjmKqFyr8Cd2tsfMOpfUpoxfIs2MqRpLJfuqIZBBmbVG+qgXyMdl1pOCI
        s52wsFUQmJgnSQx78VVQVkbTICGtkN6hXgve34sWqdCW9wf+50/KBu4GnF+R64MbP7IgjDdH6VwYb
        G65VlIyRP2OqJGEUC3TzQ7egPskq0AdIUUTA+VAKbvKJQIMbBN7/rvv12Cwe+T9KDmOVLIxesunR1
        cd20LcJQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbA3f-00072C-TH; Wed, 12 Jun 2019 20:41:24 +0000
Date:   Wed, 12 Jun 2019 17:41:19 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v1 29/31] docs: nvdimm: convert to ReST
Message-ID: <20190612174119.7c0d94bd@coco.lan>
In-Reply-To: <CAPcyv4g08r6bK_SyTjzKFRM7=wpTQLdmHqRSGh7r-e9YD4tq5Q@mail.gmail.com>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
        <075d5879142ff1b7ad16f5eccf4759d35ca02fd4.1560364494.git.mchehab+samsung@kernel.org>
        <CAPcyv4g08r6bK_SyTjzKFRM7=wpTQLdmHqRSGh7r-e9YD4tq5Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Jun 2019 12:04:12 -0700
Dan Williams <dan.j.williams@intel.com> escreveu:

> Hi Mauro,
> 
> On Wed, Jun 12, 2019 at 11:38 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > Rename the mtd documentation files to ReST, add an  
> 
> s/mtd/nvdimm/

Sorry, cut and paste issue :-)

> 
> > index for them and adjust in order to produce a nice html
> > output via the Sphinx build system.
> >
> > At its new index.rst, let's add a :orphan: while this is not linked to
> > the main index.rst file, in order to avoid build warnings.  
> 
> Looks ok, but I was not able to apply this one in isolation to give it
> a try. Am I missing some pre-reqs compared to v5.2-rc4?

I wrote the patch before v5.2-rc1, but, as this series touches a lot
of stuff, it was rebased against today's linux-next (next-20190612).

I didn't notice an conflict on this specific file during the rebases
though. 

There is a simple patch applied on linux-next after v5.2-rc4:

commit 3d9cf48b2ca257f1a249b347236098c3cf9d54f1
Author: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Date:   Thu May 9 15:40:49 2019 +0800

    Documentation: nvdimm: Fix typo
    
    Remove the extra 'we '.
    
    Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
    Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Could this be the cause of the issue you're noticing when
trying to apply it?

As this is signed-off by Jon, I suspect it went via docs-next.

Thanks,
Mauro
