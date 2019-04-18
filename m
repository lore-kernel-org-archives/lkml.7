Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53E4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C012217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389558AbfDRPrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:47:32 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36691 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRPrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:47:32 -0400
Received: from [192.168.1.110] ([77.9.47.20]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mv3Ds-1gzTo12OIK-00r1CN; Thu, 18 Apr 2019 17:46:49 +0200
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
To:     Christian Brauner <christian@brauner.io>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
References: <20190414201436.19502-1-christian@brauner.io>
 <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin>
 <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <c783a83a-01a1-9813-e2f7-0516cf7a1c16@metux.net>
 <CALCETrWWoEvnzx6oLTEajBmiArScX5sSt74o2VO+aTiwEi_9mQ@mail.gmail.com>
 <e58d1694-c143-3465-512d-43301422bd8b@metux.net>
 <20190417125422.bhyrmzom4kwuenwm@brauner.io>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <ac16b51d-3bcf-45ff-aa57-85d5da7224c2@metux.net>
Date:   Thu, 18 Apr 2019 17:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190417125422.bhyrmzom4kwuenwm@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IYyhrkNwNtN2c6nuYeX55XOpxaneFFayWbSo+WzAChYG4HifQ9Y
 2EBkdauofB47gqh6ieyX0QBtJiEXZJt6gJzKKsZ4uZMIvpaloJiMHJl+/qUWegj34i7efv2
 sOl45zyKVlZeY09RnstPdYSwTuW8DzzosqhkSsG4Oc6BElqAMF+k+LhOEJaQmPdO4SR9umH
 LcCBrP3lBjNiZ3tbiarOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ebDP8A//y0=:1vYuZJYwjSWxGy66UCRA8j
 kb8gEpsP5mY20IMUxfrnsjTAngLbksePjqncQYDwHwfctUyaLGVScfnrq4l/befRpA75taIxR
 fFBynx79+ZcSBml9oNmECqWszqwrSzFKUdbGOgThFSal58oEfJKioFMO0uT5QziowURULVszw
 QCYArVYdDk1uK1pYw+jfHajWc5tMxbRZP3+ZBzwXhiJoAuuU5KhJczhgLtLHxUAcDSs3/UhEE
 imJyaZmGmCBeucxigKTDpkvbu4iuYTUvomv+ZUhoik0sqvNg0z4ktCr8dxDxnZJ43KYeeQqWI
 b/d8I9zBVjYzOyJ6PKGbps5EBcKq/Ugp2soggAHDRFQsAwNa4T80CktnPcEuoQ7xc54zGE/+6
 mb0+gfb8QuxeUNrvOFwsNOdHdZBgyfxuz7dukYxYOnYrEYv9FzdCiuZD3QgTK2932QyYRj6ah
 G0R52YwvoOBL+uzk8gyNwUk7ChsvfrandvsNx7Qu6OY8RALp0WK7uEAxM6MfC1J/fAFbY7A+V
 oV1HBczXmSUZm+RBghBP66JsLsGAy1WEfh++H1mE5qkpPN9csRnSt16AxiMihUB85DkPUpxUV
 YXM8bVYZJdHluDwTiTLVTOh6xh2Y5U2dtU4cn6DO4/FI26+no2/y41Y+takTc1zWIBwdhAQBP
 YvdjrkpGpAVQwYyZ0IJDsTk55Rk1586hTl0+foeRJ0lipxKxdIpQULAg4HM8vYhpFQf04By1R
 eB6t68VD04Lj8t8WsHpcwsuyEmPn0WyY+s9E+Ueo5qeigo3eebzUrRe0fTQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.19 14:54, Christian Brauner wrote:

>> Ah, that is a cool thing !>> I suppose that also works across namespaces ?> > Yes, it should. If
you hand off the pidfd to another pidns (e.g. via SCM> credentials) for
example.
I thought about things like sending the pidfd via unix socket.
It would be really cool if the receiving process could then control
the referred process (eg. send signals), even if it's in a different
pidns.

>> What other things can be done via pidfd ?
> 
> Very basic things right now and until CLONE_PIDFD is accepted (possibly
> for 5.2) we won't enable any more features.
> I'm not a fan of wild speculations and grand schemes that then don't
> come to fruition. :) Right now it's about focussing on somewhat cleanly
> covering the basics. Coming to a consensus there was hard enough. We
> have no intention in making this more complex right now as it needs to
> be.

IMHO, it would be good if it would support all operations that now can
be done via numerical PID, and w/ the permissions of the process who
created that pidfd. Certainly, that would also need some lockdown
mechanism, so the creating process can define what the holder of the
fd can actually do.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
