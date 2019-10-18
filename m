Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D3ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A9C222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634247AbfJROyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393860AbfJROyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:54:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52205222C2;
        Fri, 18 Oct 2019 14:54:19 +0000 (UTC)
Date:   Fri, 18 Oct 2019 10:54:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Cc:     Zhengjun Xing <zhengjun.xing@linux.intel.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: fix "gfp_t" format for synthetic events
Message-ID: <20191018105417.3dc82a31@gandalf.local.home>
In-Reply-To: <2207cdd0-d44c-1c12-001a-f93203d3ceca@linux.intel.com>
References: <20191018012034.6404-1-zhengjun.xing@linux.intel.com>
        <2207cdd0-d44c-1c12-001a-f93203d3ceca@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 09:41:05 -0500
"Zanussi, Tom" <tom.zanussi@linux.intel.com> wrote:

> Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks Zhengjun and Tom!

I'll apply this to my urgent branch and get it upstream (even though
it's a minor fix).

-- Steve
