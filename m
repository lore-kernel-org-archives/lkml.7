Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9773AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F87820857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDIVUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:20:32 -0400
Received: from ms.lwn.net ([45.79.88.28]:45672 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfDIVUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:20:31 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4831D2BD;
        Tue,  9 Apr 2019 21:20:31 +0000 (UTC)
Date:   Tue, 9 Apr 2019 15:20:30 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] docs: Remove unnecessary reference link title
Message-ID: <20190409152030.2ed66e86@lwn.net>
In-Reply-To: <20190409004359.29668-4-tobin@kernel.org>
References: <20190409004359.29668-1-tobin@kernel.org>
        <20190409004359.29668-4-tobin@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Apr 2019 10:43:58 +1000
"Tobin C. Harding" <tobin@kernel.org> wrote:

> Labels that precede a heading use the heading as the link title.
> Explicitly adding the link title is redundant and  makes the reference
> slightly less maintainable.
> 
> Remove unnecessary reference link title.

So I agree with the objective, but...

> -	As mentioned above in :ref:`VMA policies <vma_policy>` section,
> +	As mentioned above in :ref:`vma_policy` section,

...this one generates a warning that highlights a flaw in the reasoning
here:

	Documentation/admin-guide/mm/numa_memory_policy.rst:144: WARNING:
	undefined label: vma-policy (if the link has no caption the label
	must precede a section header)

Said label does not precede a section header, so it can't be used bare in
this way.

I'll apply the other three, but this one needs some repairs :)

Thanks,

jon
