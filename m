Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83E9C32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06F721E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R9TcAVRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbfHGNR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:17:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388059AbfHGNR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:17:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x77DH95d2694604
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 7 Aug 2019 06:17:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x77DH95d2694604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565183830;
        bh=4ukqclmE6HDPYdTHnVM26E9HCiNMr7ELXdlyPgFslZE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=R9TcAVRN/bCOsCN/d9j0vE6jQi7Apr9gfr36OmXEAhNZpDIt4/rCKI+cBu85xJEeQ
         pZXJ9Hx9MjOPdbPQM7PT1BJ+2+zNomRH/B8toq7nZ/CVmoFng7+2Fj9dXFhpM7X0I6
         F1FuVm+tVQ5kswXHpOF/Q0ia9d7QnXrzwpQXrURdgF0TAYKsLFEjnFgkRFlmD4ySOW
         npUaNr6Qk+/0sNUuJtvKqLAJU459ehpuH0eYZ/NoqsLal3Ye1TtJDBwR4Ylp2liPjv
         4v0ge5dhQ0VNpQuOtxrW/ALtulrBRtn08ASxsjlElc1mHJa+ts/mdRxNoP6D8ZV4k6
         VMSHWXpYWRzyQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x77DH9ta2694601;
        Wed, 7 Aug 2019 06:17:09 -0700
Date:   Wed, 7 Aug 2019 06:17:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-7468a4eae541ce5aff65595aa502aa0a4def6615@git.kernel.org>
Cc:     gustavo@embeddedor.com, keescook@chromium.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, keescook@chromium.org,
          gustavo@embeddedor.com
In-Reply-To: <20190805201712.GA19927@embeddedor>
References: <20190805201712.GA19927@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86: mtrr: cyrix: Mark expected switch
 fall-through
Git-Commit-ID: 7468a4eae541ce5aff65595aa502aa0a4def6615
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

Commit-ID:  7468a4eae541ce5aff65595aa502aa0a4def6615
Gitweb:     https://git.kernel.org/tip/7468a4eae541ce5aff65595aa502aa0a4def6615
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Mon, 5 Aug 2019 15:17:12 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 7 Aug 2019 15:12:01 +0200

x86: mtrr: cyrix: Mark expected switch fall-through

Mark switch cases where we are expecting to fall through.

Fix the following warning (Building: i386_defconfig i386):

arch/x86/kernel/cpu/mtrr/cyrix.c:99:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20190805201712.GA19927@embeddedor

---
 arch/x86/kernel/cpu/mtrr/cyrix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
index 4296c702a3f7..72182809b333 100644
--- a/arch/x86/kernel/cpu/mtrr/cyrix.c
+++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
@@ -98,6 +98,7 @@ cyrix_get_free_region(unsigned long base, unsigned long size, int replace_reg)
 	case 7:
 		if (size < 0x40)
 			break;
+		/* Else, fall through */
 	case 6:
 	case 5:
 	case 4:
