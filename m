Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3A1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FC1216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948446;
	bh=9shmp8VvJhPk3FNT3odx32MMDitjH1qQ0HRVeh3OUgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hgU0vMyt2tPx18ZE0ZQHFYu4XrFm1PP5JRjw3XhEAgIeu+ZWv5+G1SLLiZOugFqUv
	 L/xD0WLhA5wGlKzFYF+xtU3k7JzD0KK+SmMd0tEOSseFhMen3MzmSehoyq9Buhj7g+
	 LNND5umlzxpZ2Lwl3StDzNNYH97F3RhatsEDqzjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfK1Nko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbfK1Nko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:40:44 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02920217D6;
        Thu, 28 Nov 2019 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948443;
        bh=9shmp8VvJhPk3FNT3odx32MMDitjH1qQ0HRVeh3OUgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jsfvcm5vWozw4Yjye6QIWjcomxG6vMlcDKgzMIn4ivOofJlvSkETRPV8zO+VmX3t
         qCJGS5BxxG9bGkjNJ55Use8TNbCSPy8DJqDdCvggQiRBmeMn4qZVadWukBAKbPYLUY
         dFM5qqiO7iKA/g7w5ZH1nTCZysCoZ+736YbFsVfg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 03/22] perf map: Remove needless struct forward declarations
Date:   Thu, 28 Nov 2019 10:40:08 -0300
Message-Id: <20191128134027.23726-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

At some point we may have needed that, not anymore.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hnao13231bsl7xml5wn8h4iu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c0dffa9ecfe3..aafaea22737c 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -12,11 +12,8 @@
 #include <linux/types.h>
 
 struct dso;
-struct ip_callchain;
-struct ref_reloc_sym;
 struct map_groups;
 struct machine;
-struct evsel;
 
 struct map {
 	union {
-- 
2.21.0

