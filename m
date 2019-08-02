Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA76C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC09220B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437035AbfHBUqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 16:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfHBUqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 16:46:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C273D2087E;
        Fri,  2 Aug 2019 20:46:43 +0000 (UTC)
Date:   Fri, 2 Aug 2019 16:46:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: Re: [PATCH 7/7] tracing: Un-export ftrace_set_clr_event
Message-ID: <20190802164641.46416744@gandalf.local.home>
In-Reply-To: <291a12f6-e1eb-052e-0dd6-0e649dd4a752@oracle.com>
References: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
        <1564444954-28685-8-git-send-email-divya.indi@oracle.com>
        <20190729205138.689864d2@gandalf.local.home>
        <8e50d405-a4fb-fadf-509e-157b031d7542@oracle.com>
        <20190802134229.2a969047@gandalf.local.home>
        <291a12f6-e1eb-052e-0dd6-0e649dd4a752@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 13:41:20 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> > As a stand alone patch, the first one may be fine. But as part of a
> > series, it doesn't make sense to add it.  
> 
> I see. Will separate this out from the series.

Is that really needed? Do you need to have that patch in the kernel?

Do you plan on marking it for stable?

-- Steve
