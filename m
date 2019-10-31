Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8620ECA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C6220856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="X7kLrYAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfJaAF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:05:59 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:58225 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfJaAF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:05:58 -0400
Received: from [IPv6:2a02:810c:c200:2e91:e1c6:7ce1:572b:20f1] (unknown [IPv6:2a02:810c:c200:2e91:e1c6:7ce1:572b:20f1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8D7ED22178;
        Thu, 31 Oct 2019 01:05:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1572480352;
        bh=7r3BGnQA4+151Uxptt1Woyr7NW3uh+DNEfMRBvdDzvQ=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=X7kLrYAYrx/bu6HDba4rWNiHShosbkLNny5+IuCMkB3p+WGdapMlPjRX+Q6xWoKZ6
         M3fowkJM4K2G/amLipO8/q5iI65iyhyR1XwncS1jPQ4k1UgS4powtcvdo89zja08nU
         T/kN9NOrt9DiP33KMsyZQ+n7syEM6ARwEkbRx2eY=
Date:   Thu, 31 Oct 2019 01:05:50 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <7dc930c9-0e95-7310-5e01-762276e780e6@gmail.com>
References: <20191030224251.21578-1-michael@walle.cc> <20191030224251.21578-2-michael@walle.cc> <0a42b1d6-b60d-b8a0-2264-54df155bcb3b@gmail.com> <20191030231801.GH10555@lunn.ch> <7dc930c9-0e95-7310-5e01-762276e780e6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/3] net: phy: at803x: fix Kconfig description
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
From:   Michael Walle <michael@walle.cc>
Message-ID: <D615CB94-38A8-44E2-99CB-00FB1737FC5E@walle.cc>
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31=2E Oktober 2019 00:32:15 MEZ schrieb Florian Fainelli <f=2Efainelli@g=
mail=2Ecom>:
>On 10/30/19 4:18 PM, Andrew Lunn wrote:
>> On Wed, Oct 30, 2019 at 04:16:01PM -0700, Florian Fainelli wrote:
>>> On 10/30/19 3:42 PM, Michael Walle wrote:
>>>> The name of the PHY is actually AR803x not AT803x=2E Additionally,
>add the
>>>> name of the vendor and mention the AR8031 support=2E
>>>
>>> Should not the vendor be QCA these days, or Qualcomm Atheros?
>>=20
>> Atheros Qualcomm would work best in terms of not upsetting the sort
>> order=2E
>
>Yes except the company is actually named Qualcomm Atheros:
>
>https://en=2Ewikipedia=2Eorg/wiki/Qualcomm_Atheros

Correct=2E=2E my bad=2E also the atheros prefix is wrong then=2E=2E becaus=
e there is already a qca prefix=2E

but=2E=2E should i also reorder the entry in the Kconfig then?=20

-michael=20

