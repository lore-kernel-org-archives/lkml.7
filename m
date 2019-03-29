Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3C5C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E067F217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfC2OMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:12:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41835 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfC2OMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:12:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so2431302qta.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9cWb1NVLa8ybFjtRFsTC7/aZsERN67DYELWNz6G7OZU=;
        b=EIXth5k+1ZFVmmRCx0jwUrS7U58cwnduaY7diDVX9WrAKAYmTqN16E21g2jJdU9H0e
         i5m9//KGFxjCXnQdlFlktTK9NN3q5gsQum3q6+lXSyCzScg4f+jLRWu5gdQmp3tWA885
         xPVkI/h/xphCSEPiJvwktRivEAUYqKRzVuvwBWVAIkSjgFNaDtnfWWsboeLrolHmtrqh
         T1spp/K4IRIClm4xhVADlXSaow2Hxj8zGqcd+Q9D41zKewX0WgedriYZOsyMeNbjHdRP
         7ZjDRs8macYdd8K3q3SXEAH4qVGQFNMFa+pohDupbvWXbBRWeBL4h8Fb/1Toq2XP+fJR
         Ot0Q==
X-Gm-Message-State: APjAAAWOeKrUtFnHT6EljhMGTr4wLHTzRRwLRqQTAI7uz4e6Yw7q0RbM
        FWZQgburRGWJ4LOkYsH7epdgMA==
X-Google-Smtp-Source: APXvYqyCdRzYVvALtlsV1CwYoLmEEcEnlERcrSZlMQttVZxB6icqGdntGEAhgpSpiUYwrRq+sz8fOw==
X-Received: by 2002:ac8:6646:: with SMTP id j6mr40853858qtp.197.1553868773464;
        Fri, 29 Mar 2019 07:12:53 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id k33sm1129643qte.8.2019.03.29.07.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 07:12:52 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:12:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v1] mm: balloon: drop unused function stubs
Message-ID: <20190329101235-mutt-send-email-mst@kernel.org>
References: <20190329122649.28404-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329122649.28404-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 01:26:49PM +0100, David Hildenbrand wrote:
> These are leftovers from the pre-"general non-lru movable page" era.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

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
