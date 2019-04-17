Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99203C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6884E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555472256;
	bh=MJVbzjFwZjtwRIPUVkHRcIFN0zSdOkMz/XDE5HWST/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UJzwbw5jUt5Or/KD6Rhp+H4eaiwUKbtN7/9VsIqKqHZcXfalWN/ULf7r94macjZ/V
	 ZR4tH80dXzE2HSvUlIHLKocaoCtzkUS3W0cxasW3HrZvHcDK2VAJ2bjvKpMC33qCQK
	 +qzWfAfqpQC1T91V6WMDli/IBE8r+XAShy4GjH4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfDQDhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:37:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfDQDhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:37:34 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDE9FB7A;
        Wed, 17 Apr 2019 03:37:33 +0000 (UTC)
Date:   Tue, 16 Apr 2019 20:37:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: Release memory resource after
 arch_remove_memory()
Message-Id: <20190416203732.eec38cecd35d4242a59ca19a@linux-foundation.org>
In-Reply-To: <7cbea607-284c-4e20-fee8-128dae33b143@redhat.com>
References: <20190409100148.24703-1-david@redhat.com>
        <20190409100148.24703-2-david@redhat.com>
        <20190409154115.0e94499072e93947a9c1e54e@linux-foundation.org>
        <7cbea607-284c-4e20-fee8-128dae33b143@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 10:07:24 +0200 David Hildenbrand <david@redhat.com> wrote:

> Care to fixup both u64 to resource_size_t? Or should I send a patch?
> Whatever you prefer.

Please send along a fixup.

This patch series has no evidence of having been reviewed :(.  Can you
suggest who could help us out here?

