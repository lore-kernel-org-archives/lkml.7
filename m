Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4A7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0086920652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbfDRJYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:24:34 -0400
Received: from ns.iliad.fr ([212.27.33.1]:49660 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfDRJYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:24:34 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id C60882043B;
        Thu, 18 Apr 2019 11:24:32 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id B19182035A;
        Thu, 18 Apr 2019 11:24:32 +0200 (CEST)
Subject: Re: fs/proc: Crash observed in next_tgid (fs/proc/base.c)
To:     Jitendra Sharma <shajit@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <b5b9df7b-324c-8286-3a7c-e7812511772d@codeaurora.org>
 <4cb1d095-54a1-a7aa-762f-df77dddc4621@free.fr>
 <e347f9fa-824d-bfe6-055c-1582c42d76e8@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <64ff5437-a3f9-2041-5110-06ec4dd67b2a@free.fr>
Date:   Thu, 18 Apr 2019 11:24:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e347f9fa-824d-bfe6-055c-1582c42d76e8@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Apr 18 11:24:32 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NB: it is preferable to avoid top-posting here.

On 17/04/2019 18:58, Jitendra Sharma wrote:

> Kernel version: 4.14.83

NB2: 4.14.83 is obsolete, as it stands 2255 patches behind the tip of
linux-4.14.y (though only 4 patches in fs/proc).

NB3: 4.14 is 108499(!!) patches behind v5.1-rc5 (latest release). It makes
sense to test on a recent kernel, in case someone has solved the issue along
the way (then the bisecting fun can begin).

> Test case: Not some specific test case. Issue reproduced while doing 
> monkey testing for very long hours.

I'm not sure what "monkey testing" entails...

Any relation to the infinite monkey theorem?
https://en.wikipedia.org/wiki/Infinite_monkey_theorem

Regards.
