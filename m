Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3353B2072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLRL5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:57:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57528 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLRL5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:57:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihXxQ-0000ek-Me; Wed, 18 Dec 2019 12:57:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E1F3D1C268E;
        Wed, 18 Dec 2019 12:57:35 +0100 (CET)
Date:   Wed, 18 Dec 2019 11:57:35 -0000
From:   "tip-bot2 for Enrico Weigelt" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] Documentation/x86/boot: Fix typo
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191203113314.26810-1-info@metux.net>
References: <20191203113314.26810-1-info@metux.net>
MIME-Version: 1.0
Message-ID: <157667025572.30329.18057346282277945641.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     e156c6176c9d6e69e166fb20e3b4e9f85ead8d77
Gitweb:        https://git.kernel.org/tip/e156c6176c9d6e69e166fb20e3b4e9f85ead8d77
Author:        Enrico Weigelt <info@metux.net>
AuthorDate:    Tue, 03 Dec 2019 12:33:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Dec 2019 12:50:27 +01:00

Documentation/x86/boot: Fix typo

s/Fileds/Fields/g

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191203113314.26810-1-info@metux.net
---
 Documentation/x86/boot.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 90bb8f5..692ce57 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -251,7 +251,7 @@ setting fields in the header, you must make sure only to set fields
 supported by the protocol version in use.
 
 
-Details of Harder Fileds
+Details of Header Fields
 ========================
 
 For each field, some are information from the kernel to the bootloader
