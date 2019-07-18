Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C25C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E07E20873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390486AbfGRNro convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:47:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:17861 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfGRNro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:47:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 06:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,278,1559545200"; 
   d="scan'208";a="169860182"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2019 06:47:43 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jul 2019 06:47:42 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jul 2019 06:47:42 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.110]) with mapi id 14.03.0439.000;
 Thu, 18 Jul 2019 21:47:41 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v3 2/2] balloon: fix up comments
Thread-Topic: [PATCH v3 2/2] balloon: fix up comments
Thread-Index: AQHVPWPB7Kn6mp4V4ECCoWD/TZ2+lqbQWhSw
Date:   Thu, 18 Jul 2019 13:47:40 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E1705ED@shsmsx102.ccr.corp.intel.com>
References: <20190718122324.10552-1-mst@redhat.com>
 <20190718122324.10552-2-mst@redhat.com>
In-Reply-To: <20190718122324.10552-2-mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmYzMTA4NzItODMyNi00OTQ1LWExYmQtYTg0ZjVkNWNjMWNlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSUc3MUVZK0YrRkpHb2Eyam5BN2lKWloyZ3cySDlMd1pRV211TW5KTjAxZXFRcEdRaFNEMitYZmw2c0NBK2VhbiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 18, 2019 8:24 PM, Michael S. Tsirkin wrote:
>  /*
>   * balloon_page_alloc - allocates a new page for insertion into the balloon
> - *			  page list.
> + *			page list.
>   *
> - * Driver must call it to properly allocate a new enlisted balloon page.
> - * Driver must call balloon_page_enqueue before definitively removing it
> from
> - * the guest system.  This function returns the page address for the recently
> - * allocated page or NULL in the case we fail to allocate a new page this turn.
> + * Driver must call this function to properly allocate a new enlisted balloon
> page.

Probably better to say "allocate a new balloon page to enlist" ?
"enlisted page" implies that the allocated page has been added to the list, which might
be misleading.


> + * Driver must call balloon_page_enqueue before definitively removing
> + the page
> + * from the guest system.
> + *
> + * Returns: struct page address for the allocated page or NULL in case it fails
> + * 			to allocate a new page.
>   */

Returns: pointer to the page struct of the allocated page, or NULL if allocation fails.



>  struct page *balloon_page_alloc(void)
>  {
> @@ -130,19 +133,15 @@ EXPORT_SYMBOL_GPL(balloon_page_alloc);
>  /*
>   * balloon_page_enqueue - inserts a new page into the balloon page list.
>   *
> - * @b_dev_info: balloon device descriptor where we will insert a new page
> to
> + * @b_dev_info: balloon device descriptor where we will insert a new
> + page
>   * @page: new page to enqueue - allocated using balloon_page_alloc.
>   *
> - * Driver must call it to properly enqueue a new allocated balloon page
> - * before definitively removing it from the guest system.
> + * Drivers must call this function to properly enqueue a new allocated
> + balloon
> + * page before definitively removing the page from the guest system.
>   *
> - * Drivers must not call balloon_page_enqueue on pages that have been
> - * pushed to a list with balloon_page_push before removing them with
> - * balloon_page_pop. To all pages on a list, use balloon_page_list_enqueue
> - * instead.
> - *
> - * This function returns the page address for the recently enqueued page or
> - * NULL in the case we fail to allocate a new page this turn.
> + * Drivers must not call balloon_page_enqueue on pages that have been
> + pushed to
> + * a list with balloon_page_push before removing them with
> + balloon_page_pop. To
> + * enqueue all pages on a list, use balloon_page_list_enqueue instead.

"To enqueue a list of pages" ?


>   */
>  void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  			  struct page *page)
> @@ -157,14 +156,24 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
> 
>  /*
>   * balloon_page_dequeue - removes a page from balloon's page list and
> returns
> - *			  the its address to allow the driver release the page.
> + *			  its address to allow the driver to release the page.
>   * @b_dev_info: balloon device decriptor where we will grab a page from.
>   *
> - * Driver must call it to properly de-allocate a previous enlisted balloon
> page
> - * before definetively releasing it back to the guest system.
> - * This function returns the page address for the recently dequeued page or
> - * NULL in the case we find balloon's page list temporarily empty due to
> - * compaction isolated pages.
> + * Driver must call this to properly dequeue a previously enqueued page
 
"call this function"?
 

> + * before definitively releasing it back to the guest system.
> + *
> + * Caller must perform its own accounting to ensure that this
> + * function is called only if some pages are actually enqueued.


"only when" ?

> + *
> + * Note that this function may fail to dequeue some pages even if there

"even when" ?

> + are
> + * some enqueued pages - since the page list can be temporarily empty
> + due to
> + * the compaction of isolated pages.
> + *
> + * TODO: remove the caller accounting requirements, and allow caller to
> + wait
> + * until all pages can be dequeued.
> + *
> + * Returns: struct page address for the dequeued page, or NULL if it fails to
> + * 			dequeue any pages.

Returns: pointer to the page struct of the dequeued page, or NULL if no page gets dequeued.


>   */
>  struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
> { @@ -177,9 +186,9 @@ struct page *balloon_page_dequeue(struct
> balloon_dev_info *b_dev_info)
>  	if (n_pages != 1) {
>  		/*
>  		 * If we are unable to dequeue a balloon page because the
> page
> -		 * list is empty and there is no isolated pages, then
> something
> +		 * list is empty and there are no isolated pages, then
> something
>  		 * went out of track and some balloon pages are lost.
> -		 * BUG() here, otherwise the balloon driver may get stuck
> into
> +		 * BUG() here, otherwise the balloon driver may get stuck in
>  		 * an infinite loop while attempting to release all its pages.
>  		 */
>  		spin_lock_irqsave(&b_dev_info->pages_lock, flags); @@ -
> 230,8 +239,8 @@ int balloon_page_migrate(struct address_space *mapping,
> 
>  	/*
>  	 * We can not easily support the no copy case here so ignore it as it
 
"cannot"

> -	 * is unlikely to be use with ballon pages. See include/linux/hmm.h
> for
> -	 * user of the MIGRATE_SYNC_NO_COPY mode.
> +	 * is unlikely to be used with ballon pages. See include/linux/hmm.h


"ballon" -> "balloon"


> for
> +	 * a user of the MIGRATE_SYNC_NO_COPY mode.

"for the usage of" ?


Other parts look good to me.
Reviewed-by: Wei Wang <wei.w.wang@intel.com>

Best,
Wei
