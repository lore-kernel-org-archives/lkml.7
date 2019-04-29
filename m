Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B31C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F742067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="YGTQ8yQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfD2Vrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:47:35 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:33832 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbfD2Vrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:47:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id E9C7E4A3;
        Mon, 29 Apr 2019 23:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1556574451; x=1558388852;
         bh=g929uR7j5Bljj/SBE5STwaZj4+jLJMam9hBjyMFxOyE=; b=YGTQ8yQFm8e9
        4TrdLZqp1JH50iqSFWrKO3MCLnziDMD7C5FnLUc0efA+VhGJWW3CaTFiIkh68LLJ
        azzqBl/CIqZbgu5HAOzJeaoeSYMRZw1pmFo/mfda29FycAeqE5nwVSeI2UsbRv/D
        8j3rdBkK3MU/6t1FjFjTay/UwlskevI4xCeT7Tt/GZB++VyNNerPJ20QEDgCbq5Y
        oiZ8gRA9WJbMX0px1CUtRPVJ6xcixNpNV5TN+tZrCTUKv+OalQLQi8athhyTjdDF
        36DOV9j+NuHkJXijwAJ5tbb0sh5ha6MK2GX3XGAo6+rAXztTbGKL8lLbbpjzRdLf
        EpLVhYrbojIu8oH9LwpeBmfM0SC5G+1A0mJx1Qp8BRyVDolAntVOuWiX1Lt/8IBT
        PnhbsggEhGg5eUWC4yDOgSWsgJeDE7ERPIZLCBPaNn+MmDTqaiyEDBmuHUxBa4p3
        3oNgqy17yXdtTPEiNjV+CEcXyct2cPVV/GzUIvMoaj7MMEutZozrPyhuJPA4bF6I
        P/1Bh2NanE5TaRw3yWNOaNtwc22bdNEbqEVyDIWloIqqkVy8RWFNhi8e8BVfcWDo
        pqeB8Jlx7SYnJxQ5XmM87zmGBhy8+z5636LvAe4HID6fhMm21YxYm45p+R9XtBgW
        dW7UgWZqnMQ1M8UB9kGgZP3EJLAqVHA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u67NlFI4fDUg; Mon, 29 Apr 2019 23:47:31 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id A48BA126;
        Mon, 29 Apr 2019 23:47:31 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 570282A0D;
        Mon, 29 Apr 2019 23:47:31 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc:it_IT: translation alignment
Date:   Mon, 29 Apr 2019 23:47:20 +0200
Message-Id: <20190429214720.25725-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aling Italian translation after the following changes in Documentation

bba757d8578f coding-style.rst: Generic alloc functions do not need OOM logging
d8e8bcc3d8de docs: doc-guide: remove the extension from .rst files

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/core-api/memory-allocation.rst            | 13 +++++++++++++
 .../translations/it_IT/doc-guide/index.rst          |  6 +++---
 .../translations/it_IT/process/coding-style.rst     |  8 +++++++-
 3 files changed, 23 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/translations/it_IT/core-api/memory-allocation.rst

diff --git a/Documentation/translations/it_IT/core-api/memory-allocation.rst b/Documentation/translations/it_IT/core-api/memory-allocation.rst
new file mode 100644
index 000000000000..11d5148f8d6b
--- /dev/null
+++ b/Documentation/translations/it_IT/core-api/memory-allocation.rst
@@ -0,0 +1,13 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: :ref:`Documentation/core-api/memory-allocation.rst <memory_allocation>`
+
+.. _it_memory_allocation:

+================================
+Guida all'allocazione di memoria
+================================
+
+.. warning::
+
+    TODO ancora da tradurre
diff --git a/Documentation/translations/it_IT/doc-guide/index.rst b/Documentation/translations/it_IT/doc-guide/index.rst
index 7a6562b547ee..9fffff626711 100644
--- a/Documentation/translations/it_IT/doc-guide/index.rst
+++ b/Documentation/translations/it_IT/doc-guide/index.rst
@@ -12,9 +12,9 @@ Come scrivere la documentazione del kernel
 .. toctree::
    :maxdepth: 1
 
-   sphinx.rst
-   kernel-doc.rst
-   parse-headers.rst
+   sphinx
+   kernel-doc
+   parse-headers
 
 .. only::  subproject and html
 
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 2fd0e7f79d55..5ef534c95e69 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -859,7 +859,8 @@ racchiusa in #ifdef, potete usare printk(KERN_DEBUG ...).
 
 Il kernel fornisce i seguenti assegnatori ad uso generico:
 kmalloc(), kzalloc(), kmalloc_array(), kcalloc(), vmalloc(), e vzalloc().
-Per maggiori informazioni, consultate la documentazione dell'API.
+Per maggiori informazioni, consultate la documentazione dell'API:
+:ref:`Documentation/translations/it_IT/core-api/memory-allocation.rst <it_memory_allocation>`
 
 Il modo preferito per passare la dimensione di una struttura è il seguente:
 
@@ -890,6 +891,11 @@ Il modo preferito per assegnare un vettore a zero è il seguente:
 Entrambe verificano la condizione di overflow per la dimensione
 d'assegnamento n * sizeof(...), se accade ritorneranno NULL.
 
+Questi allocatori generici producono uno *stack dump* in caso di fallimento
+a meno che non venga esplicitamente specificato __GFP_NOWARN. Quindi, nella
+maggior parte dei casi, è inutile stampare messaggi aggiuntivi quando uno di
+questi allocatori ritornano un puntatore NULL.
+
 15) Il morbo inline
 -------------------
 
-- 
2.20.1

