Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6671DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F2D206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fc9qH8QO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbfG2Vd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:33:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57345 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729545AbfG2Vd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:33:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLXltK2941348
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:33:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLXltK2941348
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564436028;
        bh=LAmpSbJePQTFCXVVJKfxFt1dn84zHJuSST1AfBMZZZ0=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Fc9qH8QOZXuinhhH+o9QJG8fKsio74EDgglj88HGbmgB2vszxX/3SO5roqfPVonpX
         Zl1njq2tvxK3ehpAPJUfh2OaJXkOYHdJya+aMAFIvJzkc62fY4kR7nBbl2T9GvBOO/
         hBVQskz84mwU2THoeg5zP9HjTmegkkgZjtt9UQwjojQSI7ntrSiDWH+mps5MGeM3sO
         Im7RactspEOTc55UJQheSpi9fG3kDOPybvArqRDUDOiS1mcb1/p7eud04D16f4b0Qo
         spqLt2vy8rhIJtcTkjS3kuW9Uxm7EfYZcsI/ImA8kT0blajkNTQIgZMTEwif5K/1W2
         zKrKajUcHuyDg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLXljZ2941345;
        Mon, 29 Jul 2019 14:33:47 -0700
Date:   Mon, 29 Jul 2019 14:33:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3liw4exxh8goc0rq9xryl2kv@git.kernel.org>
Cc:     tglx@linutronix.de, lclaudio@redhat.com, adrian.hunter@intel.com,
        mingo@kernel.org, acme@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, hpa@zytor.com, vincent@bernat.ch,
        namhyung@kernel.org, jolsa@kernel.org
Reply-To: jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
          mingo@kernel.org, vincent@bernat.ch, lclaudio@redhat.com,
          tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, davem@davemloft.net
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers UAPI: Sync if_link.h with the
 kernel
Git-Commit-ID: e54599c93dbf487ef80ba2833c5760c22bd20c32
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

Commit-ID:  e54599c93dbf487ef80ba2833c5760c22bd20c32
Gitweb:     https://git.kernel.org/tip/e54599c93dbf487ef80ba2833c5760c22bd20c32
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 26 Jul 2019 15:44:41 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 09:03:43 -0300

tools headers UAPI: Sync if_link.h with the kernel

To pick the changes in:

  07a4ddec3ce9 ("bonding: add an option to specify a delay between peer notifications")

And silence this build warning:

  Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vincent Bernat <vincent@bernat.ch>
Link: https://lkml.kernel.org/n/tip-3liw4exxh8goc0rq9xryl2kv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_link.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 7d113a9602f0..4a8c02cafa9a 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -695,6 +695,7 @@ enum {
 	IFLA_VF_IB_NODE_GUID,	/* VF Infiniband node GUID */
 	IFLA_VF_IB_PORT_GUID,	/* VF Infiniband port GUID */
 	IFLA_VF_VLAN_LIST,	/* nested list of vlans, option for QinQ */
+	IFLA_VF_BROADCAST,	/* VF broadcast */
 	__IFLA_VF_MAX,
 };
 
@@ -705,6 +706,10 @@ struct ifla_vf_mac {
 	__u8 mac[32]; /* MAX_ADDR_LEN */
 };
 
+struct ifla_vf_broadcast {
+	__u8 broadcast[32];
+};
+
 struct ifla_vf_vlan {
 	__u32 vf;
 	__u32 vlan; /* 0 - 4095, 0 disables VLAN filter */
