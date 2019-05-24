Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19942C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0DE21850
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbfEXREr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:04:47 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59553 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEXREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:04:46 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id CDCFCC0007;
        Fri, 24 May 2019 17:04:42 +0000 (UTC)
Date:   Fri, 24 May 2019 19:04:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc:     a.zummo@towertech.it, Shuah Khan <shuah@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: about selftests/rtc test related stuff
Message-ID: <20190524170442.GE3274@piout.net>
References: <CAG=yYwk+g28_dnOcN--w-PLbGtA2oM5tq14W4X5bBjdurnF2iA@mail.gmail.com>
 <20190523174739.GY3274@piout.net>
 <CAG=yYwmrE30nROqn63oAkXN9BCqfmo4T7+QPN-H3mSGG9dLU4A@mail.gmail.com>
 <20190523225219.GZ3274@piout.net>
 <CAG=yYwkhy5wTRywr5QUmGVQOED3EGQC8jFSCSj---TJfoyEhpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYwkhy5wTRywr5QUmGVQOED3EGQC8jFSCSj---TJfoyEhpw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2019 19:23:57+0530, Jeffrin Thalakkottoor wrote:
> On Fri, May 24, 2019 at 4:22 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > I just sent a fix for that timeout issue.
> 
> anyway thanks related to that
> shall i  send a selftest fix that bail out in the test program  if the
> user does not have root privileges ?
> 

No, it bails out just fine.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
