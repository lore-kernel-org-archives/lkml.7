Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FADC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1F02075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbfC0IHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:07:38 -0400
Received: from verein.lst.de ([213.95.11.211]:40327 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfC0IHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:07:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D738C68B05; Wed, 27 Mar 2019 09:07:26 +0100 (CET)
Date:   Wed, 27 Mar 2019 09:07:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     =?iso-8859-1?Q?Cl=E9ment?= Leger <cleger@kalray.eu>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma: select GENERIC_ALLOCATOR for DMA_REMAP
Message-ID: <20190327080726.GA20336@lst.de>
References: <1741404498.4767335.1553163629182.JavaMail.zimbra@kalray.eu> <1443307786.4859175.1553243409888.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1443307786.4859175.1553243409888.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please resend the actual patch so that I can apply it.
