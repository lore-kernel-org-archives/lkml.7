Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA2820675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfD2MiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:38:16 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:60492 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbfD2MiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:38:16 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 861765C0C43; Mon, 29 Apr 2019 14:37:23 +0200 (CEST)
Date:   Mon, 29 Apr 2019 14:37:23 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Edward Cree <ecree@solarflare.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rds: ib: force endiannes annotation
Message-ID: <20190429123723.GA18362@osadl.at>
References: <1556518178-13786-1-git-send-email-hofrat@osadl.org>
 <20443fd3-bd1e-9472-8ca3-e3014e59f249@solarflare.com>
 <20190429111836.GA17830@osadl.at>
 <20190429122132.GA32474@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429122132.GA32474@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 05:21:32AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 29, 2019 at 01:18:36PM +0200, Nicholas Mc Guire wrote:
> > changing uncongested to __le64 is not an option here - it would only move
> > the sparse warnings to those other locatoins where the ports that 
> > became uncongested are being or'ed into uncongested.
> 
> Than fix that a well.  Either by throwing in a conversion, or
> add {be,le}XX_{and,or} helpers.

ok - that is an option in that case - will try that route

thx!
hofrat
