Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5CFECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CABD21872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbfJAMtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:49:24 -0400
Received: from ms.lwn.net ([45.79.88.28]:36418 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387911AbfJAMtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:49:24 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4B25C6A2;
        Tue,  1 Oct 2019 12:49:23 +0000 (UTC)
Date:   Tue, 1 Oct 2019 06:49:22 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     bhenryj0117@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 2/2] docs: security: update base LSM documentation file
Message-ID: <20191001064922.683d6dfe@lwn.net>
In-Reply-To: <201909251300.E9B819EB37@keescook>
References: <20190925101745.3645-1-bhenryj0117@gmail.com>
        <20190925101745.3645-2-bhenryj0117@gmail.com>
        <201909251300.E9B819EB37@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 13:06:28 -0700
Kees Cook <keescook@chromium.org> wrote:

> > +always appears first in the stack of LSM hooks. A
> > +:c:func:`security_add_hooks()` function (in ``security/security.c``)  
> 
> IIUC, the :c:func:`...()` marking isn't needed any more, just having a
> word followed by "()" should trigger the markup.

That is correct; we now want to stomp out :c:func: wherever we see it...

Thanks,

jon
