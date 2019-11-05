Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBBAC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFABE21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390328AbfKEQod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:44:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64307 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390060AbfKEQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:44:33 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 507bcec4c336edec; Tue, 5 Nov 2019 17:44:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     myungjoo.ham@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "chanwoo@kernel.org" <chanwoo@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh@kernel.org" <robh@kernel.org>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        CPGS <cpgs@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: Update myself as maintainer for DEVFREQ subsystem support
Date:   Tue, 05 Nov 2019 17:44:31 +0100
Message-ID: <11401342.1EApItjJl2@kreacher>
In-Reply-To: <1019298652.01572945181528.JavaMail.epsvc@epcpadp2>
References: <1019298652.01572934681167.JavaMail.epsvc@epcpadp2> <CGME20191105053547epcas1p248c5a77579a8dd6fbd3639a12f3ca4c5@epcms1p2> <1019298652.01572945181528.JavaMail.epsvc@epcpadp2>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 5, 2019 8:35:05 AM CET MyungJoo Ham wrote:
> >Update myself to the DEVFREQ entry as maintainer from reviewer and
> >the git repository information to manage the devfreq patches. I've been
> >reviewing and tesing the devfreq support for the couple of years as reviewer.
> >From now, I'll help and reiview the devfreq as maintainer.
> >
> >Suggested-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> >Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
> 
> Thanks a lot, Chanwoo!

I can take this one if no one is against that.

I will be expecting devfreq pull requests from Chanwoo going forward.

Thanks!



