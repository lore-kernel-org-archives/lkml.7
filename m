Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E5BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C59206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="aLGJ9mTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDCPso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:48:44 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:33190 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbfDCPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1554306522;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=4v128Tp+ktDAhV/qENqEBuzjLJBLhHo3lzR/qUMTRlo=;
        b=aLGJ9mTdOIRbGejut86wsSoihvyWLiKCMoKGatxbO2GGbt0rgmrk1u/IZHSnOqaI
        9q6he+SwBYm0IBVF3FfhF0iw8p1u0huggAQh8Ajdj81qHKdVBq8aeZbCqixT6d+8hF5
        vRSMboQSBPUXNruZYO+UV7UfVgto6s/J40j8SZwo=
Date:   Wed, 3 Apr 2019 15:48:42 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     "Tobin C. Harding" <tobin@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] slab: Use slab_list instead of lru
In-Reply-To: <20190402230545.2929-7-tobin@kernel.org>
Message-ID: <01000169e3e35d91-7a8b7b63-dd87-4d0f-bcff-e7f1031abbe9-000000@email.amazonses.com>
References: <20190402230545.2929-1-tobin@kernel.org> <20190402230545.2929-7-tobin@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.03-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: Christoph Lameter <cl@linux.com>


