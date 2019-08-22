Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA12C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC09233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbfHVJd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:33:26 -0400
Received: from shell.v3.sk ([90.176.6.54]:35734 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfHVJd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:33:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A6343D756F;
        Thu, 22 Aug 2019 11:33:19 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RK4SDxnr7J-A; Thu, 22 Aug 2019 11:33:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 74E51D749F;
        Thu, 22 Aug 2019 11:27:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b_wlen16TW9p; Thu, 22 Aug 2019 11:26:46 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2B844493E8;
        Thu, 22 Aug 2019 11:26:46 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 00/20] Initial support for Marvell MMP3 SoC 
Date:   Thu, 22 Aug 2019 11:26:23 +0200
Message-Id: <20190822092643.593488-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

this is a second spin of a patch set that adds support for the Marvell
MMP3 processor. MMP3 is used in OLPC XO-4 laptops, Panasonic Toughpad
FZ-A1 tablet and Dell Wyse 3020 Tx0D thin clients.=20

Compared to v1, there's a handful of fixes in response to reviews. Patch
02/20 is new. Details in individual patches.
=20
Apart from the adjustments in mach-mmp/, the patch makes necessary=20
changes to the irqchip driver and adds an USB2 PHY driver. The latter=20
has a dependency on the mach-mmp/ changes, so it can't be submitted=20
separately.
=20
The patch set has been tested to work on Wyse Tx0D and not ruin MMP2=20
support on XO-1.75.=20

Thanks
Lubo


