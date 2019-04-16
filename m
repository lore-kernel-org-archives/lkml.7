Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30F5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD56A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555425207;
	bh=iQp07FIpFrByxNmlvQ61PXqxEvBA1IPxiblIo2N8vi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xXzsaww1zsFOBhHJ8PKWfgr+NJ4euNcNUoxOEnEBN5fABDnFPvDzcZNblhZpvZaQn
	 6+HlO2oNeP4Av8AFeM2QGEDWxPRNAw/ToqNTVcPJJnBPk2Kk8pPkOVgzpdbFMdJoLh
	 Unhr/6TWACiX8+JOVuLlQPMiS6YdJuB2jFtwy/So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfDPOd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:33:26 -0400
Received: from casper.infradead.org ([85.118.1.10]:47048 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfDPOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V/pYIOvyt/8G+cXgIPSr1A8Xv/CDMxgMQWIP/93VILc=; b=ZmEEzmf6YzJtGbd4ny+/B5nBMz
        odF9/yDknuU2ExV9OuScix594tqMqt45Tmcb8wmqt7fOA6JgERtukuVVc+SvKWl4a03QKPPYX55qL
        rlOq3/g/bQ6H/QSdvvUjYYFi7SAygWjCuQuyvCs02tO3FTf//kKFOIsbdGi2ysqd32MVz+SOE6AIf
        0bjAhJRZHjOt5PVgVzJEmVeMnf1KDojgkZKfzZp/jvm8hGETwheREMPsVjVp5cblQBktJVaOHRght
        +65STb+/zCUmJzq9iCgNSzR2q0vgkHeVU3POzOCM5S2EKlJLsLMeNxebD9UN8acy9ewLEMXWAi2Cx
        Vb9TRZIw==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGP9G-0006YW-2S; Tue, 16 Apr 2019 14:33:22 +0000
Date:   Tue, 16 Apr 2019 11:33:16 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com
Subject: Re: [PATCH 10/57] docs: device-mapper: convert it to ReST format
Message-ID: <20190416113316.5c3b496c@coco.lan>
In-Reply-To: <20190416080024.7fb65682@lwn.net>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <9dd3c4eca01489bd67ea6de88dfedef8b0e81901.1555382110.git.mchehab+samsung@kernel.org>
        <20190416132851.GA22497@redhat.com>
        <20190416080024.7fb65682@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 16 Apr 2019 08:00:24 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue, 16 Apr 2019 09:28:52 -0400
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > Can you help me understand why this is the direction text based
> > Documenation is taking in the Linux kernel?  All I see is markup, and
> > escaping of characters, that is a chore to administer over time.  
> 
> This is a discussion that was mostly resolved some years ago...
> 
> Classic Documentation/ is a jumbled collection of unorganized text files,
> some of which contain highly useful information and others of which
> haven't had much to offer since about 1996.  We are working to turn it
> into an organized collection where, hopefully, some thought has actually
> been given to the people who will be reading it.
> 
> The ReST conversion, in particular, allows us to link documents into a
> larger structure, create indexes and cross references, and produce output
> in formats like HTML and PDF.  It lets us present the documentation like
> this:
> 
> 	https://www.kernel.org/doc/html/latest/

Just to mention, in the specific case of the device-mapper patch,
this is the result of those changes (after renaming the files to .rst,
and adding an index file):

	https://www.infradead.org/~mchehab/rst_conversion/device-mapper/index.html

> 
> Among other things, making the documentation more accessible in this way
> makes it easier and more rewarding for developers to improve it, and I
> believe we are seeing the results of that.  Linus called out the
> documentation work in the 5.1-rc1 announcement, for example.
> 
> Nobody has complained about the maintenance burden of RST docs - so far as
> I have heard, anyway.  Things do break occasionally, but problems in the
> docs build almost always result from code changes that mess up the
> kerneldoc comments rather than RST changes, and it's been that way for as
> long as I've been paying attention.


> 
> Thanks,
> 
> jon



Thanks,
Mauro
