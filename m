Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4EAC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7E72083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561724661;
	bh=4EP0i71QCGkT60PFMZjnqQfjzvWfOVKjTFUDNd1BTGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PNyFMqYa1yP0CVOhKRfCkQYlz8SSXVuNHbbUZjx/bHzRKaFi1GjgW7/Ou58XTQ3G/
	 ly//qQAggiYKvKzWfTJuoZm6yb0XrF0kywvyEvGuN6IqPJhVnAKMbclVuxu6IqYWgb
	 rs/FjOgOh2ODsHqmDCwNwyZhqRJMc+qzPIIupE8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfF1MYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:24:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfF1MUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XybHKlaRWzbSGlu8K7TS9Q7Y/OmFmTKD4x+hIonIz/Y=; b=HIpclx1fIAgwTPJvXb6Iml9sZ3
        EIuPE5hskU9F7S7sc6Hco2psefHzp1qFcvBBxfTNfBMMttnNnmIqIiCXdQbUWZgTeSy6oShAcusD9
        NPySJZhBcqrlbLfaYwq44qT/9Y/EHEGrqCiklqa3/keqm2+PaYJHiuxVPv3YNx4lFZHYliHfwF0YI
        Wa+Uastj/s+8ybJe7Ce+L3BGeW+JgA3PfJo5ROWi03tIsjiqueJAJDX9lqlgmW/HKnbNgDXR6d80e
        qxuc+ChOtIdahkdjRGHgtjVPjabIgCcmCXwySU047XFDD+r9moEoMJMU2dW92+EBC0FnXAR0Cw8oN
        uspTS5lA==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-0000AE-Lw; Fri, 28 Jun 2019 12:20:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-00058t-OR; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 26/43] docs: namespaces: convert to ReST
Date:   Fri, 28 Jun 2019 09:20:22 -0300
Message-Id: <5a600da4c9921a96481114077d913879b50497ff.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the namespaces documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

There are two upper case file names. Rename them to
lower case, as we're working to avoid upper case file
names at Documentation.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 ...{compatibility-list.txt => compatibility-list.rst} | 10 +++++++---
 Documentation/namespaces/index.rst                    | 11 +++++++++++
 .../{resource-control.txt => resource-control.rst}    |  4 ++++
 3 files changed, 22 insertions(+), 3 deletions(-)
 rename Documentation/namespaces/{compatibility-list.txt => compatibility-list.rst} (86%)
 create mode 100644 Documentation/namespaces/index.rst
 rename Documentation/namespaces/{resource-control.txt => resource-control.rst} (89%)

diff --git a/Documentation/namespaces/compatibility-list.txt b/Documentation/namespaces/compatibility-list.rst
similarity index 86%
rename from Documentation/namespaces/compatibility-list.txt
rename to Documentation/namespaces/compatibility-list.rst
index defc5589bfcd..318800b2a943 100644
--- a/Documentation/namespaces/compatibility-list.txt
+++ b/Documentation/namespaces/compatibility-list.rst
@@ -1,4 +1,6 @@
-	Namespaces compatibility list
+=============================
+Namespaces compatibility list
+=============================
 
 This document contains the information about the problems user
 may have when creating tasks living in different namespaces.
@@ -7,13 +9,16 @@ Here's the summary. This matrix shows the known problems, that
 occur when tasks share some namespace (the columns) while living
 in different other namespaces (the rows):
 
-	UTS	IPC	VFS	PID	User	Net
+====	===	===	===	===	====	===
+-	UTS	IPC	VFS	PID	User	Net
+====	===	===	===	===	====	===
 UTS	 X
 IPC		 X	 1
 VFS			 X
 PID		 1	 1	 X
 User		 2	 2		 X
 Net						 X
+====	===	===	===	===	====	===
 
 1. Both the IPC and the PID namespaces provide IDs to address
    object inside the kernel. E.g. semaphore with IPCID or
@@ -36,4 +41,3 @@ Net						 X
    even having equal UIDs.
 
    But currently this is not so.
-
diff --git a/Documentation/namespaces/index.rst b/Documentation/namespaces/index.rst
new file mode 100644
index 000000000000..bf40625dd11a
--- /dev/null
+++ b/Documentation/namespaces/index.rst
@@ -0,0 +1,11 @@
+:orphan:
+
+==========
+Namespaces
+==========
+
+.. toctree::
+   :maxdepth: 1
+
+   compatibility-list
+   resource-control
diff --git a/Documentation/namespaces/resource-control.txt b/Documentation/namespaces/resource-control.rst
similarity index 89%
rename from Documentation/namespaces/resource-control.txt
rename to Documentation/namespaces/resource-control.rst
index abc13c394738..369556e00f0c 100644
--- a/Documentation/namespaces/resource-control.txt
+++ b/Documentation/namespaces/resource-control.rst
@@ -1,3 +1,7 @@
+===========================
+Namespaces research control
+===========================
+
 There are a lot of kinds of objects in the kernel that don't have
 individual limits or that have limits that are ineffective when a set
 of processes is allowed to switch user ids.  With user namespaces
-- 
2.21.0

