Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C412C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13761217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfKFKry convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:47:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52163 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfKFKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:47:53 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 9c54dacee3369b38; Wed, 6 Nov 2019 11:47:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     myungjoo.ham@samsung.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "chanwoo@kernel.org" <chanwoo@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh@kernel.org" <robh@kernel.org>, CPGS <cpgs@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: Update myself as maintainer for DEVFREQ subsystem support
Date:   Wed, 06 Nov 2019 11:47:51 +0100
Message-ID: <14440582.Pig9OX8cUD@kreacher>
In-Reply-To: <6a94e191-b460-bd9c-cae1-50ac93163eb1@samsung.com>
References: <1019298652.01572934681167.JavaMail.epsvc@epcpadp2> <11401342.1EApItjJl2@kreacher> <6a94e191-b460-bd9c-cae1-50ac93163eb1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 6, 2019 3:59:16 AM CET Chanwoo Choi wrote:
> On 19. 11. 6. 오전 1:44, Rafael J. Wysocki wrote:
> > On Tuesday, November 5, 2019 8:35:05 AM CET MyungJoo Ham wrote:
> >>> Update myself to the DEVFREQ entry as maintainer from reviewer and
> >>> the git repository information to manage the devfreq patches. I've been
> >>> reviewing and tesing the devfreq support for the couple of years as reviewer.
> >> >From now, I'll help and reiview the devfreq as maintainer.
> >>>
> >>> Suggested-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> >>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> >>
> >> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> >>
> >>
> >> Thanks a lot, Chanwoo!
> > 
> > I can take this one if no one is against that.
> 
> Thanks for picking up.
> 
> > 
> > I will be expecting devfreq pull requests from Chanwoo going forward.
> > 
> 
> After you applied it, If it's not late, I'll send the pull-request
> of devfreq for v5.5. Thanks.

No, it is not too late, you can send it at any time now.

Thanks!



