Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C7CA9EC9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA0920862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfJ3WFw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:05:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:36852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfJ3WFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:05:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C7E5B22F;
        Wed, 30 Oct 2019 22:05:50 +0000 (UTC)
Date:   Wed, 30 Oct 2019 23:05:49 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] net: sgi: ioc3-eth: don't abuse dma_direct_* calls
Message-Id: <20191030230549.ef9b99b5d36b0a818d904eee@suse.de>
In-Reply-To: <20191030211233.30157-2-hch@lst.de>
References: <20191030211233.30157-1-hch@lst.de>
        <20191030211233.30157-2-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 14:12:30 -0700
Christoph Hellwig <hch@lst.de> wrote:

> dma_direct_ is a low-level API that must never be used by drivers
> directly.  Switch to use the proper DMA API instead.

is the 4kb/16kb alignment still guaranteed ? If not how is the way
to get such an alignment ?

Thomas.

-- 
SUSE Software Solutions Germany GmbH
HRB 36809 (AG Nürnberg)
Geschäftsführer: Felix Imendörffer
