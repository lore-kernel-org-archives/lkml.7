Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40001C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA9321848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbfHVIKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:10:11 -0400
Received: from verein.lst.de ([213.95.11.211]:44769 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfHVIKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:10:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 34F7068C4E; Thu, 22 Aug 2019 10:10:07 +0200 (CEST)
Date:   Thu, 22 Aug 2019 10:10:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Anup Patel <Anup.Patel@wdc.com>
Subject: Re: [PATCH v4 1/3] RISC-V: Do not invoke SBI call if cpumask is
 empty
Message-ID: <20190822081007.GA17573@lst.de>
References: <20190822075151.24838-1-atish.patra@wdc.com> <20190822075151.24838-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822075151.24838-2-atish.patra@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 12:51:49AM -0700, Atish Patra wrote:
> SBI calls are expensive. If cpumask is empty, there is no need to
> trap via SBI as no remote tlb flushing is required.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
