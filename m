Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEF9C17461
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A054D21D7C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572960225;
	bh=XbzlcvI5LJBDVvpa0TOvEURACkPGy5z2DvHVu1Vz5aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mwMaGO6j/StlKzs8tmwAVzpGF0KB116uuT9mMszxXxn58BS9srsNV99y5nX/ajS/8
	 l0ag4w5IQFwSsFKvjs7YyqVCQ6qvUegVfhsLkvqg8S0L23IQouBnsM2OWpI0Xu88YG
	 fg+UiXh677gI4kUm/hLSX3i4i+qFnNFgxgI1HVKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbfKENXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:23:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388753AbfKENXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:23:43 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95A521D71;
        Tue,  5 Nov 2019 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572960222;
        bh=XbzlcvI5LJBDVvpa0TOvEURACkPGy5z2DvHVu1Vz5aQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htO1b+UhfuOvM7xzNC9LG3W+x3Oz9GgdkpTdSwIDdXYwIPxptJWIYA/fSYNIerUJF
         4fsVRC0wf/3TAhdi+DvxvkLeJBAIgADuthFt4w1GsYl24b+KjirOsaffmp3UHFHhQv
         XdXi8BLvjkcoDhQG7ui3Vcdj5Y2T2ty4s2Gsasvg=
Date:   Tue, 5 Nov 2019 15:23:37 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] MAINTAINERS: update information for "MEMORY MANAGEMENT"
Message-ID: <20191105132335.GH25005@rapoport-lnx>
References: <20191030202217.3498133-1-songliubraving@fb.com>
 <20191030182104.13847e8563105be6cd0a9dfe@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030182104.13847e8563105be6cd0a9dfe@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:21:04PM -0700, Andrew Morton wrote:
> On Wed, 30 Oct 2019 13:22:17 -0700 Song Liu <songliubraving@fb.com> wrote:
> 
> > I was trying to find the mm tree in MAINTAINERS by searching "Morton".
> > Unfortunately, I didn't find one. And I didn't even locate the MEMORY
> > MANAGEMENT section quickly, because Andrew's name was not listed there.
> > 
> > Thanks to Johannes who helped me find the mm tree.
> 
> Oh all right ;)
> 
> If I listed everything I "maintain" in MAINTAINERS, I'd double the size
> of the dang thing.
> 
> q:/usr/src/25> grep "^#NEXT_PATCHES_START" series | wc -l
> 364
> 
> (Those are the identifiable "trees" which I do (or did) "maintain").
> 
> But mm/ is special.
> 
> > Let save other's time searching around by adding:
> > 
> > M:	Andrew Morton <akpm@linux-foundation.org>
> > T:	git git://github.com/hnaz/linux-mm.git
> 
> Also:
> 
> --- a/MAINTAINERS~maintainers-update-information-for-memory-management-fix
> +++ a/MAINTAINERS
> @@ -10523,6 +10523,8 @@ M:	Andrew Morton <akpm@linux-foundation.
>  L:	linux-mm@kvack.org
>  W:	http://www.linux-mm.org
>  T:	git git://github.com/hnaz/linux-mm.git
> +T:	quilt https://ozlabs.org/~akpm/mmotm/
> +T:	quilt https://ozlabs.org/~akpm/mmots/
>  S:	Maintained
>  F:	include/linux/mm.h
>  F:	include/linux/gfp.h

The F: section here is also seems too sparse, at the very least we could
add include/linux/mm_types.h and include/linux/page*h:

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d04ce95..5e4ed4bc2372 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10526,6 +10526,8 @@ F:      include/linux/mm.h
 F:     include/linux/gfp.h
 F:     include/linux/mmzone.h
 F:     include/linux/memory_hotplug.h
+F:     include/linux/mm_types.h
+F:     include/linux/page*h
 F:     include/linux/vmalloc.h
 F:     mm/


> _
> 
> 

-- 
Sincerely yours,
Mike.
