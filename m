Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8E4C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CDE20722
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574663957;
	bh=xkacwS+//iyOXZA1xc8vJ55ct0+c517jzQk5SZvqBFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e7NHIcurKKV1G9UmmjPp8WkHSNwS//citcYy7M+Vip/Bt6IYWFpVAILP2jmCs9ZrW
	 IMb4YDxl8Kjk3njEjSe9Z0D+uAwsNTl4U0VUR/KYdF3gu7cZUFlpoQnKz0d1DuZupI
	 ptcLS3ILdOKg7qfqtafC9BzEtawL1yE/d7lozaEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfKYGjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:39:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfKYGjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 01:39:15 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6610D2071E;
        Mon, 25 Nov 2019 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574663955;
        bh=xkacwS+//iyOXZA1xc8vJ55ct0+c517jzQk5SZvqBFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hidi7cP3ogbdzhtqsYwewsyfW5pu/76pgY2xutaCoX7tvaTITBFSG3rChtUECQHXq
         /t7qeq65SCUj5Utzs2v+odgTPkRdPGj8/49Vpyo61tS9TtXbwnIg5fYP+iq82yuaS2
         lSZF0pPtI5EH+CRXBfQdqRkuoVgy1OAsc6SlSmW4=
Date:   Mon, 25 Nov 2019 15:39:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH v2 0/3] selftests/ftrace: Fix ftracetest
 testcases for non-function tracer case
Message-Id: <20191125153910.25b4c34a6bb181ac7ea2e651@kernel.org>
In-Reply-To: <157464067201.2006.6413506591718899129.stgit@devnote2>
References: <157464067201.2006.6413506591718899129.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 09:11:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 2nd version of patches to fix some issues which happens on
> the kernel with CONFIG_FUNCTION_TRACER=n or CONFIG_DYNAMIC_FTRACE=n.
> In this version I just updated the descriptions of the first 2 patches
> according to Steve's comment and add his Reviewed-by to the last patch.

Oops, I found another bug in ftracetest. I will send v3 with that patch.
Please ignore this v2.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
