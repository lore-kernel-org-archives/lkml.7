Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1444C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89531207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLIUAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:00:43 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:57538 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIUAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:00:43 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id xB9K0AF6006143
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Dec 2019 21:00:10 +0100
Received: from [139.23.79.16] ([139.23.79.16])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id xB9K090B025220;
        Mon, 9 Dec 2019 21:00:09 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH][trace-cmd] libtraceevent: Fix parsing of octal formats
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <ae43ebe0-12da-3596-7f9c-ddd00a9cfd8e@siemens.com>
Date:   Mon, 9 Dec 2019 21:00:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Just gave ">o<" so far.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/traceevent/event-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/traceevent/event-parse.c b/lib/traceevent/event-parse.c
index 0a49eb9..98bf97a 100644
--- a/lib/traceevent/event-parse.c
+++ b/lib/traceevent/event-parse.c
@@ -5071,6 +5071,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 			case 'i':
 			case 'x':
 			case 'X':
+			case 'o':
 			case 'u':
 				if (!arg) {
 					do_warning_event(event, "no argument match");
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
