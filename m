Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D6EC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9818E20673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440524AbfIXG21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 02:28:27 -0400
Received: from comms.puri.sm ([159.203.221.185]:38320 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393474AbfIXG21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 02:28:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9A718E020B;
        Mon, 23 Sep 2019 23:28:26 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eZU8imWjYbzj; Mon, 23 Sep 2019 23:28:25 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     corbet@lwn.net, will@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 1/2] mailmap: add new email address for Martin Kepplinger
Date:   Tue, 24 Sep 2019 08:28:02 +0200
Message-Id: <20190924062803.3772-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include my new email address for tracking my contributions.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index edcac87e76c8..70105bb57650 100644
--- a/.mailmap
+++ b/.mailmap
@@ -151,6 +151,7 @@ Mark Brown <broonie@sirena.org.uk>
 Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
+Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
 Mathieu Othacehe <m.othacehe@gmail.com>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
-- 
2.20.1

