Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDC4CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F562082C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409056AbfJRPre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:47:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50260 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389203AbfJRPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:47:34 -0400
Received: from [185.81.138.19] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iLUTQ-0007zq-SO; Fri, 18 Oct 2019 15:47:29 +0000
Date:   Fri, 18 Oct 2019 17:47:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Remove incorrect comment about vm_insert_page()
 behavior
Message-ID: <20191018154726.2qegz72tipyaeha7@wittgenstein>
References: <20191018153946.128584-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018153946.128584-1-jannh@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 05:39:46PM +0200, Jann Horn wrote:
> vm_insert_page() does increment the page refcount, and just to be sure,
> I've confirmed it by printing page_count(page[0].page_ptr) before and after
> vm_insert_page(). It's 1 before, 2 afterwards, as expected.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Seems this has always been the case since its introduction:
a145dd411eb2 ("VM: add "vm_insert_page()" function")

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
