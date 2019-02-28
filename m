Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E26C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53A4218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732837AbfB1Pvr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:51:47 -0500
Received: from smtp.asem.it ([151.1.184.197]:61141 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbfB1Pvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:51:46 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003723608.MSG 
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 16:51:42 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Thu, 28
 Feb 2019 16:51:40 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Thu, 28 Feb 2019 16:51:40 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: e1000e: add MAC address kernel cmd line parameter
Thread-Topic: [PATCH v3] net: e1000e: add MAC address kernel cmd line
 parameter
Thread-Index: AQHUz2za8U5Pv4cZVkOebP6EQ2CVPqX1RhaAgAAUBLA=
Date:   Thu, 28 Feb 2019 15:51:40 +0000
Message-ID: <b12067de92864d5db83bd3da9456e2fe@asem.it>
References: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
 <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
 <20190228153245.GA17912@lunn.ch>
In-Reply-To: <20190228153245.GA17912@lunn.ch>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.161]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B020E.5C78038D.000B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: giovedì 28 febbraio 2019 16:33
> To: Flavio Suligoi <f.suligoi@asem.it>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] net: e1000e: add MAC address kernel cmd line
> parameter
> 
> On Thu, Feb 28, 2019 at 02:52:31PM +0100, Flavio Suligoi wrote:
> > Sometimes, in some embedded systems boards (i.e. ARM boards),
> > the NVM eeprom is not mounted, to save cost and space.
> >
> > In this case it is necessary to bypass the NVM management
> > and directly force the MAC address using a kernel command-line
> > parameter (macaddr).
> 
> Hi Flavio
> 
> Why not use device tree, since this is an ARM platform?

Hi Andrew,

we produce a lot of boards and we have to change the MAC address, from u-boot, for every board.
So I must save in the u-boot environment (SPI NOR flash) the MAC address for every board.

Flavio
> 
>     Andrew
