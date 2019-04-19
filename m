Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32333C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094B6217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfDSWpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:45:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfDSWpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:45:41 -0400
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hHTbD-0002lC-6Y
        for linux-kernel@vger.kernel.org; Fri, 19 Apr 2019 13:30:39 +0000
Received: by mail-lj1-f198.google.com with SMTP id 28so929221ljv.14
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 06:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQVKrFw2Np8IykE5tT2+WDKW05XZoqK75yYhjPMiaeE=;
        b=P1F/BZTzzwUOfUB/PyKUh3TXxUdNDuSWZ6lkdIRzIfFMs6pRMTfFqHuICHKGk/6h0s
         iTxfL2Ox4D6kK+dF+gj7SOcY05jKauH/XpAxSg4wMZT2t0fjyEd7w0tAZZ/YfuxgbEeu
         8Cy6oUzzfCwpZ7KC9x0M7BIWzIbF/rxWWzJKdyGLOOTaz0bP5O1eJAGibYfw2OG/VHgp
         xLFWeSaoIO4/e+tFSqsoxl2WrkEWOmlXvSSnH2vrsRR01HC/IO9f+E0H7d0EYYyMjTyv
         9dsfSHjWi4X8zQUT8QHLm29jY8nbGtF4Fps9TzxjgI4oQDh37iOEKece62PA3uyVYaU7
         iJfA==
X-Gm-Message-State: APjAAAW7bMSSsfkV/twZHtkM4HMoyG9cfoZpqzNRkjIW1qeCFU1lvbki
        9mt3iB7Etd/SRnHrDq5Izj63KG7364SjDOXmjCgHqE75gKSVYrUkUFbrcqiQVeNTV/EoftBCIa9
        1wYFeaYHmxj1tVb6pY9P8OZw/HUgGO9pPHyvOaye1yOIJmTxdRyW3w8gp
X-Received: by 2002:ac2:4893:: with SMTP id x19mr2252072lfc.109.1555680638388;
        Fri, 19 Apr 2019 06:30:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyX9UV/CgGDm3QV6zv8oD0onF7KNNJEBS6lx0cSbL3xE8gkFBbFN2uoxpwtiR0CJZR38Oh+pyZUWsRfB7mhbM0=
X-Received: by 2002:ac2:4893:: with SMTP id x19mr2252062lfc.109.1555680638161;
 Fri, 19 Apr 2019 06:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190419131221.28297-1-po-hsu.lin@canonical.com> <03bdc88d-07cd-08ca-7d2f-ba93069eb41b@kernel.org>
In-Reply-To: <03bdc88d-07cd-08ca-7d2f-ba93069eb41b@kernel.org>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Fri, 19 Apr 2019 21:30:27 +0800
Message-ID: <CAMy_GT83h6DtYYm6GMz=wXfpLpyqt3GqdEmw7Aj40kKq1NkQoA@mail.gmail.com>
Subject: Re: [PATCHv2] selftests/efivarfs: clean up test files from test_create*()
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Commit f8a0590f fix some part of this issue.
I will send out V3 base on this commit in linux-kselftest next branch.

Thank you.


On Fri, Apr 19, 2019 at 9:20 PM shuah <shuah@kernel.org> wrote:
>
> On 4/19/19 7:12 AM, Po-Hsu Lin wrote:
> > Test files created by test_create*() tests will stay in the
> > $efivarfs_mount directory unless the system was rebooted.
> >
> > When the tester tries to run this efivarfs test again on the same
> > system, the immutable characteristics in that directory will cause some
> > "Operation not permitted" noises and a false-positve test result to the
> > test_create_read() test.
> >
> >      --------------------
> >      running test_create
> >      --------------------
> >      ./efivarfs.sh: line 59: /sys/firmware/efi/efivars/test_create-210be57c-9849-4fc7-a635-e6382d1aec27: Operation not permitted
> >        [PASS]
> >      --------------------
> >      running test_create_empty
> >      --------------------
> >      ./efivarfs.sh: line 78: /sys/firmware/efi/efivars/test_create_empty-210be57c-9849-4fc7-a635-e6382d1aec27: Operation not permitted
> >       [PASS]
> >      --------------------
> >      running test_create_read
> >      --------------------
> >      open(O_WRONLY): Operation not permitted
> >       [FAIL]
> >      --------------------
> >
> > Create a file_cleanup() to remove those test files in the end of each
> > test to solve this issue.
> >
> > Also, use this function to replace the existing file removal code.
> >
> > Link: https://bugs.launchpad.net/bugs/1809704
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
>
> Thanks for the patch. There is another patch that does the same in
> linux-kselftest next branch.
>
> Please check to see if that fixes the problem you are seeing.
>
> thanks,
> -- Shuah
>
