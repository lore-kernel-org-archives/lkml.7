Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A03C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8054320675
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561222756;
	bh=qYbpC+j9S057n8d7cIgGmBEnowMS02cv0S7zfdm/EGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m0IyDNM6C48RT4rTMLUgwwrbjIKTEEus8v4N9Db6l23KXrvFxjbDP98PoxtzK+9jT
	 yOoCqK9LFgJQVeB1tawGtotJKdMGBeYBG+qNrlc4NKJDYWfAQYW2GgBt7ayHYnQfc8
	 EM212Y8oP06zpiiN5YbJLFHKyuPseeeBh8xlV/mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFVQ7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:59:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfFVQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kU4lZoZk1BRhrx8HkLHCBdk7MNLvQ8R2y7TKkaZGQ4g=; b=R7fPR10ZGxp2ZfQCeRDzQ4RI9i
        yA+FRh3Ucv9NJ0sl1X9+SSfCDo1iBIcDEglQydPZIYswZclZlcDTc89RszDXyagyzfatDZq1uea+X
        N6ddAdmKOVhKxBjmznybDmqDZgaK2Hq+IX4zZBkwXWa+7SRsQhgs0IWeKPyyAidZPyntn0st8N1Rz
        dul3a7/911kGFCz+HvRkgWj7YrUbTBp+ItEiECcN2kY5Di8Jkv4BeW3oYBwYFb4SpA5AFp62+N/DE
        dpPb7LjU5fEoMhhw5SZKy4Y7B5jQPgeFCqJdTGywk3kzT/mwNkfppPzGndB/uSBqnOwqJRn7LmN1a
        hJAKiw4A==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLu-00054q-FV; Sat, 22 Jun 2019 16:58:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLs-0000vc-0C; Sat, 22 Jun 2019 13:58:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] docs: kernel_abi.py: Update copyrights
Date:   Sat, 22 Jun 2019 13:58:49 -0300
Message-Id: <9e05d3deaaba30755662f62c2a64c00c10646cf3.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561221403.git.mchehab+samsung@kernel.org>
References: <cover.1561221403.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Markus doesn't want to maintain ths file, update it to
put me as its maintainer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 2d5d582207f7..ef91b1e1ff4b 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -7,7 +7,8 @@ u"""
     Implementation of the ``kernel-abi`` reST-directive.
 
     :copyright:  Copyright (C) 2016  Markus Heiser
-    :copyright:  Copyright (C) 2016  Mauro Carvalho Chehab
+    :copyright:  Copyright (C) 2016-2019  Mauro Carvalho Chehab
+    :maintained-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
     :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
 
     The ``kernel-abi`` (:py:class:`KernelCmd`) directive calls the
-- 
2.21.0

