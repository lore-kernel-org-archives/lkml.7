Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFFEC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 05:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE9D206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 05:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfGPF7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 01:59:17 -0400
Received: from verein.lst.de ([213.95.11.211]:38821 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfGPF7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 01:59:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DF7ED68B05; Tue, 16 Jul 2019 07:59:14 +0200 (CEST)
Date:   Tue, 16 Jul 2019 07:59:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH 1/3] nvme: Pass the queue to SQ_SIZE/CQ_SIZE macros
Message-ID: <20190716055914.GA29414@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716004649.17799-1-benh@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:46:47AM +1000, Benjamin Herrenschmidt wrote:
> This will make it easier to handle variable queue entry sizes
> later. No functional change.

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
