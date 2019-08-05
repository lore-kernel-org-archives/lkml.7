Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE084C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FE4214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfHESoW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:44:22 -0400
Received: from bonn.mirbsd.org ([217.91.129.195]:14221 "EHLO herc.mirbsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfHESoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:44:22 -0400
X-Greylist: delayed 728 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 14:44:21 EDT
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id x75IUnrJ022118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 5 Aug 2019 18:30:53 GMT
Date:   Mon, 5 Aug 2019 18:30:49 +0000 (UTC)
From:   Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To:     Denis Efremov <efremov@linux.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: floppy: take over maintainership
In-Reply-To: <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
Message-ID: <Pine.BSM.4.64L.1908051827510.1920@herc.mirbsd.org>
References: <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

I just saw this on LWN and would like to thank you for picking
up floppy support as it’s important (especially for interfacing
with esoteric hardware). I’m also collecting a few drives so I
can use a spare if one breaks… usable discs are becoming a problem
though ☹

bye,
//mirabilos
--  
When he found out that the m68k port was in a pretty bad shape, he did
not, like many before him, shrug and move on; instead, he took it upon
himself to start compiling things, just so he could compile his shell.
How's that for dedication. -- Wouter, about my Debian/m68k revival
