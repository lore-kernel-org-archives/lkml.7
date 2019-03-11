Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBECC10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3BB20850
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfCKJ1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:27:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59495 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfCKJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:27:21 -0400
Received: from [192.168.1.110] ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEV7U-1hI6Nk3yUU-00Fzn6; Mon, 11 Mar 2019 10:26:59 +0100
Subject: Re: [PATCH] drivers: iio: Kconfig: pedantic cleanup
To:     Jonathan Cameron <jic23@kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <1551883943-4930-1-git-send-email-info@metux.net>
 <20190310100115.3f669aef@archlinux>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <f9030206-5dab-43ef-f705-e48b112b5799@metux.net>
Date:   Mon, 11 Mar 2019 10:26:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190310100115.3f669aef@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:I0PBZV3YetHbqoFp6PE+HXcgvfD8YQ6ywFMcCT0BrK2kLWaXfRu
 Ik2uqMcjHFc81sby1I6ZWS8VS10mZNSZuETc5W9nGQ0zLoj/22p2JqA8zuKfdGArDpT2XY5
 vujMI6eaVLTy82hyP9n1iozKDKLkxWz6phNJDXIx0wLDu5L8t2Xw4drryOUnJhGYftYd63b
 m4ZZIKkuscgCMGePqyS3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sIikyGYPDA4=:JljTaNbcIAcWujcNlSRZs0
 kRsYOsVyPPwJORCUajoA63RPN1YB7uRjqHVFZ0EkOkD+jzFqRCu7F9aswH8Nqqa0+hiHQn+Rp
 zgryGRjNZbEDhCDoqEMKKtoBSFyqpdJRwc83lSrGcg9S3tJhGMS2OZj7DOwBeHy526TZrnX5c
 noZbCxxyrofWzpI+N5ZZ+BBxHlUBn68UprTeosdQM0rrNCIuDlm8WYzyBhxOFgDalYYMAD0DA
 u+XbKeS+Z2nCsy44dktWn9GuXKGVh3cznloDSExKo3ls4vUHH5rrITZthJGehpTaTCKLaQ8lO
 zU7lXT1p0HSjIuR1CB5MFTJv+5xOEi254TBIuhDOu9wRUlXVw1T2WW7CE9XRlA2KMnxih6V7s
 7b1MgJn4m79KBSZM7eNJ0oRHoJYpzzNUZcQK3xB7eCjsrFPxCXHcJTUiRMv3qh8FURrZIUQ5q
 4QUkclYMyEhhPqzxpW9XUyfFzCwoT+8IBQ6qrsTPiNffWLFKkDqgD/dtHTFdGyonHvaPHFrVl
 NxihNT2CITfe1aHN7tSw+OzQoZmCER0A9q3OHSvRaZAf7uU//3cSRBU6pnaRs3Lgw0zfwI9Vx
 EHo65UR39oZctU1zgiXMv9GidLu83ELL8hLYQRb4xLdzQQnOcTIk6i0MajKSjn7qhYmQTX+Ai
 PXOwY0e5SSzDVfQPNlIlHmUIWqSuf8IGrRhaTHSpLHMr+ZA/PhCLkBdu9RymJTRU6g8XwCjGo
 w3vMuRVblJ4TdRj9eOchOinNVuXOu1xTU4t3cznv+HJCgJPit4IwU3vWRkA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.19 11:01, Jonathan Cameron wrote:

Hi,

> Now all we need to do is to check new stuff more carefully so
> we don't need to do this again in a few months.
> 
> Hmm. Probably over optimistic, but like a hair cut, we can
> look good for at least a week or two :)

Maybe we should extend checkpatch.pl to check for such stuff.
Haven't had the time for a deeper look into that, yet too busy
w/ other things and still have several queues w/ hunddreds
of patches to send out ...

> 
> Applied with some fuzz to the togreg branch of iio.git and
> pushed out as testing for the autobuilders to play with it.

thx.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
