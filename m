Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674B0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4679920449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbfFMPMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:12:53 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:36188 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbfFMNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:40:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 29BE13FBD2;
        Thu, 13 Jun 2019 15:40:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iDz7YgHRYd8m; Thu, 13 Jun 2019 15:40:35 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 380643F48D;
        Thu, 13 Jun 2019 15:40:33 +0200 (CEST)
Date:   Thu, 13 Jun 2019 15:40:33 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Message-ID: <20190613134033.GA2489@sx9>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-4-laurentiu.tudor@nxp.com>
 <20190605214622.GA22254@roeck-us.net>
 <20190611133223.GA30054@roeck-us.net>
 <20190611172654.GA2602@sx9>
 <20190611190343.GA18459@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611190343.GA18459@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> I don't think I'll have time to do that anytime soon. Not that I know what
> exactly to look for in the first place.

I can confirm that there is a problem with mass storage devices and these
local memory patches.

Fredrik
