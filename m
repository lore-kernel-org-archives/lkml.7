Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F715C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EAC2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbfHON1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:27:32 -0400
Received: from verein.lst.de ([213.95.11.211]:46701 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbfHON1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:27:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A98968AFE; Thu, 15 Aug 2019 15:27:28 +0200 (CEST)
Date:   Thu, 15 Aug 2019 15:27:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Richard Kuo <rkuo@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hexagon: drop empty and unused free_initrd_mem
Message-ID: <20190815132728.GB12036@lst.de>
References: <1565858133-25852-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565858133-25852-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:35:33AM +0300, Mike Rapoport wrote:
> hexagon never reserves or initializes initrd and the only mention of it is
> the empty free_initrd_mem() function.
> 
> As we have a generic implementation of free_initrd_mem(), there is no need
> to define an empty stub for the hexagon implementation and it can be
> dropped.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
