Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E04C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562F821848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbfJIPnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:43:42 -0400
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:53761 "EHLO
        12.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfJIPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:43:41 -0400
X-Greylist: delayed 29401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Oct 2019 11:43:40 EDT
Received: from player755.ha.ovh.net (unknown [10.108.57.226])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 21E3F1E4ABA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 09:26:25 +0200 (CEST)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id 845A2AD418DA;
        Wed,  9 Oct 2019 07:26:14 +0000 (UTC)
Date:   Wed, 9 Oct 2019 10:26:12 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Andi Shyti <andi@etezian.org>,
        Simon Shields <simon@lineageos.org>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: mms114 - add support for mms345l
Message-ID: <20191009072612.GA2814@jack.zhora.eu>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007205021.104402-1-stephan@gerhold.net>
 <20191008220014.GI22365@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008220014.GI22365@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 10061041571171844762
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedriedtgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > There was a related patch [2] that removes I2C_M_NOSTART for all models,
> > but it seems abandoned and I do not have any other model for testing.
> > Therefore, this patch implements the least instrusive solution
> > and only removes I2C_M_NOSTART for MMS345L.
> 
> Hmm,  at this point I am inclined to pick up Andi's patch since it seems
> to work for you and him and it looks like Android drivers are not using
> I2C_M_NOSTART. I wonder if this was some quirk/big on the platform where
> it was originally developed.

I completely forgot about that patch :)

I should refresh some old work on that device which was left
undone.

> Any objections?

It's OK for me. If you can just update my e-mail, please, when
applying the patch to "andi@etezian.org". Thanks!

Thank you,
Andi
