Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12350C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC782087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfIDXfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 19:35:02 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:41904 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728008AbfIDXfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:35:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4B4EA18224D7C;
        Wed,  4 Sep 2019 23:35:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kiss88_e7d1a863eb12
X-Filterd-Recvd-Size: 2051
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Sep 2019 23:34:59 +0000 (UTC)
Message-ID: <6806d25a240cd80ebd265fcf5f02496852027bed.camel@perches.com>
Subject: Re: [GIT PULL] clang-format for v5.3-rc8
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 04 Sep 2019 16:34:58 -0700
In-Reply-To: <20190904182949.GA22025@gmail.com>
References: <20190904182949.GA22025@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 20:29 +0200, Miguel Ojeda wrote:
> Hi Linus,
> 
> Please pull this trivial update for the .clang-format file.
> 
> Cheers,
> Miguel
> 
> The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:
> 
>   Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.3-rc8
> 
> for you to fetch changes up to 52d083472e0b64d1da5b6469ed3defb1ddc45929:
> 
>   clang-format: Update with the latest for_each macro list (2019-08-31 10:00:51 +0200)
> 
> ----------------------------------------------------------------
> clang-format update for 5.3
> 
> ----------------------------------------------------------------
> Miguel Ojeda (1):
>       clang-format: Update with the latest for_each macro list
> 
>  .clang-format | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

It's a long, long list.

$ git grep -P -h '^\s*#\s*define\s+\w*for_each\w*' | \
  grep -P -oh '\w+for_each\w*' | sort | uniq | wc -l
491

Isn't there some way to regexes or automate this?

Maybe just:
$ git grep -P -h '^\s*#\s*define\s+\w*for_each\w*' | \
  grep -P -oh '\w+for_each\w*' | sort | uniq > somefile...



