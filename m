Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F037C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 14:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282DD208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 14:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfEEOA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 10:00:58 -0400
Received: from shell.v3.sk ([90.176.6.54]:55673 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfEEOA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 10:00:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A6400103D35;
        Sun,  5 May 2019 16:00:52 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iH3liF-fHYco; Sun,  5 May 2019 16:00:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5B25E103D2B;
        Sun,  5 May 2019 16:00:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hQjYDOwTATBy; Sun,  5 May 2019 16:00:35 +0200 (CEST)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E05B0103D24;
        Sun,  5 May 2019 16:00:34 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>,
        Libin Yang <lbyang@marvell.com>,
        Albert Wang <twang13@marvell.com>,
        jacopo mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v5 00/10] media: make Marvell camera work on DT-based OLPC XO-1.75
Date:   Sun,  5 May 2019 16:00:21 +0200
Message-Id: <20190505140031.9636-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the fifth spin of a patchset that modernizes the Marvell MMP2 CCI=
C
driver, making it work on DT-based systems such as OLPC XO-1.75 laptop.

At the core of the rework is the move to asynchronous sensor discovery
and clock management with the standard clock framework. There are also
some straightforward fixes for the bitrotten parts.

Compared the the previous version it just fixes issues with the device
bindings, pointed out by Sakari Ailus, in patch [01/10].

Tested on OLPC XO-1 and OLPC XO-1.75.

Thanks,
Lubo


