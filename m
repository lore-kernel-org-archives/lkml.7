Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463AEC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D83B224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfI3Uni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:43:38 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:41308 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfI3Ung (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:43:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 84353FB05;
        Mon, 30 Sep 2019 22:26:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q1LdYn5Hi-MK; Mon, 30 Sep 2019 22:26:02 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id CB18F4898F; Mon, 30 Sep 2019 22:26:01 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] bd718xx: Fix probing when built as a module
Date:   Mon, 30 Sep 2019 22:25:59 +0200
Message-Id: <cover.1569875042.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add MODULE_ALIAS("platform:<drivername>") so the drivers of the subdevices get
loaded with the mfd driver. Without that the regulator and clk drivers would
never be loaded when built as a module.


Guido Günther (2):
  regulator: bd718x7: Add MODULE_ALIAS()
  clk: bd718x7: Add MODULE_ALIAS()

 drivers/clk/clk-bd718x7.c             | 1 +
 drivers/regulator/bd718x7-regulator.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.23.0.rc1

