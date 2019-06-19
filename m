Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B31AC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F031F21743
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560950369;
	bh=HmTzpFsOGnof5zeRmfVW5I3xbLfNXwyO1Vd0vkhYxcI=;
	h=Date:From:To:Subject:In-Reply-To:References:List-ID:From;
	b=pevbQttj74y7WfujTNC8foDxlBPbAqjuoulXFpqggmLBGTfFopiuFd3gZAKbUDJMD
	 Wb6LAhVMOBfUb6nuY7HDC+zq2m+V0FM6WN7KZWR9kuJTz52ysMEopqCAyK4tMqhZ60
	 Sx5pKP4yoBklRAqMpDHT9J36w362l+fz+Icqwc4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfFSNT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:19:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFSNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:
        Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=enh7bl+ZxtCNZahENTVUATMuvV2PoiZCx+Kx0tLEQaw=; b=Kr8dO+mJQItzeFRoa+XrWjaxK
        gxUaCZCEGKifi3deIdGTCCX0ciZdqBxSxhcwil6aLbl7xkMiFQ/mA8DY931XJUKnnP4ufE0ZdnnIm
        gg5BKrLLYparVAKkpWVZFdzC8vdTbN0t3yJgrlqMDasJrKWQFTCMrXQLBphgEL56XDSZHWWJ6JnQ9
        W5ZsfB3LX39EGRzdBXgDmxT63thYXtKBOw2SbTTn8RD5b1q1QZhEgpqaVW/JNwFjNZVzHDmpS2Sdz
        fWjlhdZ9g7eZstLTeyVv3ZU4LkMqzHCBPcbROdJE9Xz/TM5CyW529G/BPvtJyktoAuFWOT5TXvFKr
        FsmbQB85w==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdaUo-0000KD-7U; Wed, 19 Jun 2019 13:19:26 +0000
Date:   Wed, 19 Jun 2019 10:19:22 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Message-ID: <20190619101922.04340605@coco.lan>
In-Reply-To: <20190619114356.GP3419@hirez.programming.kicks-ass.net>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
        <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
        <20190619114356.GP3419@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(c/c list cleaned)

Em Wed, 19 Jun 2019 13:43:56 +0200
Peter Zijlstra <peterz@infradead.org> escreveu:

> On Tue, Jun 18, 2019 at 05:53:17PM -0300, Mauro Carvalho Chehab wrote:
> 
> >  .../{ => driver-api}/atomic_bitops.rst        |  2 -  
> 
> That's a .txt file, big fat NAK for making it an rst.

Rst is a text file. This one is parsed properly by Sphinx without
any changes.

> 
> >  .../{ => driver-api}/futex-requeue-pi.rst     |  2 -  
> 
> >  .../{ => driver-api}/gcc-plugins.rst          |  2 -  
> 
> >  Documentation/{ => driver-api}/kprobes.rst    |  2 -
> >  .../{ => driver-api}/percpu-rw-semaphore.rst  |  2 -  
> 
> More NAK for rst conversion

Again, those don't need any conversion. Those files already parse 
as-is by Sphinx, with no need for any change.

The only change here is that, on patch 1/22, the files that
aren't listed on an index file got a :orphan: added in order
to make this explicit. This patch removes it.

> 
> >  Documentation/{ => driver-api}/pi-futex.rst   |  2 -
> >  .../{ => driver-api}/preempt-locking.rst      |  2 -  
> 
> >  Documentation/{ => driver-api}/rbtree.rst     |  2 -  
> 
> >  .../{ => driver-api}/robust-futex-ABI.rst     |  2 -
> >  .../{ => driver-api}/robust-futexes.rst       |  2 -  
> 
> >  .../{ => driver-api}/speculation.rst          |  8 +--
> >  .../{ => driver-api}/static-keys.rst          |  2 -  
> 
> >  .../{ => driver-api}/this_cpu_ops.rst         |  2 -  
> 
> >  Documentation/locking/rt-mutex.rst            |  2 +-  
> 
> NAK. None of the above have anything to do with driver-api.

Ok. Where do you think they should sit instead? core-api?

Thanks,
Mauro
