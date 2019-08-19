Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0B2C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E442086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfHSIVi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:21:38 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:35857 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfHSIVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:21:37 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7A828100005;
        Mon, 19 Aug 2019 08:21:32 +0000 (UTC)
Date:   Mon, 19 Aug 2019 10:21:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, rui.zhang@intel.com,
        edubezval@gmail.com, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Huckleberry <nhuck@google.com>
Subject: Re: [PATCH] thermal: armada: Fix -Wshift-negative-value
Message-ID: <20190819102131.41da667b@xps13>
In-Reply-To: <c2b821f2-545a-9839-3de6-d68dfee5b5dc@linaro.org>
References: <20190613184923.245935-1-nhuck@google.com>
        <27428324-129e-ee37-304a-0da2ed3810a0@linaro.org>
        <CAJkfWY4X-YwuansL1R5w0rQNmE_hVJZKrMBJmOLp9G2DJPkNow@mail.gmail.com>
        <CAKwvOdkEp=q+2B_iqqyHJLwwUaFH2jnO+Ey8t-hn=x4shTbdoA@mail.gmail.com>
        <c2b821f2-545a-9839-3de6-d68dfee5b5dc@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Daniel Lezcano <daniel.lezcano@linaro.org> wrote on Thu, 15 Aug 2019
01:06:21 +0200:

> On 15/08/2019 00:12, Nick Desaulniers wrote:
> > On Tue, Aug 13, 2019 at 10:28 AM 'Nathan Huckleberry' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:  
> >>
> >> Following up to see if this patch is going to be accepted.  
> > 
> > Miquel is listed as the maintainer of this file in MAINTAINERS.
> > Miquel, can you please pick this up?  Otherwise Zhang, Eduardo, and
> > Daniel are listed as maintainers for drivers/thermal/.  
> 
> I'm listed as reviewer, it is up to Zhang or Eduardo to take the patches.
> 
> 

Sorry for the delay, I don't manage a tree for this driver, I'll let
Zhang or Eduardo take the patch with my

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
