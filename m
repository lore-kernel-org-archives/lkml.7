Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E298DCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12D82087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfJ2Kq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:46:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:44294 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfJ2Kq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:46:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 92E534FA;
        Tue, 29 Oct 2019 10:46:26 +0000 (UTC)
Date:   Tue, 29 Oct 2019 04:46:22 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     rppt@linux.ibm.com, willy@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] docs/core-api: memory-allocation: minor cleanups
Message-ID: <20191029044622.1f465a6d@lwn.net>
In-Reply-To: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 08:50:13 +1300
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Clean up some formatting and add references to helpers for calculating sizes
> safely.
> 
> This series is based of v5.4-rc4.
> 
> There was a merge conflict with commit 59bb47985c1d ("mm, sl[aou]b: guarantee
> natural alignment for kmalloc(power-of-two)") and the c:func: patch is
> dependent on the typo fix. The former was resolved with a rebase, the latter by
> actually sending it as part of the series.
> 
> Chris Packham (3):
>   docs/core-api: memory-allocation: fix typo
>   docs/core-api: memory-allocation: remove uses of c:func:
>   docs/core-api: memory-allocation: mention size helpers
> 
>  Documentation/core-api/memory-allocation.rst | 50 ++++++++++----------
>  1 file changed, 24 insertions(+), 26 deletions(-)

OK, this series is (finally) applied, thanks for your patience...

jon
