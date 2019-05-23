Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59ACC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B988620863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558621269;
	bh=SngMLq/SaK+aNcuF6oXQwtLNPwG07YFCWgpjSq2NuwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lTVXNwx0h9xhJQl47j4zk/DpZ8T3ztigfhCsPMTdPKVi2PKFcXmiclDvSiM1O5dHD
	 rzvxHLond72/QR0LDq4HNSbk4A7t938EPUMesFuEMOE8hqtID2h7MLif5B0NvKqL43
	 bpOIEnoWh2sbMCvhH23syp/JTqLHAHS45xeRjG5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfEWOVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:21:08 -0400
Received: from casper.infradead.org ([85.118.1.10]:37006 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730706AbfEWOVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TZV/AEYN5ZrdVp6z4ufM+ly5FDL6G1ayJPeeq1/Pydc=; b=aQC29XaQ6wBjZE31gH2NegNJsi
        PoKdjZX9ed3K0xuTvd1B+Y1tongtHnFj+meIyFAhvONfIwVNbCz+ZGf9s1HVZTv/HegKyuoanhBY2
        nxP/Yqaihe+h/+eCde31Xm3hgxFqAMZVdL0404vo5navbn0Mb3Cq47Vt/26iNrSY303LBrKdbCTrH
        rnVnVqPBftEq3dl2Rs36qFMRoyaGwezIfX9EWnGKbVcSdZe6lE3TfT0+pn9RYgs2nr6/dg3I4bncE
        +WYLq6jSLWPqwvZxYehZieXX18Qi6tdUyQSgZyxCjGlUhb5Wl6wG8esdqQeEKocV08G7XGTPqjuIw
        BGfLYKlA==;
Received: from [179.182.168.126] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hToaX-0001wl-Iw; Thu, 23 May 2019 14:20:58 +0000
Date:   Thu, 23 May 2019 11:20:51 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Shawnx Tu <shawnx.tu@intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the v4l-dvb
 tree
Message-ID: <20190523112051.20418ef4@coco.lan>
In-Reply-To: <20190523141004.cfbuymuykjew4tyr@kekkonen.localdomain>
References: <20190524000500.61cacf9e@canb.auug.org.au>
        <20190523141004.cfbuymuykjew4tyr@kekkonen.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 23 May 2019 17:10:05 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:

> Hi Stephen, Mauro,
> 
> On Fri, May 24, 2019 at 12:05:00AM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Commits
> > 
> >   eeabf6320e2f ("media: Revert "[media] marvell-ccic: reset ccic phy when stop streaming for stability"")
> >   bbf83ed40252c ("media: ov8856: modify register to fix test pattern")
> > 
> > are missing a Signed-off-by from their authors.  
> 
> Ouch.
> 
> Mauro, what do you prefer, reset the tree or what?

I'll drop bbf83ed40252c and the marvel-ccic patches after eeabf6320e2f,
rebasing my tree.

> 
> Shawn, Lubomir: please read "Developer's Certificate of Origin 1.1" in
> Documentation/process/submitting-patches.rst and then resend with
> appropriate SoB lines.
> 



Thanks,
Mauro
