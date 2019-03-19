Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C32C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDD1206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553013611;
	bh=ZqodSKnlr8GQ50SdhVcPipFMdRBltRsWa3Vf6y5irNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=X6Fz7CqMV+15WiFYocllobAGg4tV59eyr3nbckO2H+ZpfuIrV2XQN7Ks/woclVGyo
	 Gg6uAwQlWD0/cVURl6Kdr2B2klK0XUjTGGeMiUCp+pDVAl9Mf69rmX4gTolhR5jyyU
	 R9AyFTWlIgSQPBswFALfaQVki0pWYj8oXDhjFy5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCSQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:40:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfCSQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:40:09 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9FBC23A68;
        Tue, 19 Mar 2019 16:40:08 +0000 (UTC)
Date:   Tue, 19 Mar 2019 09:40:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Message-Id: <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
In-Reply-To: <20190318170404.GA6786@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
        <20190313012706.GB3402@redhat.com>
        <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
        <20190318170404.GA6786@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 13:04:04 -0400 Jerome Glisse <jglisse@redhat.com> wrote:

> On Wed, Mar 13, 2019 at 09:10:04AM -0700, Andrew Morton wrote:
> > On Tue, 12 Mar 2019 21:27:06 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> > 
> > > Andrew you will not be pushing this patchset in 5.1 ?
> > 
> > I'd like to.  It sounds like we're converging on a plan.
> > 
> > It would be good to hear more from the driver developers who will be
> > consuming these new features - links to patchsets, review feedback,
> > etc.  Which individuals should we be asking?  Felix, Christian and
> > Jason, perhaps?
> > 
> 
> So i am guessing you will not send this to Linus ?

I was waiting to see how the discussion proceeds.  Was also expecting
various changelog updates (at least) - more acks from driver
developers, additional pointers to client driver patchsets, description
of their readiness, etc.

Today I discover that Alex has cherrypicked "mm/hmm: use reference
counting for HMM struct" into a tree which is fed into linux-next which
rather messes things up from my end and makes it hard to feed a
(possibly modified version of) that into Linus.

So I think I'll throw up my hands, drop them all and shall await
developments :(

