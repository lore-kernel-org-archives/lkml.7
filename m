Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF69C742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F26F2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="beEJhabK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfGLJtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:49:16 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:23808 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfGLJtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:49:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id DA134819;
        Fri, 12 Jul 2019 11:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1562924951; x=1564739352;
         bh=wQTMNC5ixS/PdxerKd4Z76if3VG9NLuox49067DW6BQ=; b=beEJhabKSNHv
        vc09nnt51AYvmVWIu2kZg3WQLCidYE/uXIu26xxBTsrWU2xSeNs1nap1dEk8LwLu
        6P8rUTdpVpJ5qebo1mJkPo0zy6R46U9SDCzCq0v4mFyB+88BwFO0mjfo3a/lShho
        +FcJr2OYgsh3KMvTVTCG2aglK+dS98WgmY6H4T11owVk1q/sUhbEHf48VwMBOp+l
        fVC9UuPPEHtOKw6JhuyhRMoNvDoTT5i7JGlgTIbdUemtgJMMupEY77F2t6PjT4qn
        waiYM5fgPfuRO58qHGE1wTGfL4VQhN015cWZCCxL6iK0iM5zVuWW0XlUXFn0xhZD
        ejjyKGwlIInfnmge3vr+fdwVVens3SPeJpEailczUeCoku6FSqVQCcsvxxVCPUbc
        zZlecdwLypkNafeuYQkfNtDyOyidyRJjRydwrlxk8BqEDKsEsNE5x0N1eg0p9ZgF
        kj1QGh6njJqLOMZblbTn+gfwv+uWRrwK7YGtUabZaRJhvCpZ+SZt+a9YVYSt/mKD
        MqYCbJmXP3+DtD4TEjVcsv4b4yAaNjYW8hV17kYsDBiBJs5bZzHv96dfGuNVgfoo
        FBdhXswZbsUTmSDcSd6CqWRAlYYBubr4rV/J42z3EBQT6kNaNDJVOXGP2E3ELnD8
        iw68Lb4K/Tc9rS/mH1GZeZgQ4ORTKgU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1uDIyw3L3EiP; Fri, 12 Jul 2019 11:49:11 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id D230340C;
        Fri, 12 Jul 2019 11:49:11 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 86205418;
        Fri, 12 Jul 2019 11:49:11 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: translations in process/
Date:   Fri, 12 Jul 2019 11:48:22 +0200
Message-Id: <20190712094822.4526-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add translations for:

- programming-languages
- kernel-docs (It is better to not translate this since English is
a requirement to get something useful out of it)

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/process/index.rst      |  1 +
 .../it_IT/process/kernel-docs.rst             | 11 ++--
 .../it_IT/process/programming-language.rst    | 51 +++++++++++++++++++
 3 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/translations/it_IT/process/programming-language.rst

diff --git a/Documentation/translations/it_IT/process/index.rst b/Documentation/translations/it_IT/process/index.rst
index 2eda85d5cd1e..012de0f3154a 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -27,6 +27,7 @@ Di seguito le guide che ogni sviluppatore dovrebbe leggere.
    code-of-conduct
    development-process
    submitting-patches
+   programming-language
    coding-style
    maintainer-pgp-guide
    email-clients
diff --git a/Documentation/translations/it_IT/process/kernel-docs.rst b/Documentation/translations/it_IT/process/kernel-docs.rst
index 7bd70d661737..38e0a955121a 100644
--- a/Documentation/translations/it_IT/process/kernel-docs.rst
+++ b/Documentation/translations/it_IT/process/kernel-docs.rst
@@ -1,6 +1,7 @@
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 
 .. _it_kernel_docs:
@@ -8,6 +9,10 @@
 Indice di documenti per le persone interessate a capire e/o scrivere per il kernel Linux
 ========================================================================================
 
-.. warning::
-
-    TODO ancora da tradurre
+.. note::
+   Questo documento contiene riferimenti a documenti in lingua inglese; inoltre
+   utilizza dai campi *ReStructuredText* di supporto alla ricerca e che per
+   questo motivo è meglio non tradurre al fine di garantirne un corretto
+   utilizzo.
+   Per questi motivi il documento non verrà tradotto. Per favore fate
+   riferimento al documento originale in lingua inglese.
diff --git a/Documentation/translations/it_IT/process/programming-language.rst b/Documentation/translations/it_IT/process/programming-language.rst
new file mode 100644
index 000000000000..f4b006395849
--- /dev/null
+++ b/Documentation/translations/it_IT/process/programming-language.rst
@@ -0,0 +1,51 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+
+.. _it_programming_language:
+
+Linguaggio di programmazione
+============================
+
+Il kernel è scritto nel linguaggio di programmazione C [c-language]_.
+Più precisamente, il kernel viene compilato con ``gcc`` [gcc]_ usando
+l'opzione ``-std=gnu89`` [gcc-c-dialect-options]_: il dialetto GNU
+dello standard ISO C90 (con l'aggiunta di alcune funzionalità da C99)
+
+Questo dialetto contiene diverse estensioni al linguaggio [gnu-extensions]_,
+e molte di queste vengono usate sistematicamente dal kernel.
+
+Il kernel offre un certo livello di supporto per la compilazione con ``clang``
+[clang]_ e ``icc`` [icc]_ su diverse architetture, tuttavia in questo momento
+il supporto non è completo e richiede delle patch aggiuntive.
+
+Attributi
+---------
+
+Una delle estensioni più comuni e usate nel kernel sono gli attributi
+[gcc-attribute-syntax]_. Gli attributi permettono di aggiungere una semantica,
+definita dell'implementazione, alle entità del linguaggio (come le variabili,
+le funzioni o i tipi) senza dover fare importanti modifiche sintattiche al
+linguaggio stesso (come l'aggiunta di nuove parole chiave) [n2049]_.
+
+In alcuni casi, gli attributi sono opzionali (ovvero un compilatore che non
+dovesse supportarli dovrebbe produrre comunque codice corretto, anche se
+più lento o che non esegue controlli aggiuntivi durante la compilazione).
+
+Il kernel definisce alcune pseudo parole chiave (per esempio ``__pure``)
+in alternativa alla sintassi GNU per gli attributi (per esempio
+``__attribute__((__pure__))``) allo scopo di mostrare quali funzionalità si
+possono usare e/o per accorciare il codice.
+
+Per maggiori informazioni consultate il file d'intestazione
+``include/linux/compiler_attributes.h``.
+
+.. [c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
+.. [gcc] https://gcc.gnu.org
+.. [clang] https://clang.llvm.org
+.. [icc] https://software.intel.com/en-us/c-compilers
+.. [gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
+.. [gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
+.. [gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
+.. [n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
-- 
2.21.0

