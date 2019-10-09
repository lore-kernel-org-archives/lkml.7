Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F33AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B2521835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfJIHRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:17:48 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52779 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfJIHRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:17:47 -0400
X-Originating-IP: 2.139.156.91
Received: from localhost (91.red-2-139-156.staticip.rima-tde.net [2.139.156.91])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 10ED3C0015;
        Wed,  9 Oct 2019 07:17:44 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marek Behun <marek.behun@nic.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: linux-next: Fixes tags need some work in the mvebu tree
In-Reply-To: <20191008225002.5b95efdf@nic.cz>
References: <20191009073803.633c02b5@canb.auug.org.au> <20191008225002.5b95efdf@nic.cz>
Date:   Wed, 09 Oct 2019 09:17:44 +0200
Message-ID: <87r23ms7zb.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

> On Wed, 9 Oct 2019 07:38:03 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>> Hi all,
>> 
>> In commit
>> 
>>   69eea31a26da ("arm64: dts: armada-3720-turris-mox: convert usb-phy to phy-supply")
>> 
>> Fixes tag
>> 
>>   Fixes: eb6c2eb6c7fb ("usb: host: xhci-plat: Prevent an abnormally
>> 
>
> This is weird, in the patch I sent the tag ends there with ...")

Truncating the commit title was wrong and checkpatch complained about it
so I fixed on the fly, but unfortunately it was splitted in 2 lines by
my editor and I didn't notice.

It is fixed now

Gregory

>
> Marek

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
