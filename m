Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A829AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C462075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDOKI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:08:58 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOKI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:08:58 -0400
Received: from [192.168.1.110] ([95.115.91.41]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZjQl-1hK3Z5495z-00WoSD; Mon, 15 Apr 2019 12:08:13 +0200
Subject: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
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
Message-ID: <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
Date:   Mon, 15 Apr 2019 12:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190414201436.19502-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CppkLBFAQ5VngkZ9OaDM4DFt8Che81pzKFVU8Ac4OttUp1lmrZS
 b7Emi/b+QPXLshyrmJmnwH+ADdGUtVhAdgzWXFBKLJfFF6BDxEAXZxBkDgQnkG5ZzhcIcA2
 syjRZH7pe2QLR6kvltuVCUdJ6PdQkv0SUEGaE/wxjC6HTBlT0MCnFyVo3bpSxOFyf9xPi5v
 OpNuP6urMZdqlZRMfL+AQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9TDmmkiFtQI=:FCGjtchip+z2/utjrrxbvh
 9RiomPtCgc5XYZ18bEGqE0wkQJukLcffVJwZM1/7U4rXfqBap36yC/G/oOJ5K4u3+n27m0ZzO
 hwqhVyg4rH3njcezWvEbTMdy/flPha/1NQgnW646z53sKIMM4UP0yjrpZhNM4WdWcyyWKSWGS
 wFvZusmgXtCUnmQjgKcImD3GExYMYJgqxUMdh7XWutehlSCVW7EYLlpmddKo6GgTv2FBOOGCA
 MMpriAu/TEqeNSQLxIOvHuzw3yDF92xrq7BjgWC35fxY1mmmpYtmTZMAK2YfRBa856k1bk7QW
 Qk14g4vAtF1QO3jUuVdADkZpe21JFNC+2G2GOl5ebXo0Aa57G0HpxYByByAXelDyvrwASSrVF
 +fa6fhx1V2zc/qS8A9DEqqBPJEsyklO22HBulGeRLb8OIwxxLwaUBN0u+skdqD05hKmuZDz9O
 6vYOrFFPj79vhW6MdIpFyrpnvUO+nMrEF9HgMe0wo3fRWvLXn9agf3O6QdoycK50F/MA/BW1c
 YoYkcNl/V3vUpNIYE5MzVqU/A9la6Ch+Pp2caRV30uKaUdMrxCqJqzSyyOihkfqtCWIB4kpFq
 pOtdATFgGH1EwY+IWmrwp92apd4ryrOdF0rnCcxjd0T4K4Gdvn1TpA20lw3TPpvZvuqRBnnP7
 2d7eB+yWvKM7rauN3I9Eu2OVHvWxZ+ubzgBjVfRnUwaMzuMMbuUdXA3fceZWHVLmU90SKJFAJ
 Rs/qZV4ai207upIyMbVrV2Cxkvi0OXu5sriLf04igvFjEp89z2ituV5ZmE0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.19 22:14, Christian Brauner wrote:

Hi folks,

> This patchset makes it possible to retrieve pid file descriptors at
> process creation time by introducing the new flag CLONE_PIDFD to the
> clone() system call as previously discussed.

Sorry, for highjacking this thread, but I'm curious on what things to
consider when introducing new CLONE_* flags.

The reason I'm asking is:

I'm working on implementing plan9-like fs namespaces, where unprivileged
processes can change their own namespace at will. For that, certain
traditional unix'ish things have to be disabled, most notably suid.
As forbidding suid can be helpful in other scenarios, too, I thought
about making this its own feature. Doing that switch on clone() seems
a nice place for that, IMHO.

As there might be potentially even more CLONE_* flags in the future,
and the bitmask size is limited, this raises the question on how to
proceed with those flag additions in the future.

What's your thoughts on that ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
