Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D462C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B595B21655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernelthusiast.com header.i=@kernelthusiast.com header.b="pdF/yaEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfHPMWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:22:16 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com ([46.30.210.182]:45452
        "EHLO mailrelay1-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727134AbfHPMWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelthusiast.com; s=20140924;
        h=content-transfer-encoding:content-type:mime-version:message-id:subject:cc:to:
         from:date:from;
        bh=MqBGoGP8EsqeK+2XNYeOygT9JY6T6r/XKPLtK4b7IDw=;
        b=pdF/yaELulMPNiOqXU+6GUe8hz+dLF5ldHPSbfnZKJ8dF947WPeaNWQ7yn/CtWUN2VgwKzyH9kkHy
         wyz/2rJqa06FSwQ3nA98++MhUarE6TvfdkTv1rHEW/fws86vAlgwKzH2tULMp6NgQ+qeyhu2lDfT/f
         M7bxfD8b1ybKOdt8=
X-HalOne-Cookie: a2f75e830723c1a88d249f86aeee50bff8e4b055
X-HalOne-ID: 787ae46b-c020-11e9-aee3-d0431ea8a283
Received: from localhost (unknown [105.159.18.151])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 787ae46b-c020-11e9-aee3-d0431ea8a283;
        Fri, 16 Aug 2019 12:22:10 +0000 (UTC)
Date:   Fri, 16 Aug 2019 13:22:09 +0100
From:   Jacob Huisman <jacobhuisman@kernelthusiast.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: process: fix broken link
Message-ID: <20190816122209.5bz4rlln5cahn7ki@jacob-MS-7A62>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

http://linux.yyz.us/patch-format.html seems to be down since
approximately September 2018. There is a working archive copy on
arhive.org. Replaced the links in documenation + translations.

Signed-off-by: Jacob Huisman <jacobhuisman@kernelthusiast.com>
---
 Documentation/process/howto.rst                                 | 2 +-
 Documentation/process/submitting-patches.rst                    | 2 +-
 Documentation/translations/it_IT/process/howto.rst              | 2 +-
 Documentation/translations/it_IT/process/submitting-patches.rst | 2 +-
 Documentation/translations/ja_JP/SubmittingPatches              | 2 +-
 Documentation/translations/ja_JP/howto.rst                      | 2 +-
 Documentation/translations/ko_KR/howto.rst                      | 2 +-
 Documentation/translations/zh_CN/process/howto.rst              | 2 +-
 Documentation/translations/zh_CN/process/submitting-patches.rst | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 6ab75c11d2c3..b6f5a379ad6c 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -123,7 +123,7 @@ required reading:
 		https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
 	"Linux kernel patch submission format"
-		http://linux.yyz.us/patch-format.html
+		https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html
 
   :ref:`Documentation/process/stable-api-nonsense.rst <stable_api_nonsense>`
     This file describes the rationale behind the conscious decision to
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 9c4299293c72..fb56297f70dc 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -844,7 +844,7 @@ Andrew Morton, "The perfect patch" (tpp).
   <http://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
 Jeff Garzik, "Linux kernel patch submission format".
-  <http://linux.yyz.us/patch-format.html>
+  <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
 
 Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
   <http://www.kroah.com/log/linux/maintainer.html>
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 44e6077730e8..1db5a1082389 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -129,7 +129,7 @@ Di seguito una lista di file che sono presenti nei sorgente del kernel e che
 		https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
 	"Linux kernel patch submission format"
-		http://linux.yyz.us/patch-format.html
+		https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html
 
   :ref:`Documentation/translations/it_IT/process/stable-api-nonsense.rst <it_stable_api_nonsense>`
 
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 7d7ea92c5c5a..cba1f8cb61ed 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -868,7 +868,7 @@ Andrew Morton, "La patch perfetta" (tpp).
   <http://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
 Jeff Garzik, "Formato per la sottomissione di patch per il kernel Linux"
-  <http://linux.yyz.us/patch-format.html>
+  <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
 
 Greg Kroah-Hartman, "Come scocciare un manutentore di un sottosistema"
   <http://www.kroah.com/log/linux/maintainer.html>
diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index ad979c3c06a6..dd0c3280ba5a 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -693,7 +693,7 @@ Andrew Morton, "The perfect patch" (tpp).
   <http://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
 Jeff Garzik, "Linux kernel patch submission format".
-  <http://linux.yyz.us/patch-format.html>
+  <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
 
 Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
   <http://www.kroah.com/log/2005/03/31/>
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 2621b770a745..73ebdab4ced7 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -139,7 +139,7 @@ linux-api@vger.kernel.org に送ることを勧めます。
        "The Perfect Patch"
 		http://www.ozlabs.org/~akpm/stuff/tpp.txt
        "Linux kernel patch submission format"
-		http://linux.yyz.us/patch-format.html
+		https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html
 
   :ref:`Documentation/process/stable-api-nonsense.rst <stable_api_nonsense>`
     このファイルはカーネルの中に不変の API を持たないことにした意識的
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index bcd63731b80a..b3f51b19de7c 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -135,7 +135,7 @@ mtk.manpages@gmail.com의 메인테이너에게 보낼 것을 권장한다.
         https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
     "Linux kernel patch submission format"
-        http://linux.yyz.us/patch-format.html
+        https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html
 
    :ref:`Documentation/process/stable-api-nonsense.rst <stable_api_nonsense>`
     이 문서는 의도적으로 커널이 불변하는 API를 갖지 않도록 결정한
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index b244a7190eb6..a8e6ab818983 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -113,7 +113,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 
     "Linux kernel patch submission format"
 
-        http://linux.yyz.us/patch-format.html
+        https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html
 
   :ref:`Documentation/translations/zh_CN/process/stable-api-nonsense.rst <cn_stable_api_nonsense>`
     论证内核为什么特意不包括稳定的内核内部API，也就是说不包括像这样的特
diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index 437c23b367bb..1bb4271ab420 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -652,7 +652,7 @@ Andrew Morton, "The perfect patch" (tpp).
   <http://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
 Jeff Garzik, "Linux kernel patch submission format".
-  <http://linux.yyz.us/patch-format.html>
+  <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
 
 Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
   <http://www.kroah.com/log/linux/maintainer.html>
-- 
2.17.1

