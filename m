Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BEEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1A52148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfDXPKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbfDXPKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:10:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE1420878;
        Wed, 24 Apr 2019 15:10:10 +0000 (UTC)
Date:   Wed, 24 Apr 2019 11:10:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 02/79] docs: trace: fix some Sphinx warnings
Message-ID: <20190424111009.63fa8007@gandalf.local.home>
In-Reply-To: <f3b8a921f5c19e16dba40a7af5e2fc56baf93c74.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
        <f3b8a921f5c19e16dba40a7af5e2fc56baf93c74.1555938375.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019 10:26:51 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> There are some warnings produced when building trace. Fix them.
> 

I guess I'm fine with this (I just read the text file as is).

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/trace/ftrace.rst    |  1 +
>  Documentation/trace/histogram.rst | 86 ++++++++++++++++---------------
>  2 files changed, 45 insertions(+), 42 deletions(-)
> 
