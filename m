Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FD9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7C7206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552493410;
	bh=y010mxe/tnWoeQdgTNckREq6CA6nsfRjfdEwgmcZ51w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jGL45zLTOo8ZiULyESZM3ZaIB7O0kBdjVnpGRghgt26+E51iEQtTLrUVqfX1v6RMK
	 vP8WZdPk9BiZmtSmoYLrQOWd/qrf8E9/E2u47BVM25YJt/p7ufu+A4m3SY7FxG3HWA
	 r6YCA+zum83ChHMO0NhHhK2WjmWF3iqtYVvsA1sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfCMQKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:10:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCMQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:10:09 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C1D6CC8;
        Wed, 13 Mar 2019 16:10:08 +0000 (UTC)
Date:   Wed, 13 Mar 2019 09:10:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Message-Id: <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
In-Reply-To: <20190313012706.GB3402@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
        <20190313012706.GB3402@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 21:27:06 -0400 Jerome Glisse <jglisse@redhat.com> wrote:

> Andrew you will not be pushing this patchset in 5.1 ?

I'd like to.  It sounds like we're converging on a plan.

It would be good to hear more from the driver developers who will be
consuming these new features - links to patchsets, review feedback,
etc.  Which individuals should we be asking?  Felix, Christian and
Jason, perhaps?

