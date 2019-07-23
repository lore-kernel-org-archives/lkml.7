Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F49EC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C12A223BB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbfGWIRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:17:43 -0400
Received: from 8bytes.org ([81.169.241.247]:44932 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfGWIRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:17:41 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5F4E43A2; Tue, 23 Jul 2019 10:17:40 +0200 (CEST)
Date:   Tue, 23 Jul 2019 10:17:35 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Don't queue_iova() if there is no flush
 queue
Message-ID: <20190723081735.GJ12009@8bytes.org>
References: <20190716213806.20456-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716213806.20456-1-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:38:05PM +0100, Dmitry Safonov wrote:

> @@ -235,6 +236,11 @@ static inline void init_iova_domain(struct iova_domain *iovad,
>  {
>  }
>  
> +bool has_iova_flush_queue(struct iova_domain *iovad)
> +{
> +	return false;
> +}
> +

This needs to be 'static inline', I queued a patch on-top of my fixes
branch.

Regards,

	Joerg
