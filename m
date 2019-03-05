Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AED21019
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551802328;
	bh=cV2IHjc+UuulyiZCLRIHnnYpgzEDC2AqZY085JQ3foY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eqoHlztNj8FxLiSfWShcV5AcwxF7rC0V2Duf7ajcbXbQcIvZn7WIb2hPq/7ws2yUF
	 83rdOsiL68lkOMdK0Mrxvn0TGI9XJtkB0839nTuXO0cHpY5W9PBgVGY8M9Xgbqbjxk
	 1UdVidWJ2+tVV3QrS9dP+kj4ni5bIeD8ediRe72o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCEQMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfCEQMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:12:06 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2298420661;
        Tue,  5 Mar 2019 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551802326;
        bh=cV2IHjc+UuulyiZCLRIHnnYpgzEDC2AqZY085JQ3foY=;
        h=From:To:Cc:Subject:Date:From;
        b=K1SV9iGGqwD24hzPmRrMLCLZtr+A7fGZZtIFuzWFxVL/Nq5PD2pxgB4x5kK6o2KFU
         GpJpMWg65BbOmBGzNQ2WBbqpFY+6qZIODGEmJoGMUedXNfpc1ub/IBIOOidXFTMqJt
         9FEthqbpuzd/iQy7gS9SUeh4kyWKqAstcn1ugJcI=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: memcpy->strncpy changes for comm strings
Date:   Tue,  5 Mar 2019 10:11:58 -0600
Message-Id: <cover.1551802084.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi Steve,

Here are a couple patches as discussed, replacing memcpy with strncpy
for comm strings in trace.c and trace_events_hist.c.

Thanks,

Tom

The following changes since commit 9f0bbf3115ca9f91f43b7c74e9ac7d79f47fc6c2:

  tracing: Use strncpy instead of memcpy for string keys in hist triggers (2019-03-05 08:47:46 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/comm-strncpy

Tom Zanussi (2):
  tracing: Use strncpy instead of memcpy when copying comm for hist
    triggers
  tracing: Use strncpy instead of memcpy when copying comm in trace.c

 kernel/trace/trace.c             | 4 ++--
 kernel/trace/trace_events_hist.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.14.1

