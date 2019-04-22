Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E98F214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="I6cqfNZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfDVR3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:29:03 -0400
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:42944 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbfDVR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1555954141;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=uTp82GrKS+FoqOpQPeRfRgfZOledo6xDwlMBf3yfJG4=;
        b=I6cqfNZUSqdVhRoTlDMauiDjIdqVla6mLkcsOz4ds5wrUQGVqk1rB364uz2Xr/5k
        jY0gYuBl3eDzKi9pPTYJff5zDwUDgoNt9H2BnsBg91m08fD3FfGS1pF/ANBrG1y+uRL
        1XaNG8omk+ElH0D5ePFpKxCXKRfGUoJ+V/kdW35o=
Date:   Mon, 22 Apr 2019 17:29:01 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Wilcox <willy@infradead.org>
cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: DISCONTIGMEM is deprecated
In-Reply-To: <20190419140521.GI7751@bombadil.infradead.org>
Message-ID: <0100016a461809ed-be5bd8fc-9925-424d-9624-4a325a7a8860-000000@email.amazonses.com>
References: <20190419094335.GJ18914@techsingularity.net> <20190419140521.GI7751@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.22-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019, Matthew Wilcox wrote:

> ia64 (looks complicated ...)

Well as far as I can tell it was not even used 12 or so years ago on
Itanium when I worked on that stuff.
