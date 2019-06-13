Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284E021473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfFMVy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:54:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfFMVy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:54:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 708C03082E06;
        Thu, 13 Jun 2019 21:54:59 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-33.phx2.redhat.com [10.3.112.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD7475B68A;
        Thu, 13 Jun 2019 21:54:58 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 0B01D115; Thu, 13 Jun 2019 18:54:55 -0300 (BRT)
Date:   Thu, 13 Jun 2019 18:54:54 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf build failure with newer glibc headers
Message-ID: <20190613215454.GH2834@redhat.com>
References: <4c0a4264-7142-2e6d-540d-aa354700e0bb@redhat.com>
 <20190612205611.GA2149@redhat.com>
 <20190613151925.GA2834@redhat.com>
 <20190613204454.GB18963@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613204454.GB18963@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 13 Jun 2019 21:54:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 13, 2019 at 10:44:54PM +0200, Jiri Olsa escreveu:
> On Thu, Jun 13, 2019 at 12:19:25PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 12, 2019 at 05:56:11PM -0300, Arnaldo Carvalho de Melo escreveu:
> > commit a04ef2eb0a66d9479e75e536d919c8c9cd618ee3
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Thu Jun 13 12:04:19 2019 -0300
> > 
> >     tools build: Check if gettid() is available before providing helper

> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> looks good to me, if needed:
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, added.

- Arnaldo
