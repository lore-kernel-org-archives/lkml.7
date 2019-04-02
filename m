Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8EAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC55D2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfDBSXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:23:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbfDBSXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:23:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66C673082A4C;
        Tue,  2 Apr 2019 18:23:16 +0000 (UTC)
Received: from x230.aquini.net (dhcp-17-61.bos.redhat.com [10.18.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96A41194AA;
        Tue,  2 Apr 2019 18:23:10 +0000 (UTC)
Date:   Tue, 2 Apr 2019 14:23:07 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v1] mm: balloon: drop unused function stubs
Message-ID: <20190402182307.GA12529@x230.aquini.net>
References: <20190329122649.28404-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329122649.28404-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 02 Apr 2019 18:23:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 01:26:49PM +0100, David Hildenbrand wrote:
> These are leftovers from the pre-"general non-lru movable page" era.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/balloon_compaction.h | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index f111c780ef1d..f31521dcb09a 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -151,21 +151,6 @@ static inline void balloon_page_delete(struct page *page)
>  	list_del(&page->lru);
>  }
>  
> -static inline bool __is_movable_balloon_page(struct page *page)
> -{
> -	return false;
> -}
> -
> -static inline bool balloon_page_movable(struct page *page)
> -{
> -	return false;
> -}
> -
> -static inline bool isolated_balloon_page(struct page *page)
> -{
> -	return false;
> -}
> -
>  static inline bool balloon_page_isolate(struct page *page)
>  {
>  	return false;
> -- 
> 2.17.2
> 
Acked-by: Rafael Aquini <aquini@redhat.com>
