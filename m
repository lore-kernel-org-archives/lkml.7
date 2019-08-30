Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045B5C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B7A23407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH3O0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:26:08 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:31275 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3O0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:26:08 -0400
IronPort-SDR: BZwO+eVQ2DhvOexO6jPHW7miXC3PC3hLOr+JIQFInS3ajLDTntLpXlkasf8tEAwbNwno3dihOT
 87OECZJ2JbnbE6bQUz9U5YnsMcnRz/4mTeuAcV4qyMxMggE0Nh48RNvUsVHBFW3dfHM0UwLl/A
 ZasqYfHGhutqnW13NrJ06YLrtTFKC9gvGpyw2bG4w3b8p5cEZi7OrJgFiiLREdsR8+y+5Icnpw
 uD1/Uk0ylEi6FjNzYGLLWPHr9tbr5myRQkZ2NVZXfC3g56nOwN+hnqGDbOG6hFZfFJ1GzdTZ/K
 zVs=
X-IronPort-AV: E=Sophos;i="5.64,447,1559548800"; 
   d="scan'208";a="40907662"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 30 Aug 2019 06:26:07 -0800
IronPort-SDR: k7PZGsyo7J5cTJqQCVY17iYG2gQwQ8Mdya3Z5JIN9Mln8HRe/iUzRueBudOlcTmuXlOr6uG1et
 67c+Pc/w10iVXLQxvbszV+qh2b4BhwJha9oovBu2a+69zXUHvm6UvuPV1xAU/Cixeb9ZAxUtj1
 YSZM7pD1L+h4btyJ4sk179JF/7ax3QR5Z28tE4wLRDcbPwlHl8EdEsvxl6BM6b51CcJfQwccMY
 +EMnNIoSryYxXfb1URP4x9YJfX2Lr3z/VCGJcHx8M+FFLuQaEuQah5S8ClMkXvIme8JladIUlq
 OvM=
Date:   Fri, 30 Aug 2019 10:26:04 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
CC:     Shuah Khan <shuah@kernel.org>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v2] selftests: watchdog: Add optional file argument
Message-ID: <20190830142603.GA23419@mam-gdavis-lt>
References: <1567169597-10330-1-git-send-email-george_davis@mentor.com>
 <20190830133813.GA23613@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190830133813.GA23613@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eugeniu,

On Fri, Aug 30, 2019 at 03:38:13PM +0200, Eugeniu Rosca wrote:
> Hi George,
> 
> On Fri, Aug 30, 2019 at 08:53:16AM -0400, George G. Davis wrote:
> > v2:
> > - Update printf for ENOENT case based on report from Eugeniu Rosca
> 
> Below interdiff [1] matches my expectations. Thanks!

Thanks for confirming.

-- 
Regards,
George
