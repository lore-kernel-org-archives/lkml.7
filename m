Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB99C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1237D215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mCjjhY47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfFYIrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:47:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfFYIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:47:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8kpbf3535966
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:46:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8kpbf3535966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561452412;
        bh=r6tnFvU39VmjCmnbfgkD0LslLgpQaPrkkhyNC3Y3hjs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mCjjhY47eiUszmbb/d7Jzohnfenrjyf93AZGYlUXTZOqnjxRM7j920CVKDepGzI4o
         uClSgoyYkVPq8aKCBQMQdwlPmdATYvDuBNmSAOrk3XUROjzvNwa6m39Ky4J38td7Nz
         qEwlAz0uRk2ws0h2DmBeeowEG6+HdJC8Mh8slf6Ite1J5bV+17ucaQK1JIM3gMYnPj
         06gXQhsMoC6ZvqEc+Nqbp80mU3PfjLH5BbYzqHgEfyB0rE/XtkDo4boZWey+9i9kT6
         kaV1p3H2TQqicedltuxYTShnwV4Hwew7sycq/wgPFPP6kmph35CHh4XaOLhQ/41XNs
         srRqOutnt8d/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8kpN63535963;
        Tue, 25 Jun 2019 01:46:51 -0700
Date:   Tue, 25 Jun 2019 01:46:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michael Forney <tipbot@zytor.com>
Message-ID: <tip-ebf8d82bbb32720878a3867b28e655950ccee992@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mforney@mforney.org, hpa@zytor.com,
        will.deacon@arm.com, boqun.feng@gmail.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
          boqun.feng@gmail.com, hpa@zytor.com, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, mforney@mforney.org,
          mingo@kernel.org, peterz@infradead.org
In-Reply-To: <20190618053306.730-1-mforney@mforney.org>
References: <20190618053306.730-1-mforney@mforney.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics: Use sed(1) instead of
 non-standard head(1) option
Git-Commit-ID: ebf8d82bbb32720878a3867b28e655950ccee992
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ebf8d82bbb32720878a3867b28e655950ccee992
Gitweb:     https://git.kernel.org/tip/ebf8d82bbb32720878a3867b28e655950ccee992
Author:     Michael Forney <mforney@mforney.org>
AuthorDate: Mon, 17 Jun 2019 22:33:06 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 25 Jun 2019 10:17:07 +0200

locking/atomics: Use sed(1) instead of non-standard head(1) option

POSIX says the -n option must be a positive decimal integer. Not all
implementations of head(1) support negative numbers meaning offset from
the end of the file.

Instead, the sed expression '$d' has the same effect of removing the
last line of the file.

Signed-off-by: Michael Forney <mforney@mforney.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190618053306.730-1-mforney@mforney.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 scripts/atomic/check-atomics.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index cfa0c2f71c84..8378c63a1e09 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -22,7 +22,7 @@ while read header; do
 	OLDSUM="$(tail -n 1 ${LINUXDIR}/include/${header})"
 	OLDSUM="${OLDSUM#// }"
 
-	NEWSUM="$(head -n -1 ${LINUXDIR}/include/${header} | sha1sum)"
+	NEWSUM="$(sed '$d' ${LINUXDIR}/include/${header} | sha1sum)"
 	NEWSUM="${NEWSUM%% *}"
 
 	if [ "${OLDSUM}" != "${NEWSUM}" ]; then
