Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ACEC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0708A216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391280AbfETOzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731455AbfETOzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:55:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBB07206BA;
        Mon, 20 May 2019 14:55:40 +0000 (UTC)
Date:   Mon, 20 May 2019 10:55:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 2/4] x86/ftrace: Fix use of flags in
 ftrace_replace_code()
Message-ID: <20190520105538.7f8515d3@gandalf.local.home>
In-Reply-To: <1558363129.y2x8hf9shq.naveen@linux.ibm.com>
References: <cover.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
        <e1429923d9eda92a3cf5ee9e33c7eacce539781d.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
        <20190520091320.01cdcfb7@gandalf.local.home>
        <20190520094410.772443df@gandalf.local.home>
        <1558363129.y2x8hf9shq.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 20:12:48 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:


> Thanks, that definitely helps make things clearer. A very small nit from 
> your first patch -- it would be good to also convert the calls to 
> ftrace_check_record() to use 'true' or 'false' for the 'update' field.

Heh, I was so focused on the "enable" part, I did the "update" as a
second thought, and forgot to update the callers. Thanks for pointing
that out.

> 
> I will test my series in more detail and post a v1.

Great.

-- Steve

