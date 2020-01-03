Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1201FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA1F206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgACKTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 05:19:38 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33411 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACKTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 05:19:37 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id ADA8EE000B;
        Fri,  3 Jan 2020 10:19:35 +0000 (UTC)
Date:   Fri, 3 Jan 2020 11:19:35 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     J William Piggott <elseifthen@gmx.com>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Subject: Re: [bugreport] "hwclock -w" reset time instead of setting the right
 time
Message-ID: <20200103101935.GI3040@piout.net>
References: <CABXGCsOv26W6aqB5WPMe-mEynmwy55DTfTeL5Dg9vRq6+Y6WvA@mail.gmail.com>
 <CABXGCsNkzPrjqMRaWpssorxzhMLWBvLeSw9BpKYr_DW4LJQECQ@mail.gmail.com>
 <20200102110817.ahqaqidw3ztw3kax@10.255.255.10>
 <CABXGCsNkm3VuzO60WBCi4VJmDnO=DmprQ1P=dd0FcW2-+dGc0w@mail.gmail.com>
 <20200102131434.tky2hquki23laqqo@10.255.255.10>
 <CABXGCsMV1GRiqrXCQGHqvpBiendU3mG36h0YoG=4nw6spZHq=w@mail.gmail.com>
 <nycvar.YAK.7.76.2001021153220.1385@zhn.tzk.pbz>
 <CABXGCsMLfarquWnzV=e3Ta_HPac+DALfKEOaD3rp5n9MPqgyFw@mail.gmail.com>
 <20200103100232.GH3040@piout.net>
 <CABXGCsNv7G94TxaaKX8KXL5DEJiFgNcSu4+WShE_kQjVSa7zZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsNv7G94TxaaKX8KXL5DEJiFgNcSu4+WShE_kQjVSa7zZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2020 15:11:17+0500, Mikhail Gavrilov wrote:
> On Fri, 3 Jan 2020 at 15:02, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hi,
> >
> > What is your kernel version?
> >
> 
> $ uname -r
> 5.5.0-0.rc4.git0.1.fc32.x86_64
> 

I'm going to revert 7ad295d5196a58c22abecef62dd4f99e2f86e831, I think
this will solve this issue.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
