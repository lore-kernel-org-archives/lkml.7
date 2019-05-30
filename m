Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF76B2614D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="AvQx8mFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE3UPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:15:31 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:49014 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfE3UP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:15:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id D4928115;
        Thu, 30 May 2019 22:15:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1559247322; x=1561061723;
         bh=1qhTdGH//kJBWe1drqhLRUMzzbeFHY43hpvGox9CUAE=; b=AvQx8mFU6PGU
        E8Udc+8buXCfNULPfhdErId3TxNWT+z3N97MtTJidCjhCQhxc4gR/Si6brKssgeL
        mz79r2jm8JY8lnmsgXkwyGSOBFfcs8kqS0KLMK30LARqjJOl2rTbvjejocZhe+5v
        nFtAr0VcVnDqdif6Xz9aKWdEBJxXx0BdXqDP/u37Jk9cTw5NEg81S6lrhF/XuoWN
        q9YnegxxCar3wZQyObAwMOwOdSaffDtb8VFotbLXxzuiijuuRGheasyUxAxvCPVU
        LiIHYPqAmgpa/ZuPePAl/dpO+MJn+OhMkFhFgy8Co+CZCvsvMcqaekMdz4h/pqrO
        yljuW30We9fjsXPm7U+aSIHLQWs/hOWGaojdhcvaMQ0KEeNNLvETiYOLxZ0h2kPz
        OKueFJ0m5oW8S+RyofFi0DrGM4WbnR9PNtZuL0J0mo1huK/LZMjoY8oKZJah/4pa
        1fcy7OgBqcivCFgRmajj81VPVDkBujpq7CamIcaRAsxgUEIiBZLYXKgBWV06Hz0a
        03kCa/YCi2cUEfNv+eHf8ImsnRDjXYs1xI/w1zgKrw/7NZS+ofEBqlJ3i4An2wPK
        SQ59RuVeGGwYbosGFyFN7xShxtASFZWzYx3cyX0soq+S+0sNcN7DndLlaWlkvS54
        Ou5NbnkCOdeY6hZ9YLgZ4LYMeZ5OSoM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3cHiLUBpyZnI; Thu, 30 May 2019 22:15:22 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id EF669C8;
        Thu, 30 May 2019 22:15:21 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 968452B3C;
        Thu, 30 May 2019 22:15:21 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH] doc:it_IT: fix file references
Date:   Thu, 30 May 2019 22:14:54 +0200
Message-Id: <20190530201455.12412-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix italian translation file references based on
`scripts/documentation-file-ref-check` output.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/admin-guide/kernel-parameters.rst          | 12 ++++++++++++
 .../translations/it_IT/process/adding-syscalls.rst   |  2 +-
 .../translations/it_IT/process/coding-style.rst      |  2 +-
 Documentation/translations/it_IT/process/howto.rst   |  2 +-
 .../translations/it_IT/process/magic-number.rst      |  2 +-
 .../it_IT/process/stable-kernel-rules.rst            |  4 ++--
 6 files changed, 18 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/translations/it_IT/admin-guide/kernel-parameters.rst

diff --git a/Documentation/translations/it_IT/admin-guide/kernel-parameters.rst b/Documentation/translations/it_IT/admin-guide/kernel-parameters.rst
new file mode 100644
index 000000000000..0e36d82a92be
--- /dev/null
+++ b/Documentation/translations/it_IT/admin-guide/kernel-parameters.rst
@@ -0,0 +1,12 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
+
+.. _it_kernelparameters:
+
+I parametri da linea di comando del kernel
+==========================================
+
+.. warning::
+
+    TODO ancora da tradurre
diff --git a/Documentation/translations/it_IT/process/adding-syscalls.rst b/Documentation/translations/it_IT/process/adding-syscalls.rst
index e0a64b0688a7..c3a3439595a6 100644
--- a/Documentation/translations/it_IT/process/adding-syscalls.rst
+++ b/Documentation/translations/it_IT/process/adding-syscalls.rst
@@ -39,7 +39,7 @@ vostra interfaccia.
        un qualche modo opaca.
 
  - Se dovete esporre solo delle informazioni sul sistema, un nuovo nodo in
-   sysfs (vedere ``Documentation/translations/it_IT/filesystems/sysfs.txt``) o
+   sysfs (vedere ``Documentation/filesystems/sysfs.txt``) o
    in procfs potrebbe essere sufficiente.  Tuttavia, l'accesso a questi
    meccanismi richiede che il filesystem sia montato, il che potrebbe non
    essere sempre vero (per esempio, in ambienti come namespace/sandbox/chroot).
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 5ef534c95e69..a6559d25a23d 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -696,7 +696,7 @@ nella stringa di titolo::
 	...
 
 Per la documentazione completa sui file di configurazione, consultate
-il documento Documentation/translations/it_IT/kbuild/kconfig-language.txt
+il documento Documentation/kbuild/kconfig-language.txt
 
 
 11) Strutture dati
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 9903ac7c566b..44e6077730e8 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -131,7 +131,7 @@ Di seguito una lista di file che sono presenti nei sorgente del kernel e che
 	"Linux kernel patch submission format"
 		http://linux.yyz.us/patch-format.html
 
-  :ref:`Documentation/process/translations/it_IT/stable-api-nonsense.rst <it_stable_api_nonsense>`
+  :ref:`Documentation/translations/it_IT/process/stable-api-nonsense.rst <it_stable_api_nonsense>`
 
     Questo file descrive la motivazioni sottostanti la conscia decisione di
     non avere un API stabile all'interno del kernel, incluso cose come:
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
index 5281d53e57ee..ed1121d0ba84 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/magic-numbers.rst <magicnumbers>`
+:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_magicnumbers:
diff --git a/Documentation/translations/it_IT/process/stable-kernel-rules.rst b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
index 48e88e5ad2c5..4f206cee31a7 100644
--- a/Documentation/translations/it_IT/process/stable-kernel-rules.rst
+++ b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
@@ -33,7 +33,7 @@ Regole sul tipo di patch che vengono o non vengono accettate nei sorgenti
  - Non deve includere alcuna correzione "banale" (correzioni grammaticali,
    pulizia dagli spazi bianchi, eccetera).
  - Deve rispettare le regole scritte in
-   :ref:`Documentation/translation/it_IT/process/submitting-patches.rst <it_submittingpatches>`
+   :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`
  - Questa patch o una equivalente deve esistere già nei sorgenti principali di
    Linux
 
@@ -43,7 +43,7 @@ Procedura per sottomettere patch per i sorgenti -stable
 
  - Se la patch contiene modifiche a dei file nelle cartelle net/ o drivers/net,
    allora seguite le linee guida descritte in
-   :ref:`Documentation/translation/it_IT/networking/netdev-FAQ.rst <it_netdev-FAQ>`;
+   :ref:`Documentation/translations/it_IT/networking/netdev-FAQ.rst <it_netdev-FAQ>`;
    ma solo dopo aver verificato al seguente indirizzo che la patch non sia
    già in coda:
    https://patchwork.ozlabs.org/bundle/davem/stable/?series=&submitter=&state=*&q=&archive=
-- 
2.21.0

