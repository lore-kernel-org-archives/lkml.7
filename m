Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F732C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFBE2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfLTFAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 00:00:54 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:39866 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfLTFAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:00:54 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Dec 2019 00:00:54 EST
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 96E0115CBE3;
        Fri, 20 Dec 2019 13:53:37 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-15) with ESMTPS id xBK4raVv037128
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 13:53:37 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-15) with ESMTPS id xBK4raLR170506
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 13:53:36 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id xBK4rZcW170504;
        Fri, 20 Dec 2019 13:53:35 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] Documentation: filesystems: convert vfat.txt to RST
References: <20191121130605.29074-1-dwlsalmeida@gmail.com>
        <20191219100025.255003e6@lwn.net>
Date:   Fri, 20 Dec 2019 13:53:35 +0900
In-Reply-To: <20191219100025.255003e6@lwn.net> (Jonathan Corbet's message of
        "Thu, 19 Dec 2019 10:00:25 -0700")
Message-ID: <87immbwqb4.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> On Thu, 21 Nov 2019 10:06:05 -0300
> "Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:
>
>> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
>> 
>> Converts vfat.txt to the reStructuredText format, improving presentation
>> without changing the underlying content.
>> 
>> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
>> -----------------------------------------------------------
>> Changes in v2:
>> Refactored long lines as pointed out by Jonathan
>> Copied the maintainer
>> Updated the reference in the MAINTAINERS file for vfat
>> 
>> I did not move this into admin-guide, waiting on what the 
>> maintainer has to say about this and also about old sections
>> in the text, if any.
>
> This one, too, could user a bit less markup, and more consistent markup.
> If you have to mark up literal text, for example, it should be ``literal``,
> not *emphasis*.  But please think about whether it needs marking up at all.
>
> I have one other thing here, that could use input from the vfat maintainer:

Sorry, I have very small knowledge in Documentation stuff. So I was
thinking no need my input...

I don't know what markup is proper here. My opinion would be, let's
make it be consistent with other Documents/*.

>> +BUG REPORTS
>> +===========
>> +If you have trouble with the *VFAT* filesystem, mail bug reports to
>> +chaffee@bmrc.cs.berkeley.edu.
>> +
>> +Please specify the filename and the operation that gave you trouble.
>> +
>> +TEST SUITE
>> +==========
>> +If you plan to make any modifications to the vfat filesystem, please
>> +get the test suite that comes with the vfat distribution at
>> +
>> +`<http://web.archive.org/web/*/http://bmrc.berkeley.edu/people/chaffee/vfat.html>`_
>> +
>> +This tests quite a few parts of the vfat filesystem and additional
>> +tests for new features or untested features would be appreciated.
>
> What are the chances that the above email address works at all, especially
> given that the associated web page has to be dug out of the wayback
> machine?  We should really try to avoid perpetuating obviously wrong
> information when we can.  Hirofumi, do you have any thoughts on what might
> replace this section?

Those sections are so long years didn't work, IIRC. So IMHO, we can
remove those simply. The address for bug report would work from
MAINTAINER, lkml as usual, and even bugzilla.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
