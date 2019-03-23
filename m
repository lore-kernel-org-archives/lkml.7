Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1570DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE552183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="j6oQTzAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfCWRyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:54:41 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:8056 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbfCWRyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:54:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id F02DAA5B;
        Sat, 23 Mar 2019 18:54:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1553363678; x=1555178079; bh=o3++y+tTQiX39ZZ2qcc
        8DjFV/pK55ojg6NkZGXUEucQ=; b=j6oQTzADai1BIjoVJaVLFRoB2wqEQ6kbhK9
        WzTKnCI1/4+MJ2xhcn81GW9o+G6jtkzqUpNY+vVb1O9IDN8EW+X4Qm0G/p36T9CK
        YpckbDmiVdc+KKWEgC3x9GAhwWZlXVGYBBm7zQ25QksejfI7ICbHrDkZ+rmlZb3d
        Yq1EStIPymxe2byS1EXCQzBCaYVeOeqyRy10JepIXvT1NIQf5e2SVJM6fwcm+4AL
        CkxmDMRFzVdIfqawS+W6+Rm9/fvago6HO7hgNuPfWaeVgE3pBOqp+r0xdY7D7F+v
        TqpB5jOofbTMEW9wv+Mqwvza+YJ9+tqpFfgazYsFkMNleLo/SlnPhByjCvC+Ay6A
        X6+WDH5M7Oxy3PCt4oIHR/pBDoSjQ9UKwilmT+pvgRtzKJSSkkpnbxlbl7L1BFYp
        VXKx4qI6xwigbwwSI93oBiJnxJA5IXZf4yT3fjbJgHmb5ZgHcwz4DhTDNZdCZg9d
        vpaIyiviLECc8zOgRYNTfx8wuqBA6bF2qGRQ6GSU7hV7gHodWuMuoZoT4nUX4zAr
        lkqkoDZ+mZRYwGxbwgZn3p60ry23fWAy3NvvsyG+I0JS5LwaPnE8V2bwPQUsRPUG
        4NDtH5NHGeRh+nbLciclO3XMwUGbvQboOAD0Txj19XRE3VGklBEZ5dtnKZ4ZeSXI
        ypDz9qVA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4PpCY4FOacoP; Sat, 23 Mar 2019 18:54:38 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id C911A690;
        Sat, 23 Mar 2019 18:54:38 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 9C51F2585;
        Sat, 23 Mar 2019 18:54:38 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: minor fixes to translation's disclaimer
Date:   Sat, 23 Mar 2019 18:54:16 +0100
Message-Id: <20190323175416.6348-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- move TOC on top because that's the most interesting part
- a couple of minor fixes

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/index.rst | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
index d7a38fd28b50..e446e5ed00a6 100644
--- a/Documentation/translations/index.rst
+++ b/Documentation/translations/index.rst
@@ -4,12 +4,21 @@
 Translations
 ============
 
+.. toctree::
+   :maxdepth: 1
+
+   zh_CN/index
+   it_IT/index
+   ko_KR/index
+   ja_JP/index
+
+
 .. _translations_disclaimer:
 
 Disclaimer
 ----------
 
-Translation's purpose is to ease reading and understating in languages other
+Translation's purpose is to ease reading and understanding in languages other
 than English. Its aim is to help people who do not understand English or have
 doubts about its interpretation. Additionally, some people prefer to read
 documentation in their native language, but please bear in mind that the
@@ -40,16 +49,5 @@ translations, you may find slight differences that carry the same message but
 in a different form.
 
 If you need to communicate with the Linux community but you do not feel
-comfortable to write in English, you can ask to the translation's
-maintainers for help.
-
-Translations
-------------
-
-.. toctree::
-   :maxdepth: 1
-
-   zh_CN/index
-   it_IT/index
-   ko_KR/index
-   ja_JP/index
+comfortable writing in English, you can ask the translation's maintainers
+for help.
-- 
2.20.1

