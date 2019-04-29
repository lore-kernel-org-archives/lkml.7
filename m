Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87618C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EC62087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfD2Lzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:55:42 -0400
Received: from verein.lst.de ([213.95.11.211]:38049 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbfD2Lzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:55:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3039C68AFE; Mon, 29 Apr 2019 13:55:26 +0200 (CEST)
Date:   Mon, 29 Apr 2019 13:55:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: two small nommu cleanups
Message-ID: <20190429115526.GA30572@lst.de>
References: <20190423163059.8820-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423163059.8820-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments?  It would be nice to get this in for this merge window
to make my life simpler with the RISC-V tree next merge window..

On Tue, Apr 23, 2019 at 06:30:57PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> these two patches avoid writing some boilerplate code for the upcoming
> RISC-V nommu support, and might also help to clean up existing nommu
> support in other architectures down the road.
---end quoted text---
