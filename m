Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B06FC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AC9213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbfFYLpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:45:40 -0400
Received: from ns.iliad.fr ([212.27.33.1]:42304 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfFYLpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:45:40 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id E6C8E202C7;
        Tue, 25 Jun 2019 13:45:38 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id D2A73202C1;
        Tue, 25 Jun 2019 13:45:38 +0200 (CEST)
Subject: Re: [PATCH 2/2] dma-mapping: remove dma_max_pfn
To:     Christoph Hellwig <hch@lst.de>
References: <20190625092042.19320-1-hch@lst.de>
 <20190625092042.19320-3-hch@lst.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <2cf24650-512e-688d-fe24-119d36ed92f5@free.fr>
Date:   Tue, 25 Jun 2019 13:45:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625092042.19320-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Jun 25 13:45:38 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

There are some typos in the commit message that make it harder
(for me) to parse.

On 25/06/2019 11:20, Christoph Hellwig wrote:

> These days the DMA mapping code must bounce buffer for any not supported

Add comma after "These days" ?
s/must bounce buffer/must bounce buffers/ ?
s/not supported/unsupported/ ?

> address, and if they driver needs to optimize for natively supported

s/if they driver/if the driver/ ?

> ranged it should use dma_get_required_mask.

s/ranged it should/ranges, then it should/ ?

Regards.
