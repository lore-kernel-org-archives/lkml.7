Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4274C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7DB20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfHFOnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:43:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730489AbfHFOnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:43:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9996A3007F39;
        Tue,  6 Aug 2019 14:43:19 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-27.phx2.redhat.com [10.3.112.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F08ED67618;
        Tue,  6 Aug 2019 14:43:18 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 6D27612E; Tue,  6 Aug 2019 11:43:15 -0300 (BRT)
Date:   Tue, 6 Aug 2019 11:43:15 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com
Subject: Re: [PATCH v6 0/7] perf, intel: Add support for PEBS output to Intel
 PT
Message-ID: <20190806144315.GA2460@redhat.com>
References: <20190806084606.4021-1-alexander.shishkin@linux.intel.com>
 <20190806143032.GU2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806143032.GU2332@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 06 Aug 2019 14:43:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 06, 2019 at 04:30:32PM +0200, Peter Zijlstra escreveu:
> On Tue, Aug 06, 2019 at 11:45:59AM +0300, Alexander Shishkin wrote:
> 
> > Seventh attempt at the PEBS-via-PT feature. The previous ones were [1], [2],
> > [3], [4], [5], [6]. This one finalizes the 'aux_output' naming in the code.
> 
> > Alexander Shishkin (2):
> >   perf: Allow normal events to output AUX data
> >   perf/x86/intel: Support PEBS output to PT
> 
> Thanks Alexander!, I've picked up the above two patches.
> 
> > Adrian Hunter (5):
> >   perf tools: Add aux_output attribute flag
> >   perf tools: Add itrace option 'o' to synthesize aux-output events
> >   perf intel-pt: Process options for PEBS event synthesis
> >   perf tools: Add aux-output config term
> >   perf intel-pt: Add brief documentation for PEBS via Intel PT
> 
> Arnaldo, can you either ack (in which case I'll pick them up) or
> otherwise take care of these?

Lemme pick those, so that it goes thru the container build tests, etc.

- Arnaldo
