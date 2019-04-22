Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE56C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145452064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555942678;
	bh=Z0wAQiGWV/3iT2hJVHv/wHKstMWrufqZ8JX1P2+zHHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ge6v4tejYUPHXe33p7jTqrvy1oLqCKo28r79b4duiWDMM+N5T446RxDtG6ZRb69tX
	 hnslvUKg62UrJBAMo2+cHKy2GM+DxNFuLl6JwuRzAWft6sS9KO2OrmI0e1Bu+WNPih
	 2LAo384t132q8en5SBK+1SOK0U9Gp8I4tCfSbFWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfDVORh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:17:37 -0400
Received: from casper.infradead.org ([85.118.1.10]:60450 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BJhAGFn74B6MOd2T92DsQopSTZPOJJ34QkUCyoe5Y+M=; b=wC9/utEyTYdaZTJ0uv8sxWxV33
        9nHv//U3s5PimHmck1wZMKW2ZRQVEFhkiBoy/DPJvhGv3Oodd3rexRUvj8fTEo49aN3yXPUHBAj0Z
        pMNAHsxdSDDzDZAfAbs78zGiuX/h8+5x10sjvyxY9yT3U7zGAUNFSa/uV8XHWsgDdU4xFatV+vQ8D
        9tplOlFmF5X3gMjKosLsT39WeKYuWokrmRrgCnQoGm2Y/tFtj8m0vjv249JazMzANiM3JzayYjjp+
        sVRkC9+XSkutbwqOzftdqt7zYE/o5BQiupFQuoTPWus7LCRAupk+S9bAxkOdAcJNgfcif5A9J/X5D
        SEkvBL6Q==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIZlD-0005Tu-Bn; Mon, 22 Apr 2019 14:17:31 +0000
Date:   Mon, 22 Apr 2019 11:17:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 64/79] docs: ioctl-number.txt: convert it to ReST
 format
Message-ID: <20190422111725.18c06ea2@coco.lan>
In-Reply-To: <32310473e6aef679d00c39028adcfcf4c31f47f7.camel@redhat.com>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
        <16911408d1ac64c0df5ef3ecdae9cf1cc2df58e4.1555938376.git.mchehab+samsung@kernel.org>
        <32310473e6aef679d00c39028adcfcf4c31f47f7.camel@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 22 Apr 2019 10:05:39 -0400
Doug Ledford <dledford@redhat.com> escreveu:

> On Mon, 2019-04-22 at 10:27 -0300, Mauro Carvalho Chehab wrote:
> > +0x1b  all                                                            InfiniBand Subsystem
> > +                                                                     <http://infiniband.sourceforge.net/>  
> 
> I did not know this link was in there.  That sourceforge site is 15
> years old and totally obsolete/irrelevant at this point.  This patch
> doesn't have the purpose of fixing this up, but now that it's pointed
> out, we'll make a follow up patch to correct this.

Yeah, I suspect that there are lots of broken links over there.

It seems that some people ended by prepending some broken URLs with:

	http://web.archive.org/web/%2A/

In order to use the web archive to get an old copy of such documents.

So, replacing the link with something like:

	http://web.archive.org/web/%2A/http://infiniband.sourceforge.net/

Would allow retrieving pages. It seems that the last version is there
at:

	https://web.archive.org/web/20190212201603/http://infiniband.sourceforge.net/

Yet, if are there any new repository with updated info, it would make sense
to replace it by the new stuff. 

Alternatively, one could import existing docs (if license is compatible
with GPLv2) and add to the Kernel documentation.

Thanks,
Mauro
