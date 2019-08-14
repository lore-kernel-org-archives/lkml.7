Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E1BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B88208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfHNSWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:22:33 -0400
Received: from verein.lst.de ([213.95.11.211]:40221 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfHNSWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:22:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 314CD68B02; Wed, 14 Aug 2019 20:22:29 +0200 (CEST)
Date:   Wed, 14 Aug 2019 20:22:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: unexport set_memory_x and set_memory_nx
Message-ID: <20190814182228.GA18779@lst.de>
References: <20190813090146.26377-1-hch@lst.de> <20190813090146.26377-2-hch@lst.de> <20190814165029.yfmpopn34vxpnmte@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814165029.yfmpopn34vxpnmte@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:50:29PM +0100, Will Deacon wrote:
> arm64 allmodconfig and defconfig are happy with this, so I'll pick it up
> for 5.4 if that's ok with you?

Sounds great.
