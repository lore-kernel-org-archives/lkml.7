Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FADC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7B521473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfDCIeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:34:03 -0400
Received: from skyboo.net ([94.40.87.198]:40828 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbfDCIeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:34:02 -0400
Received: from [10.1.0.1] (helo=nemesis.skyboo.net)
        by skyboo.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1hBbLF-0005Km-KL; Wed, 03 Apr 2019 10:34:00 +0200
Date:   Wed, 3 Apr 2019 10:33:52 +0200
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Message-Id: <20190403103352.4f36cfee5e577ef017607527@skyboo.net>
In-Reply-To: <49DF2FF4-FB5E-4FB8-94E3-BE14E5C2DEAF@gmail.com>
References: <20190318092737.8170-1-manio@skyboo.net>
        <20190318092737.8170-2-manio@skyboo.net>
        <10244730-36A8-4DAC-95E5-AD7BDEA32F43@gmail.com>
        <20190327165317.GA3137@kroah.com>
        <49DF2FF4-FB5E-4FB8-94E3-BE14E5C2DEAF@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.1.0.1
X-SA-Exim-Rcpt-To: greg@kroah.com, linux-kernel@vger.kernel.org, jeff.dagenais@gmail.com
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: Re: [PATCH v2] w1: ds2408: reset on output_write retry with
 readback
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Exactly as Jean-Francois stated:
> Mariusz can chime in but I believe although it was the same exercise
> that led to his discoveries, each patch can stand alone and be applied
> in any order.
> 
> I will send a v3 without a reply-to-id. Mariusz' patch "[PATCH v2] w1:
> fix the resume command API" can be applied as is unless you need it
> changed or resent.

To sum it all - patches order is irrelevant and the patches to merge are:

mine latest one:
Subject: [PATCH v2] w1: fix the resume command API
Date: Thu, 21 Mar 2019 11:52:55 +0100
Message-ID: <20190321105255.19126-1-manio@skyboo.net>

and Jean's latest one:
Subject: [PATCH v4] w1: ds2408: reset on output_write retry with readback
Date:   Thu, 28 Mar 2019 12:41:11 -0400
Message-Id: <20190328164111.24041-1-jeff.dagenais@gmail.com>

regards,
-- 
Mariusz Białończyk | xmpp/e-mail: manio@skyboo.net
http://manio.skyboo.net | https://github.com/manio
