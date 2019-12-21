Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386E8C2D0D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E1E21655
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLUI2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:28:01 -0500
Received: from verein.lst.de ([213.95.11.211]:50389 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfLUI2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:28:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4DDB768B20; Sat, 21 Dec 2019 09:27:58 +0100 (CET)
Date:   Sat, 21 Dec 2019 09:27:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the generic-ioremap tree with the
 nvdimm-fixes tree
Message-ID: <20191221082758.GA3413@lst.de>
References: <20191218123205.3fb9c793@canb.auug.org.au> <20191218124950.191d9df4@canb.auug.org.au> <CAPcyv4jDozHaSCw26onPfmT1xefX2S2NB3RGL8pz1UWz=UDWWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jDozHaSCw26onPfmT1xefX2S2NB3RGL8pz1UWz=UDWWw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Dec 19, 2019 at 11:49:03AM -0800, Dan Williams wrote:
> Christoph are you going to submit that for v5.5 or is that v5.6 material?

This is intended for 5.6.  If you send your commit to Linus ASAP I can
still rebase.
