Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EDAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9679726147
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="d1QwvrDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfE3UP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:15:28 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:62724 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfE3UP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:15:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 9055E51F;
        Thu, 30 May 2019 22:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1559247325; x=1561061726; bh=o+dhPOQysQg5njFIBC1sFX14Ow3LdaOEtsg
        F1ERnj5Q=; b=d1QwvrDPhrBdsE4uPwDsxVxBLepkqEWyRf9+oz1P6YIBcbwqsnh
        3mT2HzDmM+fP6d4uqmUjaZ05r9CjZEGoefmtcQk+3EU/gH2CQCnQxsukSvA5LD6d
        +6iqcMdlXvpHlSEkcx7PoxcTMuEToTNEFOjgBhW5Extvw880AqtGYUo30eaxV9E3
        edAYn2OQxaBDumAU5Ylrbw4Zr5hSq/e0DZOE65PH0RZ7LDEVCFIirELUZuzQMA51
        FWv9gO479uxVMHyirsPgah/59tJsgAnPPwfnLamWJpYyFozy+KDTtPckCw55bJHH
        CpKwdnMt8jq/ULZxL9R/K7GMq94zVmRFmv7FhgU75J1rE3Hj6AwqAd1nmMiVsV7u
        BC083HYWwVLXmukAL56XazlFeE9NNpf8VWHDJX2quFz9zcqwVtAgDjnAAiNUXyvr
        M2q0cyowvl0mrRMCOZqhC9p/kKNyWYKUZykPYhNT9mtzzsI52hqck/tn7FBM0DGl
        TzZnT5l7890hrNjmLe2JGRL8kaWRyuCLWMqZdVlyXwi2yRGhMqfk9g0KDBEhvLFT
        urNifWpOhsdXehtm5BIKGRLgboEJ5lp5KUwvCuI0rVuv707z4wv7ZPn3SavPrPcl
        3tvBSLrAhWvLv9u8A4cpi4Ztk26OOUAS6Wai/GU6MWXrviMNKuSiT7J0=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l3yIbyGF4e75; Thu, 30 May 2019 22:15:25 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 12C4B11C;
        Thu, 30 May 2019 22:15:24 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id AF330B99;
        Thu, 30 May 2019 22:15:24 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH] doc:it_IT: documentation alignment
Date:   Thu, 30 May 2019 22:14:55 +0200
Message-Id: <20190530201455.12412-2-federico.vaga@vaga.pv.it>
In-Reply-To: <20190530201455.12412-1-federico.vaga@vaga.pv.it>
References: <20190530201455.12412-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation alignment for the following changes:
a700767a7682 (doc/docs-next) docs: requirements.txt: recommend Sphinx 1.7.9

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/doc-guide/sphinx.rst     | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index 793b5cc33403..1739cba8863e 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -35,8 +35,7 @@ Installazione Sphinx
 ====================
 
 I marcatori ReST utilizzati nei file in Documentation/ sono pensati per essere
-processati da ``Sphinx`` nella versione 1.3 o superiore. Se desiderate produrre
-un documento PDF è raccomandato l'utilizzo di una versione superiore alle 1.4.6.
+processati da ``Sphinx`` nella versione 1.3 o superiore.
 
 Esiste uno script che verifica i requisiti Sphinx. Per ulteriori dettagli
 consultate :ref:`it_sphinx-pre-install`.
@@ -68,13 +67,13 @@ pacchettizzato dalla vostra distribuzione.
       utilizzando LaTeX. Per una corretta interpretazione, è necessario aver
       installato texlive con i pacchetti amdfonts e amsmath.
 
-Riassumendo, se volete installare la versione 1.4.9 di Sphinx dovete eseguire::
+Riassumendo, se volete installare la versione 1.7.9 di Sphinx dovete eseguire::
 
-       $ virtualenv sphinx_1.4
-       $ . sphinx_1.4/bin/activate
-       (sphinx_1.4) $ pip install -r Documentation/sphinx/requirements.txt
+       $ virtualenv sphinx_1.7.9
+       $ . sphinx_1.7.9/bin/activate
+       (sphinx_1.7.9) $ pip install -r Documentation/sphinx/requirements.txt
 
-Dopo aver eseguito ``. sphinx_1.4/bin/activate``, il prompt cambierà per
+Dopo aver eseguito ``. sphinx_1.7.9/bin/activate``, il prompt cambierà per
 indicare che state usando il nuovo ambiente. Se aprite un nuova sessione,
 prima di generare la documentazione, dovrete rieseguire questo comando per
 rientrare nell'ambiente virtuale.
@@ -120,8 +119,8 @@ l'installazione::
 	You should run:
 
 		sudo dnf install -y texlive-luatex85
-		/usr/bin/virtualenv sphinx_1.4
-		. sphinx_1.4/bin/activate
+		/usr/bin/virtualenv sphinx_1.7.9
+		. sphinx_1.7.9/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
 
 	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
-- 
2.21.0

