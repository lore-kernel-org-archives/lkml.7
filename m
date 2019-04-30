Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D49C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC5A2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfD3M3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:29:19 -0400
Received: from ms.lwn.net ([45.79.88.28]:48108 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfD3M3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:29:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B07B49AF;
        Tue, 30 Apr 2019 12:29:17 +0000 (UTC)
Date:   Tue, 30 Apr 2019 06:29:13 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: translation alignment
Message-ID: <20190430062913.14f97f9c@lwn.net>
In-Reply-To: <20190429214720.25725-1-federico.vaga@vaga.pv.it>
References: <20190429214720.25725-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 23:47:20 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> Aling Italian translation after the following changes in Documentation
> 
> bba757d8578f coding-style.rst: Generic alloc functions do not need OOM logging
> d8e8bcc3d8de docs: doc-guide: remove the extension from .rst files
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Something stuffed a blank line into this one that made it fail to apply;
I fixed that up, fixed the typo in the title, and applied it.

Thanks,

jon
