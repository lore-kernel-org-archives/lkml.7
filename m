Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6F0C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B4C20685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfDVNp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:45:57 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:52398 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfDVNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:45:57 -0400
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id 508F8200579; Mon, 22 Apr 2019 13:45:56 +0000 (UTC)
Date:   Mon, 22 Apr 2019 15:45:56 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Christoph Hellwig <hch@infradead.org>, Ondrej Zary <linux@zary.sk>
Cc:     Rik Faith <faith@cs.unc.edu>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fdomain: Resurrect driver
Message-ID: <20190422134556.an6oh4q2m3j4pydc@isilmar-4.linta.de>
References: <20190420201126.827-1-linux@zary.sk>
 <20190421063513.GA2288@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421063513.GA2288@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 11:35:13PM -0700, Christoph Hellwig wrote:
> As mentioned before:  please drop the unused ISA and PCIMCIA code.
> We don't need to (re-)add untested code.

I fully agree with regard to the PCMCIA part.

Thanks,
	Dominik
