Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E213820718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="MKa4zP6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKVMCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:02:39 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:9250 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfKVMCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:02:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id CED4A411C8;
        Fri, 22 Nov 2019 12:53:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1574423624; x=1576238025; bh=S105/5m7v5DzK5AjvSc
        p3bpyf5exlALTKIwDoT2gS2M=; b=MKa4zP6Ei9m5nZ8WTwKKN6npezuEbMJuBmP
        es/0Dd2qt+S1zG2wMmTR1fUo97AiAV54NA3DYPIclc9/Jew025p2R0AdDhdYbvHT
        b7Q7h0X1xDywJruvNhFm+pxB7VfakUl6bii84/uVxkaqTgpbYdohp7wT0Mkwi1//
        VbjnHKF3chgkfceDsEvlur8sZRtdL/U88fhIqhnvGjlniXGwY2WSHfeK3LNLLiCU
        lNONLsliRpzW0sAou1Nk30qevRv9Y6BOZpnCuhk96AlNONWSBbawiT6NCU+r7xzB
        qSMViyVMc62yLQu8eQj892gHS5LUt0AbWKZsm5Mg4nxdVRmWKv2//zBM+NY31c/S
        oY/kZMZjyGrCZGw1dJmsu2TLVEnsVWhaH9qjwnUsOKBmUAryW9jpXjgxQq7ziv0D
        neMGHaM3zXLAjQSZDs25J9qwvlH7EiE72jm7akFEMc+XH+S4k+zhJ7LkcFUwILdG
        CCcVIoGVdi5rgIuz0tD0Q+vN9ddyl0EJHuz1r1W5j9STk2MFZotl6WrqR4ujynmy
        vDbn2qN0BkYvuIPAe/Y1P3NCKs/O9yDDTlZaGD8qvWNjD4T8ys5zpA1Jkaum8INo
        jPkUvqdZamvRxwgrzPTouVQNKApXnBlEi6D2dTC+wWEs8WnGKyBMTjL22Nzo5z7W
        Jf9Qn7dM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w5JxwDGQgqhI; Fri, 22 Nov 2019 12:53:44 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 47A5140D57;
        Fri, 22 Nov 2019 12:53:44 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id DC73E1617;
        Fri, 22 Nov 2019 12:53:43 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc: fix reference to core-api/namespaces.rst
Date:   Fri, 22 Nov 2019 12:53:37 +0100
Message-Id: <20191122115337.1541-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

commit fcfacb9f8374 ("doc: move namespaces.rst from kbuild/ to core-api/")

forgot to update the document kernel-hacking/hacking.rst.

In addition to the fix the path now is a cross-reference to the document.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/core-api/symbol-namespaces.rst | 2 ++
 Documentation/kernel-hacking/hacking.rst     | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index 982ed7b568ac..6791f8a5d726 100644
--- a/Documentation/core-api/symbol-namespaces.rst
+++ b/Documentation/core-api/symbol-namespaces.rst
@@ -1,3 +1,5 @@
+.. _core-api-namespace:
+
 =================
 Symbol Namespaces
 =================
diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index a3ddb213a5e1..107c8fd3f6c0 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -601,7 +601,7 @@ Defined in ``include/linux/export.h``
 
 This is the variant of `EXPORT_SYMBOL()` that allows specifying a symbol
 namespace. Symbol Namespaces are documented in
-``Documentation/kbuild/namespaces.rst``.
+:ref:`Documentation/core-api/symbol-namespaces.rst <core-api-namespace>`.
 
 :c:func:`EXPORT_SYMBOL_NS_GPL()`
 --------------------------------
@@ -610,7 +610,7 @@ Defined in ``include/linux/export.h``
 
 This is the variant of `EXPORT_SYMBOL_GPL()` that allows specifying a symbol
 namespace. Symbol Namespaces are documented in
-``Documentation/kbuild/namespaces.rst``.
+:ref:`Documentation/core-api/symbol-namespaces.rst <core-api-namespace>`.
 
 Routines and Conventions
 ========================
-- 
2.21.0

