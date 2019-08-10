Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4911C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8334021743
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 17:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfHJRmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 13:42:08 -0400
Received: from verein.lst.de ([213.95.11.211]:35654 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfHJRmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 13:42:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C43268BFE; Sat, 10 Aug 2019 19:42:05 +0200 (CEST)
Date:   Sat, 10 Aug 2019 19:42:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, hch@lst.de,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 9
Message-ID: <20190810174205.GA11215@lst.de>
References: <20190809180350.5cf09351@canb.auug.org.au> <CADYN=9LPrQyCqWyUG-SUZircE=0rjkeQaASqUtAM--5CoaZCiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9LPrQyCqWyUG-SUZircE=0rjkeQaASqUtAM--5CoaZCiw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed in the dma-mapping-for-linus tree, which means the pull request
will be delayed until next week.  Thanks for the report.
