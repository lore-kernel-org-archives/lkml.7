Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D876C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F04E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbfDXQQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:16:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfDXQQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:16:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9F8430894F9;
        Wed, 24 Apr 2019 16:16:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id A8CD35D9C8;
        Wed, 24 Apr 2019 16:16:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Apr 2019 18:16:45 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:16:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     weizhenliang <weizhenliang@huawei.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "colona@arista.com" <colona@arista.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Re: [PATCH v4] signal: trace_signal_deliver when
 signal_group_exit
Message-ID: <20190424161641.GI16167@redhat.com>
References: <AF4D908CC0E2A24EB308A26962C8C3BDEB1A2B@DGGEMI530-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF4D908CC0E2A24EB308A26962C8C3BDEB1A2B@DGGEMI530-MBX.china.huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 24 Apr 2019 16:16:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, weizhenliang wrote:
>
> On 04/24, Oleg wrote:
> >On 04/24, Christian Brauner wrote:
> >>
> >> On Wed, Apr 24, 2019 at 08:52:38PM +0800, Zhenliang Wei wrote:
> >>
> >> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> >
> >Yes, but ...
> >
> >> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> >Hmm, really?
>
> Yes, the kbuild test robot says that if I fix the problem with the third parameter type,
> I should add this tag. What is wrong or missing?

But this patch does not fix the problem reported by robot, your patch
(which introduced that problem) was dropped, the problem has gone.

With this "Reported-by: kbuild test robot <lkp@intel.com>" tag it looks
as if test-robot has found the problem you are trying to fix: the lack of
trace_signal_deliver(SIGKILL).

Oleg.

