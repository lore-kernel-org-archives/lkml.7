Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C591C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30CD2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfGRFsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 01:48:53 -0400
Received: from verein.lst.de ([213.95.11.211]:56624 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfGRFsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:48:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 74C6E68AFE; Thu, 18 Jul 2019 07:48:51 +0200 (CEST)
Date:   Thu, 18 Jul 2019 07:48:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: RFC: move kernel/memremap.c to mm/
Message-ID: <20190718054851.GA18376@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

was there any really good reason to have memremap.c in kernel/ back
when you started it?  It seems to be pretty much tried into the mm
infrastructure, and I keep mistyping the path.  Would you mind a simple
git-mv patch after -rc1 to move it to mm/ ?
