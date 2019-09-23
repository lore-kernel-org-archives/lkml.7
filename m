Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B91C4320D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAADE21A4C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408384AbfIWXfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:35:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55806 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfIWXfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:35:39 -0400
Received: by linux.microsoft.com (Postfix, from userid 1001)
        id 51E002008710; Mon, 23 Sep 2019 16:35:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 3A89930705AF;
        Mon, 23 Sep 2019 16:35:38 -0700 (PDT)
Date:   Mon, 23 Sep 2019 16:35:38 -0700 (PDT)
From:   James Morris <jamorris@linuxonhyperv.com>
X-X-Sender: jamorris@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
In-Reply-To: <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1909231633400.54130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com> <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com> <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Linus Torvalds wrote:

> Should we just remove safesetid again? It's not really maintained, and
> it's apparently not used.  It was merged in March (with the first
> commit in January), and here we are at end of September and this
> happens.

My understanding is that SafeSetID is shipping in ChromeOS -- this was 
part of the rationale for merging it.


-- 
James Morris
<jamorris@linuxonhyperv.com>
