Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A185C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E5921882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfKFIzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:55:20 -0500
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:55124 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726830AbfKFIzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:55:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8824A180A68CB;
        Wed,  6 Nov 2019 08:55:18 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: shock61_4b3e606027b34
X-Filterd-Recvd-Size: 1995
Received: from grimm.local.home (unknown [94.155.134.143])
        (Authenticated sender: rostedt@goodmis.org)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Nov 2019 08:55:16 +0000 (UTC)
Date:   Wed, 6 Nov 2019 03:55:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
Subject: Re: [PATCH 2/2] tracing: Use seq_buf_hex_dump() to dump buffers
Message-ID: <20191106035512.3ff7bc20@grimm.local.home>
In-Reply-To: <1573021660-30540-2-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1573021660-30540-1-git-send-email-piotrx.maziarz@linux.intel.com>
        <1573021660-30540-2-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 07:27:40 +0100
Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:

> Without this, buffers can be printed with __print_array macro that has
> no formatting options and can be hard to read. The other way is to
> mimic formatting capability with multiple calls of trace event with one
> call per row which gives performance impact and different timestamp in
> each row.
> 
> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  include/linux/trace_events.h |  5 +++++
>  include/linux/trace_seq.h    |  4 ++++
>  include/trace/trace_events.h |  6 ++++++
>  kernel/trace/trace_output.c  | 15 +++++++++++++++
>  kernel/trace/trace_seq.c     | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 60 insertions(+)
> 

I'd like to see in the patch series (patch 3?) a use case of these
added functionality. Or at least a link to what would be using it.

Thanks!

-- Steve
