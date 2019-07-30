Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB67C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D58208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbfG3PDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfG3PDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:03:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39297206B8;
        Tue, 30 Jul 2019 15:03:08 +0000 (UTC)
Date:   Tue, 30 Jul 2019 11:03:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 00/12] tracing/probe: Add multi-probes per event
 support
Message-ID: <20190730110305.65499a5a@gandalf.local.home>
In-Reply-To: <20190730152331.2e5867bf8ec7e57bd8dc64d5@kernel.org>
References: <156095682948.28024.14190188071338900568.stgit@devnote2>
        <20190704153958.16a97c881aebbc5898b1264e@kernel.org>
        <20190704072833.4bc17d3c@gandalf.local.home>
        <20190730152331.2e5867bf8ec7e57bd8dc64d5@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 15:23:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Have you already picked this series?
> If not yet, should I update and resend this series?

I started to, but then got distracted :-/

I'll work with the current series, no need to resend.

Sorry for the delay.

-- Steve
