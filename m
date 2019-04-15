Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD6C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077FF2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfDOKRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:17:42 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51873 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfDOKRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:17:41 -0400
Received: from [192.168.1.110] ([95.115.91.41]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MyseA-1guZxv1cws-00vuvR; Mon, 15 Apr 2019 12:17:01 +0200
Subject: Re: [PATCH 0/4] clone: add CLONE_PIDFD
To:     Christian Brauner <christian@brauner.io>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com
References: <20190414201436.19502-1-christian@brauner.io>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <81fa3d00-70be-0d41-e145-60285e23687d@metux.net>
Date:   Mon, 15 Apr 2019 12:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190414201436.19502-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ilDg3EbtXxkEvgvS8h/9sd/77k13CHF2jKgwBVmi7h3H7vnkkqL
 /oNXCe0zaR/E0oFGuDZpclLaa9sh3XHHyPH+19afoyZPmrPsBbsUDKHmX8dnX4pYgtsUvlD
 LmDkmLcnYGc8U/D5HIjSgUDnp3DXYolqS1oFALAPhK6wt79psYR69cXRL5VEO/qHfrvug+x
 PjIsAC2g2BaJUuQ27pJPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KevQ2pSIMQk=:2nxwiZowLEW3BNBTmqxBD1
 m6IwxsuMi6Sr+X5KmzOh8bK1E+RXG/iQlthjnLcqAGhEyFsAC1XzPENKImUBPNbHsiptbP9Jm
 Cp1IiMWHgn0M50Wy5j+QFyLlfCQJ5OgY7nk+GkPWuQCAsyop/VEfu13V2OaYKpYbt7TZ0X0B/
 zDLhemzEgLbxbnKIuiXN9JiVEFgv1wArHGteYQI/IuFJVQ14JjX30lzK+BlnE9EXKvHQoFqUJ
 wSRurA/OwBB8+aHFcroM/CuT2hiyqSvWR8n3TTHlsC2pY0LnU3p5m3tGXsnXFvaDUpLfyu2p7
 P3mxGuDF1XduCtVn69jRSgC2AlwVYypAUJTMyR4ovMAQRnwvzXHH9SRMOvJNtau4uDToAEpxH
 GhqfoUIuItYI/JEqQLXZKjnfUgSrKheFPAL4xixLnayubNDkUgpKDzX9ya5qatCGCRJN2koty
 hy2Kq1HgkrmdAH0kHw4CHEHA8Ofu8jfdwM0yk2wPKM+p2Q4gXbDdGnlyqHO7IjiDtrlkq1Oiz
 zoNIOA7irFFHmQIyTAbPO5alLBEYojKlOA8v9g1OhY5LWD8W/KcRGpjWckvct0M3VpBQ/j2iL
 7K74+cvpovK+mLvBN7cFj9Ey/RPugwwWJyN0nLQmKfFsrEaW0YXeuoRGetjBtQvYC1n1GZv3A
 zDP/k1avusYCzOt44a8AHaPFQgcRS9G1KGfJIfhhWnVEmMaLnWz0Fuzr6wIFycW1k0bVeMz4g
 +amb4a4Kn417R09eUC0FRu8X5OMM7jVDhuDJ8wlZqNeWKTqMGXfTXgOV2AQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.19 22:14, Christian Brauner wrote:

Hi,

> When clone is called with CLONE_PIDFD a pidfd instead of a pid will be
> returned. 

Uh, changing the return type by some flags produces a very strange
feeling in my stomach. Isn't there any other way for fetching a pidfs
for some pid ?

> To make it possible for users of CLONE_PIDFD to apply standard
> error checking that is common all across userspace, file descriptor
> numbering for pidfds starts at 1 and not 0. 

Feels even more strange. I'm used to the kernel always picking the
lowest available pid. In some cases, one really wants to have fd 0.
Even though the actual usecases for doing that w/ a pidfd might be
pretty limited, I don't feel good w/ breaking this old habit.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
