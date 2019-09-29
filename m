Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E2BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 11:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1DF218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 11:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfI2LHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 07:07:23 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60859 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfI2LHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 07:07:23 -0400
X-Originating-IP: 93.158.25.216
Received: from nexussix (93-158-25-216.subs.ibrowse.com [93.158.25.216])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 57ED5240004;
        Sun, 29 Sep 2019 11:07:19 +0000 (UTC)
Message-ID: <2a3f9ec1955e8b785888994e2a9b7cc0d5800a71.camel@kernel.wtf>
Subject: Re: [PATCH] i2c: pca954x: Add property to skip disabling PCA954x
 MUX device
From:   Cengiz Can <cengiz@kernel.wtf>
Reply-To: cengiz@kernel.wtf
To:     Biwen Li <biwen.li@nxp.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        peda@axentia.se, leoyang.li@nxp.com,
        Wolfram Sang <wsa@the-dreams.de>
Date:   Sun, 29 Sep 2019 14:07:19 +0300
In-Reply-To: <20190929103638.46038-1-biwen.li@nxp.com>
References: <20190929103638.46038-1-biwen.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Biwen,

> +       /* Errata ID E-00013 on board LS2088ARDB and LS2088ARDB:
> +        * The point here is that you must not disable a mux if there
> +        * are no pullups on the input or you mess up the I2C. This
> +        * needs to be put into the DTS really as the kernel cannot
> +        * know this otherwise.
> +        */

Can you please explain what a "mess up" is?

And also, should we put this new DTS property in related default
bindings? 

If not, are you planning a documentation update for the users to notify
them about this?

-- 
Cengiz Can <cengiz@kernel.wtf>

