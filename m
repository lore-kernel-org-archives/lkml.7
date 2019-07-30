Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E255EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E9F20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564514290;
	bh=WIaLkp9WjRkRPTIS3ilPRkCPoHmrJhuYAL9o0qYpcDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2rnuLIWctM/4Ybi3Rc7Hzyq4YFY008IBl1LLZw8KufbdtkoZj94q2ahZb5idNM/qR
	 huAvbUpppZyAKQViWt09zGpH9uL0Th11M8/hMGNBdwDmkH4r3PgUD+DBauuaPdBqA+
	 4K/iIDEenDTbZqzQ08MmYAMecDpJ+Cu6tl/SFOzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfG3TSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:18:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3TSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:18:09 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C324932A5;
        Tue, 30 Jul 2019 19:18:03 +0000 (UTC)
Date:   Tue, 30 Jul 2019 12:17:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: + uprobe-use-original-page-when-all-uprobes-are-removed.patch
 added to -mm tree
Message-Id: <20190730121759.41b4ddf25eb887fafa27fb28@linux-foundation.org>
In-Reply-To: <40C3ABEE-B1D1-445B-9637-A2BD5ED9C316@fb.com>
References: <20190726230333.drvM6x-wz%akpm@linux-foundation.org>
        <20190729150539.GB11349@redhat.com>
        <40C3ABEE-B1D1-445B-9637-A2BD5ED9C316@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 17:04:05 +0000 Song Liu <songliubraving@fb.com> wrote:

> > this assumes that __replace_page() can't fail, but it can. I think you
> > should move this into into __replace_page().
> 
> Good catch! Let me fix it. 
> 
> Hi Andrew,
> 
> Do you prefer a whole v10 (1/4 to 4/4) or just newer version of this 
> one (2/4)?

Either is OK.  I guess just a new 2/4 is sufficient, if the difference
is minor.

