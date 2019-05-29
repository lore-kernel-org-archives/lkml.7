Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0434BC28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DEE24323
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559172245;
	bh=AMILNefNzTi4ZaemTHZJpJnN7DES9OfEg9tGF4QK9WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LPPks1G6GtnnRuVUriXQf+/7FWXWF8iEpz3VQtCD6qGIq2csaWNKy0LnnfA88gdai
	 yuqB7fYERSZu9LIPszmTYDLFwvmrJoPUfRlRuJebz0icL5rdeCCGj0D+XmijXV9JtJ
	 HEYSaOREe5PnzrV38nIIybWtz0JdI+lMY7cOqaaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfE2XYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:24:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfE2XYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uegJiDhnQxQaXlYd/KXlqxqemOhHfM+yEvioj3JsN+U=; b=Vy03dE/fJC/z0esPCU5AkbkHF3
        iycmVoQXfI5JtgYWXdqkS/XOFIeUCCHZQloefUcIwvw/F9RID6w9JNTPlWLHVEAZMTcvhCuRDSlbG
        cTKg4kpk3xo67RR7YBdbuKoBzgMGnuR2OveRkdoAYSHL4SbPOEViLAvVOqGYPNB8S3srQBohoTvSM
        7Fln1mBeg7rufpwrymh3qF3m1/5FvbK0JOe5icvAQjJhqkZ0vr+mdRhWzeQoMLcd8cGZkrc4KiMBN
        r90mkuns5FaOpxt6Hy6mjCY2ZpaLtj6iqi2cI8edLXWL8UDTwQRKhd7t0VjpUbp2NerkecL5xH6H0
        Y190lk7A==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rm-7i; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007xc-Rb; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org
Subject: [PATCH 14/22] docs: vm: hmm.rst: fix some warnings
Date:   Wed, 29 May 2019 20:23:45 -0300
Message-Id: <59ddc30af749c0123af8b0dc04d3670133af5f8d.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Documentation/vm/hmm.rst:292: WARNING: Unexpected indentation.
    Documentation/vm/hmm.rst:300: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/vm/hmm.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index ec1efa32af3c..1ab609ca7835 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -283,12 +283,14 @@ The hmm_range struct has 2 fields default_flags and pfn_flags_mask that allows
 to set fault or snapshot policy for a whole range instead of having to set them
 for each entries in the range.
 
-For instance if the device flags for device entries are:
+For instance if the device flags for device entries are::
+
     VALID (1 << 63)
     WRITE (1 << 62)
 
 Now let say that device driver wants to fault with at least read a range then
-it does set:
+it does set::
+
     range->default_flags = (1 << 63)
     range->pfn_flags_mask = 0;
 
@@ -296,7 +298,8 @@ and calls hmm_range_fault() as described above. This will fill fault all page
 in the range with at least read permission.
 
 Now let say driver wants to do the same except for one page in the range for
-which its want to have write. Now driver set:
+which its want to have write. Now driver set::
+
     range->default_flags = (1 << 63);
     range->pfn_flags_mask = (1 << 62);
     range->pfns[index_of_write] = (1 << 62);
-- 
2.21.0

