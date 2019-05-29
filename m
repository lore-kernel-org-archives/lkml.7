Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E64FC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C5024233
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE2Vta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:49:30 -0400
Received: from ms.lwn.net ([45.79.88.28]:43738 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfE2Vta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:49:30 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 780D460C;
        Wed, 29 May 2019 21:49:29 +0000 (UTC)
Date:   Wed, 29 May 2019 15:49:28 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masanari Iida <standby24x7@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rdunlap@infradead.org
Subject: Re: [PATCH] [linux-next] docs: tracing: Fix typos in histogram.rst
Message-ID: <20190529154928.29b15e51@lwn.net>
In-Reply-To: <20190521085525.2963c10f@gandalf.local.home>
References: <20190521123000.24544-1-standby24x7@gmail.com>
        <20190521085525.2963c10f@gandalf.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 08:55:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 21 May 2019 21:30:00 +0900
> Masanari Iida <standby24x7@gmail.com> wrote:
> 
> > This patch fixes some spelling typos in histogram.rst  
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Jon,
> 
> Care to take this in your tree?

Done, thanks.

jon
