Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B888AC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CE320652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555940111;
	bh=+n4o0bYnMjFb+XXNFBS0wTEmDBcODf8Zu+JXIY8CV7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pzhWMhEVWx++bPFeWevox49RWDtSm6JKKVRVKqYBPoYGIS9/1NhlYG6Xu1+zy5vcS
	 wToU346xF+EnjyxabWcO0VJfKerF0VACdqkjgynD63BSAOdtetfqIJzIxz1sgVnqwE
	 G527qcQi8b1moKtcxlvvfw/4+Ob1MCQ9sht7Buus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfDVNfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:35:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfDVN2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lKplnLPP+Ke7yGkfsStl2Ys/5zkfNT7d5HVlqGAdajk=; b=k2gPHSa76fE0hJvgdMWmmXLsp+
        URHoWSya59fwjn0k7wgEcwOE/hyNF3ibw8fx0n2McUaOx30Y6dNBpjpdwvo5EEzOS8B5XGfP02Qqz
        4Z/2K0BB/uYMV8Q6ZcFn+s/b34MB7O5XOAp0OlG4GsMNy6Rx/xaVOh0SbvSCp0vSz0uRTz7eUu4Bx
        uJ8rvYmtfYy1xECI01k2AWw3NCY3H6UEs8JASs7ZWsrupCeI1EZLDwrlcwXngFQ941dVKBKtncwvB
        yt/KDckxznFDPBfovM79bHX4US7/DFOaIHJNqifCjoM8IFpAZMUBEIVCD5Cn12CcxcWZht8e2A2RS
        KhCp+few==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzZ-0005Hj-6V; Mon, 22 Apr 2019 13:28:17 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzU-0005on-Dv; Mon, 22 Apr 2019 10:28:12 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 66/79] docs: namespaces: convert to ReST
Date:   Mon, 22 Apr 2019 10:27:55 -0300
Message-Id: <77a8a92a31103a49a167fc73d2f4404f8a587e3e.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
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
 ...{compatibility-list.txt => compatibility-list.rst} |  9 +++++++--
 Documentation/namespaces/index.rst                    | 11 +++++++++++
 .../{resource-control.txt => resource-control.rst}    |  4 ++++
 3 files changed, 22 insertions(+), 2 deletions(-)
 rename Documentation/namespaces/{compatibility-list.txt => compatibility-list.rst} (86%)
 create mode 100644 Documentation/namespaces/index.rst
 rename Documentation/namespaces/{resource-control.txt => resource-control.rst} (89%)

diff --git a/Documentation/namespaces/compatibility-list.txt b/Documentation/namespaces/compatibility-list.rst
similarity index 86%
rename from Documentation/namespaces/compatibility-list.txt
rename to Documentation/namespaces/compatibility-list.rst
index defc5589bfcd..3af5b05156e7 100644
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
2.20.1

