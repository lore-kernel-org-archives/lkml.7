Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E05C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9038217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555538616;
	bh=JeL4gdAt0hsRIkQ6cxAgSOj/S1N63lLGqtpxClQsFVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xNwcpGd6OoOoyZNuLEaiaws6iWVAbyFDcU/WuXIGqArpEyRi3PtspDEMl+aUdluYS
	 3NVA4AsTj0payDutH7yRZ4RmcarYTYRmggwjHmfqQA20g8mpOMXL4dOtPLvhhQCQmf
	 qZDh+qdifN2g76iSZZUh+ianLa58VefYb0GAfAis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbfDQWDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:03:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:03:34 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E04B4B3E;
        Wed, 17 Apr 2019 22:03:32 +0000 (UTC)
Date:   Wed, 17 Apr 2019 15:03:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/12] mm: Sub-section memory hotplug support
Message-Id: <20190417150331.90219ca42a1c0db8632d0fd5@linux-foundation.org>
In-Reply-To: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 11:38:55 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> The memory hotplug section is an arbitrary / convenient unit for memory
> hotplug. 'Section-size' units have bled into the user interface
> ('memblock' sysfs) and can not be changed without breaking existing
> userspace. The section-size constraint, while mostly benign for typical
> memory hotplug, has and continues to wreak havoc with 'device-memory'
> use cases, persistent memory (pmem) in particular. Recall that pmem uses
> devm_memremap_pages(), and subsequently arch_add_memory(), to allocate a
> 'struct page' memmap for pmem. However, it does not use the 'bottom
> half' of memory hotplug, i.e. never marks pmem pages online and never
> exposes the userspace memblock interface for pmem. This leaves an
> opening to redress the section-size constraint.

v6 and we're not showing any review activity.  Who would be suitable
people to help out here?
