Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC7C48BD9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DF12085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="Gyrct6Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfFZTuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:50:52 -0400
Received: from smtpx.feld.cvut.cz ([147.32.192.33]:60445 "EHLO
        smtpx.feld.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZTuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:50:52 -0400
Received: from localhost (styx [192.168.200.7])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id BD31423D28;
        Wed, 26 Jun 2019 21:50:50 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.feld.cvut.cz ([192.168.200.2])
        by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10060)
        with ESMTP id jrhtm3nCYXqP; Wed, 26 Jun 2019 21:50:48 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id A92E4236F6;
        Wed, 26 Jun 2019 21:50:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
        s=felmail; t=1561578648;
        bh=K1rwTCQXZ2arM/EndWoTSs34RlV2119GZKM+AW3dqys=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=Gyrct6NcdVG/R6+WFyV4UdBE1I2xXl7cMrNVKLAgfPaWXNvnO9n3UL9ymH8cNu5Tq
         494U3opW0egcAEG95RS96mg8Zbipi+gWKgRs05aH4Db5SLS6mIROSraEeoCW10twIr
         +zH3VrND4m7DUBkhTJBdH0QW2lMFVgp/roojjKkr4EL/KBUTmuQ9Q3YB8BPZbACJCq
         HI7A4yRLUkSXkJsl6cSRQp13IKnMw66HOY2RC4Xd0VzE+2QAdHLZ9j83VNDc7dJRai
         eOzvQqlgu7RLOdxle7RDbcTlI1sv+vmqm9/1JrVx9dVo6GKFGWvYSR/ai2rCeQuvsj
         qGMNBPsnVOVvg==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] iio: srf04: fix wrong limitation in distance measuring
From:   =?utf-8?Q?Zbyn=C4=9Bk_Kocur?= <zbynek.kocur@fel.cvut.cz>
In-Reply-To: <20190626204936.2756cefd@archlinux>
Date:   Wed, 26 Jun 2019 21:50:47 +0200
Cc:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3372AFA8-5AD0-4044-9718-D3E2B76EDFAE@fel.cvut.cz>
References: <20190623122909.hhzskp6k5vm4wify@arbad>
 <20190626192134.4b7aed3c@archlinux>
 <03D5EE82-D6C7-4A03-9404-45B48F1EF5B6@fel.cvut.cz>
 <20190626204936.2756cefd@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, i will write a feedback after testing.


Zbynek
---
email: zbynek.kocur@fel.cvut.cz
phone: +420 224 354 054
web: http://www.fel.cvut.cz
Department of Telecommunications Engineering
Faculty of Electrical Engineering

> On 26 Jun 2019, at 21:49, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> No rush, it's a clear fix anyway so we can queue this up
> in the rc phase of the next kernel cycle!

