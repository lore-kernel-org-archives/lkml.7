Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB8C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DDA20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364733;
	bh=4EP0i71QCGkT60PFMZjnqQfjzvWfOVKjTFUDNd1BTGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qAOj3ElJFbtFMb+Vfre3LpQIohntzshmJgmAWBqhngZZMT6P/8gK9GISFAmvZWA5c
	 COuqneTZYXYaPNEhXwIMFVDDTHLSAngfCBcPgxap0vIg19CbisDUpvDM+V1X+UiccZ
	 AO2MjiOmzIpMCfoyvpQ3ppLYu7LbyXDVD3cHE67U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfFLSix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:38:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfFLSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XybHKlaRWzbSGlu8K7TS9Q7Y/OmFmTKD4x+hIonIz/Y=; b=ow1Fmud8AxtZf9u693hRtt80Es
        SGMqTYmlP7OP5C+add2F2LmnK80vX7ePOXcdNxSKb9o/nj+q4QKHQmx6K/0Isac316egD7BCu4LUr
        I5rW61XPUG78fOb+SbkdaD1MRus841njhqIHRPd9ThSFR4XE/YqcmaQbYpF83xi42q/BYnO0eR0Qg
        HFTUmIvlJBqIXYpNLGfXeV87tDXB2f+RK3UnAS6dn2DE49kPbCx02t9yw7V+2OFLp0RSa93Z0WSsz
        2rL2z5qC7tjIaxA4rIwXC6OjT59V7Vrn262HdHxc5OgV401zuAy81X7kMmv680uGfZ1LF83Bzloir
        xtmExswg==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YN-QE; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002Br-F4; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 25/31] docs: namespaces: convert to ReST
Date:   Wed, 12 Jun 2019 15:38:28 -0300
Message-Id: <01885b98cbf7616677365d81ea80a6733f37ebf5.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
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

