Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0001BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBFD2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfF1GA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:00:29 -0400
Received: from verein.lst.de ([213.95.11.210]:45236 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfF1GA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:00:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5A6E568D07; Fri, 28 Jun 2019 08:00:25 +0200 (CEST)
Date:   Fri, 28 Jun 2019 08:00:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] dma-mapping: remove dma_max_pfn
Message-ID: <20190628060024.GA27433@lst.de>
References: <20190625092042.19320-1-hch@lst.de> <20190625092042.19320-3-hch@lst.de> <2cf24650-512e-688d-fe24-119d36ed92f5@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf24650-512e-688d-fe24-119d36ed92f5@free.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 01:45:38PM +0200, Marc Gonzalez wrote:
> Hello Christoph,
> 
> There are some typos in the commit message that make it harder
> (for me) to parse.

The fixes looks good to me.  Ulf, do you want me to resend?
