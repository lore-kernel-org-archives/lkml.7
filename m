Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B70CC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E4F273F3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="M4aXWt+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfFCN1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:27:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40929 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfFCN1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:27:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DQ6vw609294
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:26:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DQ6vw609294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568367;
        bh=cI7OrfYYHqsooFXhIRnAzsuwawEqYxCDjWYABOBUHKk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=M4aXWt+Q65FJosIVRrGCWSawwcVA6K3VnP4/vA8rv2iLnkNnIDbHBnB22VkT1wChm
         zvfFj6wMfnS14K/Xl6k5xpYw4MF5FhZU5CloEJbpQjgJYC66TsNO22TumhuRuoQWcR
         hSABxXnug7iXVAyGLN5+9hpgFsdpIPoX1Qt2j4oeji88xvVDCkCoM2um9cftnHokGi
         nWbsVoUsWBzUfzOwXrLxZ10x/IiA+ONB8XA3auJQNynx2R2NNh9J3z8eiI2RApDaci
         5hkxAksU/uBllZUHCJ9XFBbwthNvdWryWJ9rD0OpFoItTDVnHgRcH9gGYd7+OGXzqE
         Yo1UJR7ShvvIA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DQ5OZ609291;
        Mon, 3 Jun 2019 06:26:05 -0700
Date:   Mon, 3 Jun 2019 06:26:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-f3a3a8257e5a1a5e67cbb1afdbc4c1c6a26f1b22@git.kernel.org>
Cc:     mingo@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, tglx@linutronix.de, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: acme@kernel.org, mingo@kernel.org, gregkh@linuxfoundation.org,
          alexander.shishkin@linux.intel.com,
          torvalds@linux-foundation.org, namhyung@kernel.org,
          tglx@linutronix.de, peterz@infradead.org, jolsa@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190512155518.21468-3-jolsa@kernel.org>
References: <20190512155518.21468-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Add attr_groups_update into struct pmu
Git-Commit-ID: f3a3a8257e5a1a5e67cbb1afdbc4c1c6a26f1b22
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f3a3a8257e5a1a5e67cbb1afdbc4c1c6a26f1b22
Gitweb:     https://git.kernel.org/tip/f3a3a8257e5a1a5e67cbb1afdbc4c1c6a26f1b22
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 12 May 2019 17:55:11 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:21 +0200

perf/core: Add attr_groups_update into struct pmu

Adding attr_update attribute group into pmu, to allow
having multiple attribute groups for same group name.

This will allow us to update "events" or "format"
directories with attributes that depend on various
HW conditions.

For example having group_format_extra group that updates
"format" directory only if pmu version is 2 and higher:

  static umode_t
  exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
  {
         return x86_pmu.version >= 2 ? attr->mode : 0;
  }

  static struct attribute_group group_format_extra = {
         .name       = "format",
         .is_visible = exra_is_visible,
  };

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190512155518.21468-3-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0ab99c7b652d..3dc01cf98e16 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -255,6 +255,7 @@ struct pmu {
 	struct module			*module;
 	struct device			*dev;
 	const struct attribute_group	**attr_groups;
+	const struct attribute_group	**attr_update;
 	const char			*name;
 	int				type;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3005c80f621d..118ad1aef6af 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9874,6 +9874,12 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto del_dev;
 
+	if (pmu->attr_update)
+		ret = sysfs_update_groups(&pmu->dev->kobj, pmu->attr_update);
+
+	if (ret)
+		goto del_dev;
+
 out:
 	return ret;
 
