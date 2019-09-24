Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA9EC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C4C20640
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbfIXOoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:44:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfIXOoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:44:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15A7010C0946;
        Tue, 24 Sep 2019 14:44:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.52])
        by smtp.corp.redhat.com (Postfix) with SMTP id E73075C1B2;
        Tue, 24 Sep 2019 14:44:18 +0000 (UTC)
Date:   Tue, 24 Sep 2019 16:44:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf, stat: Fix free memory access / memory leaks in
 metrics
Message-ID: <20190924144418.GC21815@krava>
References: <20190923233339.25326-1-andi@firstfloor.org>
 <20190923233339.25326-3-andi@firstfloor.org>
 <20190924075040.GC26797@krava>
 <20190924140856.GQ8537@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924140856.GQ8537@tassilo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Tue, 24 Sep 2019 14:44:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 07:08:56AM -0700, Andi Kleen wrote:
> > >  	expr__ctx_init(&pctx);
> > > +	/* Must be first id entry */
> > > +	expr__add_id(&pctx, name, avg);
> > 
> > hum, shouldn't u instead use strdup(name) instead of name?
> 
> The cleanup loop later skips freeing the first entry.

aaah, nice ;-)

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
