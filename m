Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6BBC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B8A20880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDGTBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:01:48 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:55898 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfDGTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 15:01:48 -0400
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Apr 2019 15:01:48 EDT
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 657C17A02AA;
        Sun,  7 Apr 2019 20:56:24 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Rik Faith <faith@cs.unc.edu>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] fdomain: Resurrect driver
Date:   Sun,  7 Apr 2019 20:56:15 +0200
Message-Id: <20190407185617.8467-1-linux@zary.sk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
the removal of fdomain driver caused regressions:
https://alioth-lists.debian.net/pipermail/sane-devel/2019-January/036552.html

I've got a fdomain-based AHA-2920A card so I'll try to resurrect the driver
and then clean it up.

