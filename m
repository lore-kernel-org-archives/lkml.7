Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1942C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C956B2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHLVwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:52:14 -0400
Received: from verein.lst.de ([213.95.11.211]:51633 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHLVwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:52:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5693C68B20; Mon, 12 Aug 2019 23:52:07 +0200 (CEST)
Date:   Mon, 12 Aug 2019 23:52:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fix misc compiler warnings in the ia64 build
Message-ID: <20190812215207.GA21391@lst.de>
References: <20190812065524.19959-1-hch@lst.de> <3908561D78D1C84285E8C5FCA982C28F7F41C3D7@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F41C3D7@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 09:47:40PM +0000, Luck, Tony wrote:
> > this little series fixes various warnings I see in ia64 builds.
> 
> Applied. Thanks.
> 
> [I assume you are using some up-to-date version of gcc that generates these
>  warnings ... I'm not seeing them, but I'm still using a compiler from the stone
>  age]

This is with the gcc 8.1 x86 to ia64 binary from

http://kernel.mirror.ac.za/tools/crosstool/ that I found recently.  But
at least the fork.c and kprobes.c ones should probably show up with any
supported compiler, the switch ones are fairly new.
