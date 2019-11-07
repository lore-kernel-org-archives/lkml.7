Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC5C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D462084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbfKGRoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:44:05 -0500
Received: from verein.lst.de ([213.95.11.211]:58606 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729830AbfKGRoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:44:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 05F3068BE1; Thu,  7 Nov 2019 18:44:02 +0100 (CET)
Date:   Thu, 7 Nov 2019 18:44:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] dma-debug: increase HASH_SIZE
Message-ID: <20191107174401.GA19858@lst.de>
References: <20191030184844.84219-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030184844.84219-1-edumazet@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree for 5.5.
