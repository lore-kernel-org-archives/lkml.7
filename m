Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF03C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90CB218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfDXMoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:44:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDXMoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:44:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20C0C30A9DE4;
        Wed, 24 Apr 2019 12:44:22 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-22.phx2.redhat.com [10.3.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A1095D705;
        Wed, 24 Apr 2019 12:44:21 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 536C662CF; Wed, 24 Apr 2019 09:44:27 -0300 (BRT)
Date:   Wed, 24 Apr 2019 09:44:27 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools lib traceevent: Change tag string for error
Message-ID: <20190424124427.GC4339@redhat.com>
References: <20190424013802.27569-1-leo.yan@linaro.org>
 <20190424080829.0043469b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424080829.0043469b@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 24 Apr 2019 12:44:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 24, 2019 at 08:08:29AM -0400, Steven Rostedt escreveu:
> On Wed, 24 Apr 2019 09:38:02 +0800
> Leo Yan <leo.yan@linaro.org> wrote:
> 
> > The traceevnt lib is used by perf tool, when execute 'perf test -v 6' it
> > outputs error log on ARM64 platform:
> > 
> >   running test 33 '*:*'trace-cmd: No such file or directory
> > 
> >   [...]
> > 
> >   trace-cmd: Invalid argument
> > 
> > The trace event parsing code originally came from trace-cmd so it keeps
> > the tag string "trace-cmd" for errors, this easily introduces the
> > impression that perf tool launches trace-cmd command for trace event
> > parsing, but in fact the related parsing is accomplished by traceevent
> > lib.
> > 
> > This patch changes the tag string to "libtraceevent" so can avoid
> > confusion and let users to be more easily to connect the error with
> > traceevent lib.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Arnaldo,
> 
> Can you pull this into your tree.

Sure, applied.

- Arnaldo
