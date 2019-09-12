Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9935FC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6718920830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbfILPBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 11:01:50 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:58292 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732728AbfILPBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 11:01:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B13BC18224D69;
        Thu, 12 Sep 2019 15:01:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pump00_49bc2d71dfd50
X-Filterd-Recvd-Size: 1798
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 15:01:46 +0000 (UTC)
Message-ID: <33c0f43ef2334de5885e5fcf041483a2afb13787.camel@perches.com>
Subject: Re: [PATCH 01/13] nvdimm: Use more typical whitespace
From:   Joe Perches <joe@perches.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org
Date:   Thu, 12 Sep 2019 08:01:45 -0700
In-Reply-To: <20190912121707.GA16029@infradead.org>
References: <cover.1568256705.git.joe@perches.com>
         <7a5598bda6a3d18d75c3e76ab89d9d95e8952500.1568256705.git.joe@perches.com>
         <20190912121707.GA16029@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 05:17 -0700, Christoph Hellwig wrote:
> Instead of arguing what is better just stick to what the surrounding
> code does.

That's not always feasible nor readable.

Especially for the logic inversion blocks where
the existing code does unreadable and error prone
things like hiding semicolons immediately after
comments.

	if (foo)
		/* longish comment */;
	else {
		<code>;
	}

> Or in other words:  Feel free to be a codingstyle nazi for your code
> (I am for some of mine), but leave others peoples code alone with
> "cleanup" patches.

My point was to avoid documenting per-subsystem
coding style rules.


