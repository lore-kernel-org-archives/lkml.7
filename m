Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789EEC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A7620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439427AbfFLNrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436800AbfFLNrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:47:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26307208CA;
        Wed, 12 Jun 2019 13:47:31 +0000 (UTC)
Date:   Wed, 12 Jun 2019 09:47:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Fix to init kprobes in subsys_initcall
Message-ID: <20190612094729.40106a28@gandalf.local.home>
In-Reply-To: <20190612165947.ba696696dac0faa3aa35a501@kernel.org>
References: <20190603214105.715a4072472ef4946123dc20@kernel.org>
        <155956708268.12228.10363800793132214198.stgit@devnote2>
        <20190612165947.ba696696dac0faa3aa35a501@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 16:59:47 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Could you pick this to your ftrace/core branch?

"core" or should this go to "urgent"? The difference is that core is
scheduled for the next merge window, and urgent is for the rc releases
(ie. bug fixes).

-- Steve

> 
> Thank you,
> 
> 
