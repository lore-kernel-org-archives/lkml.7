Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF5BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681032071E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950885;
	bh=Jyu8RLllLlNVSv/jmpXsW4PEaKCtWgH/gY+vmMRry4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yeYu3pmS/xLsrWnh+tKq4HCc8C6A/RNNAStAKcpUWEBTxd1oh54SjCDcMxLapeZD7
	 quX/HUMi+cR9lgUrYOLVKgd3Z0CBaxPFM5hZK1YnD/+3G9zX3f+/V4Ib8jwwFekeYG
	 61sS35Be8ezwS6q8/tcShJqQzv1AuItpIgrpIhMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfLJEIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbfLJEHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:50 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9822120726;
        Tue, 10 Dec 2019 04:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950870;
        bh=Jyu8RLllLlNVSv/jmpXsW4PEaKCtWgH/gY+vmMRry4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNgI7Dusv+Vuj/fb0EBgOYiDhW8XtODB/kYW7Cj2M0FoBjWeI9hDySEIx7qUsYWUp
         j1+Y/nqkFy+QD1FkuJYeHN9V2brP4CO0A7pnB1lTskukg99IwYbSBHAbqvhu/lV2oO
         jrEkzUVBzywQoObzc2JPT3quU5efm9SpxTNk+LVY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/12] .mailmap: Add entries for old paulmck@kernel.org addresses
Date:   Mon,  9 Dec 2019 20:07:39 -0800
Message-Id: <20191210040741.2943-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .mailmap | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.mailmap b/.mailmap
index c24773d..5f330c5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -207,6 +207,11 @@ Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
 Patrick Mochel <mochel@digitalimplant.org>
 Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
+Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.ibm.com>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.vnet.ibm.com>
+Paul E. McKenney <paulmck@kernel.org> <paul.mckenney@linaro.org>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@us.ibm.com>
 Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter@oruba.de>
 Peter Oruba <peter.oruba@amd.com>
-- 
2.9.5

