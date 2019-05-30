Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BA3C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B13325A84
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfE3Gl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 02:41:56 -0400
Received: from verein.lst.de ([213.95.11.211]:60141 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3Gl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:41:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 78D3B68AFE; Thu, 30 May 2019 08:41:31 +0200 (CEST)
Date:   Thu, 30 May 2019 08:41:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Maciej Rozycki <macro@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel
 endianess
Message-ID: <20190530064131.GA29291@lst.de>
References: <20190412143538.11780-1-hch@lst.de> <alpine.DEB.2.20.1905300243200.18422@tpp.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1905300243200.18422@tpp.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 01:46:18AM +0000, Maciej Rozycki wrote:
> > +#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ != __ORDER_BIG_ENDIAN__
> > +#error "Unsupported endianess, check your toolchain"
> 
>  Typo here: s/endianess/endianness/.

The original patch has already been merged, please send a fixup.
