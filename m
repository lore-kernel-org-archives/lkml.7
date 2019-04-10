Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF318C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A3220830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554890225;
	bh=if1Z0eEzQ5edJp18rD+1ZPqQDKauUXmCc4Mu/XTPKBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nop1wuqGFSRUfpFFzPeBYHMR/mc2kltZzTrJgGYqowaMxwEkIR60WGRonm5+SE/We
	 pxmMGS8otcTOwmerksR6xwuLxDaWwjNU062UjKLszVjY79QrqCh3gvZzIjRrLqvue6
	 z21KiP1sJilmoHYa6a3JUj3od33uRRe1zZPG0kmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfDJJ47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:56:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbfDJJ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3lbueKY2QWXhiM6Ovr6FNUSfEqePGFl1NYF40OVZJjQ=; b=NSRldRJLsiMypD1orq0TV2cNrf
        YLQSjkMZ43lDWgMD9UO/ijqpU8edSOvksHnZDRGeEuTEU71Ld4jfeTPiv+KBpwk1E2FjxuLIPa8Sa
        IJONivDVY6eLM+oHLp1wtYf13UeDvIkKhQPjSCHw+EelpKoSMbB47rnTpHfVIg03V9ieEoMH4h5uD
        AGoFlnC8rnT/wl4XEn3mAuSFeX5zcATXMi0+eNBjvch7UCIgZLLOsRo+aKRd6KWCQEebhOGbuTRg+
        wu/SKAX/3cbe8j/jRkv6gXBiAE3NQ+OQErIH4Z5mMp6AdJIPH2QO5SxjzhbZy7pNoFavH5v1/73+y
        3lRJN9vg==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE9y9-0003Cr-8Z; Wed, 10 Apr 2019 09:56:37 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hE9y3-0000o1-OE; Wed, 10 Apr 2019 06:56:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org
Subject: [PATCH 2/8] docs: atomic_bitops.txt: add a title for this document
Date:   Wed, 10 Apr 2019 06:56:21 -0300
Message-Id: <b71822db8abbb22175042fce7712e2c9108c7353.1554889999.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554889999.git.mchehab+samsung@kernel.org>
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
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

