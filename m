Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0475BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C362073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLJMyf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:54:35 -0500
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:52618 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727131AbfLJMye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:54:34 -0500
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1ief1x-000Mw2-Mt; Tue, 10 Dec 2019 13:54:21 +0100
Received: from [83.150.60.147] (helo=[10.167.67.21])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1ief1x-0001ma-Ja; Tue, 10 Dec 2019 13:54:21 +0100
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Date:   Tue, 10 Dec 2019 13:54:19 +0100
Message-Id: <AF642334-CD43-417E-B924-D59517D21E2D@volery.com>
References: <20191210120120.GA3779155@kroah.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        David Daney <ddaney@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Florian Westphal <fw@strlen.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Branden Bonaby <brandonbonaby94@gmail.com>,
        =?utf-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Paul Burton <paulburton@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Giovanni Gherdovich <bobdc9664@seznam.cz>,
        Valery Ivanov <ivalery111@gmail.com>
In-Reply-To: <20191210120120.GA3779155@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Well if documentation is missing then it's their fault.. 
Go ahead and delete it, even tho it kills me since my first 
patch was in there :)

Sandro V

> On 10 Dec 2019, at 13:01, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> ﻿On Tue, Dec 10, 2019 at 12:40:54PM +0100, Sandro Volery wrote:
>> Doesn't octeon have drivers out of staging already?
>> What is this module for?
> 
> I have no idea :(
> 

