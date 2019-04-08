Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43711C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABEE214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742780;
	bh=if1Z0eEzQ5edJp18rD+1ZPqQDKauUXmCc4Mu/XTPKBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cbbehPgaHfJPt3GS3LT4vke+D0FrtuaUm2Ik6383Xfu6DRZi4Ofuu4G60xoPQeEFH
	 CO0VMlRRHg+kpePc7YCAGTL4wLQXhb2uzNyWZ4LSXpAKn0mw+bpm1oH4bBOzbNZLrN
	 YfJSMPb/JDSVdo0xI3YZCZlnncZ2AhGqDIm6UBhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfDHQ7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:59:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbfDHQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3lbueKY2QWXhiM6Ovr6FNUSfEqePGFl1NYF40OVZJjQ=; b=eDBAbtAUP5buPahjSpkYlNfP8e
        sJ6/Guuo1y2RWNBB7dWCzd/eSO518C7FUNhythIKQUyrIcvjb+DQt/URjLf0c85dck7yLrKgGzqhP
        1n1t8YFu7g78MW1gVWbwbErbyBtZ6gpn5o5GxBB7v1+OlF3AiuK6xfQ1qojCJLhbjPGG8fds6Z0mU
        ozmOEqnXlvk5cvwa2d2fz4CgpsMOMi7gCZvn/+lq/nUzUnmTALbPYUfqUSU/R9ph00Z13/Ew/lMqq
        7cRpoUZDz4EYn5DYuEGjFNPcsZEqmWV9wHpFSxKDS3Ell0qkf/qV0iPIVxLvj04nbuRrhJFzSyTHN
        fe2MaBkQ==;
Received: from [179.95.33.162] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXbO-0005Sw-7h; Mon, 08 Apr 2019 16:58:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hDXbI-0005n5-6m; Mon, 08 Apr 2019 13:58:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 02/10] docs: atomic_bitops.txt: add a title for this document
Date:   Mon,  8 Apr 2019 13:58:18 -0300
Message-Id: <b71822db8abbb22175042fce7712e2c9108c7353.1554742526.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554742526.git.mchehab+samsung@kernel.org>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document misses a title. Add it, in order to follow
the documentation standard.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/atomic_bitops.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/atomic_bitops.txt b/Documentation/atomic_bitops.txt
index be70b32c95d9..093cdaefdb37 100644
--- a/Documentation/atomic_bitops.txt
+++ b/Documentation/atomic_bitops.txt
@@ -1,6 +1,6 @@
-
-On atomic bitops.
-
+=============
+Atomic bitops
+=============
 
 While our bitmap_{}() functions are non-atomic, we have a number of operations
 operating on single bits in a bitmap that are atomic.
-- 
2.20.1

