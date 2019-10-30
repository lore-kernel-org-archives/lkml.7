Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29325CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E822087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfJ3SMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:12:22 -0400
Received: from verein.lst.de ([213.95.11.211]:47124 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfJ3SMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:12:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C16EC68C4E; Wed, 30 Oct 2019 19:12:20 +0100 (CET)
Date:   Wed, 30 Oct 2019 19:12:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] dma-debug: add a schedule point in
 debug_dma_dump_mappings()
Message-ID: <20191030181220.GB19513@lst.de>
References: <20191028215646.16638-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028215646.16638-1-edumazet@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping for-next tree.
