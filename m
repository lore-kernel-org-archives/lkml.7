Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC214C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A057F204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfDPPJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:09:00 -0400
Received: from ms.lwn.net ([45.79.88.28]:39034 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDPPJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:09:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 452DE738;
        Tue, 16 Apr 2019 15:08:59 +0000 (UTC)
Date:   Tue, 16 Apr 2019 09:08:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Masanari Iida <standby24x7@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH] docs: trace: fix some Sphinx warnings
Message-ID: <20190416090858.3cebacfe@lwn.net>
In-Reply-To: <20190415183451.506a4b6a@gandalf.local.home>
References: <466439c96cc753254dc0fab97902d3d12aaf1e6a.1555358399.git.mchehab+samsung@kernel.org>
        <20190415183451.506a4b6a@gandalf.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 18:34:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 15 Apr 2019 17:00:05 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > There are some warnings produced when building trace. Fix them.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Jon,
> 
> Care to take this through your tree?

I've applied it, thanks.

jon
