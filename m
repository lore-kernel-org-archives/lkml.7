Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101F9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D936120862
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381427;
	bh=WNPDCluyozucmaNaWmUF9ACNNlonskyrPoSnH5INEPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lo9AwG2PZache4w7laSgAFn4FdNDRxyknb21pNBceHEuhIcBLNQhfckOurcGjy9lE
	 bz9DW7pN1MOSRqSsRN+sVYsx+0h91eOspjzgbiQ1RDF/bJakP7cIngfXi4JiqBY/mh
	 fOKGDHVOAoY2tc62uJ/ApiRdykEflU9Kx/OWH9Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfLCN5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfLCN5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:57:01 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32782080A;
        Tue,  3 Dec 2019 13:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381420;
        bh=WNPDCluyozucmaNaWmUF9ACNNlonskyrPoSnH5INEPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTyvHuYst26p9z1DTTKwbwT6fACXwE9tv2PgY4qnOhHVWfDUwuV2nQIUF4ErXUeSB
         nwWcq2TGNJ7iuP6b7bEzV+pv3aIUwiQtyAtJLvXatBMyuvBnmTH+3zzEmUnaIKE/it
         bY02VvAEcLDuwodRYqKpsnMvyaNKkL3mdtillXZs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 15/23] tools headers uapi: Sync linux/fscrypt.h with the kernel sources
Date:   Tue,  3 Dec 2019 10:55:58 -0300
Message-Id: <20191203135606.24902-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  b103fb7653ff ("fscrypt: add support for IV_INO_LBLK_64 policies")

That don't trigger any changes in tooling.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fscrypt.h' differs from latest version at 'include/uapi/linux/fscrypt.h'
  diff -u tools/include/uapi/linux/fscrypt.h include/uapi/linux/fscrypt.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cgfz3ffe07pw2m8hmstvkudl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fscrypt.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
index 39ccfe9311c3..1beb174ad950 100644
--- a/tools/include/uapi/linux/fscrypt.h
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -17,7 +17,8 @@
 #define FSCRYPT_POLICY_FLAGS_PAD_32		0x03
 #define FSCRYPT_POLICY_FLAGS_PAD_MASK		0x03
 #define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04
-#define FSCRYPT_POLICY_FLAGS_VALID		0x07
+#define FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64	0x08
+#define FSCRYPT_POLICY_FLAGS_VALID		0x0F
 
 /* Encryption algorithms */
 #define FSCRYPT_MODE_AES_256_XTS		1
-- 
2.21.0

