Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4333C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C7C20693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394459AbfIFOcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:32:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:41854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392864AbfIFOcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:32:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9D53B11B;
        Fri,  6 Sep 2019 14:32:01 +0000 (UTC)
Date:   Fri, 6 Sep 2019 16:32:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     James Byrne <james.byrne@origamienergy.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ABI: Update dev-kmsg documentation to match current
 kernel behaviour
Message-ID: <20190906143200.mjvre6x4gppfo2sq@pathway.suse.cz>
References: <0102016cf1b26630-8e9b337b-da49-43c6-b028-4250c2fac3ef-000000@eu-west-1.amazonses.com>
 <20190903050220.GB3978@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903050220.GB3978@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-09-03 14:02:20, Sergey Senozhatsky wrote:
> On (09/02/19 11:18), James Byrne wrote:
> > Commit 5aa068ea4082 ("printk: remove games with previous record flags")
> > abolished the practice of setting the log flag to 'c' for the first
> > continuation line and '+' for subsequent lines. Now all continuation
> > lines are flagged with 'c' and '+' is never used.
> >
> > Update the 'dev-kmsg' documentation to remove the reference to the
> > obsolete '+' flag. In addition, state explicitly that only 8 bits of the
> > <N> syslog prefix are used for the facility number when writing to
> > /dev/kmsg.
> >
> > Signed-off-by: James Byrne <james.byrne@origamienergy.com>
> 
> Looks good to me.
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch has been committed into printk.git, branch for-5.4.

Best Regards,
Petr Mladek
