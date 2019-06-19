Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76119C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5003E2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956993;
	bh=jMdfSXjMcnISGa2XjSMS+icXug42jIdkhV/ALhF0+ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dLM5vV/sZFnPjadYVZXSaTBrNq/4irXAbYT3ZedO2epdX0RbEfLWfUBPjhdFas2f+
	 3ZaNh7bBUC02z2/3JnS5X/f1oRsKNcv1UtQ0ohfORHedIXGfnG31zHMg/sm8ihlPQ2
	 kV1KcskFW+LewhbBhmM71eVunaokQxv3Xeagk8KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbfFSPJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbfFSPJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:09:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 511B721880;
        Wed, 19 Jun 2019 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956989;
        bh=jMdfSXjMcnISGa2XjSMS+icXug42jIdkhV/ALhF0+ZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NlfejeIJ5B++lX1xsL/y/L0rjrt7epuIQeeNRhoK1TANLapEztLrKrQKq7lvkFew5
         ehnlANllw6zBU7gdN+4N4OHXbwdnOc76vmkraQUUo0OhJSAC+O6I6cqjSffNbr540C
         J1sMi1elz1bqQC5sKNqnbG+Fey+/UhzTft1c04BM=
Date:   Thu, 20 Jun 2019 00:09:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: Re: [PATCH 1/6] docs: trace: fix a broken label
Message-Id: <20190620000945.d77311b928d647053e1a111d@kernel.org>
In-Reply-To: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 15:51:17 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Sphinx warnings about his:
> 
> 	Documentation/trace/kprobetrace.rst:68: WARNING: undefined label: user_mem_access (if the link has no caption the label must precede a section header)
> 
> The problem is quite simple: Sphinx wants a blank line after
> references.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

This also looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  Documentation/trace/kprobetrace.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index b729b40a5ba5..3d162d432a3c 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -96,6 +96,7 @@ which shows given pointer in "symbol+offset" style.
>  For $comm, the default type is "string"; any other type is invalid.
>  
>  .. _user_mem_access:
> +
>  User Memory Access
>  ------------------
>  Kprobe events supports user-space memory access. For that purpose, you can use
> -- 
> 2.21.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
