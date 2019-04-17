Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D27D206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfDQMLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:11:47 -0400
Received: from ns.iliad.fr ([212.27.33.1]:56836 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfDQMLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:11:47 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 5D2C420103;
        Wed, 17 Apr 2019 14:11:45 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 48D3F200CA;
        Wed, 17 Apr 2019 14:11:45 +0200 (CEST)
Subject: Re: fs/proc: Crash observed in next_tgid (fs/proc/base.c)
To:     Jitendra Sharma <shajit@codeaurora.org>
References: <b5b9df7b-324c-8286-3a7c-e7812511772d@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <4cb1d095-54a1-a7aa-762f-df77dddc4621@free.fr>
Date:   Wed, 17 Apr 2019 14:11:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b5b9df7b-324c-8286-3a7c-e7812511772d@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Apr 17 14:11:45 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2019 14:58, Jitendra Sharma wrote:

> We are observing one kernel crash in next_tgid function through 
> getdents64 path. Call stack is as shown below:

It might help if you specify the exact kernel version you are discussing,
as in which tag or commit hash you are running.

Also, what are you doing to trigger the issue?

Regards.
