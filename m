Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7729CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32996204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="WhDtygvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfCEWGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:06:38 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:25528 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfCEWGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:06:38 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id C18791375;
        Tue,  5 Mar 2019 23:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1551823594; x=1553637995;
         bh=1WgQPcZMgBjRpPSwCDSEun053eYRjBQsDu5d8vYZo2g=; b=WhDtygvS+stp
        EVS6ATm0xGD+GXjmU9KwXW/WiJg4P9Nt11tdbWZWR9k8UYB2tiaIZEZVDRk5xEU+
        tChtXpGQzUk0KFd+QLTGBDjeM0sy2yAUMlT5w9YlqU7quptp/cTPl1PdVQ5ZgAJ3
        jBnZJcaAoXhKp2O+m+HMs+BE7bKpIAequPPjKH6g8JHjI/YGzLqIP10Iap2K70bm
        esa4tP6e0gXRcHwKGXcnRK4EyXy9Nq8PWGmxEi9HRKL1Ec+D912W6PzjaC6VotNx
        KANTOzbAo41flPXj93j0YYG22ZGgLkS5ZC/lN//pr2YjbT7gN5TYypIYn8KVT9hQ
        XJUuYzZ6jQFhxRpmd+UjdCFFYokuESBKA+jvGiC3Mo/Y5GA8GM+IfJekG9d/szhi
        PqU35GM6yZwxerQE150Rs9Q1izYY5/1WtMjklARHWXsjeUWyUJS422MZ1u0W3Ssc
        ZjpbsysejoCbSltfQys19wbohl/zElheqiDSTwBpWtoHjJ4pFabm+qHLq1EFjn1u
        W6Au3uUmLhCBes7wtQzIhy2UX8LBTERdQGP/ZbGyS5La1XHwL02PpvDGRlidDVfk
        ilbh1g/Y/FdndWOad08yOY8o9Vzdj7ETrAnid5R9iT9ByQaVAdBOvc4/qqZuE2/H
        KZG6WLNcbyxBKb8WAx81QNBPk3fla+o=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iJMYZpJhU1ot; Tue,  5 Mar 2019 23:06:34 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 9DB04110D;
        Tue,  5 Mar 2019 23:06:34 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 2C845202C;
        Tue,  5 Mar 2019 23:06:34 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     linux-doc@vger.kernel.org
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>, harryxiyou@gmail.com,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [RFC PATCH] doc: translation disclaimer
Date:   Tue,  5 Mar 2019 23:06:11 +0100
Message-Id: <20190305220611.13136-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is only an example to propose a structure for translation's
disclaimers. The actual text needs some thoughs.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/index.rst           | 18 ++++++++++++++++++
 .../translations/it_IT/disclaimer-ita.rst      | 13 +++----------
 Documentation/translations/it_IT/index.rst     |  6 ++++++
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
index 7f77c52d33aa..b46c8ce98d6e 100644
--- a/Documentation/translations/index.rst
+++ b/Documentation/translations/index.rst
@@ -4,6 +4,24 @@
 Translations
 ============
 
+.. _translations_disclaimer:
+
+Disclaimer
+----------
+Write some text in English here to explain that:
+
+- its purpose is to ease reading and understanding in other languages
+- this is not a fork
+- the only official documentation is :ref:`linux_doc`
+- there are not guarantee about translations being in line with the
+  main documentation
+- translation's maintainer can help people who can't write in English
+- only comments and patches about translations are accepted, any other
+  discussion about Documentation does not belong here
+
+Translations
+------------
+
 .. toctree::
    :maxdepth: 1
 
diff --git a/Documentation/translations/it_IT/disclaimer-ita.rst b/Documentation/translations/it_IT/disclaimer-ita.rst
index d68e52de6a5d..aacc1a0346db 100644
--- a/Documentation/translations/it_IT/disclaimer-ita.rst
+++ b/Documentation/translations/it_IT/disclaimer-ita.rst
@@ -1,13 +1,6 @@
 :orphan:
 
-.. note::
-   This document is maintained by Federico Vaga <federico.vaga@vaga.pv.it>.
-   If you find any difference between this document and the original file or a
-   problem with the translation, please contact the maintainer of this file.
-   Following people helped to translate or review:
-   Alessia Mantegazza <amantegazza@vaga.pv.it>
-
 .. warning::
-   The purpose of this file is to be easier to read and understand for Italian
-   speakers and is not intended as a fork. So, if you have any comments or
-   updates for this file please try to update the original English file first.
+   Short (to not pollute the document) text in Italian to explain that for any
+   doubt about the documentation content people should refer to the English
+   documentation. Read the :ref:`it_disclaimer`.
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index ea9b2916b3e4..4b0b3da97c73 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -4,6 +4,12 @@
 Traduzione italiana
 ===================
 
+.. _it_disclaimer:
+
+Disclaimer
+==========
+The following text should be the translation of :ref:`translations_disclaimer`
+
 L'obiettivo di questa traduzione è di rendere più facile la lettura e
 la comprensione per chi preferisce leggere in lingua italiana.
 Tenete presente che la documentazione di riferimento rimane comunque
-- 
2.20.1

